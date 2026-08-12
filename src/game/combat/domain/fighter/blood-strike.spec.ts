import {
  BLOOD_STRIKE_COST_DICE,
  BLOOD_STRIKE_LABELS,
  bloodStrikeCostDice,
  bloodStrikeLabel,
  bloodSymphonyHealAmount,
  canTakeLowerBloodCost,
} from './blood-strike';

describe('blood-strike domain', () => {
  it('maps all catalog strike options to cost dice', () => {
    expect(Object.keys(BLOOD_STRIKE_COST_DICE).sort()).toEqual(
      Object.keys(BLOOD_STRIKE_LABELS).sort(),
    );
    expect(bloodStrikeCostDice('hunting-strike')).toBe('1d4');
    expect(bloodStrikeCostDice('exiling-strike')).toBe('1d10');
    expect(bloodStrikeCostDice('unknown')).toBeNull();
  });

  it('gates L10 reroll and L15 symphony heal', () => {
    expect(canTakeLowerBloodCost(9)).toBe(false);
    expect(canTakeLowerBloodCost(10)).toBe(true);
    expect(bloodSymphonyHealAmount(3)).toBe(3);
    expect(bloodSymphonyHealAmount(-1)).toBe(1);
  });

  it('labels known strikes', () => {
    expect(bloodStrikeLabel('bewitching-strike')).toBe('Golpe Enfeitiçante');
  });
});
