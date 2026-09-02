import { asDep } from '@common/testing/as-dep';
jest.mock('./character-sheet/load-character-sheet', () => ({
  emptySheetData: jest.fn().mockReturnValue({ classSkillSlugs: [] }),
  loadBackgroundSkillSlugs: jest.fn().mockResolvedValue(['insight']),
  loadCharacterSheet: jest.fn().mockResolvedValue({ classSkillSlugs: ['stealth'] }),
  loadManyCharacterSheets: jest.fn().mockResolvedValue(new Map([['c1', {}]])),
  mergeSheetData: jest.fn((base, slug) => ({ ...base, abilityGenerationMethodSlug: slug })),
}));

jest.mock('./character-sheet/sync-character-sheet', () => ({
  syncCharacterSheet: jest.fn().mockResolvedValue(undefined),
  clearSubclassOptions: jest.fn().mockResolvedValue(undefined),
  clearClassOptions: jest.fn().mockResolvedValue(undefined),
  clearClassSkills: jest.fn().mockResolvedValue(undefined),
  clearSpeciesChoices: jest.fn().mockResolvedValue(undefined),
}));

import { CharacterSheetRepository } from './character-sheet.repository';
import * as load from './character-sheet/load-character-sheet';
import * as sync from './character-sheet/sync-character-sheet';

describe('CharacterSheetRepository', () => {
  let repo: CharacterSheetRepository;

  beforeEach(() => {
    jest.clearAllMocks();
    repo = new CharacterSheetRepository(
      asDep({}),
      asDep({}),
      asDep({}),
      asDep({}),
      asDep({}),
      asDep({}),
      asDep({}),
      asDep({}),
    );
  });

  it('delegates load helpers', async () => {
    await repo.load('c1', 'soldier');
    await repo.loadMany(['c1'], new Map([['c1', 'soldier']]));
    await repo.loadBackgroundSkillSlugs('soldier');
    expect(load.loadCharacterSheet).toHaveBeenCalled();
    expect(load.loadManyCharacterSheets).toHaveBeenCalled();
    expect(load.loadBackgroundSkillSlugs).toHaveBeenCalledWith(expect.any(Object), 'soldier');
  });

  it('delegates sync and clear methods', async () => {
    await repo.sync('c1', { classSkillSlugs: ['stealth'] });
    await repo.clearSubclassOptions('c1');
    await repo.clearClassOptions('c1');
    await repo.clearClassSkills('c1');
    await repo.clearSpeciesChoices('c1');
    expect(sync.syncCharacterSheet).toHaveBeenCalled();
    expect(sync.clearSubclassOptions).toHaveBeenCalled();
    expect(sync.clearClassOptions).toHaveBeenCalled();
    expect(sync.clearClassSkills).toHaveBeenCalled();
    expect(sync.clearSpeciesChoices).toHaveBeenCalled();
  });

  it('delegates mergeSheetData and empty', () => {
    const base = { classSkillSlugs: [] };
    repo.mergeSheetData(asDep(base), 'point-buy');
    repo.empty();
    expect(load.mergeSheetData).toHaveBeenCalledWith(base, 'point-buy');
    expect(load.emptySheetData).toHaveBeenCalled();
  });
});
