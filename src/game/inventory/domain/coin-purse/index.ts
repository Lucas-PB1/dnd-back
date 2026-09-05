/** Moedas D&D — parse de catálogo + câmbio PHB (Coin Values). */

export type { CoinPurse, CoinPurseColumns } from './types';
export {
  EMPTY_COIN_PURSE,
  COPPER_PER_COIN,
  coinPurseFromColumns,
  applyCoinPurseToColumns,
} from './types';

export {
  parseCostText,
  catalogCostText,
  formatCoinPurseText,
  coinPurseErrorMessage,
} from './parse';

export type { InventoryPaymentDecision } from './ops';
export {
  addCoinPurses,
  scaleCoinPurse,
  purseToCopper,
  copperToPurse,
  halfCoinPurseValue,
  applyPurchaseDiscount,
  assertCanDebitCoins,
  debitCoins,
  debitCoinsWithExchange,
  creditCoins,
  creditCoinsWithExchange,
  applyCoinPatch,
  resolveInventoryPayment,
} from './ops';
