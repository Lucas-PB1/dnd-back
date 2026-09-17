export type EncounterHpDamageSplit = {
  damageTotal: number;
  absorbedByTempHp: number;
  hitPointsBefore: number;
  hitPointsAfter: number;
  tempHpBefore: number;
  tempHpAfter: number;
};

export function applyEncounterHpDamage(input: {
  damage: number;
  hitPointsCurrent: number;
  tempHp: number;
}): EncounterHpDamageSplit {
  const damageTotal = Math.max(0, input.damage);
  const tempHpBefore = Math.max(0, input.tempHp);
  const hitPointsBefore = input.hitPointsCurrent;
  const absorbedByTempHp = Math.min(tempHpBefore, damageTotal);
  const remaining = damageTotal - absorbedByTempHp;
  return {
    damageTotal,
    absorbedByTempHp,
    hitPointsBefore,
    hitPointsAfter: Math.max(0, hitPointsBefore - remaining),
    tempHpBefore,
    tempHpAfter: tempHpBefore - absorbedByTempHp,
  };
}
