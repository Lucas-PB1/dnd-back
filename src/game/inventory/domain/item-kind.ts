/** Helpers de classificação de item via properties (SSOT leve para shop/purchase). */

export function itemPropertiesKind(
  properties: Record<string, unknown> | null | undefined,
): string | null {
  const kind = properties?.kind;
  return typeof kind === 'string' ? kind : null;
}

export function isServiceItem(
  properties: Record<string, unknown> | null | undefined,
): boolean {
  return itemPropertiesKind(properties) === 'service';
}

export function isTransportItemKind(kind: string | null): boolean {
  return (
    kind === 'mount' ||
    kind === 'drawn-vehicle' ||
    kind === 'large-vehicle' ||
    kind === 'saddle' ||
    kind === 'mount-feed' ||
    kind === 'barding'
  );
}

/** Itens que podem virar game_actor vehicle/mount via Vincular. */
export function isBoardableTransportItemKind(kind: string | null): boolean {
  return (
    kind === 'mount' || kind === 'drawn-vehicle' || kind === 'large-vehicle'
  );
}

export function isContainerItem(
  properties: Record<string, unknown> | null | undefined,
  itemSlug: string,
): boolean {
  if (properties?.kind === 'container') return true;
  return /^(mochila|saca|cesta|algibeira|bolsa|estojo|aljava)/i.test(itemSlug);
}
