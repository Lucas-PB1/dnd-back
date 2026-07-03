import { Injectable } from '@nestjs/common';
import { CatalogLookupService } from '../../../catalog/catalog-lookup.service';
import { CharacterFactory } from '../domain/character.factory';
import { CharacterDomainService } from '../domain/character-domain.service';
import { CharacterRepository } from '../infrastructure/character.repository';
import { CharacterSheetRepository } from '../infrastructure/character-sheet.repository';
import { CharacterSheetValidator } from '../domain/character-sheet.validator';
import { CharacterMapper } from '../infrastructure/character.mapper';
import { CreateCharacterDto } from '../dto/create-character.dto';
import { CharacterResponseDto } from '../dto/character-response.dto';
import { CharacterSheetInput } from '../domain/character-sheet.types';

@Injectable()
export class CreateCharacterHandler {
  constructor(
    private readonly catalogLookup: CatalogLookupService,
    private readonly sheetValidator: CharacterSheetValidator,
    private readonly domain: CharacterDomainService,
    private readonly repository: CharacterRepository,
    private readonly sheetRepository: CharacterSheetRepository,
    private readonly mapper: CharacterMapper,
  ) {}

  async execute(userId: string, dto: CreateCharacterDto): Promise<CharacterResponseDto> {
    await this.catalogLookup.validateCharacterCatalogRefs({
      classSlug: dto.classSlug,
      speciesSlug: dto.speciesSlug,
      backgroundSlug: dto.backgroundSlug,
      subclassSlug: dto.subclassSlug,
      alignmentSlug: dto.alignmentSlug,
    });

    const ctx = {
      level: 1,
      classSlug: dto.classSlug,
      speciesSlug: dto.speciesSlug,
      backgroundSlug: dto.backgroundSlug,
      subclassSlug: dto.subclassSlug ?? null,
    };

    await this.sheetValidator.validateLevelRules(ctx);
    await this.sheetValidator.validateSheetInput(this.toSheetInput(dto), ctx);

    const entity = this.repository.create(CharacterFactory.buildNew(userId, dto));
    await this.domain.applyDerivedHitPoints(entity, {
      hitPointsMax: dto.hitPointsMax,
      hitPointsCurrent: dto.hitPointsCurrent,
    });

    const saved = await this.repository.save(entity);
    await this.sheetRepository.sync(saved.id, this.toSheetInput(dto));

    return this.mapper.toDto(saved);
  }

  private toSheetInput(dto: CreateCharacterDto): CharacterSheetInput {
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
