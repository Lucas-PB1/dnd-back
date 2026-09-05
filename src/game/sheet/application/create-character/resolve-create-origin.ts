import { CatalogLookupService } from '@catalog/catalog-lookup.service';
import { LoadEffectCatalog } from '@game/effects';
import { CharacterSheetValidator } from '../../domain/validation/character-sheet.validator';
import { CreateCharacterDto } from '../../dto/create-character.dto';
import { CharacterFeatDto } from '../../dto/character-sheet.dto';
import {
  resolveBackgroundOriginCharacterFeats,
  resolveBackgroundToolItemSlug,
} from '../../domain/origin/background-origin';
import { resolveHumanOriginCharacterFeats } from '../../domain/origin/species-origin';
import { resolveLessonsOriginCharacterFeats } from '../../domain/origin/lessons-origin';

export async function resolveCreateOrigin(input: {
  catalogLookup: CatalogLookupService;
  sheetValidator: CharacterSheetValidator;
  dto: CreateCharacterDto;
  effectCatalog?: LoadEffectCatalog;
}): Promise<{
  characterFeats: CharacterFeatDto[] | undefined;
  backgroundToolItemSlug: string | null;
}> {
  const { catalogLookup, sheetValidator, dto, effectCatalog } = input;

  const background = await catalogLookup.findBackgroundOrFail(dto.backgroundSlug);
  let characterFeats = resolveBackgroundOriginCharacterFeats(
    background,
    dto.characterFeats,
  );
  const speciesSlug = dto.speciesSlug ?? '';
  const speciesEffects =
    effectCatalog && speciesSlug
      ? await effectCatalog.load({
          ownerKind: 'species',
          ownerSlugs: [speciesSlug],
          kinds: ['grant_feat'],
        })
      : undefined;
  characterFeats = resolveHumanOriginCharacterFeats(
    speciesSlug,
    dto.speciesChoices,
    characterFeats,
    speciesEffects,
  );
  characterFeats = resolveLessonsOriginCharacterFeats(
    dto.classOptions,
    characterFeats,
  );
  const backgroundToolItemSlug = resolveBackgroundToolItemSlug(
    background,
    dto.backgroundToolItemSlug,
  );

  await sheetValidator.validateBackgroundToolChoice(
    background,
    backgroundToolItemSlug,
  );
  await sheetValidator.validateBackgroundOriginFeat(background, characterFeats);

  return { characterFeats, backgroundToolItemSlug };
}
