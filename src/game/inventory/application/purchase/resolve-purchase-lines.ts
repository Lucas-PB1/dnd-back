import { CatalogLookupService } from '@catalog/catalog-lookup.service';
import { assertNotClassGrantedCatalogItem } from '@catalog/items/domain/class-granted-catalog-item';
import {
  EMPTY_COIN_PURSE,
  type CoinPurse,
} from '../../domain/coin-purse';
import { parseItemCoverage } from '../../domain/coverage/item-coverage';
import {
  assertAttachCoverageSlugIsCoverage,
  assertCoverageLineHasTarget,
} from '../../domain/coverage/coverage-inventory-rules';
import { assertBaseEligibleForCoverage } from '../../domain/coverage/coverage-base-eligibility';
import { isServiceItem } from '../../domain/item-kind';
import { PurchaseInventoryDto } from '../../dto/purchase-inventory.dto';
import {
  tryAddCatalogCost,
  tryAddTierCoverageCost,
  type PurchaseDiscountContext,
} from './purchase-cost';

export type ResolvedPurchase = {
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

export async function resolvePurchaseLines(
  catalogLookup: CatalogLookupService,
  dto: PurchaseInventoryDto,
  discount?: PurchaseDiscountContext | null,
): Promise<ResolvedPurchase> {
  const inventoryLines: ResolvedPurchase['inventoryLines'] = [];
  const coverageAttaches: ResolvedPurchase['coverageAttaches'] = [];
  const statsLines: ResolvedPurchase['statsLines'] = [];
  let totalCost = { ...EMPTY_COIN_PURSE };
  let needsPrice = false;
  let pricedLineCount = 0;

  for (const line of dto.lines) {
    const quantity = line.quantity ?? 1;
    const catalog = await catalogLookup.assertItemInCatalog(line.itemSlug);
    const props = (catalog.properties ?? null) as Record<string, unknown> | null;
    assertNotClassGrantedCatalogItem(line.itemSlug, props);
    const coverage = parseItemCoverage(props);
    const service = isServiceItem(props);

    const priced = tryAddCatalogCost(catalog.cost, quantity, totalCost, {
      itemSlug: line.itemSlug,
      properties: props,
      discount,
    });
    totalCost = priced.total;
    if (priced.ok) pricedLineCount += 1;

    statsLines.push({ itemSlug: line.itemSlug, quantity });

    if (service) {
      if (!priced.ok) needsPrice = true;
      continue;
    }

    if (coverage && line.attachToBaseSlug) {
      const baseCatalog = await catalogLookup.assertItemInCatalog(
        line.attachToBaseSlug,
      );
      assertBaseEligibleForCoverage(
        line.attachToBaseSlug,
        (baseCatalog.properties ?? null) as Record<string, unknown> | null,
        props,
      );
      if (!priced.ok) {
        const tier = tryAddTierCoverageCost(
          props,
          line.attachCoverageBonus,
          quantity,
          totalCost,
          discount,
          line.itemSlug,
        );
        totalCost = tier.total;
        if (tier.ok) pricedLineCount += 1;
        else needsPrice = true;
      }
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
      const covCatalog = await catalogLookup.assertItemInCatalog(
        line.attachCoverageSlug,
      );
      const covProps = (covCatalog.properties ?? null) as
        | Record<string, unknown>
        | null;
      assertAttachCoverageSlugIsCoverage(line.attachCoverageSlug, covProps);
      assertBaseEligibleForCoverage(line.itemSlug, props, covProps);
      if (!priced.ok) needsPrice = true;
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
      const covPriced = tryAddCatalogCost(covCatalog.cost, quantity, totalCost, {
        itemSlug: line.attachCoverageSlug,
        properties: covProps,
        discount,
      });
      if (covPriced.ok) {
        totalCost = covPriced.total;
        pricedLineCount += 1;
      } else {
        const tier = tryAddTierCoverageCost(
          covProps,
          line.attachCoverageBonus,
          quantity,
          totalCost,
          discount,
          line.attachCoverageSlug,
        );
        totalCost = tier.total;
        if (tier.ok) pricedLineCount += 1;
        else needsPrice = true;
      }
      statsLines.push({
        itemSlug: line.attachCoverageSlug,
        quantity,
      });
      continue;
    }

    if (!priced.ok) needsPrice = true;
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
