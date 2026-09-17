import { applyCombatHpDamage } from './apply-combat-hp-damage';

describe('applyCombatHpDamage', () => {
  it('absorbs damage with temporary HP first', () => {
    expect(
      applyCombatHpDamage({
        damage: 10,
        hitPointsCurrent: 20,
        tempHp: 4,
      }),
    ).toEqual({
      damageTotal: 10,
      absorbedByTempHp: 4,
      hitPointsBefore: 20,
      hitPointsAfter: 14,
      tempHpBefore: 4,
      tempHpAfter: 0,
    });
  });
});
