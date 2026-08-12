import { BadRequestException, Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { DataSource, Repository } from 'typeorm';
import { RecordItemCatalogStatsService } from '@catalog/items/application/record-item-catalog-stats.service';
import { CatalogLookupService } from '@catalog/catalog-lookup.service';
import { PhbItem } from '@entities/phb-item.entity';
import { CampaignCharacterAccessService } from '@game/campaign/infrastructure/campaign-character-access.service';
import { PlayerCharacterAccessService } from '@game/shared/player-character-access.service';
import {
  addCoinPurses,
  catalogCostText,
  coinPurseErrorMessage,
  coinPurseFromColumns,
  debitCoinsWithExchange,
  EMPTY_COIN_PURSE,
  parseCostText,
  resolveInventoryPayment,
  scaleCoinPurse,
  type CoinPurse,
} from '../domain/coin-purse';
import { parseItemCoverage } from '../domain/coverage/item-coverage';
import {
  assertAttachCoverageSlugIsCoverage,
  assertCoverageLineHasTarget,
  assertNotStandaloneCoverageItem,
} from '../domain/coverage/coverage-inventory-rules';
import { isServiceItem } from '../domain/item-kind';
import { assertNotClassGrantedCatalogItem } from '@catalog/items/domain/class-granted-catalog-item';
import { CharacterInventoryResponseDto } from '../dto/inventory.dto';
import { PurchaseInventoryDto } from '../dto/purchase-inventory.dto';
import { CharacterInventoryRepository } from '../infrastructure/character-inventory.repository';
import { purchaseInventoryLines } from '../infrastructure/inventory/inventory-purchase-tx';
import { AttachCoverageHandler } from './attach-coverage.handler';
import { GetCharacterInventoryQuery } from './get-character-inventory.query';

type ResolvedPurchase = {
  inventoryLines: Array<{ itemSlug: string; quantity: number }>;
  coverageAttaches: Array<{
    baseItemSlug: string;
    coverageSlug: string;
    bonus?: 1 | 2 | 3;
  }>;
  statsLines: Array<{ itemSlug: string; quantity: number }>;
  totalCost: CoinPurse;
  pricedLineCount: number;
  needsPrice: boolean;
};

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

    const resolved = await this.resolveLines(dto);
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

  private async resolveLines(dto: PurchaseInventoryDto): Promise<ResolvedPurchase> {
    const inventoryLines: ResolvedPurchase['inventoryLines'] = [];
    const coverageAttaches: ResolvedPurchase['coverageAttaches'] = [];
    const statsLines: ResolvedPurchase['statsLines'] = [];
    let totalCost = { ...EMPTY_COIN_PURSE };
    let needsPrice = false;
    let pricedLineCount = 0;

    for (const line of dto.lines) {
      const quantity = line.quantity ?? 1;
      const catalog = await this.catalogLookup.assertItemInCatalog(line.itemSlug);
      const props = (catalog.properties ?? null) as Record<string, unknown> | null;
      assertNotClassGrantedCatalogItem(line.itemSlug, props);
      const coverage = parseItemCoverage(props);
      const service = isServiceItem(props);

      const priced = this.tryAddCost(catalog.cost, quantity, totalCost);
      totalCost = priced.total;
      if (priced.ok) pricedLineCount += 1;
      else needsPrice = true;

      statsLines.push({ itemSlug: line.itemSlug, quantity });

      if (service) continue;

      if (coverage && line.attachToBaseSlug) {
        inventoryLines.push({ itemSlug: line.itemSlug, quantity: 1 });
        coverageAttaches.push({
          baseItemSlug: line.attachToBaseSlug,
          coverageSlug: line.itemSlug,
          bonus: line.attachCoverageBonus,
        });
        continue;
      }

      if (coverage) {
        assertCoverageLineHasTarget(line.itemSlug, line);
      }

      if (line.attachCoverageSlug) {
        const covCatalog = await this.catalogLookup.assertItemInCatalog(
          line.attachCoverageSlug,
        );
        assertAttachCoverageSlugIsCoverage(
          line.attachCoverageSlug,
          (covCatalog.properties ?? null) as Record<string, unknown> | null,
        );
        inventoryLines.push({ itemSlug: line.itemSlug, quantity });
        inventoryLines.push({
          itemSlug: line.attachCoverageSlug,
          quantity: 1,
        });
        coverageAttaches.push({
          baseItemSlug: line.itemSlug,
          coverageSlug: line.attachCoverageSlug,
          bonus: line.attachCoverageBonus,
        });
        const covPriced = this.tryAddCost(covCatalog.cost, 1, totalCost);
        totalCost = covPriced.total;
        if (covPriced.ok) pricedLineCount += 1;
        else needsPrice = true;
        statsLines.push({ itemSlug: line.attachCoverageSlug, quantity: 1 });
        continue;
      }

      inventoryLines.push({ itemSlug: line.itemSlug, quantity });
    }

    return {
      inventoryLines,
      coverageAttaches,
      statsLines,
      totalCost,
      pricedLineCount,
      needsPrice,
    };
  }

  private tryAddCost(
    cost: Record<string, unknown> | null | undefined,
    quantity: number,
    current: CoinPurse,
  ): { ok: boolean; total: CoinPurse } {
    try {
      const scaled = scaleCoinPurse(
        parseCostText(catalogCostText(cost)),
        quantity,
      );
      return { ok: true, total: addCoinPurses(current, scaled) };
    } catch {
      return { ok: false, total: current };
    }
  }
}
