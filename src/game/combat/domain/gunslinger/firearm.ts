/**
 * Regras de combate do Pistoleiro (Valdas) para armas de fogo e Tiro Crítico.
 * Crit: SSOT `phb_class_feature_schedule.gunslinger_crit_threshold`.
 */

import { resolveFighterAttackCritThreshold } from '../fighter/features';
import {
  FEATURE_SCHEDULE_KEYS,
  scheduleIntAtLevel,
  type FeatureScheduleBand,
} from '../feature-schedule';

export function gunslingerCritThreshold(
  level: number,
  bands: readonly FeatureScheduleBand[],
): number {
  return scheduleIntAtLevel(
    bands,
    FEATURE_SCHEDULE_KEYS.gunslingerCritThreshold,
    level,
    20,
  );
}

export function isGunslingerClass(classSlug: string | null | undefined): boolean {
  return classSlug === 'gunslinger';
}

/**
 * Dano base de arma de fogo: não soma o modificador de atributo
 * (exceto se negativo — o RAW omite só o bônus positivo implícito;
 * Valdas: "não adiciona seu modificador", então zeroamos positivos e
 * negativos para bater o texto; negativos ficam 0 também).
 *
 * Exagero (nv.11+) reintroduz o modificador via `applyOverkillDamageBonus`.
 */
export function firearmAbilityDamageBonus(_abilityMod: number): number {
  return 0;
}

/**
 * Exagero (nível 11+): em arma de fogo à distância, reintroduz o
 * modificador. Em arma à distância que já somava o mod, +1d8 extra.
 */
export function applyOverkillDamageBonus(input: {
  level: number;
  isFirearm: boolean;
  abilityMod: number;
}): { abilityDamageBonus: number; extraDamageDice: string | null } {
  if (input.level < 11) {
    return {
      abilityDamageBonus: input.isFirearm
        ? firearmAbilityDamageBonus(input.abilityMod)
        : input.abilityMod,
      extraDamageDice: null,
    };
  }
  if (input.isFirearm) {
    return {
      abilityDamageBonus: input.abilityMod,
      extraDamageDice: null,
    };
  }
  return {
    abilityDamageBonus: input.abilityMod,
    extraDamageDice: '1d8',
  };
}

/**
 * Limiar de crítico efetivo: Pistoleiro (à distância) ou Campeão (qualquer).
 * O menor limiar (melhor crítico) vence se ambos se aplicarem.
 */
export function resolveAttackCritThreshold(input: {
  classSlug?: string | null;
  subclassSlug?: string | null;
  level?: number;
  mode: 'melee' | 'ranged';
  featureSchedules: readonly FeatureScheduleBand[];
}): number {
  let threshold = 20;

  if (
    input.mode === 'ranged' &&
    isGunslingerClass(input.classSlug) &&
    input.level != null
  ) {
    threshold = Math.min(
      threshold,
      gunslingerCritThreshold(input.level, input.featureSchedules),
    );
  }

  threshold = Math.min(
    threshold,
    resolveFighterAttackCritThreshold({
      classSlug: input.classSlug,
      subclassSlug: input.subclassSlug,
      level: input.level,
      featureSchedules: input.featureSchedules,
    }),
  );

  return threshold;
}
