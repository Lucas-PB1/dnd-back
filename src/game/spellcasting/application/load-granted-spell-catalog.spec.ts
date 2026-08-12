import { LoadGrantedSpellCatalog } from './load-granted-spell-catalog';
import { VPhbSpeciesGrantedSpell } from '@entities/views/v-phb-species-granted-spell.entity';
import { VPhbFeatGrantedSpell } from '@entities/views/v-phb-feat-granted-spell.entity';
import { VPhbSubclassPreparedSpell } from '@entities/views/v-phb-subclass-prepared-spell.entity';
import { VPhbClassGrantedSpell } from '@entities/views/v-phb-class-granted-spell.entity';

describe('LoadGrantedSpellCatalog', () => {
  let service: LoadGrantedSpellCatalog;
  let speciesGrants: jest.Mocked<Pick<import('typeorm').Repository<VPhbSpeciesGrantedSpell>, 'find'>>;
  let featGrants: jest.Mocked<Pick<import('typeorm').Repository<VPhbFeatGrantedSpell>, 'find'>>;
  let subclassSpells: jest.Mocked<
    Pick<import('typeorm').Repository<VPhbSubclassPreparedSpell>, 'find'>
  >;
  let classSpells: jest.Mocked<
    Pick<import('typeorm').Repository<VPhbClassGrantedSpell>, 'find'>
  >;

  beforeEach(() => {
    speciesGrants = { find: jest.fn() };
    featGrants = { find: jest.fn() };
    subclassSpells = { find: jest.fn() };
    classSpells = { find: jest.fn() };
    service = new LoadGrantedSpellCatalog(
      speciesGrants as never,
      featGrants as never,
      subclassSpells as never,
      classSpells as never,
    );
  });

  describe('loadSpeciesCatalog', () => {
    it('loads all species when slug omitted', async () => {
      speciesGrants.find.mockResolvedValue([
        {
          speciesSlug: 'elf',
          choiceKind: null,
          choiceSlug: null,
          unlockLevel: 1,
          spellSlug: 'detect-magic',
        },
      ] as unknown as VPhbSpeciesGrantedSpell[]);

      const rows = await service.loadSpeciesCatalog();
      expect(speciesGrants.find).toHaveBeenCalledWith();
      expect(rows[0]).toEqual({
        speciesSlug: 'elf',
        choiceKind: null,
        choiceSlug: null,
        unlockLevel: 1,
        spellSlug: 'detect-magic',
      });
    });

    it('filters by species slug', async () => {
      speciesGrants.find.mockResolvedValue([]);
      await service.loadSpeciesCatalog('human');
      expect(speciesGrants.find).toHaveBeenCalledWith({ where: { speciesSlug: 'human' } });
    });
  });

  describe('loadFeatFixedSpells', () => {
    it('returns empty array for empty feat slug list', async () => {
      await expect(service.loadFeatFixedSpells([])).resolves.toEqual([]);
      expect(featGrants.find).not.toHaveBeenCalled();
    });

    it('returns all feats when slugs omitted', async () => {
      featGrants.find.mockResolvedValue([
        { featSlug: 'magic-initiate', spellSlug: 'bless' },
      ] as VPhbFeatGrantedSpell[]);
      await expect(service.loadFeatFixedSpells()).resolves.toEqual([
        { featSlug: 'magic-initiate', spellSlug: 'bless' },
      ]);
    });

    it('filters feat rows by slug set', async () => {
      featGrants.find.mockResolvedValue([
        { featSlug: 'magic-initiate', spellSlug: 'bless' },
        { featSlug: 'fey-touched', spellSlug: 'misty-step' },
      ] as VPhbFeatGrantedSpell[]);
      const rows = await service.loadFeatFixedSpells(['fey-touched']);
      expect(rows).toEqual([{ featSlug: 'fey-touched', spellSlug: 'misty-step' }]);
    });
  });

  describe('loadSubclassGrantedSpells', () => {
    it.each([null, undefined, ''])('returns [] for falsy subclass %p', async (slug) => {
      await expect(service.loadSubclassGrantedSpells(slug)).resolves.toEqual([]);
      expect(subclassSpells.find).not.toHaveBeenCalled();
    });

    it('maps subclass prepared spells', async () => {
      subclassSpells.find.mockResolvedValue([
        { unlockLevel: 3, spellSlug: 'hunter-mark' },
      ] as unknown as VPhbSubclassPreparedSpell[]);
      const rows = await service.loadSubclassGrantedSpells('hunter');
      expect(subclassSpells.find).toHaveBeenCalledWith({ where: { subclassSlug: 'hunter' } });
      expect(rows).toEqual([{ unlockLevel: 3, spellSlug: 'hunter-mark', terrainSlug: null }]);
    });

    it('filters land spells by terrain pick', async () => {
      subclassSpells.find.mockResolvedValue([
        { unlockLevel: 3, spellSlug: 'maos-flamejantes', terrainSlug: 'arid' },
        { unlockLevel: 3, spellSlug: 'nevoa-obscurecente', terrainSlug: 'polar' },
      ] as unknown as VPhbSubclassPreparedSpell[]);
      const rows = await service.loadSubclassGrantedSpells('land', [
        { optionKey: 'circleTerrain', valueId: 'arid' },
      ]);
      expect(rows).toEqual([
        { unlockLevel: 3, spellSlug: 'maos-flamejantes', terrainSlug: 'arid' },
      ]);
    });
  });

  describe('loadClassGrantedSpells', () => {
    it.each([null, undefined, ''])('returns [] for falsy class %p', async (slug) => {
      await expect(service.loadClassGrantedSpells(slug)).resolves.toEqual([]);
      expect(classSpells.find).not.toHaveBeenCalled();
    });

    it('maps class granted spells', async () => {
      classSpells.find.mockResolvedValue([
        { unlockLevel: 1, spellSlug: 'marca-do-predador' },
      ] as unknown as VPhbClassGrantedSpell[]);
      const rows = await service.loadClassGrantedSpells('ranger');
      expect(classSpells.find).toHaveBeenCalledWith({ where: { classSlug: 'ranger' } });
      expect(rows).toEqual([{ unlockLevel: 1, spellSlug: 'marca-do-predador' }]);
    });
  });

  describe('loadMergeCatalog', () => {
    it('dedupes species slugs and skips empty lists', async () => {
      speciesGrants.find.mockResolvedValue([]);
      featGrants.find.mockResolvedValue([]);
      subclassSpells.find.mockResolvedValue([]);

      await service.loadMergeCatalog({
        speciesSlugs: ['', 'elf', 'elf'],
        featSlugs: ['magic-initiate'],
        subclassSlug: null,
        classSlug: null,
      });

      expect(speciesGrants.find).toHaveBeenCalledTimes(1);
      expect(speciesGrants.find).toHaveBeenCalledWith({ where: { speciesSlug: 'elf' } });
    });

    it('returns merged catalog sections', async () => {
      speciesGrants.find.mockResolvedValue([
        { speciesSlug: 'elf', choiceKind: null, choiceSlug: null, unlockLevel: 1, spellSlug: 'light' },
      ] as unknown as VPhbSpeciesGrantedSpell[]);
      featGrants.find.mockResolvedValue([
        { featSlug: 'magic-initiate', spellSlug: 'bless' },
      ] as VPhbFeatGrantedSpell[]);
      subclassSpells.find.mockResolvedValue([
        { unlockLevel: 3, spellSlug: 'hunter-mark' },
      ] as unknown as VPhbSubclassPreparedSpell[]);
      classSpells.find.mockResolvedValue([
        { unlockLevel: 1, spellSlug: 'marca-do-predador' },
      ] as unknown as VPhbClassGrantedSpell[]);

      const result = await service.loadMergeCatalog({
        speciesSlugs: ['elf'],
        featSlugs: ['magic-initiate'],
        subclassSlug: 'hunter',
        classSlug: 'ranger',
      });

      expect(result.speciesCatalog).toHaveLength(1);
      expect(result.featFixedSpells).toHaveLength(1);
      expect(result.subclassGrantedSpells).toEqual([
        { unlockLevel: 3, spellSlug: 'hunter-mark', terrainSlug: null },
      ]);
      expect(result.classGrantedSpells).toEqual([
        { unlockLevel: 1, spellSlug: 'marca-do-predador' },
      ]);
    });

    it('returns empty species catalog when all slugs are falsy', async () => {
      featGrants.find.mockResolvedValue([]);
      const result = await service.loadMergeCatalog({
        speciesSlugs: ['', null as unknown as string],
        featSlugs: [],
        subclassSlug: null,
      });
      expect(result.speciesCatalog).toEqual([]);
      expect(speciesGrants.find).not.toHaveBeenCalled();
    });
  });
});
