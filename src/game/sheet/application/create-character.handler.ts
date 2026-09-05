import {
  Injectable,
  UnauthorizedException,
} from '@nestjs/common';
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
import { LoadGrantedSpellCatalog } from '@game/spellcasting/application/load-granted-spell-catalog';
import { ResolveSubclassOptionGrantedSpells } from '@game/spellcasting/application/resolve-subclass-option-granted-spells';
import { SeedStartingInventoryHandler } from '@game/inventory/application/query/seed-starting-inventory.handler';
import { LoadEffectCatalog } from '@game/effects';
import {
  AUTH_USER_MISSING_MESSAGE,
  assertAuthUserExists,
  isPlayerCharacterUserFkError,
} from './create-character/assert-auth-user';
import { mergeCreateCharacterSpells } from './create-character/merge-create-character-spells';
import { resolveCreateOrigin } from './create-character/resolve-create-origin';
import { toCreateSheetInput } from './create-character/to-sheet-input';

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
    private readonly resolveSubclassOptionGrants: ResolveSubclassOptionGrantedSpells,
    private readonly effectCatalog: LoadEffectCatalog,
    private readonly dataSource: DataSource,
  ) {}

  async execute(userId: string, dto: CreateCharacterDto): Promise<CharacterResponseDto> {
    await this.catalogLookup.validateCharacterCatalogRefs({
      classSlug: dto.classSlug,
      speciesSlug: dto.speciesSlug,
      heritageSlug: dto.heritageSlug,
      backgroundSlug: dto.backgroundSlug,
      subclassSlug: dto.subclassSlug,
      alignmentSlug: dto.alignmentSlug,
    });

    const level = dto.level ?? 1;

    const ctx = {
      level,
      classSlug: dto.classSlug,
      speciesSlug: dto.speciesSlug?.trim() ?? '',
      heritageSlug: dto.heritageSlug?.trim() || null,
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

    const { characterFeats, backgroundToolItemSlug } = await resolveCreateOrigin({
      catalogLookup: this.catalogLookup,
      sheetValidator: this.sheetValidator,
      dto,
      effectCatalog: this.effectCatalog,
    });

    const sheetInput = toCreateSheetInput(dto, characterFeats);
    await mergeCreateCharacterSpells({
      dto,
      sheetInput,
      level,
      grantedSpellCatalog: this.grantedSpellCatalog,
      resolveSubclassOptionGrants: this.resolveSubclassOptionGrants,
      dataSource: this.dataSource,
      effectCatalog: this.effectCatalog,
    });

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

    const startingGold = await this.sheetValidator.resolveStartingGold(
      sheetInput.equipment,
      { classSlug: dto.classSlug, backgroundSlug: dto.backgroundSlug },
    );
    if (startingGold > 0) {
      entity.coinGold = startingGold;
    }

    await assertAuthUserExists(this.dataSource, userId);

    let saved;
    try {
      saved = await this.repository.save(entity);
    } catch (error) {
      if (isPlayerCharacterUserFkError(error)) {
        throw new UnauthorizedException(AUTH_USER_MISSING_MESSAGE);
      }
      throw error;
    }
    await this.sheetRepository.sync(saved.id, sheetInput);
    await this.seedStartingInventory.execute(saved.id, sheetInput.equipment);

    return this.mapper.toDto(saved);
  }
}
