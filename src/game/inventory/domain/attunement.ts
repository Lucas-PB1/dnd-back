/** Limite padrão 5e / PHB 2024: até 3 itens sintonizados. */
export const MAX_ATTUNED_ITEMS = 3;

export function itemRequiresAttunement(
  properties: Record<string, unknown> | null | undefined,
): boolean {
  return Boolean(properties?.requiresAttunement);
}
