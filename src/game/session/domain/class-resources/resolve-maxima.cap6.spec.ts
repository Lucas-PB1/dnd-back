import { resolveClassResourceMaxima } from './resolve-maxima';

describe('resolveClassResourceMaxima (Cap. 6 transformation)', () => {
  it('PB+stage e transformation_stage via fórmula SQL', () => {
    const rows = [
      {
        resourceSlug: 'infernal-smite-uses',
        resourceName: 'Punição Infernal',
        unlockLevel: 1,
        maxFormula: 'proficiency_bonus_plus_stage',
        fixedMax: null,
        recoverOneOnShort: false,
        recoverAllOnShort: true,
        recoverAllOnLong: true,
        recoverOnLongDice: null,
      },
      {
        resourceSlug: 'angelic-wings-uses',
        resourceName: 'Angelic Wings',
        unlockLevel: 1,
        maxFormula: 'transformation_stage',
        fixedMax: null,
        recoverOneOnShort: false,
        recoverAllOnShort: true,
        recoverAllOnLong: true,
        recoverOnLongDice: null,
      },
    ] as const;

    const result = resolveClassResourceMaxima({
      rows,
      level: 3,
      proficiencyBonus: 4,
      abilityModifiers: {
        forca: 0,
        destreza: 0,
        constituicao: 3,
        inteligencia: 0,
        sabedoria: 0,
        carisma: 0,
      },
      transformationStage: 3,
      featureSchedules: [],
    });

    const infernal = result.find((r) => r.slug === 'infernal-smite-uses');
    const wings = result.find((r) => r.slug === 'angelic-wings-uses');

    expect(infernal?.max).toBe(7);
    expect(wings?.max).toBe(3);
  });
});
