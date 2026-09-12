import type { CharacterFeatLike } from './character-check-bonuses/types';
import {
  resolveInitiativeBonus,
  type InitiativeRollContext,
} from './resolve-initiative-roll';

export function initiativeBonus(
  dexterityModifier: number,
  proficiencyBonus: number,
  characterFeats: readonly CharacterFeatLike[] | undefined,
  extra?: Partial<
    Omit<
      InitiativeRollContext,
      'dexterityModifier' | 'proficiencyBonus' | 'characterFeats'
    >
  >,
): number {
  return resolveInitiativeBonus({
    dexterityModifier,
    proficiencyBonus,
    characterFeats: characterFeats ?? [],
    wisdomModifier: extra?.wisdomModifier ?? 0,
    intelligenceModifier: extra?.intelligenceModifier ?? 0,
    classSlug: extra?.classSlug ?? '',
    subclassSlug: extra?.subclassSlug ?? null,
    level: extra?.level ?? 0,
    heritageChoices: extra?.heritageChoices,
    speciesChoices: extra?.speciesChoices,
    featEffects: extra?.featEffects,
  }).total;
}
