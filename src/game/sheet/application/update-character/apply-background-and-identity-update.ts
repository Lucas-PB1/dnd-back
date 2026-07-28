import { CatalogLookupService } from '../../../../catalog/catalog-lookup.service';
import { CharacterSheetValidator } from '../../domain/validation/character-sheet.validator';
import { CharacterFactory } from '../../domain/core/character.factory';
import {
  applyBackgroundAbilityBoosts,
  resolveBackgroundAbilityBoostInput,
} from '../../domain/origin/background-ability-boost';
import { resolveBackgroundToolItemSlug } from '../../domain/origin/background-origin';
import { UpdateCharacterDto } from '../../dto/update-character.dto';
import { PlayerCharacter } from '../../../shared/infrastructure/player-character.entity';

type EffectiveIdentity = {
  backgroundSlug: string;
};

/** Aplica patch de background (boosts/tool) + UpdateCharacterDto na row. */
export async function applyBackgroundAndIdentityUpdate(input: {
  row: PlayerCharacter;
  dto: UpdateCharacterDto;
  effective: EffectiveIdentity;
  catalogLookup: CatalogLookupService;
  sheetValidator: CharacterSheetValidator;
  backgroundChanged: boolean;
}): Promise<void> {
  const { row, dto, effective, catalogLookup, sheetValidator, backgroundChanged } =
    input;

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
    const background = await catalogLookup.findBackgroundOrFail(
      effective.backgroundSlug,
    );
    const resolvedTool = resolveBackgroundToolItemSlug(
      background,
      updateDto.backgroundToolItemSlug,
    );
    await sheetValidator.validateBackgroundToolChoice(background, resolvedTool);
    updateDto.backgroundToolItemSlug = resolvedTool ?? undefined;
  }

  CharacterFactory.applyUpdate(
    row,
    scoresAreBase ? { ...updateDto, abilityScores: undefined } : updateDto,
  );

  if (boostPatch) {
    await sheetValidator.validateBackgroundAbilityBoosts(effective.backgroundSlug, {
      mode: row.backgroundBoostMode,
      plus2Slug: row.backgroundBoostPlus2AbilitySlug,
      plus1Slug: row.backgroundBoostPlus1AbilitySlug,
      plus1Slugs: row.backgroundBoostPlus1Slugs,
    });
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
}
