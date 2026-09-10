import { proficiencyBonusForLevel } from '@game/session/domain/proficiency-bonus-for-level';
import type { EffectAmountFormula } from '@entities/phb-effect-numeric.entity';
import { rollDamageParts, type Rng } from '@game/dice/domain/dice';

export type ResolvedAmount = {
  amount: number;
  expression?: string;
  faces?: number;
};

export function resolveEffectAmount(input: {
  amountFormula: EffectAmountFormula;
  flat: number | null;
  level: number;
  rng?: Rng;
    hitDieFaces?: number;
}): ResolvedAmount {
  const pb = proficiencyBonusForLevel(input.level);
  const rng = input.rng ?? Math.random;

  switch (input.amountFormula) {
    case 'fixed':
      return { amount: input.flat ?? 0 };
    case 'proficiency_bonus':
      return { amount: pb };
    case 'proficiency_bonus_times_2':
      return { amount: 2 * pb };
    case 'level':
      return { amount: input.level };
    case 'level_times_2':
      return { amount: 2 * input.level };
    case 'level_div_2':
      return { amount: Math.max(1, Math.floor(input.level / 2)) };
    case 'dice_pb_d4': {
      const rolled = rollDamageParts(`${pb}d4`, 0, { rng });
      return {
        amount: rolled.total,
        expression: rolled.expression,
        faces: 4,
      };
    }
    case 'dice_pb_d6': {
      const rolled = rollDamageParts(`${pb}d6`, 0, { rng });
      return {
        amount: rolled.total,
        expression: rolled.expression,
        faces: 6,
      };
    }
    case 'dice_hit_die_plus_pb': {
      const faces = input.hitDieFaces ?? 8;
      const rolled = rollDamageParts(`1d${faces}`, pb, { rng });
      return {
        amount: rolled.total,
        expression: rolled.expression,
        faces,
      };
    }
    case 'dice_1d4': {
      const rolled = rollDamageParts('1d4', 0, { rng });
      return {
        amount: rolled.total,
        expression: rolled.expression,
        faces: 4,
      };
    }
    case 'dice_2d4_plus_flat': {
      const bonus = input.flat ?? 0;
      const rolled = rollDamageParts('2d4', bonus, { rng });
      return {
        amount: rolled.total,
        expression: rolled.expression,
        faces: 4,
      };
    }
    case 'proficiency_bonus_plus_cha':
      return { amount: pb + (input.flat ?? 0) };
    case 'attack_ability_mod':
      // flat carrega o mod do atributo do ataque quando o caller resolve.
      return { amount: input.flat ?? 0 };
    case 'eight_plus_mod_plus_pb':
      return { amount: 8 + (input.flat ?? 0) + pb };
    default: {
      const _exhaustive: never = input.amountFormula;
      return _exhaustive;
    }
  }
}

export function resolveCastMaxUses(input: {
  economy: string;
  usesFormula: string;
  fixedUses: number | null;
  proficiencyBonus: number;
}): number {
  if (input.economy !== 'once_per_long_rest') return 0;
  if (input.usesFormula === 'proficiency_bonus') {
    return Math.max(1, input.proficiencyBonus);
  }
  return Math.max(1, input.fixedUses ?? 1);
}
