import { BadRequestException } from '@nestjs/common';
import type { Repository } from 'typeorm';
import type { PlayerCharacterItem } from '@game/inventory/infrastructure/player-character-item.entity';

export async function consumeInventoryQuantity(
  items: Repository<PlayerCharacterItem>,
  characterId: string,
  itemSlug: string,
  amount = 1,
): Promise<void> {
  const row = await items.findOne({ where: { characterId, itemSlug } });
  if (!row || row.quantity < amount) {
    throw new BadRequestException(`Personagem não possui o item '${itemSlug}'`);
  }
  row.quantity -= amount;
  if (row.quantity <= 0) {
    await items.remove(row);
    return;
  }
  await items.save(row);
}
