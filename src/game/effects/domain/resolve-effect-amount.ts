import { proficiencyBonusForLevel } from '@game/session/domain/proficiency-bonus-for-level';
import type { EffectAmountFormula } from '@entities/effect/phb-effect-numeric.entity';
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
  /** Faces do dado vindo de schedule (psi / superioridade). */
  scheduleDieFaces?: number;
  /** Contagem vinda de schedule (portent / divine spark). */
  scheduleCount?: number;
  /** Bônus de dano da Fúria (schedule). */
  rageBonus?: number;
  rageActive?: boolean;
  /** Astúcia Mágica: quantidade de slots de Pacto a recuperar. */
  pactSlotsRecoveryCount?: number;
}): ResolvedAmount {
  const pb = proficiencyBonusForLevel(input.level);
  const rng = input.rng ?? Math.random;
  const rageBonus = Math.max(1, input.rageBonus ?? 2);

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
      return { amount: 2 * input.level + (input.flat ?? 0) };
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
    case 'dice_1d10_plus_level': {
      const level = Math.max(1, input.level);
      const rolled = rollDamageParts('1d10', level, { rng });
      return {
        amount: rolled.total,
        expression: rolled.expression,
        faces: 10,
      };
    }
    case 'schedule_die_plus_flat': {
      const faces = Math.max(2, input.scheduleDieFaces ?? 6);
      const bonus = input.flat ?? 0;
      const rolled = rollDamageParts(`1d${faces}`, bonus, { rng });
      return {
        amount: rolled.total,
        expression: rolled.expression,
        faces,
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
    case 'ability_mod':
      return { amount: input.flat ?? 0 };
    case 'eight_plus_mod_plus_pb':
      return { amount: 8 + (input.flat ?? 0) + pb };
    case 'rage_bonus':
      return { amount: rageBonus };
    case 'rage_bonus_d6': {
      const rolled = rollDamageParts(`${rageBonus}d6`, 0, { rng });
      return {
        amount: rolled.total,
        expression: rolled.expression,
        faces: 6,
      };
    }
    case 'half_level_if_rage':
      return {
        amount: input.rageActive
          ? Math.max(0, Math.floor(input.level / 2))
          : 0,
      };
    case 'level_times_5':
      return { amount: 5 * input.level };
    case 'dice_divine_spark_plus_flat': {
      const count = Math.max(1, input.scheduleCount ?? 1);
      const die = `${count}d8`;
      const rolled = rollDamageParts(die, input.flat ?? 0, { rng });
      return {
        amount: rolled.total,
        expression: rolled.expression,
        faces: 8,
      };
    }
    case 'ability_mod_d8': {
      const count = Math.max(1, input.flat ?? 1);
      const rolled = rollDamageParts(`${count}d8`, 0, { rng });
      return {
        amount: rolled.total,
        expression: rolled.expression,
        faces: 8,
      };
    }
    case 'dice_2d6_plus_flat': {
      const rolled = rollDamageParts('2d6', input.flat ?? 0, { rng });
      return {
        amount: rolled.total,
        expression: rolled.expression,
        faces: 6,
      };
    }
    case 'dice_2d10_plus_level': {
      const rolled = rollDamageParts('2d10', input.level, { rng });
      return {
        amount: rolled.total,
        expression: rolled.expression,
        faces: 10,
      };
    }
    case 'dice_2d8_plus_level': {
      const rolled = rollDamageParts('2d8', input.level, { rng });
      return {
        amount: rolled.total,
        expression: rolled.expression,
        faces: 8,
      };
    }
    case 'schedule_die_double_plus_flat': {
      const faces = Math.max(2, input.scheduleDieFaces ?? 6);
      const bonus = input.flat ?? 0;
      const rolled = rollDamageParts(`2d${faces}`, bonus, { rng });
      return {
        amount: rolled.total,
        expression: rolled.expression,
        faces,
      };
    }
    case 'dice_2d_schedule': {
      const faces = Math.max(2, input.scheduleDieFaces ?? 6);
      const rolled = rollDamageParts(`2d${faces}`, 0, { rng });
      return {
        amount: rolled.total,
        expression: rolled.expression,
        faces,
      };
    }
    case 'dice_3d_schedule': {
      const faces = Math.max(2, input.scheduleDieFaces ?? 6);
      const rolled = rollDamageParts(`3d${faces}`, 0, { rng });
      return {
        amount: rolled.total,
        expression: rolled.expression,
        faces,
      };
    }
    case 'pact_slots_recovery_count':
      return {
        amount: Math.max(1, input.pactSlotsRecoveryCount ?? 1),
      };
    case 'portent_d20_count': {
      const count = Math.max(1, input.scheduleCount ?? 2);
      const rolls = Array.from(
        { length: count },
        () => 1 + Math.floor(rng() * 20),
      );
      return {
        amount: rolls[0] ?? 1,
        expression: rolls.join(', '),
        faces: 20,
      };
    }
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
