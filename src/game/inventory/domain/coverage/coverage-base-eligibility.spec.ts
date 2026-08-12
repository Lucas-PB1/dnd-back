import {
  assertBaseEligibleForCoverage,
  isMagicCatalogItem,
} from './coverage-base-eligibility';

describe('coverage-base-eligibility', () => {
  it('detects magic catalog items', () => {
    expect(isMagicCatalogItem({ magic: true })).toBe(true);
    expect(isMagicCatalogItem({ magic: false })).toBe(false);
    expect(isMagicCatalogItem(null)).toBe(false);
  });

  it('rejects magic and coverage bases', () => {
    expect(() =>
      assertBaseEligibleForCoverage('loriga-de-escamas-draconicas', {
        magic: true,
      }),
    ).toThrow(/already magical/i);
    expect(() =>
      assertBaseEligibleForCoverage('armadura-adamantina', {
        kind: 'coverage',
      }),
    ).toThrow(/coverage overlay/i);
  });

  it('allows mundane bases', () => {
    expect(() =>
      assertBaseEligibleForCoverage('scale-mail', {
        acFormula: { type: 'fixed', base: 14 },
      }),
    ).not.toThrow();
  });
});
