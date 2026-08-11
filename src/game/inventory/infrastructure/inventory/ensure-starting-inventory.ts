import { CatalogLookupService } from '@catalog/catalog-lookup.service';
import { Repository } from 'typeorm';
import { PlayerCharacterItem } from '../player-character-item.entity';

/** Seed mochila a partir do equipamento inicial; não sobrescreve itens existentes. */
export async function ensureFromStartingEquipment(
  items: Repository<PlayerCharacterItem>,
  catalogLookup: CatalogLookupService,
  characterId: string,
  equipment: Array<{ itemSlug?: string; quantity?: number }>,
): Promise<void> {
  const totals = new Map<string, number>();
  for (const row of equipment) {
    const slug = row.itemSlug?.trim();
    if (!slug) continue;
    const qty = Math.max(1, row.quantity ?? 1);
    totals.set(slug, (totals.get(slug) ?? 0) + qty);
  }

  for (const [itemSlug, quantity] of totals) {
    const existing = await items.findOne({
      where: { characterId, itemSlug },
    });
    if (existing) continue;

    await catalogLookup.assertItemInCatalog(itemSlug);
    await items.save(
      items.create({
        characterId,
        itemSlug,
        quantity,
        location: 'backpack',
        equipmentSlot: null,
        attuned: false,
        isPactWeapon: false,
        attachedCharmSlug: null,
      }),
    );
  }
}
