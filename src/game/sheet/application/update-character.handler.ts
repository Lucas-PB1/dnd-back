import { Injectable } from '@nestjs/common';
import { DataSource } from 'typeorm';
import { CatalogLookupService } from '../../../catalog/catalog-lookup.service';
import { CharacterDomainService } from '../domain/core/character-domain.service';
import { CharacterRepository } from '../../shared/infrastructure/character.repository';
import { CharacterSheetRepository } from '../infrastructure/character-sheet.repository';
import { CharacterSheetValidator } from '../domain/validation/character-sheet.validator';
import { CharacterMapper } from '../infrastructure/character.mapper';
import { UpdateCharacterDto } from '../dto/update-character.dto';
import { CharacterResponseDto } from '../dto/character-response.dto';
import { CharacterSheetInput } from '../domain/character-sheet.types';
import { SeedStartingInventoryHandler } from '../../inventory/application/seed-starting-inventory.handler';
import { LoadGrantedSpellCatalog } from '../../spellcasting/application/load-granted-spell-catalog';
import { applyBackgroundAndIdentityUpdate } from './update-character/apply-background-and-identity-update';
import { assertAndConsumeHighElfCantripSwap } from './update-character/assert-high-elf-cantrip-swap';
import { clearStaleSheetChoices } from './update-character/clear-stale-sheet-choices';
import { mergeUpdateCharacterSpells } from './update-character/merge-update-character-spells';
import {
  featSlugsOf,
  resolveEffectiveFeatOptions,
  shouldResyncCharacterSpells,
  toSheetInput,
} from './update-character/update-sheet-input';

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
    private readonly grantedSpellCatalog: LoadGrantedSpellCatalog,
    private readonly dataSource: DataSource,
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
      dto.characterFeats !== undefined ? dto.characterFeats : sheetSnapshot.characterFeats;
    const effectiveFeatOptions = resolveEffectiveFeatOptions(
      dto,
      sheetSnapshot,
      effectiveCharacterFeats,
    );
    const effectiveSpeciesChoices =
      dto.speciesChoices !== undefined
        ? dto.speciesChoices
        : sheetSnapshot.speciesChoices;

    if (dto.speciesChoices !== undefined) {
      await assertAndConsumeHighElfCantripSwap(
        this.dataSource,
        row.id,
        sheetSnapshot.speciesChoices,
        dto.speciesChoices,
      );
    }

    const levelChanged = dto.level !== undefined && dto.level !== row.level;
    const speciesChanged =
      dto.speciesSlug !== undefined && dto.speciesSlug !== row.speciesSlug;
    const subclassChanged =
      dto.subclassSlug !== undefined && dto.subclassSlug !== row.subclassSlug;
    const classChanged =
      dto.classSlug !== undefined && dto.classSlug !== row.classSlug;
    const backgroundChanged =
      dto.backgroundSlug !== undefined && dto.backgroundSlug !== row.backgroundSlug;

    const shouldResyncSpells = shouldResyncCharacterSpells(
      dto,
      levelChanged,
      speciesChanged,
      subclassChanged,
    );

    const sheetInput = toSheetInput(dto);
    if (shouldResyncSpells) {
      await mergeUpdateCharacterSpells({
        dto,
        sheetInput,
        sheetSnapshot,
        effective,
        previous: {
          speciesSlug: row.speciesSlug,
          subclassSlug: row.subclassSlug,
          level: row.level,
        },
        effectiveCharacterFeats,
        effectiveFeatOptions,
        effectiveSpeciesChoices,
        grantedSpellCatalog: this.grantedSpellCatalog,
      });
    }

    // Expertise/weapon mastery patches often omit skills/feats already on the sheet.
    // Validation still needs those sources or proficient checks fail (e.g. level-up).
    const needsProficiencyContext = sheetInput.classOptions !== undefined;
    const injectFeatOptions =
      (shouldResyncSpells || needsProficiencyContext) &&
      sheetInput.featOptions === undefined;
    const injectSpeciesChoices =
      (shouldResyncSpells || needsProficiencyContext) &&
      sheetInput.speciesChoices === undefined;

    const validationInput: CharacterSheetInput = {
      ...sheetInput,
      ...(needsProficiencyContext && sheetInput.classSkillSlugs === undefined
        ? { classSkillSlugs: sheetSnapshot.classSkillSlugs }
        : {}),
      ...(needsProficiencyContext && sheetInput.characterSpells === undefined
        ? { characterSpells: sheetSnapshot.characterSpells }
        : {}),
      ...(injectFeatOptions ? { featOptions: effectiveFeatOptions } : {}),
      ...(injectSpeciesChoices
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
    if (dto.characterFeats !== undefined || dto.subclassOptions !== undefined) {
      await this.sheetValidator.validateFightingStyleSelections(
        dto.classSlug ?? row.classSlug,
        effectiveCharacterFeats,
        effectiveSubclassOptions,
      );
    }

    await clearStaleSheetChoices(this.sheetRepository, row.id, dto, {
      classChanged,
      speciesChanged,
      subclassChanged,
    });

    const before = {
      level: row.level,
      classSlug: row.classSlug,
      abilityScores: row.abilityScores,
      featSlugs: featSlugsOf(sheetSnapshot.characterFeats),
    };

    await applyBackgroundAndIdentityUpdate({
      row,
      dto,
      effective,
      catalogLookup: this.catalogLookup,
      sheetValidator: this.sheetValidator,
      backgroundChanged,
    });

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
        characterFeats: effectiveFeatSlugs.join('|') !== before.featSlugs.join('|'),
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
}
