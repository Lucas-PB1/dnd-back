import type { CoinPurse } from '../../domain/coin-purse';

export type AddInventoryOptions = {
  debit?: CoinPurse | null;
};

export type RemoveInventoryOptions = {
  credit?: CoinPurse | null;
  quantity?: number;
};

export type PatchQuantityCoinOptions = {
  debit?: CoinPurse | null;
  credit?: CoinPurse | null;
};

export const EMPTY_WEALTH: CoinPurse = {
  copper: 0,
  silver: 0,
  electrum: 0,
  gold: 0,
  platinum: 0,
};
