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
import { applyBackgroundAbilityBoosts } from '../domain/background-ability-boost';
import {
  resolveBackgroundToolItemSlug,
} from '../domain/background-origin';

@Injectable()
export class UpdateCharacterHandler {
  constructor(
    private readonly catalogLookup: CatalogLookupService,
    private readonly sheetValidator: CharacterSheetValidator,
    private readonly domain: CharacterDomainService,
    private readonly repository: CharacterRepository,
    private readonly sheetRepository: CharacterSheetRepository,
    private readonly mapper: CharacterMapper,
  ) {}

  async execute(
    userId: string,
    id: string,
    dto: UpdateCharacterDto,
  ): Promise<CharacterResponseDto> {
    const row = await this.repository.findOwnedOrFail(userId, id);

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

    await this.sheetValidator.validateSheetInput(this.toSheetInput(dto), {
      ...effective,
      characterFeats: effectiveCharacterFeats,
    });

    if (dto.characterFeats !== undefined || dto.featOptions !== undefined) {
      await this.sheetValidator.validateFeatOptions(
        effectiveCharacterFeats,
        effectiveFeatOptions,
      );
    }

    const classChanged = dto.classSlug !== undefined && dto.classSlug !== row.classSlug;
    const speciesChanged = dto.speciesSlug !== undefined && dto.speciesSlug !== row.speciesSlug;
    const subclassChanged =
      dto.subclassSlug !== undefined && dto.subclassSlug !== row.subclassSlug;

    if (classChanged && dto.classSkillSlugs === undefined) {
      await this.sheetRepository.clearClassSkills(row.id);
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
    };

    const backgroundChanged =
      dto.backgroundSlug !== undefined && dto.backgroundSlug !== row.backgroundSlug;

    const boostPatch =
      dto.backgroundAbilityBoostPlus2Slug !== undefined ||
      dto.backgroundAbilityBoostPlus1Slug !== undefined;
    const scoresAreBase = boostPatch && dto.abilityScores !== undefined;

    if (backgroundChanged && !boostPatch) {
      row.backgroundBoostPlus2AbilitySlug = null;
      row.backgroundBoostPlus1AbilitySlug = null;
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
      const plus2 = row.backgroundBoostPlus2AbilitySlug;
      const plus1 = row.backgroundBoostPlus1AbilitySlug;
      await this.sheetValidator.validateBackgroundAbilityBoosts(
        effective.backgroundSlug,
        { plus2Slug: plus2 ?? undefined, plus1Slug: plus1 ?? undefined },
      );
      if (scoresAreBase && plus2 && plus1 && dto.abilityScores) {
        row.abilityScores = applyBackgroundAbilityBoosts(dto.abilityScores, {
          plus2Slug: plus2,
          plus1Slug: plus1,
        });
      }
    }

    await this.domain.refreshHitPointsAfterChange(row, dto, {
      level: dto.level !== undefined && dto.level !== before.level,
      classSlug: dto.classSlug !== undefined && dto.classSlug !== before.classSlug,
      abilityScores:
        dto.abilityScores !== undefined &&
        JSON.stringify(dto.abilityScores) !== JSON.stringify(before.abilityScores),
    });

    const saved = await this.repository.save(row);
    await this.sheetRepository.sync(saved.id, this.toSheetInput(dto));

    return this.mapper.toDto(saved);
  }

  private toSheetInput(dto: UpdateCharacterDto): CharacterSheetInput {
    return {
      classSkillSlugs: dto.classSkillSlugs,
      speciesChoices: dto.speciesChoices,
      subclassOptions: dto.subclassOptions,
      characterFeats: dto.characterFeats,
      featOptions: dto.featOptions,
      characterSpells: dto.characterSpells,
      equipment: dto.equipment,
      languageSlugs: dto.languageSlugs,
      abilityGenerationMethodSlug: dto.abilityGenerationMethodSlug,
    };
  }
}
