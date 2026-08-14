import { CombatCatalogService } from './combat-catalog.service';

describe('CombatCatalogService', () => {
  let hpBonusRepo: { find: jest.Mock };
  let unarmoredRepo: { find: jest.Mock };
  let service: CombatCatalogService;

  beforeEach(() => {
    hpBonusRepo = { find: jest.fn() };
    unarmoredRepo = { find: jest.fn() };
    service = new CombatCatalogService(hpBonusRepo as never, unarmoredRepo as never);
  });

  describe('loadHitPointsBonusSources', () => {
    it('filters species, subclass, feat and ignores unknown kinds', async () => {
      hpBonusRepo.find.mockResolvedValue([
        {
          sourceKind: 'species',
          sourceSlug: 'dwarf',
          label: 'Dwarf',
          flatBonus: 0,
          perLevelBonus: 1,
          fromLevel: 1,
        },
        {
          sourceKind: 'subclass',
          sourceSlug: 'draconic',
          label: 'Draconic',
          flatBonus: 0,
          perLevelBonus: 1,
          fromLevel: 1,
        },
        {
          sourceKind: 'feat',
          sourceSlug: 'tough',
          label: 'Tough',
          flatBonus: 0,
          perLevelBonus: 2,
          fromLevel: 1,
        },
        {
          sourceKind: 'other',
          sourceSlug: 'x',
          label: 'X',
          flatBonus: 1,
          perLevelBonus: 0,
          fromLevel: 1,
        },
        {
          sourceKind: 'species',
          sourceSlug: 'elf',
          label: 'Elf',
          flatBonus: 0,
          perLevelBonus: 1,
          fromLevel: 1,
        },
      ]);

      const rows = await service.loadHitPointsBonusSources({
        speciesSlug: 'dwarf',
        subclassSlug: 'draconic',
        featSlugs: ['tough'],
      });

      expect(rows.map((r) => r.label)).toEqual(['Dwarf', 'Draconic', 'Tough']);
      expect(rows[2]).toMatchObject({ perLevel: 2, flat: 0, fromLevel: 1 });
    });

    it('matches nothing when inputs empty', async () => {
      hpBonusRepo.find.mockResolvedValue([
        {
          sourceKind: 'species',
          sourceSlug: 'dwarf',
          label: 'Dwarf',
          flatBonus: 0,
          perLevelBonus: 1,
          fromLevel: 1,
        },
        {
          sourceKind: 'feat',
          sourceSlug: 'tough',
          label: 'Tough',
          flatBonus: 0,
          perLevelBonus: 2,
          fromLevel: 1,
        },
      ]);
      await expect(service.loadHitPointsBonusSources({})).resolves.toEqual([]);
    });
  });

  describe('loadUnarmoredDefenses', () => {
    it('queries only matching class and subclass defenses', async () => {
      unarmoredRepo.find.mockResolvedValue([
        {
          sourceKind: 'class',
          sourceSlug: 'barbarian',
          label: 'Barb',
          secondAbilitySlug: 'constituicao',
          allowsShield: false,
        },
        {
          sourceKind: 'subclass',
          sourceSlug: 'monk-way',
          label: 'Monk',
          secondAbilitySlug: 'sabedoria',
          allowsShield: false,
        },
      ]);

      const rows = await service.loadUnarmoredDefenses({
        classSlug: 'barbarian',
        subclassSlug: 'monk-way',
      });
      expect(unarmoredRepo.find).toHaveBeenCalledWith({
        where: [
          { sourceKind: 'class', sourceSlug: 'barbarian' },
          { sourceKind: 'subclass', sourceSlug: 'monk-way' },
        ],
      });
      expect(rows).toEqual([
        {
          label: 'Barb',
          secondAbility: 'constituicao',
          allowsShield: false,
        },
        {
          label: 'Monk',
          secondAbility: 'sabedoria',
          allowsShield: false,
        },
      ]);
    });

    it('returns empty without querying when no class/subclass', async () => {
      await expect(service.loadUnarmoredDefenses({})).resolves.toEqual([]);
      expect(unarmoredRepo.find).not.toHaveBeenCalled();
    });
  });
});
