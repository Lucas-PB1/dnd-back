import { filterCombatMechanicalCatalog } from './filter-combat-mechanical-catalog';
import type { CombatMechanicalCatalogResponseDto } from '../dto/combat-mechanical-catalog-response.dto';

function sampleCatalog(): CombatMechanicalCatalogResponseDto {
  return {
    gunslingerManeuvers: [{ slug: 'g1' } as never],
    battleMasterManeuvers: [{ slug: 'bm1' } as never],
    cunningStrikeEffects: [
      { slug: 'poison', subclassSlug: 'thief' } as never,
      { slug: 'trip' } as never,
    ],
    tableActions: [
      { subclassSlug: 'psi-warrior', slug: 'telekinetic' } as never,
      { subclassSlug: 'battle-master', slug: 'maneuver' } as never,
    ],
    personaMasks: [{ slug: 'jester', name: 'Bobão' }],
    beastborneAspectBenefits: [{ level: 3, note: 'x' }],
    dungeoneerSlayerLabels: ['Aberração'],
    precautionSpells: [{ slug: 'alarme', name: 'Alarme' }],
    economyActions: [
      { id: 'fighter-a', classSlug: 'fighter' } as never,
      { id: 'bard-a', classSlug: 'bard' } as never,
      { id: 'species-a', speciesSlug: 'dwarf' } as never,
      {
        id: 'fighter-sub',
        classSlug: 'fighter',
        subclassSlug: 'psi-warrior',
      } as never,
    ],
    panelActions: [
      { panelKey: 'fighter|a', classSlug: 'fighter' } as never,
      { panelKey: 'bard|a', classSlug: 'bard' } as never,
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
    expect(result.personaMasks).toEqual([]);
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
