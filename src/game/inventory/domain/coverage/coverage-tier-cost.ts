import type { CoverageAppliesTo } from './item-coverage';
import { parseItemCoverage } from './item-coverage';
import type { CoinPurse } from '../coin-purse';
import { EMPTY_COIN_PURSE } from '../coin-purse';

/**
 * Valores DMG 2024 (Magic Item Rarities and Values).
 * Peça base PHB soma à parte (já cobrada na linha do item mundano).
 */
const RARITY_VALUE_GP = {
  uncommon: 400,
  rare: 4_000,
  'very-rare': 40_000,
  legendary: 200_000,
} as const;

/**
 * Mapa de raridade por bônus — headers DMG:
 * - Armadura: Raro (+1) / Muito Raro (+2) / Lendário (+3)
 * - Arma, Escudo, Munição, Varinha: Incomum (+1) / Raro (+2) / Muito Raro (+3)
 */
const TIER_RARITY_BY_APPLIES: Record<
  CoverageAppliesTo,
  Record<1 | 2 | 3, keyof typeof RARITY_VALUE_GP>
> = {
  armor: { 1: 'rare', 2: 'very-rare', 3: 'legendary' },
  weapon: { 1: 'uncommon', 2: 'rare', 3: 'very-rare' },
  shield: { 1: 'uncommon', 2: 'rare', 3: 'very-rare' },
  ammunition: { 1: 'uncommon', 2: 'rare', 3: 'very-rare' },
  wand: { 1: 'uncommon', 2: 'rare', 3: 'very-rare' },
  unarmed: { 1: 'uncommon', 2: 'rare', 3: 'very-rare' },
};

export function coverageTierBonusCostGp(
  appliesTo: CoverageAppliesTo,
  bonus: 1 | 2 | 3,
): number {
  return RARITY_VALUE_GP[TIER_RARITY_BY_APPLIES[appliesTo][bonus]];
}

export function coverageTierBonusCostText(
  appliesTo: CoverageAppliesTo,
  bonus: 1 | 2 | 3,
): string {
  return `${coverageTierBonusCostGp(appliesTo, bonus).toLocaleString('pt-BR')} PO`;
}

export function coverageTierBonusPurse(
  appliesTo: CoverageAppliesTo,
  bonus: 1 | 2 | 3,
): CoinPurse {
  return {
    ...EMPTY_COIN_PURSE,
    gold: coverageTierBonusCostGp(appliesTo, bonus),
  };
}

/** Preço da cobertura quando o catálogo não tem `cost` e há tier +1/+2/+3. */
export function resolveCoveragePurchaseCost(
  properties: Record<string, unknown> | null | undefined,
  bonus: 1 | 2 | 3 | undefined,
): { text: string; purse: CoinPurse } | null {
  const coverage = parseItemCoverage(properties);
  if (!coverage?.requiresTierBonus || !bonus) return null;
  return {
    text: coverageTierBonusCostText(coverage.appliesTo, bonus),
    purse: coverageTierBonusPurse(coverage.appliesTo, bonus),
  };
}
