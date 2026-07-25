import { Injectable } from '@nestjs/common';
import { CharacterInventoryRepository } from '../infrastructure/character-inventory.repository';

type StartingEquipmentRow = {
  itemSlug?: string;
  quantity?: number;
};

/** Materializa pacotes de criação como itens no inventário (Beyond-like). */
@Injectable()
export class SeedStartingInventoryHandler {
  constructor(private readonly inventory: CharacterInventoryRepository) {}

  async execute(
    characterId: string,
    equipment: StartingEquipmentRow[] | undefined,
  ): Promise<void> {
    if (!equipment?.length) return;
    await this.inventory.ensureFromStartingEquipment(characterId, equipment);
  }
}
