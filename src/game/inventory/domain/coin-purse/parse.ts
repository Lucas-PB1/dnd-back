import {
  COIN_KEYS,
  COIN_LABEL,
  EMPTY_COIN_PURSE,
  type CoinKey,
  type CoinPurse,
} from './types';

/** Abreviações do catálogo PHB-PT + PL para platina (evita colisão PP=prata). */
const TOKEN_TO_KEY: Record<string, CoinKey> = {
  pc: 'copper',
  pp: 'silver',
  pe: 'electrum',
  po: 'gold',
  pl: 'platinum',
  ppl: 'platinum',
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

export function catalogCostText(
  cost: Record<string, unknown> | null | undefined,
): string | null {
  if (!cost || typeof cost !== 'object') return null;
  const text = cost.text;
  return typeof text === 'string' ? text : null;
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
