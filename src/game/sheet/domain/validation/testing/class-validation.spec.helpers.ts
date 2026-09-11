import { ClassProficienciesQuery } from '@catalog/game-port';

const EMPTY_PROFICIENCIES = {
  savingThrowSlugs: [] as string[],
  savingThrowNames: [] as string[],
  armorTrainingSlugs: [] as string[],
  armorTrainingNames: [] as string[],
  weaponProficiencySlugs: ['armas-simples', 'armas-marciais'] as string[],
  weaponProficiencyNames: [] as string[],
  fightingStyleSlugs: ['defense', 'dueling'] as string[],
  fightingStyleNames: [] as string[],
};

export function mockClassProficienciesQuery(
  overrides: Partial<(typeof EMPTY_PROFICIENCIES)> = {},
) {
  const forClassSlug = jest.fn().mockResolvedValue({
    ...EMPTY_PROFICIENCIES,
    ...overrides,
  });
  return {
    forClassSlug,
    query: { forClassSlug } as unknown as ClassProficienciesQuery,
  };
}
