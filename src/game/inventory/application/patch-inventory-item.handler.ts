import { BadRequestException, Injectable } from '@nestjs/common';
import { CatalogLookupService } from '@catalog/catalog-lookup.service';
import { CampaignCharacterAccessService } from '@game/campaign/infrastructure/campaign-character-access.service';
import { PlayerCharacterAccessService } from '@game/shared/player-character-access.service';
import { CharacterInventoryRepository } from '../infrastructure/character-inventory.repository';
import {
  InventoryItemResponseDto,
  PatchInventoryItemDto,
} from '../dto/inventory.dto';
import { AssertCanBindPactWeaponService } from './assert-can-bind-pact-weapon.service';
import { AssertCanEquipItemService } from './assert-can-equip-item.service';
import {
  catalogCostText,
  coinPurseErrorMessage,
  coinPurseFromColumns,
  debitCoinsWithExchange,
  halfCoinPurseValue,
  parseCostText,
  resolveInventoryPayment,
  scaleCoinPurse,
} from '../domain/coin-purse';
import { RecordItemCatalogStatsService } from '@catalog/items/application/record-item-catalog-stats.service';

function isEquipping(dto: PatchInventoryItemDto): boolean {
  if (dto.location === 'equipped') return true;
  if (dto.location === 'backpack') return false;
  return dto.equipmentSlot !== undefined;
}

@Injectable()
export class PatchInventoryItemHandler {
  constructor(
    private readonly access: PlayerCharacterAccessService,
    private readonly campaignAccess: CampaignCharacterAccessService,
    private readonly catalogLookup: CatalogLookupService,
    private readonly inventory: CharacterInventoryRepository,
    private readonly assertCanEquip: AssertCanEquipItemService,
    private readonly assertCanBindPact: AssertCanBindPactWeaponService,
    private readonly catalogStats: RecordItemCatalogStatsService,
  ) {}

  async execute(
    userId: string,
    characterId: string,
    itemSlug: string,
    dto: PatchInventoryItemDto,
  ): Promise<InventoryItemResponseDto> {
    const character = await this.access.findAccessibleOrFail(
      userId,
      characterId,
      'write',
    );
    if (isEquipping(dto)) {
      await this.assertCanEquip.assert(character, itemSlug);
    }
    if (dto.pactWeapon === true) {
      await this.assertCanBindPact.assert(character, itemSlug);
    }

    if (dto.quantity !== undefined) {
      const current =
        (await this.inventory.peekItemQuantity(characterId, itemSlug)) ?? 0;
      if (dto.quantity !== current) {
        return this.patchQuantityWithEconomy(
          userId,
          characterId,
          itemSlug,
          current,
          dto.quantity,
          character.abilityScores?.forca ?? 10,
          {
            classSlug: character.classSlug,
            speciesSlug: character.speciesSlug ?? null,
          },
          dto,
        );
      }
    }

    return this.inventory.patch(
      characterId,
      itemSlug,
      dto,
      character.abilityScores?.forca ?? 10,
      {
        classSlug: character.classSlug,
        speciesSlug: character.speciesSlug ?? null,
      },
    );
  }

  private async patchQuantityWithEconomy(
    userId: string,
    characterId: string,
    itemSlug: string,
    currentQty: number,
    newQty: number,
    strengthScore: number,
    characterCtx: { classSlug: string; speciesSlug: string | null },
    dto: PatchInventoryItemDto,
  ): Promise<InventoryItemResponseDto> {
    const paymentCtx =
      await this.campaignAccess.resolveInventoryPaymentContext(
        userId,
        characterId,
      );
    const chargeApplies =
      paymentCtx.inCampaign && !paymentCtx.viewerIsDmOrAssistant;
    const delta = newQty - currentQty;
    const character = await this.access.findAccessibleOrFail(
      userId,
      characterId,
      'write',
    );

    let debit = null;
    let credit = null;

    if (chargeApplies && delta > 0) {
      const decision = resolveInventoryPayment({
        ...paymentCtx,
        pay: true,
      });
      if (decision.mustPay) {
        try {
          const catalog =
            await this.catalogLookup.assertItemInCatalog(itemSlug);
          debit = scaleCoinPurse(
            parseCostText(catalogCostText(catalog.cost)),
            delta,
          );
          debitCoinsWithExchange(coinPurseFromColumns(character), debit);
        } catch (error) {
          throw new BadRequestException(coinPurseErrorMessage(error));
        }
      }
    }

    if (chargeApplies && delta < 0) {
      try {
        const catalog = await this.catalogLookup.assertItemInCatalog(itemSlug);
        credit = halfCoinPurseValue(
          scaleCoinPurse(
            parseCostText(catalogCostText(catalog.cost)),
            Math.abs(delta),
          ),
        );
      } catch (error) {
        if (
          !(
            error instanceof Error &&
            (/no catalog price/i.test(error.message) ||
              /Cannot parse/i.test(error.message))
          )
        ) {
          throw new BadRequestException(coinPurseErrorMessage(error));
        }
      }
    }

    const { quantity: _q, ...rest } = dto;
    const hasOtherPatches = Object.values(rest).some((v) => v !== undefined);

    let result = await this.inventory.patchQuantityWithCoins(
      characterId,
      itemSlug,
      newQty,
      { debit, credit },
    );

    if (delta > 0 && debit) {
      await this.catalogStats.recordPurchase(itemSlug, delta);
    }

    if (hasOtherPatches) {
      result = await this.inventory.patch(
        characterId,
        itemSlug,
        rest,
        strengthScore,
        characterCtx,
      );
    }

    return result;
  }
}
