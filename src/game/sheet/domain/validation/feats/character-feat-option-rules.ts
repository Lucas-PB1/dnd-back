import { BadRequestException } from '@nestjs/common';
import { assertUnique } from '../../../../../common/assert';
import { FeatOptionDto, CharacterFeatDto } from '../../../dto/character-sheet.dto';
import {
  ABILITY_SCORE_IMPROVEMENT_FEAT_SLUG,
  ASI_DISTRIBUTION_PLUS1PLUS1,
  ASI_DISTRIBUTION_PLUS2,
} from './ability-score-improvement-feat-options';
import { isFeatCastingLinkedToAsi } from './linked-casting-feat-options';
import {
  ritualSpellSlotIndex,
  RITUAL_CASTER_FEAT_SLUG,
} from './ritual-caster-feat-options';

/** Regras síncronas de opções de feat (ASI, Magic Initiate, Ritual Caster, casting ligado). */
export function validateAbilityScoreImprovement(
  characterFeats: CharacterFeatDto[],
  options: FeatOptionDto[],
): void {
  for (const feat of characterFeats.filter(
    (f) => f.featSlug === ABILITY_SCORE_IMPROVEMENT_FEAT_SLUG,
  )) {
    const featOptions = options.filter(
      (o) =>
        o.featSlug === ABILITY_SCORE_IMPROVEMENT_FEAT_SLUG &&
        (o.instanceIndex ?? 0) === feat.instanceIndex,
    );
    const mode = featOptions.find((o) => o.optionKey === 'distributionMode')?.valueId;
    const primary = featOptions.find((o) => o.optionKey === 'primaryAbility')?.valueId;
    const secondary = featOptions.find(
      (o) => o.optionKey === 'secondaryAbility',
    )?.valueId;

    if (mode && mode !== ASI_DISTRIBUTION_PLUS2 && mode !== ASI_DISTRIBUTION_PLUS1PLUS1) {
      throw new BadRequestException(
        `Invalid distributionMode '${mode}' for ability-score-improvement`,
      );
    }

    if (mode === ASI_DISTRIBUTION_PLUS2 && secondary) {
      throw new BadRequestException(
        'secondaryAbility is not used when distribution is +2 on one ability',
      );
    }

    if (mode === ASI_DISTRIBUTION_PLUS1PLUS1 && primary && secondary && primary === secondary) {
      throw new BadRequestException(
        'Ability Score Improvement +1/+1 choices must be different abilities',
      );
    }
  }
}

export function validateLinkedCastingAbilityMatchesAsi(
  characterFeats: CharacterFeatDto[],
  options: FeatOptionDto[],
): void {
  for (const feat of characterFeats.filter((f) => isFeatCastingLinkedToAsi(f.featSlug))) {
    const featOptions = options.filter(
      (o) =>
        o.featSlug === feat.featSlug &&
        (o.instanceIndex ?? 0) === feat.instanceIndex,
    );
    const asi = featOptions.find((o) => o.optionKey === 'abilityIncrease')?.valueId;
    const casting = featOptions.find((o) => o.optionKey === 'castingAbility')?.valueId;
    if (!asi || !casting) continue;
    if (asi !== casting) {
      throw new BadRequestException(
        `Feat '${feat.featSlug}' requires the same attribute for +1 and spell casting`,
      );
    }
  }
}

export function validateRitualCasterSpells(
  characterFeats: CharacterFeatDto[],
  options: FeatOptionDto[],
  proficiencyBonus: number,
): void {
  for (const feat of characterFeats.filter((f) => f.featSlug === RITUAL_CASTER_FEAT_SLUG)) {
    const featOptions = options.filter(
      (o) =>
        o.featSlug === RITUAL_CASTER_FEAT_SLUG &&
        (o.instanceIndex ?? 0) === feat.instanceIndex,
    );
    const ritualSlugs = featOptions
      .filter((o) => ritualSpellSlotIndex(o.optionKey) !== null)
      .map((o) => o.valueId);
    if (ritualSlugs.some((value) => !value)) continue;
    assertUnique(ritualSlugs, 'Ritual Caster spell choices must be distinct');
    const extra = featOptions.filter((o) => {
      const slot = ritualSpellSlotIndex(o.optionKey);
      return slot !== null && slot > proficiencyBonus;
    });
    if (extra.length > 0) {
      throw new BadRequestException(
        `Feat 'ritual-caster' allows ${proficiencyBonus} ritual spell choice(s) at this level`,
      );
    }
  }
}

export function validateMagicInitiateSpellLists(
  characterFeats: CharacterFeatDto[],
  options: FeatOptionDto[],
): void {
  const instances = characterFeats.filter((feat) => feat.featSlug === 'magic-initiate');
  if (instances.length <= 1) return;

  const spellLists = instances.map((instance) =>
    options.find(
      (option) =>
        option.featSlug === 'magic-initiate' &&
        (option.instanceIndex ?? 0) === instance.instanceIndex &&
        option.optionKey === 'spellList',
    )?.valueId,
  );

  if (spellLists.some((value) => !value)) return;
  assertUnique(
    spellLists,
    'Each Magic Initiate instance must choose a different spell list',
  );
}
