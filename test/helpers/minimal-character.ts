/** Payloads mínimos válidos para POST /characters nos e2e (DB local PHB). */

/** Soldier: common fixo + 2 escolhas; boost STR/DEX/CON. */
export const SOLDIER_LANGUAGE_SLUGS = ['common', 'dwarvish', 'elvish'] as const;

/** Evita overlap com perícias do soldier (athletics, intimidation). */
export const FIGHTER_CLASS_SKILLS = ['perception', 'insight'] as const;
export const WIZARD_CLASS_SKILLS = ['arcana', 'history'] as const;

export function minimalFighterPayload(
  name: string,
  overrides: Record<string, unknown> = {},
) {
  return {
    name,
    classSlug: 'fighter',
    speciesSlug: 'dwarf',
    backgroundSlug: 'soldier',
    classSkillSlugs: [...FIGHTER_CLASS_SKILLS],
    languageSlugs: [...SOLDIER_LANGUAGE_SLUGS],
    backgroundAbilityBoostMode: 'plus2plus1',
    backgroundAbilityBoostPlus2Slug: 'forca',
    backgroundAbilityBoostPlus1Slug: 'constituicao',
    backgroundToolItemSlug: 'conjunto-de-dados',
    ...overrides,
  };
}

export function minimalWizardPayload(
  name: string,
  overrides: Record<string, unknown> = {},
) {
  return {
    name,
    classSlug: 'wizard',
    speciesSlug: 'dwarf',
    backgroundSlug: 'soldier',
    classSkillSlugs: [...WIZARD_CLASS_SKILLS],
    languageSlugs: [...SOLDIER_LANGUAGE_SLUGS],
    backgroundAbilityBoostMode: 'plus2plus1',
    backgroundAbilityBoostPlus2Slug: 'destreza',
    backgroundAbilityBoostPlus1Slug: 'constituicao',
    backgroundToolItemSlug: 'conjunto-de-dados',
    ...overrides,
  };
}
