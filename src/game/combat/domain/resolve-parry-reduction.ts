import type { IncomingHitDefenseKind } from './resolve-incoming-hit';

export type ResolveParryReductionInput = {
  dieFaces: number;
  dieRoll: number;
  strengthMod: number;
  dexterityMod: number;
};

/** Redução de Parry: Dado de Superioridade + max(FOR, DES). */
export function resolveParryReduction(
  input: ResolveParryReductionInput,
): { reduction: number; expression: string } {
  const ability = Math.max(input.strengthMod, input.dexterityMod);
  const reduction = Math.max(0, input.dieRoll + ability);
  const sign = ability >= 0 ? '+' : '';
  return {
    reduction,
    expression: `1d${input.dieFaces}${sign}${ability}`,
  };
}

export function isParryDefense(
  defense: IncomingHitDefenseKind | null | undefined,
): boolean {
  return defense === 'parry';
}
