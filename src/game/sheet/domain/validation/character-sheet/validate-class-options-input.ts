import {
  CharacterSheetInput,
  CharacterSheetContext,
} from '../../character-sheet.types';
import type { ValidateSheetInputDeps } from './types';

export async function validateClassOptionsInput(
  deps: Pick<
    ValidateSheetInputDeps,
    | 'classOptionsValidator'
    | 'extraSkillValidator'
    | 'mysticArcanumValidator'
    | 'signatureSpellsValidator'
  >,
  input: CharacterSheetInput,
  ctx: CharacterSheetContext,
): Promise<void> {
  if (input.classOptions === undefined) return;

  const { classOptionsValidator: classOpts } = deps;

  await classOpts.validateClassExpertiseOptions(
    ctx,
    input.classOptions,
    input.classSkillSlugs,
    input.speciesChoices,
    input.featOptions,
  );
  await classOpts.validateClassWeaponMasteryOptions(ctx, input.classOptions, {
    characterFeats: input.characterFeats ?? ctx.characterFeats,
    subclassOptions: input.subclassOptions,
  });
  await classOpts.validateSpellMasteryOptions(
    ctx,
    input.classOptions,
    input.characterSpells,
  );
  await classOpts.validateEldritchInvocationOptions(
    ctx,
    input.classOptions,
    input.characterSpells,
    input.characterFeats ?? ctx.characterFeats,
  );
  await classOpts.validateMetamagicOptions(ctx, input.classOptions);
  await classOpts.validateClassFeatureOptions(ctx, input.classOptions);
  await deps.extraSkillValidator.validateClassExtraSkillOptions(
    ctx,
    input.classOptions,
    input.classSkillSlugs,
    input.speciesChoices,
    input.featOptions,
  );
  await deps.mysticArcanumValidator.validateMysticArcanumOptions(
    ctx,
    input.classOptions,
  );
  await deps.signatureSpellsValidator.validateSignatureSpellOptions(
    ctx,
    input.classOptions,
    input.characterSpells,
  );
}
