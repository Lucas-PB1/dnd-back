import { BadRequestException } from '@nestjs/common';
import type { DataSource, Repository } from 'typeorm';
import type { PlayerCharacterItem } from '../player-character-item.entity';
import { findInventoryItemOrFail } from '../inventory/inventory-item-ops';
import { removeInventoryItemWithCredit } from '../inventory/inventory-coin-tx';
import { removeInventoryQuantityWithCredit } from '../inventory/inventory-purchase-tx';
import type { RemoveInventoryOptions } from './types';

type RemoveItemPorts = {
  items: Repository<PlayerCharacterItem>;
  dataSource: DataSource;
};

export async function removeInventoryItem(
  ports: RemoveItemPorts,
  characterId: string,
  itemSlug: string,
  options: RemoveInventoryOptions = {},
): Promise<void> {
  const row = await findInventoryItemOrFail(
    ports.items,
    characterId,
    itemSlug,
  );
  const quantity = options.quantity ?? row.quantity;
  if (quantity < 1 || quantity > row.quantity) {
    throw new BadRequestException(
      `Cannot remove ${quantity}; stack has ${row.quantity}`,
    );
  }
  const isPartial = quantity < row.quantity;
  if (!options.credit && !isPartial) {
    await ports.items.remove(row);
    return;
  }
  if (!options.credit && isPartial) {
    row.quantity -= quantity;
    await ports.items.save(row);
    return;
  }
  if (isPartial || options.credit) {
    await removeInventoryQuantityWithCredit({
      dataSource: ports.dataSource,
      characterId,
      itemSlug,
      quantity,
      credit: options.credit ?? null,
    });
    return;
  }
  await removeInventoryItemWithCredit({
    dataSource: ports.dataSource,
    characterId,
    itemSlug,
    credit: options.credit!,
  });
}
