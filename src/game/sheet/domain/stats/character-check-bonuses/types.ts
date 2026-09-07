import type { CatalogEffect } from '@game/effects';

/** Escolhas de espécie que concedem uma perícia (slug em choiceSlug). */
export const SKILL_SPECIES_CHOICE_KINDS = new Set([
  'human_skill',
  'elf_keen_senses',
]);

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
  featEffects?: readonly CatalogEffect[];
  classOptions?: readonly ClassOptionLike[];
  subclassOptions?: readonly SubclassOptionLike[];
  classSlug?: string | null;
  level?: number;
};
