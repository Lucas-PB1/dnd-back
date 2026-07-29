/**
 * Regras de combate do Pistoleiro (Valda) para armas de fogo e Tiro Crítico.
 * Fonte: features de classe; o motor só aplica números.
 */

/** Limiar mínimo no d20 para crítico à distância (Pistoleiro). */
export function gunslingerCritThreshold(level: number): number {
  if (level >= 17) return 17;
  if (level >= 9) return 18;
  if (level >= 2) return 19;
  return 20;
}

export function isGunslingerClass(classSlug: string | null | undefined): boolean {
  return classSlug === 'gunslinger';

}

/**
 * Dano base de arma de fogo: não soma o modificador de atributo
 * (exceto se negativo — o RAW omite só o bônus positivo implícito;
 * Valda: "não adiciona seu modificador", então zeroamos positivos e
 * negativos para bater o texto; negativos ficam 0 também).
 *
 * Exagero (nv.11+) reintroduz o modificador via `applyOverkillDamageBonus`.
 */
export function firearmAbilityDamageBonus(abilityMod: number): number {
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

/** Limiar de crítico efetivo para um ataque à distância do Pistoleiro. */
export function resolveAttackCritThreshold(input: {
  classSlug?: string | null;
  level?: number;
  mode: 'melee' | 'ranged';
}): number {
  if (
    input.mode !== 'ranged' ||
    !isGunslingerClass(input.classSlug) ||
    input.level == null
  ) {
    return 20;
  }
  return gunslingerCritThreshold(input.level);
}
