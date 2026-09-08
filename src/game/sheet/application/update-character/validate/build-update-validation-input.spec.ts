import { buildUpdateValidationInput } from './build-update-validation-input';
import type { CharacterSheetData } from '@game/sheet/domain/character-sheet.types';

function snapshot(
  overrides: Partial<CharacterSheetData> = {},
): CharacterSheetData {
  return {
    classSkillSlugs: ['stealth', 'sleight-of-hand'],
    speciesChoices: [],
    heritageChoices: [],
    transformation: null,
    subclassOptions: [],
    classOptions: [
      { optionKey: 'expertiseSkill1', valueId: 'stealth' },
      { optionKey: 'expertiseSkill2', valueId: 'sleight-of-hand' },
    ],
    characterFeats: [],
    featOptions: [],
    characterSpells: [],
    equipment: [],
    languageSlugs: [],
    abilityGenerationMethodSlug: null,
    ...overrides,
  } as CharacterSheetData;
}

describe('buildUpdateValidationInput', () => {
  it('on level-up resync injects classOptions AND classSkillSlugs from snapshot', () => {
    const sheetSnapshot = snapshot();
    const result = buildUpdateValidationInput({
      sheetInput: {},
      sheetSnapshot,
      shouldResyncSpells: true,
      effective: { speciesSlug: 'human', heritageSlug: null },
      effectiveFeatOptions: [],
      effectiveSpeciesChoices: [],
      effectiveHeritageChoices: [],
    });

    expect(result.classOptions).toEqual(sheetSnapshot.classOptions);
    expect(result.classSkillSlugs).toEqual(['stealth', 'sleight-of-hand']);
  });

  it('on level-up resync injects subclassOptions so granted cantrips validate', () => {
    const sheetSnapshot = snapshot({
      subclassOptions: [
        { optionKey: 'holyRevelationCantrip1', valueId: 'luz' },
        { optionKey: 'holyRevelationCantrip2', valueId: 'taumaturgia' },
      ],
      characterSpells: [
        { spellSlug: 'luz', listType: 'always_prepared' },
        { spellSlug: 'taumaturgia', listType: 'always_prepared' },
      ],
    });
    const result = buildUpdateValidationInput({
      sheetInput: {
        characterSpells: sheetSnapshot.characterSpells,
      },
      sheetSnapshot,
      shouldResyncSpells: true,
      effective: { speciesSlug: 'human', heritageSlug: null },
      effectiveFeatOptions: [],
      effectiveSpeciesChoices: [],
      effectiveHeritageChoices: [],
    });

    expect(result.subclassOptions).toEqual(sheetSnapshot.subclassOptions);
  });

  it('when patch sends classOptions alone, still injects classSkillSlugs', () => {
    const sheetSnapshot = snapshot();
    const result = buildUpdateValidationInput({
      sheetInput: {
        classOptions: [
          { optionKey: 'expertiseSkill1', valueId: 'sleight-of-hand' },
        ],
      },
      sheetSnapshot,
      shouldResyncSpells: false,
      effective: { speciesSlug: null, heritageSlug: null },
      effectiveFeatOptions: [],
      effectiveSpeciesChoices: [],
      effectiveHeritageChoices: [],
    });

    expect(result.classSkillSlugs).toEqual(['stealth', 'sleight-of-hand']);
    expect(result.classOptions).toEqual([
      { optionKey: 'expertiseSkill1', valueId: 'sleight-of-hand' },
    ]);
  });
});
