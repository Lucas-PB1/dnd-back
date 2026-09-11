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

  it('gates from catalog unlock levels', () => {
    expect(canUseBloodArmament(6, 7)).toBe(false);
    expect(canUseBloodArmament(7, 7)).toBe(true);
    expect(canUseBloodExplosion(7, 7)).toBe(true);
    expect(canTakeLowerBloodCost(9, 10)).toBe(false);
    expect(canTakeLowerBloodCost(10, 10)).toBe(true);
    expect(canBloodSymphonyHeal(14, 15)).toBe(false);
    expect(canBloodSymphonyHeal(15, 15)).toBe(true);
    expect(canBloodSymphonyRefund(15, 15)).toBe(true);
    expect(canUseBloodArmament(20, null)).toBe(false);
  });

  it('identifies Sabujo subclass', () => {
    expect(isBloodHoundSubclass('blood-hound')).toBe(true);
    expect(isBloodHoundSubclass('battle-master')).toBe(false);
  });
});
