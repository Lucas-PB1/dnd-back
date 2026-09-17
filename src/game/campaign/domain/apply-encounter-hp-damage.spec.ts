import { applyEncounterHpDamage } from './apply-encounter-hp-damage';

describe('applyEncounterHpDamage', () => {
  it('absorbs damage with temp HP before reducing current HP', () => {
    expect(
      applyEncounterHpDamage({
        damage: 8,
        hitPointsCurrent: 20,
        tempHp: 3,
      }),
    ).toEqual({
      damageTotal: 8,
      absorbedByTempHp: 3,
      hitPointsBefore: 20,
      hitPointsAfter: 15,
      tempHpBefore: 3,
      tempHpAfter: 0,
    });
  });

  it('does not drop current HP below zero', () => {
    expect(
      applyEncounterHpDamage({
        damage: 40,
        hitPointsCurrent: 7,
        tempHp: 0,
      }),
    ).toMatchObject({
      hitPointsAfter: 0,
      absorbedByTempHp: 0,
    });
  });

  it('treats negative damage as zero', () => {
    expect(
      applyEncounterHpDamage({
        damage: -4,
        hitPointsCurrent: 10,
        tempHp: 2,
      }),
    ).toMatchObject({
      damageTotal: 0,
      hitPointsAfter: 10,
      tempHpAfter: 2,
    });
  });
});
