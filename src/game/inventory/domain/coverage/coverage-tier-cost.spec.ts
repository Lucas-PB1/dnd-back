import {
  coverageTierBonusCostGp,
  coverageTierBonusCostText,
  resolveCoveragePurchaseCost,
} from './coverage-tier-cost';

describe('coverage-tier-cost', () => {
  it('prices weapon/shield tiers as uncommon/rare/very-rare', () => {
    expect(coverageTierBonusCostGp('weapon', 1)).toBe(400);
    expect(coverageTierBonusCostGp('shield', 2)).toBe(4_000);
    expect(coverageTierBonusCostGp('weapon', 3)).toBe(40_000);
    expect(coverageTierBonusCostText('shield', 3)).toBe('40.000 PO');
  });

  it('prices armor tiers as rare/very-rare/legendary', () => {
    expect(coverageTierBonusCostGp('armor', 1)).toBe(4_000);
    expect(coverageTierBonusCostGp('armor', 2)).toBe(40_000);
    expect(coverageTierBonusCostGp('armor', 3)).toBe(200_000);
  });

  it('resolves purchase cost from coverage properties + bonus', () => {
    expect(
      resolveCoveragePurchaseCost(
        {
          kind: 'coverage',
          appliesTo: 'armor',
          appliesFilter: 'Qualquer Leve, Média ou Pesada',
          requiresTierBonus: true,
        },
        1,
      ),
    ).toEqual({
      text: '4.000 PO',
      purse: {
        copper: 0,
        silver: 0,
        electrum: 0,
        gold: 4_000,
        platinum: 0,
      },
    });
    expect(
      resolveCoveragePurchaseCost(
        {
          kind: 'coverage',
          appliesTo: 'armor',
          appliesFilter: 'x',
          requiresTierBonus: true,
        },
        undefined,
      ),
    ).toBeNull();
  });
});
