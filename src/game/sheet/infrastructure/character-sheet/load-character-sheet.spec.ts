import { ObjectLiteral, Repository } from 'typeorm';
import { PlayerCharacterSkill } from '../player-character-skill.entity';
import {
  PlayerCharacterClassOption,
  PlayerCharacterEquipment,
  PlayerCharacterFeat,
  PlayerCharacterFeatOption,
  PlayerCharacterLanguage,
  PlayerCharacterSpeciesChoice,
  PlayerCharacterSpell,
  PlayerCharacterSubclassOption,
} from '../player-sheet.entities';
import { EMPTY_SHEET_DATA } from '../../domain/character-sheet.types';
import {
  emptySheetData,
  loadBackgroundSkillSlugs,
  loadCharacterSheet,
  loadManyCharacterSheets,
  mergeSheetData,
  type CharacterSheetLoadDeps,
} from './load-character-sheet';

function repo<T extends ObjectLiteral>(): jest.Mocked<Pick<Repository<T>, 'find'>> {
  return { find: jest.fn().mockResolvedValue([]) };
}

describe('load-character-sheet', () => {
  let deps: CharacterSheetLoadDeps;
  let dataSource: { query: jest.Mock };

  beforeEach(() => {
    dataSource = { query: jest.fn().mockResolvedValue([]) };
    deps = {
      dataSource: dataSource as never,
      skills: repo<PlayerCharacterSkill>() as unknown as Repository<PlayerCharacterSkill>,
      speciesChoices:
        repo<PlayerCharacterSpeciesChoice>() as unknown as Repository<PlayerCharacterSpeciesChoice>,
      subclassOptions:
        repo<PlayerCharacterSubclassOption>() as unknown as Repository<PlayerCharacterSubclassOption>,
      classOptions:
        repo<PlayerCharacterClassOption>() as unknown as Repository<PlayerCharacterClassOption>,
      feats: repo<PlayerCharacterFeat>() as unknown as Repository<PlayerCharacterFeat>,
      featOptions:
        repo<PlayerCharacterFeatOption>() as unknown as Repository<PlayerCharacterFeatOption>,
      spells: repo<PlayerCharacterSpell>() as unknown as Repository<PlayerCharacterSpell>,
      equipment:
        repo<PlayerCharacterEquipment>() as unknown as Repository<PlayerCharacterEquipment>,
      languages:
        repo<PlayerCharacterLanguage>() as unknown as Repository<PlayerCharacterLanguage>,
    };
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
    it('maps repository rows into CharacterSheetData', async () => {
      (deps.skills.find as jest.Mock).mockResolvedValue([{ skillSlug: 'stealth' }]);
      (deps.speciesChoices.find as jest.Mock).mockResolvedValue([
        { choiceKind: 'language', choiceSlug: 'elvish' },
      ]);
      (deps.subclassOptions.find as jest.Mock).mockResolvedValue([
        { optionKey: 'feature', valueId: 'fire' },
      ]);
      (deps.classOptions.find as jest.Mock).mockResolvedValue([
        { optionKey: 'expertiseSkill1', valueId: 'stealth' },
      ]);
      (deps.feats.find as jest.Mock).mockResolvedValue([{ featSlug: 'alert', instanceIndex: 0 }]);
      // Lote C: DB entity uses ownerSlug, function maps to featSlug
      (deps.featOptions.find as jest.Mock).mockResolvedValue([
        { ownerSlug: 'alert', instanceIndex: 0, optionKey: 'pick', valueId: 'perception' },
      ]);
      (deps.spells.find as jest.Mock).mockResolvedValue([
        { spellSlug: 'fire-bolt', listType: 'known' },
      ]);
      (deps.equipment.find as jest.Mock).mockResolvedValue([
        {
          source: 'class',
          packageSlug: 'fighter-a',
          itemSlug: 'longsword',
          quantity: 1,
          sortOrder: 0,
        },
      ]);
      (deps.languages.find as jest.Mock).mockResolvedValue([{ languageSlug: 'common' }]);

      const result = await loadCharacterSheet(deps, 'char-1');

      expect(result).toEqual({
        classSkillSlugs: ['stealth'],
        speciesChoices: [{ choiceKind: 'language', choiceSlug: 'elvish' }],
        subclassOptions: [{ optionKey: 'feature', valueId: 'fire' }],
        classOptions: [{ optionKey: 'expertiseSkill1', valueId: 'stealth' }],
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
      });
      expect(dataSource.query).not.toHaveBeenCalled();
    });

    it('loads background skills when backgroundSlug is provided', async () => {
      dataSource.query.mockResolvedValue([{ slug: 'athletics' }]);
      const result = await loadCharacterSheet(deps, 'char-1', 'soldier');
      expect(result.backgroundSkillSlugs).toEqual(['athletics']);
    });

    it('normalizes null equipment itemSlug to undefined', async () => {
      (deps.equipment.find as jest.Mock).mockResolvedValue([
        { source: 'background', packageSlug: 'pack', itemSlug: null, quantity: 2, sortOrder: 1 },
      ]);
      const result = await loadCharacterSheet(deps, 'char-1');
      expect(result.equipment[0].itemSlug).toBeUndefined();
    });
  });

  describe('loadManyCharacterSheets', () => {
    it('returns empty map for no ids', async () => {
      await expect(loadManyCharacterSheets(deps, [], new Map())).resolves.toEqual(new Map());
      expect(deps.skills.find).not.toHaveBeenCalled();
    });

    it('loads each character with optional background slug', async () => {
      (deps.skills.find as jest.Mock).mockImplementation((_opts: { where: { characterId: string } }) => {
        const id = _opts.where.characterId;
        return Promise.resolve([{ skillSlug: id === 'a' ? 'stealth' : 'perception' }]);
      });
      const backgrounds = new Map([['a', 'soldier']]);
      dataSource.query.mockResolvedValue([{ slug: 'athletics' }]);

      const map = await loadManyCharacterSheets(deps, ['a', 'b'], backgrounds);

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
});
