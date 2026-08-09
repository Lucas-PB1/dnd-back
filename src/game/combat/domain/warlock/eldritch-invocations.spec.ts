import {
  readEldritchInvocationPicks,
  validateEldritchInvocationPicks,
  type EldritchInvocationCatalogRow,
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
});
