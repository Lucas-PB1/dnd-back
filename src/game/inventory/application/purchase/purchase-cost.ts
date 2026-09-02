import {
  addCoinPurses,
  catalogCostText,
  parseCostText,
  scaleCoinPurse,
  type CoinPurse,
} from '../../domain/coin-purse';
import { resolveCoveragePurchaseCost } from '../../domain/coverage/coverage-tier-cost';

export type CostAccumulateResult = { ok: boolean; total: CoinPurse };

export function tryAddCatalogCost(
  cost: Record<string, unknown> | null | undefined,
  quantity: number,
  current: CoinPurse,
): CostAccumulateResult {
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

export function tryAddTierCoverageCost(
  properties: Record<string, unknown> | null | undefined,
  bonus: 1 | 2 | 3 | undefined,
  quantity: number,
  current: CoinPurse,
): CostAccumulateResult {
  const resolved = resolveCoveragePurchaseCost(properties, bonus);
  if (!resolved) return { ok: false, total: current };
  return {
    ok: true,
    total: addCoinPurses(current, scaleCoinPurse(resolved.purse, quantity)),
  };
}
