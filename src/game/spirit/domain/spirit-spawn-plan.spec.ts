import { planSpiritSpawns, resolveSpiritSelections } from './spirit-spawn-plan';

describe('spirit-spawn-plan', () => {
  const animateVariants = [
    {
      variantKey: 'medio',
      templateSlug: 'objeto-animado-medio',
      label: 'Médio',
      budgetCost: 1,
    },
    {
      variantKey: 'grande',
      templateSlug: 'objeto-animado-grande',
      label: 'Grande',
      budgetCost: 2,
    },
    {
      variantKey: 'enorme',
      templateSlug: 'objeto-animado-enorme',
      label: 'Enorme',
      budgetCost: 3,
    },
  ];

  it('resolveSpiritSelections usa variantKey + count', () => {
    expect(
      resolveSpiritSelections({ variantKey: 'medio', spiritCount: 2 }),
    ).toEqual([{ variantKey: 'medio', count: 2 }]);
  });

  it('permite misturar tamanhos dentro do mod', () => {
    const planned = planSpiritSpawns({
      spellSlug: 'animar-objetos',
      selections: [
        { variantKey: 'enorme', count: 1 },
        { variantKey: 'medio', count: 1 },
      ],
      variants: animateVariants,
      castingAbilityMod: 4,
    });
    expect(planned).toHaveLength(2);
  });

  it('rejeita custo acima do mod', () => {
    expect(() =>
      planSpiritSpawns({
        spellSlug: 'animar-objetos',
        selections: [{ variantKey: 'enorme', count: 2 }],
        variants: animateVariants,
        castingAbilityMod: 5,
      }),
    ).toThrow(/custo 6/);
  });

  it('rejeita multi em summon sem budget', () => {
    expect(() =>
      planSpiritSpawns({
        spellSlug: 'invocar-fera',
        selections: [{ variantKey: 'ar', count: 2 }],
        variants: [
          {
            variantKey: 'ar',
            templateSlug: 'espirito-bestial-ar',
            label: 'Ar',
            budgetCost: 1,
          },
        ],
        castingAbilityMod: 5,
      }),
    ).toThrow(/no máximo 1/);
  });
});
