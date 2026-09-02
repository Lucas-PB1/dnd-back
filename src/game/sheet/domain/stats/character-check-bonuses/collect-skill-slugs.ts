import { collectClassExtraSkillSlugs } from '../../validation/class-options/class-extra-skill-slots';
import { collectSubclassBonusSkillSlugs } from '../../validation/class-options/subclass-option-effects';
import {
  FIXED_FEAT_SKILL_SLUGS,
  PROF_OR_EXPERTISE_FEAT_OPTION_KEYS,
  SKILL_SPECIES_CHOICE_KINDS,
  type CharacterFeatLike,
  type ClassOptionLike,
  type FeatOptionLike,
  type SkillBonusSources,
  type SpeciesChoiceLike,
} from './types';

function collectFixedFeatSkillSlugs(
  characterFeats: readonly CharacterFeatLike[] | undefined,
): string[] {
  if (!characterFeats?.length) return [];
  const slugs: string[] = [];
  for (const feat of characterFeats) {
    const fixed = FIXED_FEAT_SKILL_SLUGS[feat.featSlug];
    if (fixed) slugs.push(...fixed);
  }
  return slugs;
}

function isFeatSkillProficiencyOptionKey(optionKey: string): boolean {
  return (
    optionKey === 'newSkill' ||
    optionKey.startsWith('proficiency') ||
    optionKey === 'expertiseSkill' ||
    PROF_OR_EXPERTISE_FEAT_OPTION_KEYS.has(optionKey)
  );
}

export function collectFeatSkillOptionSlugs(
  featOptions: readonly FeatOptionLike[] | undefined,
): string[] {
  if (!featOptions?.length) return [];
  return featOptions
    .filter((option) => isFeatSkillProficiencyOptionKey(option.optionKey))
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

/** Proficiências “base” (sem expertise condicional de Observant/Keen Mind / Loki). */
function collectPriorProficientSkillSlugs(input: SkillBonusSources): string[] {
  const featOptions = (input.featOptions ?? []).filter(
    (option) => !PROF_OR_EXPERTISE_FEAT_OPTION_KEYS.has(option.optionKey),
  );
  return [
    ...new Set([
      ...(input.classSkillSlugs ?? []),
      ...(input.backgroundSkillSlugs ?? []),
      ...collectSpeciesSkillSlugs(input.speciesChoices),
      ...collectFeatSkillOptionSlugs(featOptions),
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
  const fixedFeatSkills = collectFixedFeatSkillSlugs(input.characterFeats);

  for (const option of input.featOptions ?? []) {
    if (option.optionKey === 'expertiseSkill' && option.valueId) {
      result.add(option.valueId);
    }
    if (
      PROF_OR_EXPERTISE_FEAT_OPTION_KEYS.has(option.optionKey) &&
      option.valueId &&
      prior.has(option.valueId)
    ) {
      result.add(option.valueId);
    }
  }

  for (const skill of fixedFeatSkills) {
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
        PROF_OR_EXPERTISE_FEAT_OPTION_KEYS.has(option.optionKey),
      ),
    ),
    ...collectFixedFeatSkillSlugs(input.characterFeats),
    ...collectClassExpertiseSkillSlugs(input.classOptions),
  ]);
  return [...set];
}
