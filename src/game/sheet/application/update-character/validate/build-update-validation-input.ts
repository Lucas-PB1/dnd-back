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

/**
 * Injeta contexto de proficiência/feats já na ficha quando o patch omite campos
 * que a validação ainda precisa (ex.: level-up com expertise/weapon mastery).
 */
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
  /** Expertise/mastery precisam das perícias da ficha mesmo quando classOptions vêm do snapshot (só level↑). */
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
