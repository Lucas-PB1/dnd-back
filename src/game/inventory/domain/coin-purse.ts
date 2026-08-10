/** Moedas D&D separadas (sem troca automática entre tipos). */

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

const COIN_KEYS = [
  'copper',
  'silver',
  'electrum',
  'gold',
  'platinum',
] as const;

type CoinKey = (typeof COIN_KEYS)[number];

/** Abreviações do catálogo PHB-PT + PL para platina (evita colisão PP=prata). */
const TOKEN_TO_KEY: Record<string, CoinKey> = {
  pc: 'copper',
  pp: 'silver',
  pe: 'electrum',
  po: 'gold',
  pl: 'platinum',
  ppl: 'platinum',
};

export function parseCostText(costText: string | null | undefined): CoinPurse {
  if (!costText?.trim()) {
    throw new Error('Item has no catalog price');
  }
  const purse = { ...EMPTY_COIN_PURSE };
  const matches = [...costText.matchAll(/(\d+)\s*(PC|PP|PE|PO|PL|PPl)\b/gi)];
  if (matches.length === 0) {
    throw new Error(`Cannot parse item cost '${costText}'`);
  }
  for (const match of matches) {
    const amount = Number(match[1]);
    const token = match[2].toLowerCase();
    const key = TOKEN_TO_KEY[token];
    if (!key || !Number.isFinite(amount) || amount < 0) {
      throw new Error(`Cannot parse item cost '${costText}'`);
    }
    purse[key] += amount;
  }
  return purse;
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

export function creditCoins(balance: CoinPurse, delta: CoinPurse): CoinPurse {
  return {
    copper: balance.copper + delta.copper,
    silver: balance.silver + delta.silver,
    electrum: balance.electrum + delta.electrum,
    gold: balance.gold + delta.gold,
    platinum: balance.platinum + delta.platinum,
  };
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

/**
 * Solo → free. DM/assistant → gift free. Player → pay unless skip liberado e pay=false.
 */
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

export function catalogCostText(
  cost: Record<string, unknown> | null | undefined,
): string | null {
  if (!cost || typeof cost !== 'object') return null;
  const text = cost.text;
  return typeof text === 'string' ? text : null;
}

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

const COIN_LABEL: Record<CoinKey, string> = {
  copper: 'PC',
  silver: 'PP',
  electrum: 'PE',
  gold: 'PO',
  platinum: 'PL',
};

/** Mensagem amigável a partir de erro de parse/debit do domínio. */
export function coinPurseErrorMessage(error: unknown): string {
  const message = error instanceof Error ? error.message : String(error);
  if (/no catalog price/i.test(message)) {
    return 'Este item não tem preço de catálogo. Peça ao DM para presentear ou use “Não pagar” se a campanha permitir.';
  }
  if (/Cannot parse/i.test(message)) {
    return 'Não foi possível interpretar o preço do item no catálogo.';
  }
  const insufficient = message.match(/Insufficient (\w+) coins \(have (\d+), need (\d+)\)/);
  if (insufficient) {
    const key = insufficient[1] as CoinKey;
    const label = COIN_LABEL[key] ?? key;
    return `Saldo insuficiente de ${label} (tem ${insufficient[2]}, precisa ${insufficient[3]}).`;
  }
  return message;
}
