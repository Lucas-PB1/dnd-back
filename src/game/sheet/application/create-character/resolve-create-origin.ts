import { DataSource } from 'typeorm';
import { CatalogLookupService } from '@catalog/catalog-lookup.service';
import { LoadEffectCatalog } from '@game/effects';
import { CharacterSheetValidator } from '../../domain/validation/character-sheet.validator';
import { CreateCharacterDto } from '../../dto/create-character.dto';
import { CharacterFeatDto } from '../../dto/character-sheet.dto';
import {
  mergeGrantedLanguageSlugs,
  resolveBackgroundOriginCharacterFeats,
  resolveBackgroundToolItemSlug,
} from '../../domain/origin/background-origin';
import { resolveHumanOriginCharacterFeats } from '../../domain/origin/species-origin';
import { resolveLessonsOriginCharacterFeats } from '../../domain/origin/lessons-origin';
import { classLanguageGrant } from '../../domain/validation/class-options/class-language-grant';
import { loadBackgroundLanguageSlugs } from '../../infrastructure/queries/background-origin.queries';

export async function resolveCreateOrigin(input: {
  catalogLookup: CatalogLookupService;
  sheetValidator: CharacterSheetValidator;
  dataSource: DataSource;
  dto: CreateCharacterDto;
  effectCatalog?: LoadEffectCatalog;
}): Promise<{
  characterFeats: CharacterFeatDto[] | undefined;
  backgroundToolItemSlug: string | null;
  languageSlugs: string[];
}> {
  const { catalogLookup, sheetValidator, dataSource, dto, effectCatalog } = input;

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

  const fixedLanguages = await loadBackgroundLanguageSlugs(
    dataSource,
    dto.backgroundSlug,
  );
  const classLanguages = classLanguageGrant(dto.classSlug, dto.level ?? 1);
  const languageSlugs = mergeGrantedLanguageSlugs(dto.languageSlugs, [
    ...fixedLanguages,
    ...classLanguages.grantedSlugs,
  ]);

  return { characterFeats, backgroundToolItemSlug, languageSlugs };
}
