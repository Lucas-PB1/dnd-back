import {
  sorcererMetamagicLimit,
  validateMetamagicPicks,
} from './metamagic';
import { fixtureSchedulesFor } from '../feature-schedule.fixtures';

describe('sorcerer metamagic picks', () => {
  const sorcererBands = fixtureSchedulesFor('sorcerer');

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
    expect(sorcererMetamagicLimit(1, sorcererBands)).toBe(0);
    expect(sorcererMetamagicLimit(2, sorcererBands)).toBe(2);
    expect(sorcererMetamagicLimit(10, sorcererBands)).toBe(4);
    expect(sorcererMetamagicLimit(17, sorcererBands)).toBe(6);
  });

  it('rejects unknown or excess picks using catalog rows', () => {
    expect(
      validateMetamagicPicks({
        level: 2,
        picks: [{ slug: 'quickened-spell' }, { slug: 'subtle-spell' }],
        catalog,
        featureSchedules: sorcererBands,
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
        featureSchedules: sorcererBands,
      }).length,
    ).toBeGreaterThan(0);

    expect(
      validateMetamagicPicks({
        level: 2,
        picks: [{ slug: 'not-real' }],
        catalog,
        featureSchedules: sorcererBands,
      }),
    ).toContain("Opção de Metamagia desconhecida: 'not-real'");
  });
});
