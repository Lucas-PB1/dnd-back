import { clearStaleSheetChoices } from './clear-stale-sheet-choices';
import { asDep } from '@common/testing/as-dep';

describe('clearStaleSheetChoices', () => {
  let sheetRepository: {
    clearClassSkills: jest.Mock;
    clearClassOptions: jest.Mock;
    clearSpeciesChoices: jest.Mock;
    clearSubclassOptions: jest.Mock;
  };

  beforeEach(() => {
    sheetRepository = {
      clearClassSkills: jest.fn(),
      clearClassOptions: jest.fn(),
      clearSpeciesChoices: jest.fn(),
      clearSubclassOptions: jest.fn(),
    };
  });

  it('clears all stale groups when changed without payload', async () => {
    await clearStaleSheetChoices(asDep(sheetRepository), 'ch1', {}, {
      classChanged: true,
      speciesChanged: true,
      subclassChanged: true,
    });
    expect(sheetRepository.clearClassSkills).toHaveBeenCalledWith('ch1');
    expect(sheetRepository.clearClassOptions).toHaveBeenCalledWith('ch1');
    expect(sheetRepository.clearSpeciesChoices).toHaveBeenCalledWith('ch1');
    expect(sheetRepository.clearSubclassOptions).toHaveBeenCalledWith('ch1');
  });

  it('skips clears when dto provides replacements', async () => {
    await clearStaleSheetChoices(
      asDep(sheetRepository),
      'ch1',
      asDep({
        classSkillSlugs: ['athletics'],
        classOptions: [],
        speciesChoices: [],
        subclassOptions: [],
      }),
      {
        classChanged: true,
        speciesChanged: true,
        subclassChanged: true,
      },
    );
    expect(sheetRepository.clearClassSkills).not.toHaveBeenCalled();
    expect(sheetRepository.clearClassOptions).not.toHaveBeenCalled();
    expect(sheetRepository.clearSpeciesChoices).not.toHaveBeenCalled();
    expect(sheetRepository.clearSubclassOptions).not.toHaveBeenCalled();
  });

  it('does nothing when nothing changed', async () => {
    await clearStaleSheetChoices(asDep(sheetRepository), 'ch1', {}, {
      classChanged: false,
      speciesChanged: false,
      subclassChanged: false,
    });
    expect(sheetRepository.clearClassSkills).not.toHaveBeenCalled();
  });
});
