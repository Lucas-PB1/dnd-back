import { CAP6_PB_PLUS_STAGE_RESOURCE_SLUGS } from '@game/session/domain/transformation/cap6-resource-max';
import { resolveClassResourceMaxima } from './resolve-maxima';

describe('resolveClassResourceMaxima (Cap. 6 transformation)', () => {
  it('PB+stage e fixed-null-as-stage', () => {
    const rows = [
      {
        resourceSlug: 'infernal-smite-uses',
        resourceName: 'Punição Infernal',
        unlockLevel: 1,
        maxFormula: 'proficiency_bonus',
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
        maxFormula: 'fixed',
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
      proficiencyBonusPlusStageSlugs: CAP6_PB_PLUS_STAGE_RESOURCE_SLUGS,
    });

    const infernal = result.find((r) => r.slug === 'infernal-smite-uses');
    const wings = result.find((r) => r.slug === 'angelic-wings-uses');

    expect(infernal?.max).toBe(7);
    expect(wings?.max).toBe(3);
  });
});
