import {
  CharacterSheetInput,
  CharacterSheetContext,
} from '@game/sheet/domain/character-sheet.types';
import type { CharacterSpeciesChoicesValidator } from '../character-species-choices.validator';
import type { CharacterHeritageChoicesValidator } from '../character-heritage-choices.validator';

export type OriginChoicesValidationDeps = {
  speciesChoicesValidator: CharacterSpeciesChoicesValidator;
  heritageChoicesValidator: CharacterHeritageChoicesValidator;
};

export async function validateSpeciesChoices(
  deps: OriginChoicesValidationDeps,
  speciesSlug: string,
  choices: CharacterSheetInput['speciesChoices'],
): Promise<void> {
  return deps.speciesChoicesValidator.validateSpeciesChoices(
    speciesSlug,
    choices,
  );
}

export async function validateHeritageChoices(
  deps: OriginChoicesValidationDeps,
  heritageSlug: string,
  choices: CharacterSheetInput['heritageChoices'],
): Promise<void> {
  return deps.heritageChoicesValidator.validateHeritageChoices(
    heritageSlug,
    choices,
  );
}

export async function validateOriginChoices(
  deps: OriginChoicesValidationDeps,
  ctx: Pick<CharacterSheetContext, 'speciesSlug' | 'heritageSlug'>,
  input: Pick<CharacterSheetInput, 'speciesChoices' | 'heritageChoices'>,
): Promise<void> {
  if (ctx.heritageSlug?.trim()) {
    await validateHeritageChoices(deps, ctx.heritageSlug, input.heritageChoices);
    return;
  }
  if (!ctx.speciesSlug?.trim()) return;
  await validateSpeciesChoices(deps, ctx.speciesSlug, input.speciesChoices);
}
