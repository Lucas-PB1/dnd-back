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
  PlayerCharacterClassOption,
  PlayerCharacterFeat,
  PlayerCharacterFeatOption,
  PlayerCharacterLanguage,
  PlayerCharacterSpeciesChoice,
  PlayerCharacterSubclassOption,
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
      subclassOptions:
        repo<PlayerCharacterSubclassOption>() as unknown as Repository<PlayerCharacterSubclassOption>,
      classOptions:
        repo<PlayerCharacterClassOption>() as unknown as Repository<PlayerCharacterClassOption>,
      feats: repo<PlayerCharacterFeat>() as unknown as Repository<PlayerCharacterFeat>,
      featOptions:
        repo<PlayerCharacterFeatOption>() as unknown as Repository<PlayerCharacterFeatOption>,
      spells: repo() as never,
      equipment: repo() as never,
      languages:
        repo<PlayerCharacterLanguage>() as unknown as Repository<PlayerCharacterLanguage>,
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
    expect(deps.classOptions.insert).toHaveBeenCalledWith([
      { characterId, optionKey: 'expertiseSkill1', valueId: 'stealth' },
    ]);
  });

  it('removes orphan feat options when feats shrink', async () => {
    (deps.featOptions.find as jest.Mock).mockResolvedValue([
      { featSlug: 'alert', instanceIndex: 0, optionKey: 'pick' },
      { featSlug: 'lucky', instanceIndex: 0, optionKey: 'pick' },
    ]);

    await syncCharacterSheet(deps, characterId, {
      characterFeats: [{ featSlug: 'alert', instanceIndex: 0 }],
    });

    expect(deps.featOptions.delete).toHaveBeenCalledWith([
      {
        characterId,
        featSlug: 'lucky',
        instanceIndex: 0,
        optionKey: 'pick',
      },
    ]);
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
    expect(deps.subclassOptions.insert).toHaveBeenCalled();

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
    expect(deps.featOptions.insert).toHaveBeenCalledWith([
      expect.objectContaining({ optionKey: 'pick', instanceIndex: 0 }),
    ]);
    expect(deps.spells.insert).toHaveBeenCalled();
    expect(deps.equipment.insert).toHaveBeenCalledWith([
      expect.objectContaining({ itemSlug: 'longsword', sortOrder: 0, quantity: 1 }),
    ]);
  });

  it('clears feat options when characterFeats is empty', async () => {
    (deps.featOptions.find as jest.Mock).mockResolvedValue([]);
    await syncCharacterSheet(deps, characterId, { characterFeats: [] });
    expect(deps.feats.delete).toHaveBeenCalledWith({ characterId });
    expect(deps.featOptions.delete).not.toHaveBeenCalled();
  });

  it('defaults feat option instanceIndex and equipment quantity', async () => {
    await syncCharacterSheet(deps, characterId, {
      featOptions: [{ featSlug: 'alert', optionKey: 'pick', valueId: 'perception' }],
      equipment: [{ source: 'background', packageSlug: 'pack' }],
    });
    expect(deps.featOptions.insert).toHaveBeenCalledWith([
      expect.objectContaining({ instanceIndex: 0 }),
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
      subclassOptions: repo() as never,
      classOptions: repo() as never,
      feats: repo() as never,
      featOptions: repo() as never,
      spells: repo() as never,
      equipment: repo() as never,
      languages: repo() as never,
    };
  });

  it.each([
    ['clearSubclassOptions', clearSubclassOptions, 'subclassOptions'],
    ['clearClassOptions', clearClassOptions, 'classOptions'],
    ['clearClassSkills', clearClassSkills, 'skills'],
    ['clearSpeciesChoices', clearSpeciesChoices, 'speciesChoices'],
  ])('%s deletes by characterId', async (_label, fn, key) => {
    await fn(deps, characterId);
    expect(deps[key as keyof CharacterSheetSyncDeps].delete).toHaveBeenCalledWith({ characterId });
  });
});
