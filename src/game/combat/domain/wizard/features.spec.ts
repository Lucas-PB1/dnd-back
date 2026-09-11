import {
  abjurerArcaneWardHp,
  arcaneRecoveryMaxSlotLevels,
  isWizardClass,
  portentDiceCount,
} from './features';

describe('wizard-features', () => {
  it('identifies wizard class correctly', () => {
    expect(isWizardClass('wizard')).toBe(true);
    expect(isWizardClass('sorcerer')).toBe(false);
  });

  it('computes arcane recovery max slot level sum', () => {
    expect(arcaneRecoveryMaxSlotLevels(1)).toBe(1);
    expect(arcaneRecoveryMaxSlotLevels(3)).toBe(2);
    expect(arcaneRecoveryMaxSlotLevels(5)).toBe(3);
    expect(arcaneRecoveryMaxSlotLevels(20)).toBe(10);
  });

  it('computes abjurer arcane ward hp', () => {
    expect(abjurerArcaneWardHp(3, 3)).toBe(9);
    expect(abjurerArcaneWardHp(10, 4)).toBe(24);
  });

  it('computes portent dice count', () => {
    expect(portentDiceCount(3)).toBe(2);
    expect(portentDiceCount(14)).toBe(3);
  });
});
