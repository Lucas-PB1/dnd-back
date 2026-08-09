import { Injectable } from '@nestjs/common';
import { DataSource } from 'typeorm';
import { CatalogLookupService } from '@catalog/catalog-lookup.service';
import { CharacterFactory } from '../domain/core/character.factory';
import { CharacterDomainService } from '../domain/core/character-domain.service';
import { CharacterRepository } from '@game/shared/infrastructure/character.repository';
import { CharacterSheetRepository } from '../infrastructure/character-sheet.repository';
import { CharacterSheetValidator } from '../domain/validation/character-sheet.validator';
import { CharacterMapper } from '../infrastructure/character.mapper';
import { CreateCharacterDto } from '../dto/create-character.dto';
import { CharacterResponseDto } from '../dto/character-response.dto';
import { CharacterSheetInput } from '../domain/character-sheet.types';
import { CharacterFeatDto } from '../dto/character-sheet.dto';
import {
  resolveBackgroundOriginCharacterFeats,
  resolveBackgroundToolItemSlug,
} from '../domain/origin/background-origin';
import { resolveHumanOriginCharacterFeats } from '../domain/origin/species-origin';
import { mergeGrantedSpells } from '@game/spellcasting/application/merge-granted-spells';
import { LoadGrantedSpellCatalog } from '@game/spellcasting/application/load-granted-spell-catalog';
import { SeedStartingInventoryHandler } from '@game/inventory/application/seed-starting-inventory.handler';
import { resolveEldritchGrantedSpellSlugs } from './eldritch-granted-spells';

@Injectable()
export class CreateCharacterHandler {
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
      mode: dto.backgroundAbilityBoostMode,
      plus2Slug: dto.backgroundAbilityBoostPlus2Slug,
      plus1Slug: dto.backgroundAbilityBoostPlus1Slug,
      plus1Slugs: dto.backgroundAbilityBoostPlus1Slugs,
    });

    const background = await this.catalogLookup.findBackgroundOrFail(dto.backgroundSlug);
    let characterFeats = resolveBackgroundOriginCharacterFeats(
      background,
      dto.characterFeats,
    );
    characterFeats = resolveHumanOriginCharacterFeats(
      dto.speciesSlug,
      dto.speciesChoices,
      characterFeats,
    );
    const backgroundToolItemSlug = resolveBackgroundToolItemSlug(
      background,
      dto.backgroundToolItemSlug,
    );

    await this.sheetValidator.validateBackgroundToolChoice(background, backgroundToolItemSlug);
    await this.sheetValidator.validateBackgroundOriginFeat(background, characterFeats);

    const sheetInput = this.toSheetInput(dto, characterFeats);
    const featSlugs = (sheetInput.characterFeats ?? []).map((f) => f.featSlug);
    const { speciesCatalog, featFixedSpells, subclassGrantedSpells } =
      await this.grantedSpellCatalog.loadMergeCatalog({
        speciesSlugs: [dto.speciesSlug],
        featSlugs,
        subclassSlug: dto.subclassSlug,
      });
    const extraGrantedSpellSlugs = await resolveEldritchGrantedSpellSlugs(
      this.dataSource,
      sheetInput.classOptions,
    );
    sheetInput.characterSpells = mergeGrantedSpells(
      sheetInput.characterSpells ?? [],
      {
        featOptions: sheetInput.featOptions,
        characterFeats: sheetInput.characterFeats,
        speciesSlug: dto.speciesSlug,
        speciesChoices: sheetInput.speciesChoices,
        level,
        speciesCatalog,
        featFixedSpells,
        subclassGrantedSpells,
        extraGrantedSpellSlugs,
      },
    );

    await this.sheetValidator.validateCreateRequiredFields(sheetInput, ctx);
    await this.sheetValidator.validateSheetInput(sheetInput, ctx);

    const epicBoonFeatSlugs = await this.catalogLookup.findEpicBoonFeatSlugs();

    const entity = this.repository.create(
      CharacterFactory.withFeatAbilityBoostsApplied(
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
        sheetInput.featOptions,
        epicBoonFeatSlugs,
      ),
    );
    await this.domain.applyDerivedHitPoints(
      entity,
      {
        hitPointsMax: dto.hitPointsMax,
        hitPointsCurrent: dto.hitPointsCurrent,
      },
      (sheetInput.characterFeats ?? []).map((feat) => feat.featSlug),
    );

    const saved = await this.repository.save(entity);
    await this.sheetRepository.sync(saved.id, sheetInput);
    await this.seedStartingInventory.execute(saved.id, sheetInput.equipment);

    return this.mapper.toDto(saved);
  }

  private toSheetInput(
    dto: CreateCharacterDto,
    characterFeats?: CharacterFeatDto[],
  ): CharacterSheetInput {
    return {
      classSkillSlugs: dto.classSkillSlugs,
      speciesChoices: dto.speciesChoices,
      subclassOptions: dto.subclassOptions,
      classOptions: dto.classOptions,
      characterFeats: characterFeats ?? dto.characterFeats,
      featOptions: dto.featOptions,
      characterSpells: dto.characterSpells,
      equipment: dto.equipment,
      languageSlugs: dto.languageSlugs,
      abilityGenerationMethodSlug: dto.abilityGenerationMethodSlug,
    };
  }
}
