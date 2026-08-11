import { BadRequestException, Injectable } from '@nestjs/common';
import { RecordItemCatalogStatsService } from '@catalog/items/application/record-item-catalog-stats.service';
import { CatalogLookupService } from '@catalog/catalog-lookup.service';
import { CampaignCharacterAccessService } from '@game/campaign/infrastructure/campaign-character-access.service';
import { PlayerCharacterAccessService } from '@game/shared/player-character-access.service';
import { CharacterInventoryRepository } from '../infrastructure/character-inventory.repository';
import {
  AddInventoryItemDto,
  InventoryItemResponseDto,
} from '../dto/inventory.dto';
import {
  catalogCostText,
  coinPurseErrorMessage,
  coinPurseFromColumns,
  debitCoinsWithExchange,
  parseCostText,
  resolveInventoryPayment,
  scaleCoinPurse,
} from '../domain/coin-purse';
import { isServiceItem } from '../domain/item-kind';

@Injectable()
export class AddInventoryItemHandler {
  constructor(
    private readonly access: PlayerCharacterAccessService,
    private readonly campaignAccess: CampaignCharacterAccessService,
    private readonly catalogLookup: CatalogLookupService,
    private readonly inventory: CharacterInventoryRepository,
    private readonly catalogStats: RecordItemCatalogStatsService,
  ) {}

  async execute(
    userId: string,
    characterId: string,
    dto: AddInventoryItemDto,
  ): Promise<InventoryItemResponseDto> {
    const character = await this.access.findAccessibleOrFail(
      userId,
      characterId,
      'write',
    );
    const catalog = await this.catalogLookup.assertItemInCatalog(dto.itemSlug);
    if (isServiceItem(catalog.properties as Record<string, unknown> | null)) {
      throw new BadRequestException(
        'Serviços não entram na mochila — use POST …/inventory/purchase.',
      );
    }

    const paymentCtx =
      await this.campaignAccess.resolveInventoryPaymentContext(
        userId,
        characterId,
      );
    const decision = resolveInventoryPayment({
      ...paymentCtx,
      pay: dto.pay !== false,
    });

    const quantity = dto.quantity ?? 1;
    let debit = null;
    if (decision.mustPay) {
      try {
        debit = scaleCoinPurse(
          parseCostText(catalogCostText(catalog.cost)),
          quantity,
        );
        debitCoinsWithExchange(coinPurseFromColumns(character), debit);
      } catch (error) {
        throw new BadRequestException(coinPurseErrorMessage(error));
      }
    }

    const result = await this.inventory.add(
      characterId,
      dto,
      character.abilityScores?.forca ?? 10,
      { debit },
    );
    if (debit) {
      await this.catalogStats.recordPurchase(dto.itemSlug, quantity);
    }
    return result;
  }
}
