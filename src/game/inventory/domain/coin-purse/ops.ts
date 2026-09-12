import { COIN_KEYS, COPPER_PER_COIN, type CoinPurse } from './types';

export function addCoinPurses(a: CoinPurse, b: CoinPurse): CoinPurse {
  return copperToPurse(purseToCopper(a) + purseToCopper(b));
}

export function scaleCoinPurse(purse: CoinPurse, quantity: number): CoinPurse {
  if (!Number.isInteger(quantity) || quantity < 1) {
    throw new Error('Quantity must be a positive integer');
  }
  return {
    copper: purse.copper * quantity,
    silver: purse.silver * quantity,
    electrum: purse.electrum * quantity,
    gold: purse.gold * quantity,
    platinum: purse.platinum * quantity,
  };
}

export function purseToCopper(purse: CoinPurse): number {
  let total = 0;
  for (const key of COIN_KEYS) {
    total += purse[key] * COPPER_PER_COIN[key];
  }
  return total;
}

export function copperToPurse(copper: number): CoinPurse {
  if (!Number.isInteger(copper) || copper < 0) {
    throw new Error('Copper amount must be a non-negative integer');
  }
  let rest = copper;
  const platinum = Math.floor(rest / COPPER_PER_COIN.platinum);
  rest -= platinum * COPPER_PER_COIN.platinum;
  const gold = Math.floor(rest / COPPER_PER_COIN.gold);
  rest -= gold * COPPER_PER_COIN.gold;
  const electrum = Math.floor(rest / COPPER_PER_COIN.electrum);
  rest -= electrum * COPPER_PER_COIN.electrum;
  const silver = Math.floor(rest / COPPER_PER_COIN.silver);
  rest -= silver * COPPER_PER_COIN.silver;
  return {
    platinum,
    gold,
    electrum,
    silver,
    copper: rest,
  };
}

export function halfCoinPurseValue(purse: CoinPurse): CoinPurse {
  return copperToPurse(Math.floor(purseToCopper(purse) / 2));
}

export function applyPurchaseDiscount(
  purse: CoinPurse,
  percentOff: number,
): CoinPurse {
  if (!Number.isInteger(percentOff) || percentOff < 1 || percentOff > 99) {
    throw new Error('percentOff must be an integer 1–99');
  }
  const kept = Math.floor((purseToCopper(purse) * (100 - percentOff)) / 100);
  return copperToPurse(kept);
}

export function assertCanDebitCoins(
  balance: CoinPurse,
  cost: CoinPurse,
): void {
  for (const key of COIN_KEYS) {
    if (balance[key] < cost[key]) {
      throw new Error(
        `Insufficient ${key} coins (have ${balance[key]}, need ${cost[key]})`,
      );
    }
  }
}

export function debitCoins(balance: CoinPurse, cost: CoinPurse): CoinPurse {
  assertCanDebitCoins(balance, cost);
  return {
    copper: balance.copper - cost.copper,
    silver: balance.silver - cost.silver,
    electrum: balance.electrum - cost.electrum,
    gold: balance.gold - cost.gold,
    platinum: balance.platinum - cost.platinum,
  };
}

export function debitCoinsWithExchange(
  balance: CoinPurse,
  cost: CoinPurse,
): CoinPurse {
  const have = purseToCopper(balance);
  const need = purseToCopper(cost);
  if (have < need) {
    throw new Error(
      `Insufficient coins (have ${have} copper, need ${need} copper)`,
    );
  }
  return copperToPurse(have - need);
}

export function creditCoins(balance: CoinPurse, delta: CoinPurse): CoinPurse {
  return {
    copper: balance.copper + delta.copper,
    silver: balance.silver + delta.silver,
    electrum: balance.electrum + delta.electrum,
    gold: balance.gold + delta.gold,
    platinum: balance.platinum + delta.platinum,
  };
}

export function creditCoinsWithExchange(
  balance: CoinPurse,
  delta: CoinPurse,
): CoinPurse {
  return copperToPurse(purseToCopper(balance) + purseToCopper(delta));
}

export function applyCoinPatch(
  balance: CoinPurse,
  patch: Partial<CoinPurse>,
): CoinPurse {
  const next = { ...balance };
  for (const key of COIN_KEYS) {
    const value = patch[key];
    if (value === undefined) continue;
    if (!Number.isInteger(value) || value < 0) {
      throw new Error(`Invalid ${key} amount`);
    }
    next[key] = value;
  }
  return next;
}

export type InventoryPaymentDecision =
  | { mustPay: false; reason: 'solo' | 'gift' | 'skip' }
  | { mustPay: true };

export function resolveInventoryPayment(input: {
  inCampaign: boolean;
  viewerIsDmOrAssistant: boolean;
  allowPlayerSkipPayment: boolean;
  pay: boolean;
}): InventoryPaymentDecision {
  if (!input.inCampaign) return { mustPay: false, reason: 'solo' };
  if (input.viewerIsDmOrAssistant) return { mustPay: false, reason: 'gift' };
  if (!input.pay && input.allowPlayerSkipPayment) {
    return { mustPay: false, reason: 'skip' };
  }
  return { mustPay: true };
}
