export type SkirmishAttackLogRoll = {
  critical: boolean;
  hit: boolean;
  attackExpression: string;
  attackRolls: number[];
  attackTotal: number;
  targetAc?: number;
  damageTotal: number | null;
  damageExpression: string | null;
  damageRolls?: number[];
};

function facesSuffix(rolls: number[] | undefined): string {
  if (!rolls || rolls.length === 0) return '';
  return ` [${rolls.join(', ')}]`;
}

export function formatSkirmishAttackLogLine(
  attackerName: string,
  targetName: string,
  rolled: SkirmishAttackLogRoll,
): string {
  const outcome = rolled.critical
    ? 'crítico'
    : rolled.hit
      ? 'acerto'
      : 'erro';
  const attackFaces = facesSuffix(rolled.attackRolls);
  const vsAc =
    rolled.targetAc != null ? ` vs CA ${rolled.targetAc}` : '';
  const attackPart = `${rolled.attackExpression}${attackFaces} = ${rolled.attackTotal}${vsAc}`;
  let damage = '';
  if (rolled.damageTotal != null) {
    if (rolled.damageExpression) {
      damage = ` · dano ${rolled.damageExpression}${facesSuffix(rolled.damageRolls)} = ${rolled.damageTotal}`;
    } else {
      damage = ` · dano ${rolled.damageTotal}`;
    }
  }
  return `${attackerName} → ${targetName}: ${outcome} (${attackPart})${damage}`;
}
