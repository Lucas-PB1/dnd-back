import { BadRequestException } from '@nestjs/common';

/** Itens manifestados por classe/subclasse — visíveis na mesa, não na loja/mochila. */
export function isClassGrantedCatalogItem(
  properties: Record<string, unknown> | null | undefined,
): boolean {
  if (!properties) return false;
  return (
    typeof properties.grantedBySubclass === 'string' ||
    typeof properties.grantedByClass === 'string'
  );
}

/** Filtro SQL para listagens de catálogo (loja, pickers). */
export const EXCLUDE_CLASS_GRANTED_ITEMS_SQL = `(item.properties->>'grantedBySubclass' IS NULL AND item.properties->>'grantedByClass' IS NULL)`;

export const EXCLUDE_CLASS_GRANTED_ITEMS_JOIN_SQL = `(i.properties->>'grantedBySubclass' IS NULL AND i.properties->>'grantedByClass' IS NULL)`;

export function assertNotClassGrantedCatalogItem(
  itemSlug: string,
  properties: Record<string, unknown> | null | undefined,
): void {
  if (!isClassGrantedCatalogItem(properties)) return;
  throw new BadRequestException(
    `Item '${itemSlug}' is granted by class features and cannot be purchased or stored in inventory`,
  );
}
