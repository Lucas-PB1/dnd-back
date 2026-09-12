import { ARTISAN_CRAFT_INSTANCE_KEY, readArtisanCraftedQty } from '../domain/artisan-craft';

type InventoryRow = {
  itemSlug: string;
  quantity: number;
  instanceProperties: Record<string, unknown> | null;
};

export function dissolveArtisanCraftedItems(
  rows: readonly InventoryRow[],
): { keep: InventoryRow[]; removedNotes: string[] } {
  const keep: InventoryRow[] = [];
  const removedNotes: string[] = [];
  for (const row of rows) {
    const crafted = readArtisanCraftedQty(row.instanceProperties);
    if (crafted <= 0) {
      keep.push(row);
      continue;
    }
    const removeQty = Math.min(crafted, row.quantity);
    removedNotes.push(
      `Fabricação Rápida: ${row.itemSlug} ×${removeQty} se desfez no Descanso Longo.`,
    );
    const remaining = row.quantity - removeQty;
    if (remaining <= 0) continue;
    const props = { ...(row.instanceProperties ?? {}) };
    delete props[ARTISAN_CRAFT_INSTANCE_KEY];
    keep.push({
      ...row,
      quantity: remaining,
      instanceProperties: Object.keys(props).length > 0 ? props : null,
    });
  }
  return { keep, removedNotes };
}
