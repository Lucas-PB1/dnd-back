import { Injectable } from '@nestjs/common';
import { DataSource } from 'typeorm';
import { CatalogLookupService } from '@catalog/catalog-lookup.service';
import { CharacterDomainService } from '../domain/core/character-domain.service';
import { CharacterRepository } from '@game/shared/infrastructure/character.repository';
import { CharacterSheetRepository } from '../infrastructure/character-sheet.repository';
import { CharacterSheetValidator } from '../domain/validation/character-sheet.validator';
import { CharacterMapper } from '../infrastructure/character.mapper';
import { UpdateCharacterDto } from '../dto/update-character.dto';
import { CharacterResponseDto } from '../dto/character-response.dto';
import { SeedStartingInventoryHandler } from '@game/inventory/application/query/seed-starting-inventory.handler';
import { LoadGrantedSpellCatalog } from '@game/spellcasting/application/load-granted-spell-catalog';
import { ResolveSubclassOptionGrantedSpells } from '@game/spellcasting/application/resolve-subclass-option-granted-spells';
import { LoadEffectCatalog } from '@game/effects';
import { applyBackgroundAndIdentityUpdate } from './update-character/apply-background-and-identity-update';
import { mergeUpdateCharacterSpells } from './update-character/merge-update-character-spells';
import { clearStaleSheetChoices } from './update-character/sheet/clear-stale-sheet-choices';
import { resolveEffectiveUpdateSheet } from './update-character/sheet/resolve-effective-update-sheet';
import {
  detectCharacterIdentityChanges,
  featSlugsOf,
  shouldResyncCharacterSpells,
  toSheetInput,
} from './update-character/sheet/update-sheet-input';
import { buildUpdateValidationInput } from './update-character/validate/build-update-validation-input';
import {
  resolveEffectiveCharacterIdentity,
  validateUpdateCatalogRefsIfNeeded,
} from './update-character/validate/resolve-effective-identity';
import { validateUpdateCharacterSheet } from './update-character/validate/validate-update-character-sheet';

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
    private readonly resolveSubclassOptionGrants: ResolveSubclassOptionGrantedSpells,
    private readonly dataSource: DataSource,
    private readonly effectCatalog: LoadEffectCatalog,
  ) {}

  async execute(
    userId: string,
    id: string,
    dto: UpdateCharacterDto,
  ): Promise<CharacterResponseDto> {
    const row = await this.repository.findAccessibleOrFail(userId, id, 'write');
    const effective = resolveEffectiveCharacterIdentity(dto, row);

    await validateUpdateCatalogRefsIfNeeded({
      catalogLookup: this.catalogLookup,
      dto,
      row,
      effective,
    });
    await this.sheetValidator.validateLevelRules(effective);

    const sheetSnapshot = await this.sheetRepository.load(row.id, effective.backgroundSlug);
    const {
      effectiveCharacterFeats,
      effectiveFeatOptions,
      effectiveSpeciesChoices,
      effectiveHeritageChoices,
    } = await resolveEffectiveUpdateSheet({
      dataSource: this.dataSource,
      characterId: row.id,
      dto,
      sheetSnapshot,
    });

    const {
      levelChanged,
      speciesChanged,
      subclassChanged,
      classChanged,
      backgroundChanged,
    } = detectCharacterIdentityChanges(dto, row);

    const shouldResyncSpells = shouldResyncCharacterSpells(
      dto,
      levelChanged,
      speciesChanged,
      subclassChanged,
      classChanged,
    );

    const sheetInput = toSheetInput(dto);
    if (dto.classOptions !== undefined && dto.characterFeats === undefined) {
      sheetInput.characterFeats = effectiveCharacterFeats;
    }
    if (shouldResyncSpells) {
      await mergeUpdateCharacterSpells({
        dto,
        sheetInput,
        sheetSnapshot,
        effective,
        previous: {
          classSlug: row.classSlug,
          speciesSlug: row.speciesSlug,
          subclassSlug: row.subclassSlug,
          level: row.level,
        },
        effectiveCharacterFeats,
        effectiveFeatOptions,
        effectiveSpeciesChoices,
        grantedSpellCatalog: this.grantedSpellCatalog,
        resolveSubclassOptionGrants: this.resolveSubclassOptionGrants,
        dataSource: this.dataSource,
        effectCatalog: this.effectCatalog,
      });
    }

    await validateUpdateCharacterSheet({
      sheetValidator: this.sheetValidator,
      dto,
      validationInput: buildUpdateValidationInput({
        sheetInput,
        sheetSnapshot,
        shouldResyncSpells,
        effective,
        effectiveFeatOptions,
        effectiveSpeciesChoices,
        effectiveHeritageChoices,
      }),
      effective,
      sheetSnapshot,
      effectiveCharacterFeats,
      effectiveFeatOptions,
      rowLevel: row.level,
      rowClassSlug: row.classSlug,
    });

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
