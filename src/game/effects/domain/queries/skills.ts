import type {
  CatalogEffect,
  EffectProficiencySatellite,
} from '../catalog-effect';

export function isChoiceSkillOptionKey(optionKey: string): boolean {
  if (optionKey === 'newSkill' || optionKey === 'expertiseSkill') return true;
  if (optionKey.startsWith('proficiency') || optionKey.startsWith('skill')) {
    return true;
  }
  return /[A-Z]/.test(optionKey);
}

export const PHB_SKILL_SLUGS = [
  'acrobatics',
  'animal-handling',
  'arcana',
  'athletics',
  'deception',
  'history',
  'insight',
  'intimidation',
  'investigation',
  'medicine',
  'nature',
  'perception',
  'performance',
  'persuasion',
  'religion',
  'sleight-of-hand',
  'stealth',
  'survival',
] as const;

export function proficiencyOptionKeysFromEffects(input: {
  effects: readonly CatalogEffect[];
  featSlug: string;
  proficiencyKind?: EffectProficiencySatellite['proficiencyKind'];
}): string[] {
  const keys: string[] = [];
  for (const effect of input.effects) {
    if (effect.kind !== 'grant_proficiency') continue;
    if (effect.ownerKind !== 'feat' || effect.ownerSlug !== input.featSlug) {
      continue;
    }
    if (!effect.proficiency) continue;
    if (
      input.proficiencyKind &&
      effect.proficiency.proficiencyKind !== input.proficiencyKind
    ) {
      continue;
    }
    keys.push(effect.proficiency.optionKey);
  }
  return keys;
}

export function fixedSkillSlugsFromEffects(
  effects: readonly CatalogEffect[],
  featSlugs: readonly string[],
): string[] {
  const owned = new Set(featSlugs);
  const slugs = new Set<string>();
  for (const effect of effects) {
    if (effect.ownerKind !== 'feat' || !effect.ownerSlug) continue;
    if (!owned.has(effect.ownerSlug)) continue;
    if (effect.kind === 'grant_all_skill_proficiencies') {
      for (const skill of PHB_SKILL_SLUGS) slugs.add(skill);
      continue;
    }
    if (effect.kind !== 'grant_proficiency' || !effect.proficiency) continue;
    if (effect.proficiency.proficiencyKind !== 'skill') continue;
    const key = effect.proficiency.optionKey;
    if (isChoiceSkillOptionKey(key)) continue;
    slugs.add(key);
  }
  return [...slugs];
}

export function expertiseSkillSlugsFromEffects(
  effects: readonly CatalogEffect[],
  featSlugs: readonly string[],
): string[] {
  const owned = new Set(featSlugs);
  const slugs = new Set<string>();
  for (const effect of effects) {
    if (effect.kind !== 'grant_expertise') continue;
    if (effect.ownerKind !== 'feat' || !effect.ownerSlug) continue;
    if (!owned.has(effect.ownerSlug) || !effect.proficiency) continue;
    if (effect.proficiency.proficiencyKind !== 'skill') continue;
    const key = effect.proficiency.optionKey;
    if (isChoiceSkillOptionKey(key)) continue;
    slugs.add(key);
  }
  return [...slugs];
}
