import {
  assertAttachCoverageSlugIsCoverage,
  assertCoverageLineHasTarget,
  assertNotStandaloneCoverageItem,
} from './coverage-inventory-rules';

describe('coverage-inventory-rules', () => {
  it('blocks standalone coverage in inventory', () => {
    expect(() =>
      assertNotStandaloneCoverageItem('armadura-adamantina', {
        kind: 'coverage',
        appliesTo: 'armor',
        appliesFilter: 'Qualquer Média ou Pesada',
      }),
    ).toThrow(/attach it to a base piece/i);
  });

  it('requires attach target on coverage purchase lines', () => {
    expect(() =>
      assertCoverageLineHasTarget('armadura-de-vulnerabilidade', {}),
    ).toThrow(/requires attachToBaseSlug/i);
  });

  it('validates attachCoverageSlug is coverage', () => {
    expect(() =>
      assertAttachCoverageSlugIsCoverage('longsword', { kind: 'unique' }),
    ).toThrow(/not a coverage item/i);
  });
});
