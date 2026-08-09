import type { AbilityKey } from '@game/build/domain/ability-generation';
import { RESILIENT_FEAT_SLUG } from '../validation/feats/resilient-feat-options';
import { hasJackOfAllTrades } from '../validation/class-options/class-expertise-slots';

/** Escolhas de espécie que concedem uma perícia (slug em choiceSlug). */
export const SKILL_SPECIES_CHOICE_KINDS = new Set([
  'human_skill',
  'elf_keen_senses',
]);

export const ALERT_FEAT_SLUG = 'alert';

/** Feats que dão proficiência ou expertise na perícia escolhida. */
export const PROF_OR_EXPERTISE_FEAT_OPTION_KEYS = new Set([
  'attentiveSkill', // observant
  'vastKnowledgeSkill', // keen-mind
]);

export type SkillProficiencyRank =
  | 'none'
  | 'jack'
  | 'proficient'
  | 'expertise';

type FeatOptionLike = {
  featSlug: string;
  optionKey: string;
  valueId: string;
};

type SpeciesChoiceLike = {
  choiceKind: string;
  choiceSlug: string;
};

type CharacterFeatLike = {
  featSlug: string;
};

type ClassOptionLike = {
  optionKey: string;
  valueId: string;
};

export type SkillBonusSources = {
  classSkillSlugs?: readonly string[];
  backgroundSkillSlugs?: readonly string[];
  speciesChoices?: readonly SpeciesChoiceLike[];
  featOptions?: readonly FeatOptionLike[];
  classOptions?: readonly ClassOptionLike[];
  classSlug?: string | null;
  level?: number;
};

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

/** Proficiências “base” (sem expertise condicional de Observant/Keen Mind). */
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
    ...collectClassExpertiseSkillSlugs(input.classOptions),
  ]);
  return [...set];
}

export function skillProficiencyRank(
  skillSlug: string,
  input: SkillBonusSources,
): SkillProficiencyRank {
  const expertise = new Set(collectExpertiseSkillSlugs(input));
  if (expertise.has(skillSlug)) return 'expertise';
  const proficient = new Set(collectProficientSkillSlugs(input));
  if (proficient.has(skillSlug)) return 'proficient';
  if (hasJackOfAllTrades(input.classSlug, input.level ?? 0)) return 'jack';
  return 'none';
}

/** Mod + PB (×2 expertise; metade arredondada para baixo se Jack of All Trades). */
export function skillCheckBonus(
  abilityModifier: number,
  proficiencyBonus: number,
  rank: SkillProficiencyRank,
): number {
  if (rank === 'expertise') return abilityModifier + proficiencyBonus * 2;
  if (rank === 'proficient') return abilityModifier + proficiencyBonus;
  if (rank === 'jack') {
    return abilityModifier + Math.floor(proficiencyBonus / 2);
  }
  return abilityModifier;
}

/** Salvaguardas: classe + Resiliente (abilityIncrease). */
export function collectSaveProficiencyAbilities(
  classSavingThrowSlugs: readonly string[],
  featOptions: readonly FeatOptionLike[] | undefined,
): AbilityKey[] {
  const set = new Set<string>(classSavingThrowSlugs);
  for (const option of featOptions ?? []) {
    if (
      option.featSlug === RESILIENT_FEAT_SLUG &&
      option.optionKey === 'abilityIncrease' &&
      option.valueId
    ) {
      set.add(option.valueId);
    }
  }
  return [...set] as AbilityKey[];
}

export function hasAlertFeat(
  characterFeats: readonly CharacterFeatLike[] | undefined,
): boolean {
  return (characterFeats ?? []).some(
    (feat) => feat.featSlug === ALERT_FEAT_SLUG,
  );
}

/** Iniciativa: mod DEX + PB se Alerta. */
export function initiativeBonus(
  dexterityModifier: number,
  proficiencyBonus: number,
  characterFeats: readonly CharacterFeatLike[] | undefined,
): number {
  return (
    dexterityModifier +
    (hasAlertFeat(characterFeats) ? proficiencyBonus : 0)
  );
}
