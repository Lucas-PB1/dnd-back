import { parseHitDieLabel } from '@game/sheet/domain/stats/hit-points.calc';
import { rollDie, type Rng } from '@game/dice/domain/dice';

export type HitDiceSpendResult = {
  hitDiceSpent: number;
  hitDiceRemaining: number;
  rolls: number[];
  rawHealed: number;
  hitPointsHealed: number;
  hitPointsCurrent: number;
};

/** PHB: por dado, max(0, 1dX + CON). */
export function rollHitDieHealing(
  hitDieSides: number,
  constitutionModifier: number,
  rng: Rng = Math.random,
): { roll: number; healed: number } {
  const roll = rollDie(hitDieSides, rng);
  return { roll, healed: Math.max(0, roll + constitutionModifier) };
}

export function spendHitDice(input: {
  hitDiceCurrent: number;
  hitDiceMax: number;
  hitDiceSpent: number;
  hitDieLabel: string;
  constitutionModifier: number;
  hitPointsCurrent: number;
  hitPointsMax: number;
  rng?: Rng;
}): HitDiceSpendResult {
  const spent = input.hitDiceSpent;
  if (!Number.isInteger(spent) || spent < 0) {
    throw new Error('hitDiceSpent must be a non-negative integer');
  }
  if (spent > input.hitDiceCurrent) {
    throw new Error(
      `Cannot spend ${spent} hit dice; only ${input.hitDiceCurrent} remaining`,
    );
  }

  const sides = parseHitDieLabel(input.hitDieLabel);
  const rng = input.rng ?? Math.random;
  const rolls: number[] = [];
  let rawHealed = 0;
  for (let i = 0; i < spent; i += 1) {
    const { roll, healed } = rollHitDieHealing(
      sides,
      input.constitutionModifier,
      rng,
    );
    rolls.push(roll);
    rawHealed += healed;
  }

  const room = Math.max(0, input.hitPointsMax - input.hitPointsCurrent);
  const hitPointsHealed = Math.min(rawHealed, room);

  return {
    hitDiceSpent: spent,
    hitDiceRemaining: input.hitDiceCurrent - spent,
    rolls,
    rawHealed,
    hitPointsHealed,
    hitPointsCurrent: input.hitPointsCurrent + hitPointsHealed,
  };
}

/** PHB: recupera metade do total de dados (mín. 1), sem passar do máximo. */
export function restoreHitDiceOnLongRest(
  hitDiceCurrent: number,
  hitDiceMax: number,
): number {
  if (hitDiceMax <= 0) return 0;
  const regain = Math.max(1, Math.floor(hitDiceMax / 2));
  return Math.min(hitDiceMax, hitDiceCurrent + regain);
}

export function grantHitDiceOnLevelUp(
  hitDiceCurrent: number,
  previousLevel: number,
  newLevel: number,
): number {
  if (newLevel <= previousLevel) {
    return Math.min(hitDiceCurrent, newLevel);
  }
  const gained = newLevel - previousLevel;
  return Math.min(newLevel, hitDiceCurrent + gained);
}
