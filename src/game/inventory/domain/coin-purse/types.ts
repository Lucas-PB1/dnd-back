

export type CoinPurse = {
  copper: number;
  silver: number;
  electrum: number;
  gold: number;
  platinum: number;
};

export const EMPTY_COIN_PURSE: CoinPurse = {
  copper: 0,
  silver: 0,
  electrum: 0,
  gold: 0,
  platinum: 0,
};

export const COIN_KEYS = [
  'copper',
  'silver',
  'electrum',
  'gold',
  'platinum',
] as const;

export type CoinKey = (typeof COIN_KEYS)[number];


export const COPPER_PER_COIN: Record<CoinKey, number> = {
  copper: 1,
  silver: 10,
  electrum: 50,
  gold: 100,
  platinum: 1000,
};

export const COIN_LABEL: Record<CoinKey, string> = {
  copper: 'PC',
  silver: 'PP',
  electrum: 'PE',
  gold: 'PO',
  platinum: 'PL',
};

export type CoinPurseColumns = {
  coinCopper: number;
  coinSilver: number;
  coinElectrum: number;
  coinGold: number;
  coinPlatinum: number;
};

export function coinPurseFromColumns(row: CoinPurseColumns): CoinPurse {
  return {
    copper: row.coinCopper,
    silver: row.coinSilver,
    electrum: row.coinElectrum,
    gold: row.coinGold,
    platinum: row.coinPlatinum,
  };
}

export function applyCoinPurseToColumns(
  row: CoinPurseColumns,
  purse: CoinPurse,
): void {
  row.coinCopper = purse.copper;
  row.coinSilver = purse.silver;
  row.coinElectrum = purse.electrum;
  row.coinGold = purse.gold;
  row.coinPlatinum = purse.platinum;
}
