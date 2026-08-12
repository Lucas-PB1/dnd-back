import { BadRequestException } from '@nestjs/common';
import {
  SPELL_MASTERY_LEVEL_1_KEY,
  SPELL_MASTERY_LEVEL_2_KEY,
  SPELL_MASTERY_UNLOCK_LEVEL,
} from '@game/combat/domain/wizard';
import { mysticArcanumSlotsAtLevel } from '@game/combat/domain/warlock';
import { signatureSpellKeysAtLevel } from '@game/combat/domain/wizard/signature-spells';
import {
  CharacterSheetContext,
  CharacterSheetInput,
} from '@game/sheet/domain/character-sheet.types';
import { classExpertiseSlotsAtLevel } from './class-expertise-slots';
import { classExtraSkillSlotsAtLevel } from './class-extra-skill-slots';
import { classWeaponMasterySlotsAtLevel } from './class-weapon-mastery-slots';
import { missingFilledOptionKeys } from './create-required-option-keys';
import type { CharacterClassOptionsValidator } from './character-class-options.validator';
import type { CharacterClassExtraSkillValidator } from './character-class-extra-skill.validator';
import type { CharacterMysticArcanumValidator } from './character-mystic-arcanum.validator';
import type { CharacterSignatureSpellsValidator } from './character-signature-spells.validator';

export async function assertCreateProgressionPicks(input: {
  ctx: CharacterSheetContext;
  sheet: CharacterSheetInput;
  classOptionsValidator: CharacterClassOptionsValidator;
  extraSkillValidator: CharacterClassExtraSkillValidator;
  mysticArcanumValidator: CharacterMysticArcanumValidator;
  signatureSpellsValidator: CharacterSignatureSpellsValidator;
}): Promise<void> {
  const { ctx, sheet, classOptionsValidator, extraSkillValidator } = input;
  const provided = sheet.classOptions ?? [];

  const expertiseSlots = classExpertiseSlotsAtLevel(ctx.classSlug, ctx.level);
  const missingExpertise = missingFilledOptionKeys(
    expertiseSlots.map((slot) => slot.optionKey),
    provided,
  );
  if (missingExpertise.length > 0) {
    throw new BadRequestException(
      `Class '${ctx.classSlug}' requires expertise options: ${missingExpertise.join(', ')}`,
    );
  }
  if (expertiseSlots.length > 0) {
    await classOptionsValidator.validateClassExpertiseOptions(
      ctx,
      provided,
      sheet.classSkillSlugs,
      sheet.speciesChoices,
      sheet.featOptions,
    );
  }

  const extraSkillSlots = classExtraSkillSlotsAtLevel(ctx.classSlug, ctx.level);
  const missingExtraSkill = missingFilledOptionKeys(
    extraSkillSlots.map((slot) => slot.optionKey),
    provided,
  );
  if (missingExtraSkill.length > 0) {
    throw new BadRequestException(
      `Classe '${ctx.classSlug}' exige perícia extra: ${missingExtraSkill.join(', ')}.`,
    );
  }
  if (extraSkillSlots.length > 0) {
    await extraSkillValidator.validateClassExtraSkillOptions(
      ctx,
      provided,
      sheet.classSkillSlugs,
      sheet.speciesChoices,
      sheet.featOptions,
    );
  }

  const masterySlots = classWeaponMasterySlotsAtLevel(
    await classOptionsValidator.loadWeaponMasteryProgression(ctx.classSlug),
    ctx.level,
  );
  const missingMastery = missingFilledOptionKeys(
    masterySlots.map((slot) => slot.optionKey),
    provided,
  );
  if (missingMastery.length > 0) {
    throw new BadRequestException(
      `Class '${ctx.classSlug}' requires weapon mastery options: ${missingMastery.join(', ')}`,
    );
  }
  if (masterySlots.length > 0) {
    await classOptionsValidator.validateClassWeaponMasteryOptions(ctx, provided);
  }

  const masterySpellKeys =
    ctx.classSlug === 'wizard' && ctx.level >= SPELL_MASTERY_UNLOCK_LEVEL
      ? [SPELL_MASTERY_LEVEL_1_KEY, SPELL_MASTERY_LEVEL_2_KEY]
      : [];
  const missingSpellMastery = missingFilledOptionKeys(masterySpellKeys, provided);
  if (missingSpellMastery.length > 0) {
    throw new BadRequestException(
      `Mago exige Maestria de Magias: ${missingSpellMastery.join(', ')}.`,
    );
  }
  if (masterySpellKeys.length > 0) {
    await classOptionsValidator.validateSpellMasteryOptions(
      ctx,
      provided,
      sheet.characterSpells,
    );
  }

  const signatureKeys = signatureSpellKeysAtLevel(
    ctx.classSlug === 'wizard' ? ctx.level : 0,
  );
  const missingSignature = missingFilledOptionKeys(signatureKeys, provided);
  if (missingSignature.length > 0) {
    throw new BadRequestException(
      `Mago exige Assinatura Mágica: ${missingSignature.join(', ')}.`,
    );
  }
  if (signatureKeys.length > 0) {
    await input.signatureSpellsValidator.validateSignatureSpellOptions(
      ctx,
      provided,
      sheet.characterSpells,
    );
  }

  const arcanumKeys = mysticArcanumSlotsAtLevel(
    ctx.classSlug === 'warlock' ? ctx.level : 0,
  ).map((slot) => slot.optionKey);
  const missingArcanum = missingFilledOptionKeys(arcanumKeys, provided);
  if (missingArcanum.length > 0) {
    throw new BadRequestException(
      `Bruxo exige Arcana Mística: ${missingArcanum.join(', ')}.`,
    );
  }
  if (arcanumKeys.length > 0) {
    await input.mysticArcanumValidator.validateMysticArcanumOptions(ctx, provided);
  }
}
