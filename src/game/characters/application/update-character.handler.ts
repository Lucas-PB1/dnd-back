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
    await this.sheetValidator.validateSheetInput(this.toSheetInput(dto), effective);

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

    CharacterFactory.applyUpdate(row, dto);

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
      featSlugs: dto.featSlugs,
      characterSpells: dto.characterSpells,
      equipment: dto.equipment,
      languageSlugs: dto.languageSlugs,
      abilityGenerationMethodSlug: dto.abilityGenerationMethodSlug,
    };
  }
}
