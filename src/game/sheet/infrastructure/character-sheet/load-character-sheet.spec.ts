import { EMPTY_SHEET_DATA } from '@game/sheet/domain/character-sheet.types';
import {
  emptySheetData,
  loadBackgroundSkillSlugs,
  loadCharacterSheet,
  loadGrantedSpellSheetSlice,
  loadManyCharacterSheets,
  mergeSheetData,
  type CharacterSheetLoadDeps,
} from './load-character-sheet';

describe('load-character-sheet', () => {
  let deps: CharacterSheetLoadDeps;
  let dataSource: { query: jest.Mock };

  beforeEach(() => {
    dataSource = { query: jest.fn().mockResolvedValue([]) };
    deps = { dataSource: dataSource as never };
  });

  describe('emptySheetData', () => {
    it('returns a copy of EMPTY_SHEET_DATA', () => {
      const sheet = emptySheetData();
      expect(sheet).toEqual(EMPTY_SHEET_DATA);
      expect(sheet).not.toBe(EMPTY_SHEET_DATA);
    });
  });

  describe('mergeSheetData', () => {
    it('merges abilityGenerationMethodSlug onto base', () => {
      const base = emptySheetData();
      expect(mergeSheetData(base, 'standard-array')).toEqual({
        ...base,
        abilityGenerationMethodSlug: 'standard-array',
      });
    });

    it('allows null ability generation method', () => {
      const base = { ...emptySheetData(), abilityGenerationMethodSlug: 'point-buy' };
      expect(mergeSheetData(base, null).abilityGenerationMethodSlug).toBeNull();
    });
  });

  describe('loadBackgroundSkillSlugs', () => {
    it('queries background skills and maps slugs', async () => {
      dataSource.query.mockResolvedValue([{ slug: 'insight' }, { slug: 'religion' }]);
      await expect(loadBackgroundSkillSlugs(deps, 'acolyte')).resolves.toEqual([
        'insight',
        'religion',
      ]);
      expect(dataSource.query).toHaveBeenCalledWith(
        expect.stringContaining('phb_background_skill'),
        ['acolyte'],
      );
    });
  });

  describe('loadCharacterSheet', () => {
    it('maps RPC bundle into CharacterSheetData', async () => {
      dataSource.query.mockResolvedValue([
        {
          bundle: {
            classSkillSlugs: ['stealth'],
            speciesChoices: [{ choiceKind: 'language', choiceSlug: 'elvish' }],
            subclassOptions: [{ optionKey: 'feature', valueId: 'fire' }],
            classOptions: [
              { optionKey: 'expertiseSkill1', valueId: 'stealth', instanceIndex: 0 },
            ],
            characterFeats: [{ featSlug: 'alert', instanceIndex: 0 }],
            featOptions: [
              {
                featSlug: 'alert',
                instanceIndex: 0,
                optionKey: 'pick',
                valueId: 'perception',
              },
            ],
            characterSpells: [{ spellSlug: 'fire-bolt', listType: 'known' }],
            equipment: [
              {
                source: 'class',
                packageSlug: 'fighter-a',
                itemSlug: 'longsword',
                quantity: 1,
                sortOrder: 0,
              },
            ],
            languageSlugs: ['common'],
            backgroundSkillSlugs: [],
          },
        },
      ]);

      const result = await loadCharacterSheet(deps, 'char-1');

      expect(result).toEqual({
        classSkillSlugs: ['stealth'],
        speciesChoices: [{ choiceKind: 'language', choiceSlug: 'elvish' }],
        subclassOptions: [{ optionKey: 'feature', valueId: 'fire' }],
        classOptions: [
          { optionKey: 'expertiseSkill1', valueId: 'stealth', instanceIndex: 0 },
        ],
        characterFeats: [{ featSlug: 'alert', instanceIndex: 0 }],
        featOptions: [
          { featSlug: 'alert', instanceIndex: 0, optionKey: 'pick', valueId: 'perception' },
        ],
        characterSpells: [{ spellSlug: 'fire-bolt', listType: 'known' }],
        equipment: [
          {
            source: 'class',
            packageSlug: 'fighter-a',
            itemSlug: 'longsword',
            quantity: 1,
            sortOrder: 0,
          },
        ],
        languageSlugs: ['common'],
        abilityGenerationMethodSlug: null,
        backgroundSkillSlugs: [],
        proficiencyBonus: null,
        classAbilityBoosts: [],
        speciesSize: null,
      });
      expect(dataSource.query).toHaveBeenCalledWith(
        expect.stringContaining('get_character_sheet_bundle'),
        ['char-1', null],
      );
    });

    it('passes backgroundSlug to the RPC', async () => {
      dataSource.query.mockResolvedValue([
        { bundle: { ...EMPTY_SHEET_DATA, backgroundSkillSlugs: ['athletics'] } },
      ]);
      const result = await loadCharacterSheet(deps, 'char-1', 'soldier');
      expect(result.backgroundSkillSlugs).toEqual(['athletics']);
      expect(dataSource.query).toHaveBeenCalledWith(
        expect.stringContaining('get_character_sheet_bundle'),
        ['char-1', 'soldier'],
      );
    });

    it('maps proficiencyBonus, classAbilityBoosts and speciesSize from RPC', async () => {
      dataSource.query.mockResolvedValue([
        {
          bundle: {
            proficiencyBonus: 3,
            speciesSize: 'Médio',
            classAbilityBoosts: [
              {
                abilitySlug: 'forca',
                label: 'Aura',
                bonus: 1,
                scoreMax: 22,
                fromLevel: 6,
              },
            ],
          },
        },
      ]);

      const result = await loadCharacterSheet(deps, 'char-1');
      expect(result.proficiencyBonus).toBe(3);
      expect(result.speciesSize).toBe('Médio');
      expect(result.classAbilityBoosts).toEqual([
        {
          ability: 'forca',
          label: 'Aura',
          bonus: 1,
          scoreMax: 22,
          fromLevel: 6,
        },
      ]);
    });

    it('normalizes null equipment itemSlug to undefined', async () => {
      dataSource.query.mockResolvedValue([
        {
          bundle: {
            equipment: [
              {
                source: 'background',
                packageSlug: 'pack',
                itemSlug: null,
                quantity: 2,
                sortOrder: 1,
              },
            ],
          },
        },
      ]);
      const result = await loadCharacterSheet(deps, 'char-1');
      expect(result.equipment[0].itemSlug).toBeUndefined();
    });

    it('returns empty sheet when RPC yields no row', async () => {
      dataSource.query.mockResolvedValue([]);
      await expect(loadCharacterSheet(deps, 'char-1')).resolves.toEqual(EMPTY_SHEET_DATA);
    });
  });

  describe('loadManyCharacterSheets', () => {
    it('returns empty map for no ids', async () => {
      await expect(loadManyCharacterSheets(deps, [], new Map())).resolves.toEqual(new Map());
      expect(dataSource.query).not.toHaveBeenCalled();
    });

    it('loads each character with optional background slug', async () => {
      dataSource.query.mockImplementation(
        (_sql: string, params: [string, string | null]) => {
          const [id, bg] = params;
          return Promise.resolve([
            {
              bundle: {
                classSkillSlugs: [id === 'a' ? 'stealth' : 'perception'],
                backgroundSkillSlugs: bg === 'soldier' ? ['athletics'] : [],
              },
            },
          ]);
        },
      );

      const map = await loadManyCharacterSheets(
        deps,
        ['a', 'b'],
        new Map([['a', 'soldier']]),
      );

      expect(map.get('a')).toMatchObject({
        classSkillSlugs: ['stealth'],
        backgroundSkillSlugs: ['athletics'],
      });
      expect(map.get('b')).toMatchObject({
        classSkillSlugs: ['perception'],
        backgroundSkillSlugs: [],
      });
    });
  });

  describe('loadGrantedSpellSheetSlice', () => {
    it('loads classOptions alongside feats/spells via sheet bundle', async () => {
      dataSource.query.mockResolvedValue([
        {
          bundle: {
            speciesChoices: [],
            classOptions: [
              {
                optionKey: 'eldritch-invocation',
                valueId: 'mask-of-many-faces',
                instanceIndex: 0,
              },
            ],
            characterFeats: [],
            featOptions: [],
            characterSpells: [{ spellSlug: 'disguise-self', listType: 'known' }],
            classSkillSlugs: ['stealth'],
            equipment: [{ source: 'class', packageSlug: 'x', quantity: 1, sortOrder: 0 }],
            languageSlugs: ['common'],
          },
        },
      ]);

      const slice = await loadGrantedSpellSheetSlice(deps, 'char-1');

      expect(slice).toEqual({
        speciesChoices: [],
        classOptions: [
          {
            optionKey: 'eldritch-invocation',
            valueId: 'mask-of-many-faces',
            instanceIndex: 0,
          },
        ],
        characterFeats: [],
        featOptions: [],
        characterSpells: [{ spellSlug: 'disguise-self', listType: 'known' }],
      });
      expect(dataSource.query).toHaveBeenCalledTimes(1);
    });
  });
});
