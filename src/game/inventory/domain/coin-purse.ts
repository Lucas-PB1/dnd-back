/** Moedas D&D — parse de catálogo + câmbio PHB (Coin Values). */

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

/**
 * PHB Coin Values em cobre (1 PO = 100 PC).
 * 1 PC=1, 1 PP(prata)=10, 1 PE=50, 1 PO=100, 1 PL=1000
 */
export const COPPER_PER_COIN: Record<CoinKey, number> = {
  copper: 1,
  silver: 10,
  electrum: 50,
  gold: 100,
  platinum: 1000,
};

const COIN_LABEL: Record<CoinKey, string> = {
  copper: 'PC',
  silver: 'PP',
  electrum: 'PE',
  gold: 'PO',
  platinum: 'PL',
};

/** Extrai valor inteiro aceitando milhar BR (`1.500`). */
function parseAmountToken(raw: string): number {
  const normalized = raw.replace(/\./g, '');
  const amount = Number(normalized);
  if (!Number.isFinite(amount) || amount < 0) {
    throw new Error(`Cannot parse amount '${raw}'`);
  }
  return amount;
}

export function parseCostText(costText: string | null | undefined): CoinPurse {
  if (!costText?.trim()) {
    throw new Error('Item has no catalog price');
  }
  if (/^varia$/i.test(costText.trim())) {
    throw new Error('Item has no catalog price');
  }
  const purse = { ...EMPTY_COIN_PURSE };
  const matches = [
    ...costText.matchAll(
      /(\d{1,3}(?:\.\d{3})+|\d+)\s*(PC|PP|PE|PO|PL|PPl)\b/gi,
    ),
  ];
  if (matches.length === 0) {
    throw new Error(`Cannot parse item cost '${costText}'`);
  }
  for (const match of matches) {
    const amount = parseAmountToken(match[1]!);
    const token = match[2]!.toLowerCase();
    const key = TOKEN_TO_KEY[token];
    if (!key) {
      throw new Error(`Cannot parse item cost '${costText}'`);
    }
    purse[key] += amount;
  }
  return purse;
}

/** Soma purses via cobre (câmbio PHB). */
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

/** Rebalanceia cobre em PL → PO → PE → PP → PC (greedy). */
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

/** Metade do valor (venda PHB) — arredonda para baixo em cobre. */
export function halfCoinPurseValue(purse: CoinPurse): CoinPurse {
  return copperToPurse(Math.floor(purseToCopper(purse) / 2));
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

/**
 * Debita pelo valor total em cobre e rebalanceia o saldo (loja aceita mistura).
 */
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

/**
 * Credita e rebalanceia (útil após venda ½).
 */
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

/** Formata purse não-vazio (ex. `3 PO · 5 PP`). */
export function formatCoinPurseText(purse: CoinPurse): string {
  return COIN_KEYS.filter((key) => purse[key] > 0)
    .map((key) => `${purse[key]} ${COIN_LABEL[key]}`)
    .join(' · ');
}

/** Mensagem amigável a partir de erro de parse/debit do domínio. */
export function coinPurseErrorMessage(error: unknown): string {
  const message = error instanceof Error ? error.message : String(error);
  if (/no catalog price/i.test(message)) {
    return 'Este item não tem preço de catálogo. Peça ao DM para presentear ou use “Não pagar” se a campanha permitir.';
  }
  if (/Cannot parse/i.test(message)) {
    return 'Não foi possível interpretar o preço do item no catálogo.';
  }
  const insufficientTotal = message.match(
    /Insufficient coins \(have (\d+) copper, need (\d+) copper\)/,
  );
  if (insufficientTotal) {
    const haveGp = (Number(insufficientTotal[1]) / 100).toFixed(2);
    const needGp = (Number(insufficientTotal[2]) / 100).toFixed(2);
    return `Saldo insuficiente (equivalente a ${haveGp} PO; precisa ${needGp} PO).`;
  }
  const insufficient = message.match(
    /Insufficient (\w+) coins \(have (\d+), need (\d+)\)/,
  );
  if (insufficient) {
    const key = insufficient[1] as CoinKey;
    const label = COIN_LABEL[key] ?? key;
    return `Saldo insuficiente de ${label} (tem ${insufficient[2]}, precisa ${insufficient[3]}).`;
  }
  return message;
}
