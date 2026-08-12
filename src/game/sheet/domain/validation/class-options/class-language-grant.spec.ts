import {
  DRUIDIC_LANGUAGE_SLUG,
  THIEVES_CANT_LANGUAGE_SLUG,
  classLanguageGrant,
} from './class-language-grant';

describe('classLanguageGrant', () => {
  it('grants thieves cant plus one choice to rogue', () => {
    expect(classLanguageGrant('rogue', 1)).toEqual({
      grantedSlugs: [THIEVES_CANT_LANGUAGE_SLUG],
      choiceCount: 1,
    });
  });

  it('grants druidic to druid', () => {
    expect(classLanguageGrant('druid', 1)).toEqual({
      grantedSlugs: [DRUIDIC_LANGUAGE_SLUG],
      choiceCount: 0,
    });
  });

  it('grants two language choices to ranger from level 2', () => {
    expect(classLanguageGrant('ranger', 1)).toEqual({
      grantedSlugs: [],
      choiceCount: 0,
    });
    expect(classLanguageGrant('ranger', 2)).toEqual({
      grantedSlugs: [],
      choiceCount: 2,
    });
  });

  it('grants nothing to other classes', () => {
    expect(classLanguageGrant('fighter', 12)).toEqual({
      grantedSlugs: [],
      choiceCount: 0,
    });
  });
});
