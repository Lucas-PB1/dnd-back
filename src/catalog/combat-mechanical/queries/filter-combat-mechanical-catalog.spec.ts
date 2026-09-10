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
    ]);
    expect(result.battleMasterManeuvers).toHaveLength(1);
    expect(result.gunslingerManeuvers).toEqual([]);
    expect(result.tableActions.map((row) => row.slug)).toEqual(['maneuver']);
  });
});
