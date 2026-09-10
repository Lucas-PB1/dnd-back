import {
  bloodSymphonyHealAmount,
  canBloodSymphonyHeal,
  canBloodSymphonyRefund,
  canTakeLowerBloodCost,
  canUseBloodArmament,
  canUseBloodExplosion,
  isBloodHoundSubclass,
} from './blood-strike';

describe('blood-strike product gates', () => {
  it('Sinfonia heal is max(1, CON)', () => {
    expect(bloodSymphonyHealAmount(0)).toBe(1);
    expect(bloodSymphonyHealAmount(2)).toBe(2);
    expect(bloodSymphonyHealAmount(-1)).toBe(1);
  });

  it('gates L7 / L10 / L15', () => {
    expect(canUseBloodArmament(6)).toBe(false);
    expect(canUseBloodArmament(7)).toBe(true);
    expect(canUseBloodExplosion(7)).toBe(true);
    expect(canTakeLowerBloodCost(9)).toBe(false);
    expect(canTakeLowerBloodCost(10)).toBe(true);
    expect(canBloodSymphonyHeal(14)).toBe(false);
    expect(canBloodSymphonyHeal(15)).toBe(true);
    expect(canBloodSymphonyRefund(15)).toBe(true);
  });

  it('identifies Sabujo subclass', () => {
    expect(isBloodHoundSubclass('blood-hound')).toBe(true);
    expect(isBloodHoundSubclass('battle-master')).toBe(false);
  });
});
