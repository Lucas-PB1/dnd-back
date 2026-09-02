import { CatalogLookupService } from '@catalog/catalog-lookup.service';
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
}): Promise<{
  characterFeats: CharacterFeatDto[] | undefined;
  backgroundToolItemSlug: string | null;
}> {
  const { catalogLookup, sheetValidator, dto } = input;

  const background = await catalogLookup.findBackgroundOrFail(dto.backgroundSlug);
  let characterFeats = resolveBackgroundOriginCharacterFeats(
    background,
    dto.characterFeats,
  );
  characterFeats = resolveHumanOriginCharacterFeats(
    dto.speciesSlug ?? '',
    dto.speciesChoices,
    characterFeats,
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
