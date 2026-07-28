import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { PlayerCharacterAccessService } from '../../shared/player-character-access.service';
import { PlayerCharacterEquipment } from '../../sheet/infrastructure/player-sheet.entities';
import { CharacterInventoryRepository } from '../infrastructure/character-inventory.repository';
import { CharacterInventoryResponseDto } from '../dto/inventory.dto';
import { SeedStartingInventoryHandler } from './seed-starting-inventory.handler';

@Injectable()
export class GetCharacterInventoryQuery {
  constructor(
    private readonly access: PlayerCharacterAccessService,
    private readonly inventory: CharacterInventoryRepository,
    private readonly seedStartingInventory: SeedStartingInventoryHandler,
    @InjectRepository(PlayerCharacterEquipment)
    private readonly equipment: Repository<PlayerCharacterEquipment>,
  ) {}

  async execute(
    userId: string,
    characterId: string,
  ): Promise<CharacterInventoryResponseDto> {
    const character = await this.access.findAccessibleOrFail(
      userId,
      characterId,
      'read',
    );
    const strength = character.abilityScores?.forca ?? 10;

    let result = await this.inventory.list(characterId, strength);
    if (result.items.length > 0) return result;

    const rows = await this.equipment.find({ where: { characterId } });
    if (rows.length === 0) return result;

    await this.seedStartingInventory.execute(
      characterId,
      rows.map((row) => ({
        itemSlug: row.itemSlug ?? undefined,
        quantity: row.quantity,
      })),
    );

    result = await this.inventory.list(characterId, strength);
    return result;
  }
}
