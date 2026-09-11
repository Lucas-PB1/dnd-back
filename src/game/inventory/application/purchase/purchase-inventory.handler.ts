import { BadRequestException, Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { DataSource, Repository } from 'typeorm';
import { RecordItemCatalogStatsService } from '@catalog/game-port';
import { CatalogLookupService } from '@catalog/catalog-lookup.service';
import { PhbItem } from '@entities/equipment/phb-item.entity';
import { CampaignCharacterAccessService } from '@game/campaign/infrastructure/campaign-character-access.service';
import {
  LoadEffectCatalog,
  purchaseDiscountPercentFromEffects,
} from '@game/effects';
import { PlayerCharacterAccessService } from '@game/shared/player-character-access.service';
import { loadCharacterFeatSlugs } from '@game/session/infrastructure/queries/class-resource-character.queries';
import {
  coinPurseErrorMessage,
  coinPurseFromColumns,
  debitCoinsWithExchange,
  resolveInventoryPayment,
  type CoinPurse,
} from '../../domain/coin-purse';
import { CharacterInventoryResponseDto } from '../../dto/inventory.dto';
import { PurchaseInventoryDto } from '../../dto/purchase-inventory.dto';
import { CharacterInventoryRepository } from '../../infrastructure/character-inventory.repository';
import { purchaseInventoryLines } from '../../infrastructure/inventory/inventory-purchase-tx';
import { AttachCoverageHandler } from '../attach/attach-coverage.handler';
import { GetCharacterInventoryQuery } from '../query/get-character-inventory.query';
import { resolvePurchaseLines } from './resolve-purchase-lines';

@Injectable()
export class PurchaseInventoryHandler {
  constructor(
    private readonly access: PlayerCharacterAccessService,
    private readonly campaignAccess: CampaignCharacterAccessService,
    private readonly catalogLookup: CatalogLookupService,
    private readonly inventory: CharacterInventoryRepository,
    private readonly getInventory: GetCharacterInventoryQuery,
    private readonly catalogStats: RecordItemCatalogStatsService,
    private readonly attachCoverage: AttachCoverageHandler,
    private readonly effectCatalog: LoadEffectCatalog,
    private readonly dataSource: DataSource,
    @InjectRepository(PhbItem)
    private readonly catalogItems: Repository<PhbItem>,
  ) {}

  async execute(
    userId: string,
    characterId: string,
    dto: PurchaseInventoryDto,
  ): Promise<CharacterInventoryResponseDto> {
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
    const decision = resolveInventoryPayment({
      ...paymentCtx,
      pay: dto.pay !== false,
    });

    const featSlugs = await loadCharacterFeatSlugs(
      this.dataSource,
      character.id,
    );
    const featEffects = await this.effectCatalog.load({
      ownerKind: 'feat',
      ownerSlugs: featSlugs,
      kinds: ['purchase_discount'],
    });
    const discount = purchaseDiscountPercentFromEffects(featEffects);
    const resolved = await resolvePurchaseLines(
      this.catalogLookup,
      dto,
      discount,
    );
    let debit: CoinPurse | null = null;
    if (decision.mustPay) {
      if (resolved.needsPrice && resolved.pricedLineCount === 0) {
        throw new BadRequestException(
          'Um ou mais itens não têm preço de catálogo. Peça ao DM ou use “Não pagar” se a campanha permitir.',
        );
      }
      if (resolved.pricedLineCount > 0) {
        try {
          debit = resolved.totalCost;
          debitCoinsWithExchange(coinPurseFromColumns(character), debit);
        } catch (error) {
          throw new BadRequestException(coinPurseErrorMessage(error));
        }
      }
    }

    if (resolved.inventoryLines.length > 0) {
      await purchaseInventoryLines({
        dataSource: this.dataSource,
        catalogItems: this.catalogItems,
        characterId,
        lines: resolved.inventoryLines,
        debit,
      });
    } else if (debit) {
      await this.inventory.debitWealth(characterId, debit);
    }

    for (const attach of resolved.coverageAttaches) {
      await this.attachCoverage.attach(userId, characterId, {
        baseItemSlug: attach.baseItemSlug,
        coverageSlug: attach.coverageSlug,
        bonus: attach.bonus,
      });
    }

    await this.catalogStats.recordPurchases(resolved.statsLines);

    return this.getInventory.execute(userId, characterId);
  }
}
