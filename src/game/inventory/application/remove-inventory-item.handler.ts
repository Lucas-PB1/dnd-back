import { BadRequestException, Injectable } from '@nestjs/common';
import { CatalogLookupService } from '@catalog/catalog-lookup.service';
import { CampaignCharacterAccessService } from '@game/campaign/infrastructure/campaign-character-access.service';
import { PlayerCharacterAccessService } from '@game/shared/player-character-access.service';
import { CharacterInventoryRepository } from '../infrastructure/character-inventory.repository';
import {
  catalogCostText,
  coinPurseErrorMessage,
  halfCoinPurseValue,
  parseCostText,
  scaleCoinPurse,
} from '../domain/coin-purse';

export type RemoveInventoryMode = 'sell' | 'discard';

@Injectable()
export class RemoveInventoryItemHandler {
  constructor(
    private readonly access: PlayerCharacterAccessService,
    private readonly campaignAccess: CampaignCharacterAccessService,
    private readonly catalogLookup: CatalogLookupService,
    private readonly inventory: CharacterInventoryRepository,
  ) {}

  async execute(
    userId: string,
    characterId: string,
    itemSlug: string,
    options: { quantity?: number; mode?: RemoveInventoryMode } = {},
  ): Promise<void> {
    await this.access.findAccessibleOrFail(userId, characterId, 'write');
    const paymentCtx =
      await this.campaignAccess.resolveInventoryPaymentContext(
        userId,
        characterId,
      );

    const chargeApplies =
      paymentCtx.inCampaign && !paymentCtx.viewerIsDmOrAssistant;
    const mode = options.mode ?? (chargeApplies ? 'sell' : 'discard');
    const stackQty =
      (await this.inventory.peekItemQuantity(characterId, itemSlug)) ?? 1;
    const quantity = options.quantity ?? stackQty;

    let credit = null;
    if (chargeApplies && mode === 'sell') {
      try {
        const catalog = await this.catalogLookup.assertItemInCatalog(itemSlug);
        credit = halfCoinPurseValue(
          scaleCoinPurse(
            parseCostText(catalogCostText(catalog.cost)),
            quantity,
          ),
        );
      } catch (error) {
        if (
          error instanceof Error &&
          (/no catalog price/i.test(error.message) ||
            /Cannot parse/i.test(error.message))
        ) {
          credit = null;
        } else {
          throw new BadRequestException(coinPurseErrorMessage(error));
        }
      }
    }

    try {
      await this.inventory.remove(characterId, itemSlug, { credit, quantity });
    } catch (error) {
      if (error instanceof BadRequestException) throw error;
      throw new BadRequestException(coinPurseErrorMessage(error));
    }
  }
}
