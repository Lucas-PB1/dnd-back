import { DataSource } from 'typeorm';
import { CatalogLookupService } from '@catalog/catalog-lookup.service';
import { clearAbilityPenaltiesFromInstance } from '@game/inventory/domain/artifact/artifact-instance-ops';
import {
  itemIsCursed,
  withCurseBroken,
} from '@game/inventory/domain/cursed-item';
import { PlayerCharacterItem } from '@game/inventory/infrastructure/player-character-item.entity';

export async function clearInventoryAbilityPenalties(
  dataSource: DataSource,
  characterId: string,
): Promise<void> {
  const items = dataSource.getRepository(PlayerCharacterItem);
  const rows = await items.find({ where: { characterId } });
  for (const row of rows) {
    const props = row.instanceProperties;
    if (
      !props ||
      typeof props !== 'object' ||
      !('abilityPenalties' in props) ||
      props.abilityPenalties == null
    ) {
      continue;
    }
    row.instanceProperties = clearAbilityPenaltiesFromInstance(props);
    await items.save(row);
  }
}

/** Remover Maldição: quebra sintonia de itens cursed e marca curseBroken. */
export async function breakCursedItemAttunements(
  dataSource: DataSource,
  catalogLookup: CatalogLookupService,
  characterId: string,
): Promise<void> {
  const items = dataSource.getRepository(PlayerCharacterItem);
  const rows = await items.find({ where: { characterId, attuned: true } });
  for (const row of rows) {
    const catalog = await catalogLookup.assertItemInCatalog(row.itemSlug);
    const props =
      catalog.properties != null &&
      typeof catalog.properties === 'object' &&
      !Array.isArray(catalog.properties)
        ? (catalog.properties as Record<string, unknown>)
        : null;
    if (!itemIsCursed(props)) continue;
    row.instanceProperties = withCurseBroken(row.instanceProperties);
    row.attuned = false;
    await items.save(row);
  }
}

export async function applyPostCastInventoryEffects(
  spellSlug: string,
  dataSource: DataSource,
  catalogLookup: CatalogLookupService,
  characterId: string,
): Promise<void> {
  if (spellSlug === 'restauracao-maior') {
    await clearInventoryAbilityPenalties(dataSource, characterId);
  }
  if (spellSlug === 'remover-maldicao') {
    await breakCursedItemAttunements(dataSource, catalogLookup, characterId);
  }
}
