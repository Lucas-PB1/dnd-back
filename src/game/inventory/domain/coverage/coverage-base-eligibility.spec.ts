import {
  assertBaseEligibleForCoverage,
  isMagicCatalogItem,
  masterworkTierBonusApplies,
} from './coverage-base-eligibility';

describe('coverage-base-eligibility', () => {
  it('detects magic catalog items', () => {
    expect(isMagicCatalogItem({ magic: true })).toBe(true);
    expect(isMagicCatalogItem({ magic: false })).toBe(false);
    expect(isMagicCatalogItem(null)).toBe(false);
  });

  it('rejects magic bases for normal coverage, allows masterwork', () => {
    expect(() =>
      assertBaseEligibleForCoverage('loriga-de-escamas-draconicas', {
        magic: true,
      }),
    ).toThrow(/already magical/i);
    expect(() =>
      assertBaseEligibleForCoverage(
        'espada-flamejante',
        { magic: true },
        { kind: 'coverage', masterwork: true },
      ),
    ).not.toThrow();
    expect(() =>
      assertBaseEligibleForCoverage('armadura-adamantina', {
        kind: 'coverage',
      }),
    ).toThrow(/coverage overlay/i);
  });

  it('skips masterwork +1 on magic bases', () => {
    expect(
      masterworkTierBonusApplies({ masterwork: true }, true),
    ).toBe(false);
    expect(
      masterworkTierBonusApplies({ masterwork: true }, false),
    ).toBe(true);
    expect(masterworkTierBonusApplies({ kind: 'coverage' }, true)).toBe(
      true,
    );
  });

  it('allows mundane bases', () => {
    expect(() =>
      assertBaseEligibleForCoverage('scale-mail', {
        acFormula: { type: 'fixed', base: 14 },
      }),
    ).not.toThrow();
  });
});
