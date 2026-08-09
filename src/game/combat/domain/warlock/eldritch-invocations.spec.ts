import {
  buildEldritchCantripCastNote,
  collectEldritchFreeCastSpellSlugs,
  pickRandomValidEldritchInvocations,
  readEldritchInvocationPicks,
  resolveEldritchInvocationFreeCast,
  validateEldritchInvocationPicks,
  type EldritchInvocationCatalogRow,
  type EldritchInvocationEffectRow,
} from './eldritch-invocations';
import { warlockInvocationLimit } from './features';

describe('eldritch-invocations', () => {
  const catalog: EldritchInvocationCatalogRow[] = [
    {
      slug: 'pact-of-the-blade',
      name: 'Pacto da Lâmina',
      minLevel: 1,
      requiresPactSlug: null,
      requiresInvocationSlug: null,
      repeatable: false,
    },
    {
      slug: 'thirsting-blade',
      name: 'Lâmina Sedenta',
      minLevel: 5,
      requiresPactSlug: 'pact-of-the-blade',
      requiresInvocationSlug: null,
      repeatable: false,
    },
    {
      slug: 'agonizing-blast',
      name: 'Explosão Agonizante',
      minLevel: 2,
      requiresPactSlug: null,
      requiresInvocationSlug: null,
      repeatable: true,
    },
  ];

  const effectCatalog: EldritchInvocationEffectRow[] = [
    {
      slug: 'armor-of-shadows',
      name: 'Armadura de Sombras',
      minLevel: 1,
      requiresPactSlug: null,
      requiresInvocationSlug: null,
      repeatable: false,
      kind: 'free_cast',
      grantedSpellSlug: 'armadura-arcana',
    },
    {
      slug: 'gift-of-the-depths',
      name: 'Presente das Profundezas',
      minLevel: 5,
      requiresPactSlug: null,
      requiresInvocationSlug: null,
      repeatable: false,
      kind: 'free_cast',
      grantedSpellSlug: 'respirar-na-agua',
    },
    {
      slug: 'eldritch-mind',
      name: 'Mente Mística',
      minLevel: 1,
      requiresPactSlug: null,
      requiresInvocationSlug: null,
      repeatable: false,
      kind: 'passive',
      grantedSpellSlug: null,
    },
  ];

  it('reads picks from classOptions', () => {
    const picks = readEldritchInvocationPicks([
      { optionKey: 'expertiseSkill1', valueId: 'stealth' },
      {
        optionKey: 'eldritch-invocation',
        valueId: 'pact-of-the-blade',
        instanceIndex: 0,
      },
      {
        optionKey: 'eldritch-invocation',
        valueId: 'agonizing-blast',
        instanceIndex: 1,
      },
    ]);
    expect(picks).toEqual([
      { slug: 'pact-of-the-blade', instanceIndex: 0 },
      { slug: 'agonizing-blast', instanceIndex: 1 },
    ]);
  });

  it('rejects over-limit and missing pact prerequisite', () => {
    expect(warlockInvocationLimit(1)).toBe(1);
    const errors = validateEldritchInvocationPicks({
      level: 5,
      picks: [
        { slug: 'thirsting-blade', instanceIndex: 0 },
        { slug: 'agonizing-blast', instanceIndex: 1 },
      ],
      catalog,
    });
    expect(errors.some((e) => e.includes('pact-of-the-blade'))).toBe(true);
  });

  it('accepts valid pact + thirsting blade', () => {
    const errors = validateEldritchInvocationPicks({
      level: 5,
      picks: [
        { slug: 'pact-of-the-blade', instanceIndex: 0 },
        { slug: 'thirsting-blade', instanceIndex: 1 },
        { slug: 'agonizing-blast', instanceIndex: 2 },
        { slug: 'agonizing-blast', instanceIndex: 3 },
        { slug: 'agonizing-blast', instanceIndex: 4 },
      ],
      catalog,
    });
    expect(errors).toEqual([]);
  });

  it('resolves at-will and once-per-long-rest free casts', () => {
    expect(
      resolveEldritchInvocationFreeCast({
        spellSlug: 'armadura-arcana',
        pickedSlugs: ['armor-of-shadows'],
        catalog: effectCatalog,
      }),
    ).toEqual({
      invocationSlug: 'armor-of-shadows',
      invocationName: 'Armadura de Sombras',
      economy: 'at_will',
    });
    expect(
      resolveEldritchInvocationFreeCast({
        spellSlug: 'respirar-na-agua',
        pickedSlugs: ['gift-of-the-depths'],
        catalog: effectCatalog,
      })?.economy,
    ).toBe('once_per_long_rest');
    expect(
      resolveEldritchInvocationFreeCast({
        spellSlug: 'armadura-arcana',
        pickedSlugs: [],
        catalog: effectCatalog,
      }),
    ).toBeNull();
  });

  it('collects free-cast spell slugs from picks', () => {
    const slugs = collectEldritchFreeCastSpellSlugs(
      ['armor-of-shadows', 'eldritch-mind', 'gift-of-the-depths'],
      effectCatalog,
    );
    expect([...slugs].sort()).toEqual([
      'armadura-arcana',
      'respirar-na-agua',
    ]);
  });

  it('builds cantrip cast notes for blast invocations', () => {
    expect(
      buildEldritchCantripCastNote({
        spellLevel: 1,
        pickedSlugs: ['agonizing-blast'],
        charismaModifier: 4,
        warlockLevel: 5,
      }),
    ).toBeNull();
    const note = buildEldritchCantripCastNote({
      spellLevel: 0,
      pickedSlugs: ['agonizing-blast', 'repelling-blast', 'eldritch-spear'],
      charismaModifier: 5,
      warlockLevel: 5,
    });
    expect(note).toMatch(/Explosão Agonizante: \+5/);
    expect(note).toMatch(/Explosão Repulsiva/);
    expect(note).toMatch(/Lança Mística: alcance \+45 m/);
  });

  it('picks a full valid random set up to the level limit', () => {
    const fullCatalog: EldritchInvocationCatalogRow[] = [
      ...catalog,
      {
        slug: 'armor-of-shadows',
        name: 'Armadura',
        minLevel: 1,
        requiresPactSlug: null,
        requiresInvocationSlug: null,
        repeatable: false,
      },
      {
        slug: 'devil-sight',
        name: 'Visão',
        minLevel: 2,
        requiresPactSlug: null,
        requiresInvocationSlug: null,
        repeatable: false,
      },
      {
        slug: 'mask-of-many-faces',
        name: 'Máscara',
        minLevel: 2,
        requiresPactSlug: null,
        requiresInvocationSlug: null,
        repeatable: false,
      },
    ];
    let seed = 0;
    const picks = pickRandomValidEldritchInvocations({
      level: 5,
      catalog: fullCatalog,
      random: () => {
        seed += 0.17;
        return seed % 1;
      },
    });
    expect(picks).toHaveLength(5);
    expect(
      validateEldritchInvocationPicks({
        level: 5,
        picks,
        catalog: fullCatalog,
      }),
    ).toEqual([]);
  });
});
