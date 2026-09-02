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
  'wildSkill', // blessing-of-freyr-and-freyja
  'loreSkill', // blessing-of-wotan
]);

/** Perícias fixas concedidas pelo feat (sem option_def) — proficiência ou expertise se já tiver. */
export const FIXED_FEAT_SKILL_SLUGS: Readonly<Record<string, readonly string[]>> =
  {
    'blessing-of-loki': ['deception'],
  };

export type SkillProficiencyRank =
  | 'none'
  | 'jack'
  | 'proficient'
  | 'expertise';

export type FeatOptionLike = {
  featSlug: string;
  optionKey: string;
  valueId: string;
};

export type SpeciesChoiceLike = {
  choiceKind: string;
  choiceSlug: string;
};

export type CharacterFeatLike = {
  featSlug: string;
};

export type ClassOptionLike = {
  optionKey: string;
  valueId: string;
};

export type SubclassOptionLike = {
  optionKey: string;
  valueId: string;
};

export type SkillBonusSources = {
  classSkillSlugs?: readonly string[];
  backgroundSkillSlugs?: readonly string[];
  speciesChoices?: readonly SpeciesChoiceLike[];
  featOptions?: readonly FeatOptionLike[];
  characterFeats?: readonly CharacterFeatLike[];
  classOptions?: readonly ClassOptionLike[];
  subclassOptions?: readonly SubclassOptionLike[];
  classSlug?: string | null;
  level?: number;
};
