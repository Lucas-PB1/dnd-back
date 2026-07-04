import { Injectable } from '@nestjs/common';
import { CatalogLookupService } from '../../../catalog/catalog-lookup.service';
import { CharacterFactory } from '../domain/character.factory';
import { CharacterDomainService } from '../domain/character-domain.service';
import { CharacterRepository } from '../../shared/infrastructure/character.repository';
import { CharacterSheetRepository } from '../infrastructure/character-sheet.repository';
import { CharacterSheetValidator } from '../domain/character-sheet.validator';
import { CharacterMapper } from '../infrastructure/character.mapper';
import { CreateCharacterDto } from '../dto/create-character.dto';
import { CharacterResponseDto } from '../dto/character-response.dto';
import { CharacterSheetInput } from '../domain/character-sheet.types';
import {
  resolveBackgroundOriginFeatSlugs,
  resolveBackgroundToolItemSlug,
} from '../domain/background-origin';

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

    const level = dto.level ?? 1;

    const ctx = {
      level,
      classSlug: dto.classSlug,
      speciesSlug: dto.speciesSlug,
      backgroundSlug: dto.backgroundSlug,
      subclassSlug: dto.subclassSlug ?? null,
    };

    await this.sheetValidator.validateLevelRules(ctx);
    await this.sheetValidator.validateBackgroundAbilityBoosts(dto.backgroundSlug, {
      plus2Slug: dto.backgroundAbilityBoostPlus2Slug,
      plus1Slug: dto.backgroundAbilityBoostPlus1Slug,
    });

    const background = await this.catalogLookup.findBackgroundOrFail(dto.backgroundSlug);
    const featSlugs = resolveBackgroundOriginFeatSlugs(background, dto.featSlugs);
    const backgroundToolItemSlug = resolveBackgroundToolItemSlug(
      background,
      dto.backgroundToolItemSlug,
    );

    await this.sheetValidator.validateBackgroundToolChoice(background, backgroundToolItemSlug);
    await this.sheetValidator.validateBackgroundOriginFeat(background, featSlugs);

    const sheetInput = this.toSheetInput(dto, featSlugs);

    await this.sheetValidator.validateCreateRequiredFields(sheetInput, ctx);
    await this.sheetValidator.validateSheetInput(sheetInput, ctx);

    const entity = this.repository.create(
      CharacterFactory.withBackgroundTool(
        CharacterFactory.withBackgroundBoostsApplied(
          CharacterFactory.buildNew(userId, {
            ...dto,
            backgroundToolItemSlug: backgroundToolItemSlug ?? undefined,
          }),
          dto,
        ),
        backgroundToolItemSlug,
      ),
    );
    await this.domain.applyDerivedHitPoints(entity, {
      hitPointsMax: dto.hitPointsMax,
      hitPointsCurrent: dto.hitPointsCurrent,
    });

    const saved = await this.repository.save(entity);
    await this.sheetRepository.sync(saved.id, sheetInput);

    return this.mapper.toDto(saved);
  }

  private toSheetInput(
    dto: CreateCharacterDto,
    featSlugs?: string[],
  ): CharacterSheetInput {
    return {
      classSkillSlugs: dto.classSkillSlugs,
      speciesChoices: dto.speciesChoices,
      subclassOptions: dto.subclassOptions,
      featSlugs: featSlugs ?? dto.featSlugs,
      featOptions: dto.featOptions,
      characterSpells: dto.characterSpells,
      equipment: dto.equipment,
      languageSlugs: dto.languageSlugs,
      abilityGenerationMethodSlug: dto.abilityGenerationMethodSlug,
    };
  }
}
