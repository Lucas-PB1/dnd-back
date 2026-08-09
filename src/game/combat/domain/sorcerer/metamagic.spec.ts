import {
  sorcererMetamagicLimit,
  validateMetamagicPicks,
} from './metamagic';

describe('sorcerer metamagic picks', () => {
  const catalog = [
    {
      slug: 'quickened-spell',
      name: 'Magia Acelerada',
      description: '…',
      cost: 2,
      stacksWithOther: false,
    },
    {
      slug: 'subtle-spell',
      name: 'Magia Sutil',
      description: '…',
      cost: 1,
      stacksWithOther: false,
    },
  ];

  it('limits picks by level', () => {
    expect(sorcererMetamagicLimit(1)).toBe(0);
    expect(sorcererMetamagicLimit(2)).toBe(2);
    expect(sorcererMetamagicLimit(10)).toBe(4);
    expect(sorcererMetamagicLimit(17)).toBe(6);
  });

  it('rejects unknown or excess picks using catalog rows', () => {
    expect(
      validateMetamagicPicks({
        level: 2,
        picks: [{ slug: 'quickened-spell' }, { slug: 'subtle-spell' }],
        catalog,
      }),
    ).toEqual([]);

    expect(
      validateMetamagicPicks({
        level: 2,
        picks: [
          { slug: 'quickened-spell' },
          { slug: 'subtle-spell' },
          { slug: 'subtle-spell' },
        ],
        catalog,
      }).length,
    ).toBeGreaterThan(0);

    expect(
      validateMetamagicPicks({
        level: 2,
        picks: [{ slug: 'not-real' }],
        catalog,
      }),
    ).toContain("Opção de Metamagia desconhecida: 'not-real'");
  });
});
