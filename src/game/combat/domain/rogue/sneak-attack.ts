import { psiEnergyDiceSchedule } from '../fighter/features';

export function isRogueClass(classSlug: string | null | undefined): boolean {
  return classSlug === 'rogue';
}

/** Dados de Ataque Furtivo: 1d6 no nível 1 e +1d6 a cada nível ímpar. */
export function sneakAttackDiceCount(level: number): number {
  return Math.max(0, Math.ceil(level / 2));
}

/** O Perseguidor Aracnídeo pode trocar os d6 por d8 de dano Venenoso. */
export function sneakAttackDieFaces(
  subclassSlug?: string | null,
  usePoisonousStrike = false,
): 6 | 8 {
  return subclassSlug === 'arachnoid-stalker' && usePoisonousStrike ? 8 : 6;
}

export function sneakAttackDiceExpression(input: {
  level: number;
  subclassSlug?: string | null;
  usePoisonousStrike?: boolean;
}): string {
  return `${sneakAttackDiceCount(input.level)}d${sneakAttackDieFaces(
    input.subclassSlug,
    input.usePoisonousStrike,
  )}`;
}

export function hasSlipperyMind(level: number): boolean {
  return level >= 15;
}

/** Soulknife usa a mesma progressão de dados psiônicos do Psi Warrior. */
export function soulknifePsiDiceSchedule(level: number): {
  faces: number;
  count: number;
} | null {
  return psiEnergyDiceSchedule(level);
}
