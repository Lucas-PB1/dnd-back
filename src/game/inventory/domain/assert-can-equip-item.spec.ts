import { assertCanEquipItem } from './assert-can-equip-item';

describe('assertCanEquipItem', () => {
  it('allows armor without training (soft compliance elsewhere)', () => {
    expect(() => assertCanEquipItem({ kind: 'armor' })).not.toThrow();
  });

  it('allows weapon without proficiency (soft compliance elsewhere)', () => {
    expect(() => assertCanEquipItem({ kind: 'weapon' })).not.toThrow();
  });
});
