import { BadRequestException, Injectable } from '@nestjs/common';
import { CatalogLookupService } from '@catalog/catalog-lookup.service';
import { CampaignCharacterAccessService } from '@game/campaign/infrastructure/campaign-character-access.service';
import { PlayerCharacterAccessService } from '@game/shared/player-character-access.service';
import { CharacterInventoryRepository } from '../infrastructure/character-inventory.repository';
import {
  AddInventoryItemDto,
  InventoryItemResponseDto,
} from '../dto/inventory.dto';
import {
  assertCanDebitCoins,
  catalogCostText,
  coinPurseErrorMessage,
  coinPurseFromColumns,
  parseCostText,
  resolveInventoryPayment,
  scaleCoinPurse,
} from '../domain/coin-purse';

@Injectable()
export class AddInventoryItemHandler {
  constructor(
    private readonly access: PlayerCharacterAccessService,
    private readonly campaignAccess: CampaignCharacterAccessService,
    private readonly catalogLookup: CatalogLookupService,
    private readonly inventory: CharacterInventoryRepository,
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
    const paymentCtx =
      await this.campaignAccess.resolveInventoryPaymentContext(
        userId,
        characterId,
      );
    const pay = dto.pay !== false;
    const decision = resolveInventoryPayment({
      ...paymentCtx,
      pay,
    });

    let debit = null;
    if (decision.mustPay) {
      const catalog = await this.catalogLookup.assertItemInCatalog(
        dto.itemSlug,
      );
      const quantity = dto.quantity ?? 1;
      try {
        debit = scaleCoinPurse(
          parseCostText(catalogCostText(catalog.cost)),
          quantity,
        );
        assertCanDebitCoins(coinPurseFromColumns(character), debit);
      } catch (error) {
        throw new BadRequestException(coinPurseErrorMessage(error));
      }
    }

    return this.inventory.add(
      characterId,
      dto,
      character.abilityScores?.forca ?? 10,
      { debit },
    );
  }
}
