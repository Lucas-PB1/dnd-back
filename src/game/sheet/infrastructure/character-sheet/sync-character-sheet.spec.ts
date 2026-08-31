import { ObjectLiteral, Repository } from 'typeorm';
import {
  clearClassOptions,
  clearClassSkills,
  clearSpeciesChoices,
  clearSubclassOptions,
  syncCharacterSheet,
  type CharacterSheetSyncDeps,
} from './sync-character-sheet';
import { PlayerCharacterSkill } from '../player-character-skill.entity';
import {
  PlayerCharacterFeat,
  PlayerCharacterLanguage,
  PlayerCharacterOption,
  PlayerCharacterSpeciesChoice,
} from '../player-sheet.entities';

function repo<T extends ObjectLiteral>(): jest.Mocked<
  Pick<Repository<T>, 'delete' | 'insert' | 'find'>
> {
  return {
    delete: jest.fn().mockResolvedValue(undefined),
    insert: jest.fn().mockResolvedValue(undefined),
    find: jest.fn().mockResolvedValue([]),
  };
}

describe('syncCharacterSheet', () => {
  const characterId = 'char-1';
  let deps: CharacterSheetSyncDeps;

  beforeEach(() => {
    deps = {
      skills: repo<PlayerCharacterSkill>() as unknown as Repository<PlayerCharacterSkill>,
      speciesChoices:
        repo<PlayerCharacterSpeciesChoice>() as unknown as Repository<PlayerCharacterSpeciesChoice>,
      options: repo<PlayerCharacterOption>() as unknown as Repository<PlayerCharacterOption>,
      feats: repo<PlayerCharacterFeat>() as unknown as Repository<PlayerCharacterFeat>,
      spells: repo() as never,
      equipment: repo() as never,
      languages:
        repo<PlayerCharacterLanguage>() as unknown as Repository<PlayerCharacterLanguage>,
      dataSource: { query: jest.fn().mockResolvedValue([]) } as never,
    };
  });

  it('replaces class skills when provided', async () => {
    await syncCharacterSheet(deps, characterId, {
      classSkillSlugs: ['stealth', 'perception'],
    });

    expect(deps.skills.delete).toHaveBeenCalledWith({ characterId });
    expect(deps.skills.insert).toHaveBeenCalledWith([
      { characterId, skillSlug: 'stealth' },
      { characterId, skillSlug: 'perception' },
    ]);
  });

  it('clears skills when empty array', async () => {
    await syncCharacterSheet(deps, characterId, { classSkillSlugs: [] });

    expect(deps.skills.delete).toHaveBeenCalledWith({ characterId });
    expect(deps.skills.insert).not.toHaveBeenCalled();
  });

  it('syncs languages and class options', async () => {
    await syncCharacterSheet(deps, characterId, {
      languageSlugs: ['common', 'elvish'],
      classOptions: [{ optionKey: 'expertiseSkill1', valueId: 'stealth' }],
    });

    expect(deps.languages.insert).toHaveBeenCalledWith([
      { characterId, languageSlug: 'common' },
      { characterId, languageSlug: 'elvish' },
    ]);
    expect(deps.options.insert).toHaveBeenCalledWith([
      expect.objectContaining({
        characterId,
        scope: 'class',
        optionKey: 'expertiseSkill1',
        valueId: 'stealth',
      }),
    ]);
  });

  it('removes orphan feat options when feats shrink', async () => {
    (deps.options.find as jest.Mock).mockResolvedValue([
      { id: 'opt-1', ownerSlug: 'alert', instanceIndex: 0, optionKey: 'pick' },
      { id: 'opt-2', ownerSlug: 'lucky', instanceIndex: 0, optionKey: 'pick' },
    ]);

    await syncCharacterSheet(deps, characterId, {
      characterFeats: [{ featSlug: 'alert', instanceIndex: 0 }],
    });

    expect(deps.options.delete).toHaveBeenCalledWith(['opt-2']);
  });

  it('skips undefined sections', async () => {
    await syncCharacterSheet(deps, characterId, {});

    expect(deps.skills.delete).not.toHaveBeenCalled();
    expect(deps.languages.delete).not.toHaveBeenCalled();
  });

  it('syncs species, subclass, class options, and clears empty species', async () => {
    await syncCharacterSheet(deps, characterId, {
      speciesChoices: [{ choiceKind: 'language', choiceSlug: 'elvish' }],
      subclassOptions: [{ optionKey: 'feature', valueId: 'fire' }],
      classOptions: [{ optionKey: 'expertiseSkill1', valueId: 'stealth' }],
    });
    expect(deps.speciesChoices.insert).toHaveBeenCalled();
    expect(deps.options.insert).toHaveBeenCalled();

    await syncCharacterSheet(deps, characterId, { speciesChoices: [] });
    expect(deps.speciesChoices.delete).toHaveBeenCalledWith({ characterId });
  });

  it('syncs feats, feat options, spells, and equipment', async () => {
    await syncCharacterSheet(deps, characterId, {
      characterFeats: [{ featSlug: 'alert', instanceIndex: 0 }],
      featOptions: [{ featSlug: 'alert', optionKey: 'pick', valueId: 'perception' }],
      characterSpells: [{ spellSlug: 'fire-bolt', listType: 'known' }],
      equipment: [
        { source: 'class', packageSlug: 'fighter-a', itemSlug: 'longsword', quantity: 1 },
      ],
    });

    expect(deps.feats.insert).toHaveBeenCalled();
    expect(deps.options.insert).toHaveBeenCalledWith([
      expect.objectContaining({ scope: 'feat', optionKey: 'pick', instanceIndex: 0 }),
    ]);
    expect(deps.spells.insert).toHaveBeenCalled();
    expect(deps.equipment.insert).toHaveBeenCalledWith([
      expect.objectContaining({ itemSlug: 'longsword', sortOrder: 0, quantity: 1 }),
    ]);
  });

  it('clears feat options when characterFeats is empty', async () => {
    (deps.options.find as jest.Mock).mockResolvedValue([]);
    await syncCharacterSheet(deps, characterId, { characterFeats: [] });
    expect(deps.feats.delete).toHaveBeenCalledWith({ characterId });
    expect(deps.options.delete).not.toHaveBeenCalled();
  });

  it('defaults feat option instanceIndex and equipment quantity', async () => {
    await syncCharacterSheet(deps, characterId, {
      featOptions: [{ featSlug: 'alert', optionKey: 'pick', valueId: 'perception' }],
      equipment: [{ source: 'background', packageSlug: 'pack' }],
    });
    expect(deps.options.insert).toHaveBeenCalledWith([
      expect.objectContaining({ scope: 'feat', instanceIndex: 0 }),
    ]);
    expect(deps.equipment.insert).toHaveBeenCalledWith([
      expect.objectContaining({ quantity: 1, itemSlug: null }),
    ]);
  });
});

describe('clearCharacterSheet helpers', () => {
  const characterId = 'char-1';
  let deps: CharacterSheetSyncDeps;

  beforeEach(() => {
    deps = {
      skills: repo() as never,
      speciesChoices: repo() as never,
      options: repo() as never,
      feats: repo() as never,
      spells: repo() as never,
      equipment: repo() as never,
      languages: repo() as never,
      dataSource: { query: jest.fn().mockResolvedValue([]) } as never,
    };
  });

  it('clearSubclassOptions deletes scoped rows', async () => {
    await clearSubclassOptions(deps, characterId);
    expect(deps.options.delete).toHaveBeenCalledWith({ characterId, scope: 'subclass' });
  });

  it('clearClassOptions deletes scoped rows', async () => {
    await clearClassOptions(deps, characterId);
    expect(deps.options.delete).toHaveBeenCalledWith({ characterId, scope: 'class' });
  });

  it('clearClassSkills deletes skills', async () => {
    await clearClassSkills(deps, characterId);
    expect(deps.skills.delete).toHaveBeenCalledWith({ characterId });
  });

  it('clearSpeciesChoices deletes species choices', async () => {
    await clearSpeciesChoices(deps, characterId);
    expect(deps.speciesChoices.delete).toHaveBeenCalledWith({ characterId });
  });
});
