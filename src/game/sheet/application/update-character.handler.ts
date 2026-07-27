import { Injectable } from '@nestjs/common';
import { CatalogLookupService } from '../../../catalog/catalog-lookup.service';
import { CharacterFactory } from '../domain/character.factory';
import { CharacterDomainService } from '../domain/character-domain.service';
import { CharacterRepository } from '../../shared/infrastructure/character.repository';
import { CharacterSheetRepository } from '../infrastructure/character-sheet.repository';
import { CharacterSheetValidator } from '../domain/character-sheet.validator';
import { CharacterMapper } from '../infrastructure/character.mapper';
import { UpdateCharacterDto } from '../dto/update-character.dto';
import { CharacterResponseDto } from '../dto/character-response.dto';
import { CharacterSheetInput } from '../domain/character-sheet.types';
import { applyBackgroundAbilityBoosts, resolveBackgroundAbilityBoostInput } from '../domain/background-ability-boost';
import {
  resolveBackgroundToolItemSlug,
} from '../domain/background-origin';
import { SeedStartingInventoryHandler } from '../../inventory/application/seed-starting-inventory.handler';
import { CharacterFeatDto } from '../dto/character-sheet.dto';
import { mergeCharacterSpellsWithGrantedSources } from '../domain/granted-spells';
import { GrantedSpellCatalogService } from '../infrastructure/granted-spell-catalog.service';

function featSlugsOf(feats: readonly CharacterFeatDto[]): string[] {
  return feats.map((feat) => feat.featSlug).sort();
}

@Injectable()
export class UpdateCharacterHandler {
  constructor(
    private readonly catalogLookup: CatalogLookupService,
    private readonly sheetValidator: CharacterSheetValidator,
    private readonly domain: CharacterDomainService,
    private readonly repository: CharacterRepository,
    private readonly sheetRepository: CharacterSheetRepository,
    private readonly mapper: CharacterMapper,
    private readonly seedStartingInventory: SeedStartingInventoryHandler,
    private readonly grantedSpellCatalog: GrantedSpellCatalogService,
  ) {}

  async execute(
    userId: string,
    id: string,
    dto: UpdateCharacterDto,
  ): Promise<CharacterResponseDto> {
    const row = await this.repository.findAccessibleOrFail(userId, id, 'write');

    const effective = {
      level: dto.level ?? row.level,
      classSlug: dto.classSlug ?? row.classSlug,
      speciesSlug: dto.speciesSlug ?? row.speciesSlug,
      backgroundSlug: dto.backgroundSlug ?? row.backgroundSlug,
      subclassSlug:
        dto.subclassSlug !== undefined ? (dto.subclassSlug ?? null) : row.subclassSlug,
    };

    if (
      dto.classSlug !== undefined ||
      dto.speciesSlug !== undefined ||
      dto.backgroundSlug !== undefined ||
      dto.subclassSlug !== undefined ||
      dto.alignmentSlug !== undefined
    ) {
      await this.catalogLookup.validateCharacterCatalogRefs({
        classSlug: effective.classSlug,
        speciesSlug: effective.speciesSlug,
        backgroundSlug: effective.backgroundSlug,
        subclassSlug: effective.subclassSlug,
        alignmentSlug: dto.alignmentSlug !== undefined ? dto.alignmentSlug : row.alignmentSlug,
      });
    }

    await this.sheetValidator.validateLevelRules(effective);

    const sheetSnapshot = await this.sheetRepository.load(row.id, effective.backgroundSlug);
    const effectiveCharacterFeats =
      dto.characterFeats !== undefined
        ? dto.characterFeats
        : sheetSnapshot.characterFeats;
    let effectiveFeatOptions = sheetSnapshot.featOptions;
    if (dto.featOptions !== undefined) {
      effectiveFeatOptions = dto.featOptions;
    } else if (dto.characterFeats !== undefined) {
      effectiveFeatOptions = sheetSnapshot.featOptions.filter((option) =>
        effectiveCharacterFeats.some(
          (feat) =>
            feat.featSlug === option.featSlug &&
            feat.instanceIndex === (option.instanceIndex ?? 0),
        ),
      );
    }

    const effectiveSpeciesChoices =
      dto.speciesChoices !== undefined
        ? dto.speciesChoices
        : sheetSnapshot.speciesChoices;

    const levelChanged = dto.level !== undefined && dto.level !== row.level;
    const speciesChanged =
      dto.speciesSlug !== undefined && dto.speciesSlug !== row.speciesSlug;
    const subclassChanged =
      dto.subclassSlug !== undefined && dto.subclassSlug !== row.subclassSlug;

    const shouldResyncSpells =
      dto.characterSpells !== undefined ||
      dto.featOptions !== undefined ||
      dto.characterFeats !== undefined ||
      dto.speciesChoices !== undefined ||
      speciesChanged ||
      subclassChanged ||
      levelChanged;

    const sheetInput = this.toSheetInput(dto);
    if (shouldResyncSpells) {
      const featSlugs = [
        ...effectiveCharacterFeats.map((f) => f.featSlug),
        ...sheetSnapshot.characterFeats.map((f) => f.featSlug),
      ];
      const { speciesCatalog, featFixedSpells, subclassGrantedSpells } =
        await this.grantedSpellCatalog.loadMergeCatalog({
          speciesSlugs: [effective.speciesSlug, row.speciesSlug],
          featSlugs,
          subclassSlug: effective.subclassSlug,
        });
      const previousSubclassGrantedSpells =
        await this.grantedSpellCatalog.loadSubclassGrantedSpells(
          row.subclassSlug,
        );
      sheetInput.characterSpells = mergeCharacterSpellsWithGrantedSources(
        dto.characterSpells ?? sheetSnapshot.characterSpells,
        {
          featOptions: effectiveFeatOptions,
          characterFeats: effectiveCharacterFeats,
          previousFeatOptions: sheetSnapshot.featOptions,
          previousCharacterFeats: sheetSnapshot.characterFeats,
          speciesSlug: effective.speciesSlug,
          speciesChoices: effectiveSpeciesChoices,
          level: effective.level,
          previousSpeciesSlug: row.speciesSlug,
          previousSpeciesChoices: sheetSnapshot.speciesChoices,
          previousLevel: row.level,
          speciesCatalog,
          featFixedSpells,
          subclassGrantedSpells,
          previousSubclassGrantedSpells,
        },
      );
      if (dto.featOptions === undefined && dto.characterFeats !== undefined) {
        sheetInput.featOptions = effectiveFeatOptions;
      }
    }

    const validationInput: CharacterSheetInput = {
      ...sheetInput,
      ...(shouldResyncSpells && sheetInput.featOptions === undefined
        ? { featOptions: effectiveFeatOptions }
        : {}),
      ...(shouldResyncSpells && sheetInput.speciesChoices === undefined
        ? { speciesChoices: effectiveSpeciesChoices }
        : {}),
    };

    await this.sheetValidator.validateSheetInput(validationInput, {
      ...effective,
      characterFeats: effectiveCharacterFeats,
    });

    if (dto.characterFeats !== undefined || dto.featOptions !== undefined) {
      await this.sheetValidator.validateFeatOptions(
        effectiveCharacterFeats,
        effectiveFeatOptions,
        dto.level ?? row.level,
        dto.classSlug ?? row.classSlug,
      );
    }

    const effectiveSubclassOptions =
      dto.subclassOptions !== undefined
        ? dto.subclassOptions
        : sheetSnapshot.subclassOptions;
    if (
      dto.characterFeats !== undefined ||
      dto.subclassOptions !== undefined
    ) {
      await this.sheetValidator.validateFightingStyleSelections(
        dto.classSlug ?? row.classSlug,
        effectiveCharacterFeats,
        effectiveSubclassOptions,
      );
    }

    const classChanged = dto.classSlug !== undefined && dto.classSlug !== row.classSlug;

    if (classChanged && dto.classSkillSlugs === undefined) {
      await this.sheetRepository.clearClassSkills(row.id);
    }
    if (classChanged && dto.classOptions === undefined) {
      await this.sheetRepository.clearClassOptions(row.id);
    }
    if (speciesChanged && dto.speciesChoices === undefined) {
      await this.sheetRepository.clearSpeciesChoices(row.id);
    }
    if (subclassChanged && dto.subclassOptions === undefined) {
      await this.sheetRepository.clearSubclassOptions(row.id);
    }

    const before = {
      level: row.level,
      classSlug: row.classSlug,
      abilityScores: row.abilityScores,
      featSlugs: featSlugsOf(sheetSnapshot.characterFeats),
    };

    const backgroundChanged =
      dto.backgroundSlug !== undefined && dto.backgroundSlug !== row.backgroundSlug;

    const boostPatch =
      dto.backgroundAbilityBoostMode !== undefined ||
      dto.backgroundAbilityBoostPlus2Slug !== undefined ||
      dto.backgroundAbilityBoostPlus1Slug !== undefined ||
      dto.backgroundAbilityBoostPlus1Slugs !== undefined;
    const scoresAreBase = boostPatch && dto.abilityScores !== undefined;

    if (backgroundChanged && !boostPatch) {
      row.backgroundBoostMode = 'plus2plus1';
      row.backgroundBoostPlus2AbilitySlug = null;
      row.backgroundBoostPlus1AbilitySlug = null;
      row.backgroundBoostPlus1Slugs = null;
    }

    if (backgroundChanged && dto.backgroundToolItemSlug === undefined) {
      row.backgroundToolItemSlug = null;
    }

    const updateDto: UpdateCharacterDto = { ...dto };

    if (updateDto.backgroundToolItemSlug !== undefined) {
      const background = await this.catalogLookup.findBackgroundOrFail(
        effective.backgroundSlug,
      );
      const resolvedTool = resolveBackgroundToolItemSlug(
        background,
        updateDto.backgroundToolItemSlug,
      );
      await this.sheetValidator.validateBackgroundToolChoice(
        background,
        resolvedTool,
      );
      updateDto.backgroundToolItemSlug = resolvedTool ?? undefined;
    }

    CharacterFactory.applyUpdate(
      row,
      scoresAreBase ? { ...updateDto, abilityScores: undefined } : updateDto,
    );

    if (boostPatch) {
      await this.sheetValidator.validateBackgroundAbilityBoosts(
        effective.backgroundSlug,
        {
          mode: row.backgroundBoostMode,
          plus2Slug: row.backgroundBoostPlus2AbilitySlug,
          plus1Slug: row.backgroundBoostPlus1AbilitySlug,
          plus1Slugs: row.backgroundBoostPlus1Slugs,
        },
      );
      if (scoresAreBase && dto.abilityScores) {
        row.abilityScores = applyBackgroundAbilityBoosts(
          dto.abilityScores,
          resolveBackgroundAbilityBoostInput({
            mode: row.backgroundBoostMode,
            plus2Slug: row.backgroundBoostPlus2AbilitySlug,
            plus1Slug: row.backgroundBoostPlus1AbilitySlug,
            plus1Slugs: row.backgroundBoostPlus1Slugs,
          }),
        );
      }
    }

    const effectiveFeatSlugs = featSlugsOf(effectiveCharacterFeats);

    await this.domain.refreshHitPointsAfterChange(
      row,
      dto,
      {
        level: dto.level !== undefined && dto.level !== before.level,
        classSlug: dto.classSlug !== undefined && dto.classSlug !== before.classSlug,
        abilityScores:
          dto.abilityScores !== undefined &&
          JSON.stringify(dto.abilityScores) !== JSON.stringify(before.abilityScores),
        speciesSlug: speciesChanged,
        subclassSlug: subclassChanged,
        characterFeats:
          effectiveFeatSlugs.join('|') !== before.featSlugs.join('|'),
      },
      effectiveFeatSlugs,
    );

    const saved = await this.repository.save(row);
    await this.sheetRepository.sync(saved.id, sheetInput);
    if (dto.equipment !== undefined) {
      await this.seedStartingInventory.execute(saved.id, dto.equipment);
    }

    return this.mapper.toDto(saved);
  }

  private toSheetInput(dto: UpdateCharacterDto): CharacterSheetInput {
    return {
      classSkillSlugs: dto.classSkillSlugs,
      speciesChoices: dto.speciesChoices,
      subclassOptions: dto.subclassOptions,
      classOptions: dto.classOptions,
      characterFeats: dto.characterFeats,
      featOptions: dto.featOptions,
      characterSpells: dto.characterSpells,
      equipment: dto.equipment,
      languageSlugs: dto.languageSlugs,
      abilityGenerationMethodSlug: dto.abilityGenerationMethodSlug,
    };
  }
}
