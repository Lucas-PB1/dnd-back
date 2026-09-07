import { collectClassExtraSkillSlugs } from '../../validation/class-options/class-extra-skill-slots';
import { collectSubclassBonusSkillSlugs } from '../../validation/class-options/subclass-option-effects';
import {
  expertiseSkillSlugsFromEffects,
  fixedSkillSlugsFromEffects,
  isChoiceSkillOptionKey,
  proficiencyOptionKeysFromEffects,
} from '@game/effects';
import type { CatalogEffect } from '@game/effects';
import {
  SKILL_SPECIES_CHOICE_KINDS,
  type CharacterFeatLike,
  type ClassOptionLike,
  type FeatOptionLike,
  type SkillBonusSources,
  type SpeciesChoiceLike,
} from './types';

function choiceSkillOptionKeysForFeat(
  featEffects: readonly CatalogEffect[] | undefined,
  featSlug: string,
): string[] {
  return proficiencyOptionKeysFromEffects({
    effects: featEffects ?? [],
    featSlug,
    proficiencyKind: 'skill',
  }).filter(isChoiceSkillOptionKey);
}

function isProfOrExpertiseChoiceOption(
  option: FeatOptionLike,
  featEffects: readonly CatalogEffect[] | undefined,
): boolean {
  return choiceSkillOptionKeysForFeat(featEffects, option.featSlug).includes(
    option.optionKey,
  );
}

function collectFixedFeatSkillSlugsFromEffects(
  characterFeats: readonly CharacterFeatLike[] | undefined,
  featEffects: readonly CatalogEffect[] | undefined,
): string[] {
  if (!characterFeats?.length || !featEffects?.length) return [];
  return fixedSkillSlugsFromEffects(
    featEffects,
    characterFeats.map((feat) => feat.featSlug),
  );
}

function collectExpertiseFeatSkillSlugsFromEffects(
  characterFeats: readonly CharacterFeatLike[] | undefined,
  featEffects: readonly CatalogEffect[] | undefined,
): string[] {
  if (!characterFeats?.length || !featEffects?.length) return [];
  return expertiseSkillSlugsFromEffects(
    featEffects,
    characterFeats.map((feat) => feat.featSlug),
  );
}

export function collectFeatSkillOptionSlugs(
  featOptions: readonly FeatOptionLike[] | undefined,
  featEffects?: readonly CatalogEffect[],
): string[] {
  if (!featOptions?.length) return [];
  return featOptions
    .filter((option) => {
      const effectKeys = proficiencyOptionKeysFromEffects({
        effects: featEffects ?? [],
        featSlug: option.featSlug,
        proficiencyKind: 'skill',
      });
      return effectKeys.includes(option.optionKey);
    })
    .map((option) => option.valueId)
    .filter(Boolean);
}

export function collectSpeciesSkillSlugs(
  speciesChoices: readonly SpeciesChoiceLike[] | undefined,
): string[] {
  if (!speciesChoices?.length) return [];
  return speciesChoices
    .filter((choice) => SKILL_SPECIES_CHOICE_KINDS.has(choice.choiceKind))
    .map((choice) => choice.choiceSlug)
    .filter(Boolean);
}

export function collectClassExpertiseSkillSlugs(
  classOptions: readonly ClassOptionLike[] | undefined,
): string[] {
  if (!classOptions?.length) return [];
  return classOptions
    .filter(
      (option) =>
        option.optionKey.startsWith('expertiseSkill') && option.valueId,
    )
    .map((option) => option.valueId);
}

/** Proficiências “base” (sem expertise condicional Observant/Keen Mind / similar). */
function collectPriorProficientSkillSlugs(input: SkillBonusSources): string[] {
  const featOptions = (input.featOptions ?? []).filter(
    (option) => !isProfOrExpertiseChoiceOption(option, input.featEffects),
  );
  return [
    ...new Set([
      ...(input.classSkillSlugs ?? []),
      ...(input.backgroundSkillSlugs ?? []),
      ...collectSpeciesSkillSlugs(input.speciesChoices),
      ...collectFeatSkillOptionSlugs(featOptions, input.featEffects),
      ...collectClassExtraSkillSlugs(input.classOptions),
      ...collectSubclassBonusSkillSlugs(input.subclassOptions),
    ]),
  ];
}

export function collectExpertiseSkillSlugs(
  input: SkillBonusSources,
): string[] {
  const prior = new Set(collectPriorProficientSkillSlugs(input));
  const result = new Set<string>(
    collectClassExpertiseSkillSlugs(input.classOptions),
  );
  const fixedFeatSkills = collectFixedFeatSkillSlugsFromEffects(
    input.characterFeats,
    input.featEffects,
  );

  for (const option of input.featOptions ?? []) {
    if (option.optionKey === 'expertiseSkill' && option.valueId) {
      result.add(option.valueId);
    }
    if (
      isProfOrExpertiseChoiceOption(option, input.featEffects) &&
      option.valueId &&
      prior.has(option.valueId)
    ) {
      result.add(option.valueId);
    }
  }

  for (const skill of fixedFeatSkills) {
    if (prior.has(skill)) result.add(skill);
  }

  for (const skill of collectExpertiseFeatSkillSlugsFromEffects(
    input.characterFeats,
    input.featEffects,
  )) {
    if (prior.has(skill)) result.add(skill);
  }

  return [...result];
}

export function collectProficientSkillSlugs(
  input: SkillBonusSources,
): string[] {
  const set = new Set([
    ...collectPriorProficientSkillSlugs(input),
    ...collectFeatSkillOptionSlugs(
      (input.featOptions ?? []).filter((option) =>
        isProfOrExpertiseChoiceOption(option, input.featEffects),
      ),
      input.featEffects,
    ),
    ...collectFixedFeatSkillSlugsFromEffects(
      input.characterFeats,
      input.featEffects,
    ),
    ...collectClassExpertiseSkillSlugs(input.classOptions),
  ]);
  return [...set];
}
