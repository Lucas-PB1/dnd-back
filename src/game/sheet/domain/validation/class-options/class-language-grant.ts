/**
 * Idiomas extras de classe — PHB 2024.
 * Druida L1: Idioma Druídico (concedido).
 * Ladino L1: Gíria dos Ladrões + 1 idioma.
 * Patrulheiro L2: Explorador Hábil +2 idiomas.
 */

export const THIEVES_CANT_LANGUAGE_SLUG = 'thieves-cant';
export const DRUIDIC_LANGUAGE_SLUG = 'druidic';

export type ClassLanguageGrant = {
  grantedSlugs: string[];
  choiceCount: number;
};

const EMPTY: ClassLanguageGrant = { grantedSlugs: [], choiceCount: 0 };

export function classLanguageGrant(
  classSlug: string | null | undefined,
  level: number,
): ClassLanguageGrant {
  if (classSlug === 'rogue' && level >= 1) {
    return { grantedSlugs: [THIEVES_CANT_LANGUAGE_SLUG], choiceCount: 1 };
  }
  if (classSlug === 'druid' && level >= 1) {
    return { grantedSlugs: [DRUIDIC_LANGUAGE_SLUG], choiceCount: 0 };
  }
  if (classSlug === 'ranger' && level >= 2) {
    return { grantedSlugs: [], choiceCount: 2 };
  }
  return EMPTY;
}
