/**
 * Seeds de actor leve (Arma Espiritual etc.) usam `NdX+0` como marcador:
 * o flat `+0` é trocado pelo modificador de conjuração no sync.
 * Expressões sem `+0` (ex.: `3d10`) permanecem intactas.
 */
export function injectCasterDamageMod(
  damageExpression: string,
  castingAbilityMod: number | null | undefined,
): string {
  const trimmed = damageExpression.trim();
  const match = /^(\d+)d(\d+)\+0$/i.exec(trimmed);
  if (!match) return damageExpression;
  const dice = match[1];
  const die = match[2];
  const mod = castingAbilityMod ?? 0;
  return `${dice}d${die}+${mod}`;
}
