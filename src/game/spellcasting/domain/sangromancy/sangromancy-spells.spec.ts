import {
  SANGROMANCY_SAVANT_OPTION_DEFS,
  SANGROMANCY_SAVANT_OPTION_KEYS,
  isSangromancerWizard,
  isSangromancySavantOptionKey,
  usesWizardPlusSangromancyList,
} from './sangromancy-spells';

describe('sangromancy-spells', () => {
  it('detects sangromancer wizard', () => {
    expect(isSangromancerWizard('wizard', 'sangromancer')).toBe(true);
    expect(isSangromancerWizard('wizard', 'evoker')).toBe(false);
    expect(isSangromancerWizard('sorcerer', 'sangromancer')).toBe(false);
  });

  it('detects wizard+sangromancy list for sanguine thief', () => {
    expect(usesWizardPlusSangromancyList('rogue', 'sanguine-thief')).toBe(true);
    expect(usesWizardPlusSangromancyList('rogue', 'thief')).toBe(false);
    expect(usesWizardPlusSangromancyList('wizard', 'sangromancer')).toBe(true);
  });

  it('defines nine savant picks (2 at L3 + one per new slot tier from L5)', () => {
    expect(SANGROMANCY_SAVANT_OPTION_KEYS).toHaveLength(9);
    expect(SANGROMANCY_SAVANT_OPTION_DEFS).toHaveLength(9);
    expect(SANGROMANCY_SAVANT_OPTION_DEFS[0]).toMatchObject({
      optionKey: 'sangromancySavant1',
      unlockLevel: 3,
      spellMaxLevel: 2,
    });
    expect(SANGROMANCY_SAVANT_OPTION_DEFS[2]).toMatchObject({
      optionKey: 'sangromancySavant3',
      unlockLevel: 5,
      spellMaxLevel: 3,
    });
  });

  it('recognizes savant option keys', () => {
    expect(isSangromancySavantOptionKey('sangromancySavant1')).toBe(true);
    expect(isSangromancySavantOptionKey('abjurationVersatility1')).toBe(false);
  });
});
