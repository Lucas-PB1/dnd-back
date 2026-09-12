import {
  addCoinPurses,
  applyPurchaseDiscount,
  catalogCostText,
  parseCostText,
  scaleCoinPurse,
  type CoinPurse,
} from '../../domain/coin-purse';
import { resolveCoveragePurchaseCost } from '../../domain/coverage/coverage-tier-cost';
import { isFoodDrinkPurchaseItem } from '../../domain/item-kind';

export type CostAccumulateResult = { ok: boolean; total: CoinPurse };

export type PurchaseDiscountContext = {
  percentOff: number;
  nonMagicOnly: boolean;
  foodDrinkOnly?: boolean;
};

function maybeDiscount(
  purse: CoinPurse,
  itemSlug: string,
  props: Record<string, unknown> | null | undefined,
  discount: PurchaseDiscountContext | null | undefined,
): CoinPurse {
  if (!discount) return purse;
  if (discount.nonMagicOnly && props?.magic === true) {
    if (!(discount.foodDrinkOnly && isFoodDrinkPurchaseItem(itemSlug, props))) {
      return purse;
    }
  }
  if (discount.foodDrinkOnly && !isFoodDrinkPurchaseItem(itemSlug, props)) {
    return purse;
  }
  return applyPurchaseDiscount(purse, discount.percentOff);
}

export function tryAddCatalogCost(
  cost: Record<string, unknown> | null | undefined,
  quantity: number,
  current: CoinPurse,
  options?: {
    itemSlug?: string;
    properties?: Record<string, unknown> | null;
    discount?: PurchaseDiscountContext | null;
  },
): CostAccumulateResult {
  try {
    const scaled = scaleCoinPurse(
      parseCostText(catalogCostText(cost)),
      quantity,
    );
    const priced = maybeDiscount(
      scaled,
      options?.itemSlug ?? '',
      options?.properties,
      options?.discount,
    );
    return { ok: true, total: addCoinPurses(current, priced) };
  } catch {
    return { ok: false, total: current };
  }
}

export function tryAddTierCoverageCost(
  properties: Record<string, unknown> | null | undefined,
  bonus: 1 | 2 | 3 | undefined,
  quantity: number,
  current: CoinPurse,
  discount?: PurchaseDiscountContext | null,
  itemSlug = '',
): CostAccumulateResult {
  const resolved = resolveCoveragePurchaseCost(properties, bonus);
  if (!resolved) return { ok: false, total: current };
  const scaled = scaleCoinPurse(resolved.purse, quantity);
  const priced = maybeDiscount(scaled, itemSlug, properties, discount);
  return {
    ok: true,
    total: addCoinPurses(current, priced),
  };
}
