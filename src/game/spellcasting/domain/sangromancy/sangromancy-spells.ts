/** Tag editorial no início de `phb_spell.description` (Cap. 7 GH). */
export const SANGROMANCY_DESCRIPTION_PREFIX = '[Sangromancia]';

/** Filtro em `phb_option_def.spell_school_slugs` para picks de grimório bônus. */
export const SANGROMANCY_SCHOOL_FILTER_SLUG = 'sangromancia';

export const SANGROMANCER_SUBCLASS_SLUG = 'sangromancer';

export const SANGUINE_THIEF_SUBCLASS_SLUG = 'sanguine-thief';

/** Níveis em que o mago ganha um novo círculo de espaço (PHB 2024). */
export const WIZARD_NEW_SLOT_TIER_LEVELS = [
  { classLevel: 3, maxSpellLevel: 2 },
  { classLevel: 5, maxSpellLevel: 3 },
  { classLevel: 7, maxSpellLevel: 4 },
  { classLevel: 9, maxSpellLevel: 5 },
  { classLevel: 11, maxSpellLevel: 6 },
  { classLevel: 13, maxSpellLevel: 7 },
  { classLevel: 15, maxSpellLevel: 8 },
  { classLevel: 17, maxSpellLevel: 9 },
] as const;

export const SANGROMANCY_SAVANT_OPTION_KEYS = [
  'sangromancySavant1',
  'sangromancySavant2',
  'sangromancySavant3',
  'sangromancySavant4',
  'sangromancySavant5',
  'sangromancySavant6',
  'sangromancySavant7',
  'sangromancySavant8',
  'sangromancySavant9',
] as const;

export type SangromancySavantOptionKey =
  (typeof SANGROMANCY_SAVANT_OPTION_KEYS)[number];

const SANGROMANCY_SAVANT_KEY_SET = new Set<string>(
  SANGROMANCY_SAVANT_OPTION_KEYS,
);

/** Definição de cada pick de grimório bônus (2 no nv. 3 + 1 por faixa de slot). */
export const SANGROMANCY_SAVANT_OPTION_DEFS: readonly {
  optionKey: SangromancySavantOptionKey;
  unlockLevel: number;
  spellMaxLevel: number;
  sortOrder: number;
}[] = [
  { optionKey: 'sangromancySavant1', unlockLevel: 3, spellMaxLevel: 2, sortOrder: 1 },
  { optionKey: 'sangromancySavant2', unlockLevel: 3, spellMaxLevel: 2, sortOrder: 2 },
  ...WIZARD_NEW_SLOT_TIER_LEVELS.slice(1).map((tier, index) => ({
    optionKey: SANGROMANCY_SAVANT_OPTION_KEYS[index + 2],
    unlockLevel: tier.classLevel,
    spellMaxLevel: tier.maxSpellLevel,
    sortOrder: index + 3,
  })),
];

export function isSangromancySavantOptionKey(
  optionKey: string,
): optionKey is SangromancySavantOptionKey {
  return SANGROMANCY_SAVANT_KEY_SET.has(optionKey);
}

export function isSangromancerWizard(
  classSlug: string | null | undefined,
  subclassSlug: string | null | undefined,
): boolean {
  return classSlug === 'wizard' && subclassSlug === SANGROMANCER_SUBCLASS_SLUG;
}

/** Lista de magias = mago PHB + tag [Sangromancia] (Sangromante ou Ladrão Sanguíneo). */
export function usesWizardPlusSangromancyList(
  classSlug: string | null | undefined,
  subclassSlug: string | null | undefined,
): boolean {
  return (
    isSangromancerWizard(classSlug, subclassSlug) ||
    (classSlug === 'rogue' && subclassSlug === SANGUINE_THIEF_SUBCLASS_SLUG)
  );
}

export function sangromancyDescriptionSqlPattern(): string {
  return `${SANGROMANCY_DESCRIPTION_PREFIX}%`;
}
