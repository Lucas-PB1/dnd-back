import {
  classOrderSkillCheckBonus,
  extraArmorTrainingFromClassOrder,
  extraCantripsFromClassOrder,
  extraWeaponProficiencyFromClassOrder,
} from './class-order-effects';

describe('class-order-effects', () => {
  it('grants heavy armor and martial weapons to cleric protector', () => {
    const options = [{ optionKey: 'divineOrder', valueId: 'protector' }];
    expect(extraArmorTrainingFromClassOrder('cleric', options)).toEqual(['heavy']);
    expect(extraWeaponProficiencyFromClassOrder('cleric', options)).toEqual([
      'armas-marciais',
    ]);
    expect(extraCantripsFromClassOrder(options)).toBe(0);
  });

  it('grants martial weapons to druid warden', () => {
    const options = [{ optionKey: 'primalOrder', valueId: 'warden' }];
    expect(extraArmorTrainingFromClassOrder('druid', options)).toEqual([]);
    expect(extraWeaponProficiencyFromClassOrder('druid', options)).toEqual([
      'armas-marciais',
    ]);
  });

  it('grants extra cantrip and wis skill bonus to thaumaturge/magician', () => {
    const thaumaturge = [{ optionKey: 'divineOrder', valueId: 'thaumaturge' }];
    const magician = [{ optionKey: 'primalOrder', valueId: 'magician' }];
    expect(extraCantripsFromClassOrder(thaumaturge)).toBe(1);
    expect(extraCantripsFromClassOrder(magician)).toBe(1);
    expect(classOrderSkillCheckBonus('arcana', thaumaturge, 3)).toBe(3);
    expect(classOrderSkillCheckBonus('religion', thaumaturge, 0)).toBe(1);
    expect(classOrderSkillCheckBonus('nature', magician, 2)).toBe(2);
    expect(classOrderSkillCheckBonus('athletics', thaumaturge, 3)).toBe(0);
  });
});
