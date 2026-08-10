const CHARGE_UPCAST_RESOURCE_SLUGS = new Set([
  'varinhaRelampagosCharges',
  'varinhaCuspidoraFogoCharges',
]);

/**
 * Nível de conjuração ao gastar cargas de item.
 * - Default: max(nível da magia, spend) — custo em cargas ≠ círculo (ex. Muralha de Gelo 4 cargas → 6º).
 * - Varinhas Relâmpagos/Cuspidora: 1 carga = círculo base; cargas extras sobem o círculo.
 */
export function resolveItemCastSlotLevel(input: {
  spellLevel: number;
  spendAmount: number;
  resourceSlug?: string | null;
}): number | null {
  const { spellLevel, spendAmount, resourceSlug } = input;
  if (spellLevel <= 0) return null;
  if (resourceSlug && CHARGE_UPCAST_RESOURCE_SLUGS.has(resourceSlug)) {
    return spellLevel + spendAmount - 1;
  }
  return Math.max(spellLevel, spendAmount);
}
