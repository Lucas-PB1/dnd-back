import { filterCombatMechanicalCatalog } from './filter-combat-mechanical-catalog';
import type { CombatMechanicalCatalogResponseDto } from '../dto/combat-mechanical-catalog-response.dto';
import { asDep } from '@common/testing/as-dep';

function sampleCatalog(): CombatMechanicalCatalogResponseDto {
  return {
    gunslingerManeuvers: [asDep({ slug: 'g1' })],
    battleMasterManeuvers: [asDep({ slug: 'bm1' })],
    cunningStrikeEffects: [
      asDep({ slug: 'poison', subclassSlug: 'thief' }),
      asDep({ slug: 'trip' }),
    ],
    strikeOptions: [
      asDep({ slug: 'hunting-strike', subclassSlug: 'blood-hound' }),
    ],
    tableActions: [
      asDep({ subclassSlug: 'psi-warrior', slug: 'telekinetic' }),
      asDep({ subclassSlug: 'battle-master', slug: 'maneuver' }),
    ],
    personaMasks: [{ slug: 'jester', name: 'Bobão' }],
    beastborneAspectBenefits: [{ level: 3, note: 'x' }],
    dungeoneerSlayerLabels: ['Aberração'],
    precautionSpells: [{ slug: 'alarme', name: 'Alarme' }],
    economyActions: [
      asDep({ id: 'fighter-a', classSlug: 'fighter' }),
      asDep({ id: 'bard-a', classSlug: 'bard' }),
      asDep({ id: 'species-a', speciesSlug: 'dwarf' }),
      asDep({
        id: 'fighter-sub',
        classSlug: 'fighter',
        subclassSlug: 'psi-warrior',
      }),
      asDep({ id: 'lucky-a', featSlug: 'lucky' }),
      asDep({ id: 'potion-a', itemSlug: 'potion-of-healing' }),
      asDep({ id: 'thread-a', threadSlug: 'cursemarked' }),
      asDep({ id: 'heritage-a', heritageTraitSlug: 'potent-breath' }),
    ],
    panelActions: [
      asDep({ panelKey: 'fighter|a', classSlug: 'fighter' }),
      asDep({ panelKey: 'bard|a', classSlug: 'bard' }),
    ],
  };
}

describe('filterCombatMechanicalCatalog', () => {
  it('returns full catalog when filters omitted', () => {
    const catalog = sampleCatalog();
    expect(filterCombatMechanicalCatalog(catalog, {})).toBe(catalog);
  });

  it('filters economy/panel by class and keeps species rows', () => {
    const result = filterCombatMechanicalCatalog(sampleCatalog(), {
      classSlug: 'fighter',
    });
    expect(result.economyActions.map((row) => row.id)).toEqual([
      'fighter-a',
      'species-a',
      'fighter-sub',
      'lucky-a',
      'potion-a',
      'thread-a',
      'heritage-a',
    ]);
    expect(result.panelActions.map((row) => row.panelKey)).toEqual([
      'fighter|a',
    ]);
    expect(result.battleMasterManeuvers).toHaveLength(1);
    expect(result.gunslingerManeuvers).toEqual([]);
    expect(result.personaMasks).toEqual([]);
  });

  it('keeps gunslinger maneuvers when filtering by gunslinger class', () => {
    const result = filterCombatMechanicalCatalog(sampleCatalog(), {
      classSlug: 'gunslinger',
    });
    expect(result.gunslingerManeuvers).toHaveLength(1);
    expect(result.battleMasterManeuvers).toEqual([]);
  });

  it('keeps gunslinger maneuvers for Valdas subclasses and filters by subclassSlug', () => {
    const catalog = sampleCatalog();
    catalog.gunslingerManeuvers = [
      asDep({ slug: 'base', subclassSlug: undefined }),
      asDep({ slug: 'eagle', subclassSlug: 'deadeye' }),
      asDep({ slug: 'fan', subclassSlug: 'pistolero' }),
    ];
    const result = filterCombatMechanicalCatalog(catalog, {
      classSlug: 'gunslinger',
      subclassSlug: 'deadeye',
    });
    expect(result.gunslingerManeuvers.map((m) => m.slug)).toEqual([
      'base',
      'eagle',
    ]);
  });

  it('filters subclass subsets', () => {
    const result = filterCombatMechanicalCatalog(sampleCatalog(), {
      classSlug: 'fighter',
      subclassSlug: 'battle-master',
    });
    expect(result.economyActions.map((row) => row.id)).toEqual([
      'fighter-a',
      'species-a',
      'lucky-a',
      'potion-a',
      'thread-a',
      'heritage-a',
    ]);
    expect(result.battleMasterManeuvers).toHaveLength(1);
    expect(result.gunslingerManeuvers).toEqual([]);
    expect(result.tableActions.map((row) => row.slug)).toEqual(['maneuver']);
  });

  it('filters economy by featSlug and clears class extras', () => {
    const result = filterCombatMechanicalCatalog(sampleCatalog(), {
      featSlug: 'lucky',
    });
    expect(result.economyActions.map((row) => row.id)).toEqual(['lucky-a']);
    expect(result.panelActions).toEqual([]);
    expect(result.battleMasterManeuvers).toEqual([]);
    expect(result.gunslingerManeuvers).toEqual([]);
  });

  it('filters economy by itemSlug', () => {
    const result = filterCombatMechanicalCatalog(sampleCatalog(), {
      itemSlug: 'potion-of-healing',
    });
    expect(result.economyActions.map((row) => row.id)).toEqual(['potion-a']);
  });

  it('filters economy by speciesSlug, threadSlug and heritageTraitSlug', () => {
    expect(
      filterCombatMechanicalCatalog(sampleCatalog(), {
        speciesSlug: 'dwarf',
      }).economyActions.map((row) => row.id),
    ).toEqual(['species-a']);
    expect(
      filterCombatMechanicalCatalog(sampleCatalog(), {
        threadSlug: 'cursemarked',
      }).economyActions.map((row) => row.id),
    ).toEqual(['thread-a']);
    expect(
      filterCombatMechanicalCatalog(sampleCatalog(), {
        heritageTraitSlug: 'potent-breath',
      }).economyActions.map((row) => row.id),
    ).toEqual(['heritage-a']);
  });
});
