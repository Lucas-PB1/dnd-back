import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { PlayerCharacterAccessService } from '@game/shared/player-character-access.service';
import { CampaignCharacterAccessService } from '@game/campaign/infrastructure/campaign-character-access.service';
import { PlayerCharacterEquipment } from '@game/sheet/infrastructure/player-sheet.entities';
import { CharacterInventoryRepository } from '../infrastructure/character-inventory.repository';
import { CharacterInventoryResponseDto } from '../dto/inventory.dto';
import { SeedStartingInventoryHandler } from './seed-starting-inventory.handler';
import { coinPurseFromColumns } from '../domain/coin-purse';

@Injectable()
export class GetCharacterInventoryQuery {
  constructor(
    private readonly access: PlayerCharacterAccessService,
    private readonly campaignAccess: CampaignCharacterAccessService,
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
    if (result.items.length === 0) {
      const rows = await this.equipment.find({ where: { characterId } });
      if (rows.length > 0) {
        await this.seedStartingInventory.execute(
          characterId,
          rows.map((row) => ({
            itemSlug: row.itemSlug ?? undefined,
            quantity: row.quantity,
          })),
        );
        result = await this.inventory.list(characterId, strength);
      }
    }

    const paymentCtx =
      await this.campaignAccess.resolveInventoryPaymentContext(
        userId,
        characterId,
      );

    return {
      ...result,
      wealth: coinPurseFromColumns(character),
      paymentContext: {
        ...paymentCtx,
        chargeApplies:
          paymentCtx.inCampaign && !paymentCtx.viewerIsDmOrAssistant,
      },
    };
  }
}
