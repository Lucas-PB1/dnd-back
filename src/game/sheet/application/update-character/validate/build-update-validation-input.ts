import {
  CharacterSheetData,
  CharacterSheetInput,
} from '@game/sheet/domain/character-sheet.types';
import {
  FeatOptionDto,
  SpeciesChoiceDto,
} from '@game/sheet/dto/character-sheet.dto';

type EffectiveIdentitySlugs = {
  speciesSlug: string | null;
  heritageSlug: string | null;
};


export function buildUpdateValidationInput(input: {
  sheetInput: CharacterSheetInput;
  sheetSnapshot: CharacterSheetData;
  shouldResyncSpells: boolean;
  effective: EffectiveIdentitySlugs;
  effectiveFeatOptions: FeatOptionDto[];
  effectiveSpeciesChoices: SpeciesChoiceDto[];
  effectiveHeritageChoices: SpeciesChoiceDto[];
}): CharacterSheetInput {
  const {
    sheetInput,
    sheetSnapshot,
    shouldResyncSpells,
    effective,
    effectiveFeatOptions,
    effectiveSpeciesChoices,
    effectiveHeritageChoices,
  } = input;

  const patchHasClassOptions = sheetInput.classOptions !== undefined;
  const injectClassOptions =
    shouldResyncSpells && sheetInput.classOptions === undefined;
  const needsProficiencyContext = patchHasClassOptions || injectClassOptions;

  const injectFeatOptions =
    (shouldResyncSpells || needsProficiencyContext) &&
    sheetInput.featOptions === undefined;
  const injectSubclassOptions =
    shouldResyncSpells && sheetInput.subclassOptions === undefined;
  const injectHeritageChoices =
    (shouldResyncSpells || needsProficiencyContext) &&
    sheetInput.heritageChoices === undefined &&
    effective.heritageSlug;
  const injectSpeciesChoices =
    (shouldResyncSpells || needsProficiencyContext) &&
    sheetInput.speciesChoices === undefined &&
    effective.speciesSlug;

  return {
    ...sheetInput,
    ...(needsProficiencyContext && sheetInput.classSkillSlugs === undefined
      ? { classSkillSlugs: sheetSnapshot.classSkillSlugs }
      : {}),
    ...(needsProficiencyContext && sheetInput.characterSpells === undefined
      ? { characterSpells: sheetSnapshot.characterSpells }
      : {}),
    ...(injectFeatOptions ? { featOptions: effectiveFeatOptions } : {}),
    ...(injectSubclassOptions
      ? { subclassOptions: sheetSnapshot.subclassOptions }
      : {}),
    ...(injectSpeciesChoices
      ? { speciesChoices: effectiveSpeciesChoices }
      : {}),
    ...(injectHeritageChoices
      ? { heritageChoices: effectiveHeritageChoices }
      : {}),
    ...(injectClassOptions
      ? { classOptions: sheetSnapshot.classOptions }
      : {}),
  };
}
