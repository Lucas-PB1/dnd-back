/**
 * Strike options — tipos e lookups sobre catálogo montado de phb_effect.
 */

import { rollExpression, type Rng } from '@game/dice/domain/dice';

/** Slugs de atributo da ficha (PT). */
export type StrikeSaveAbility =
  | 'forca'
  | 'destreza'
  | 'constituicao'
  | 'inteligencia'
  | 'sabedoria'
  | 'carisma';

const SAVE_ABILITY_TO_SHEET: Readonly<Record<string, StrikeSaveAbility>> = {
  strength: 'forca',
  dexterity: 'destreza',
  constitution: 'constituicao',
  intelligence: 'inteligencia',
  wisdom: 'sabedoria',
  charisma: 'carisma',
  forca: 'forca',
  destreza: 'destreza',
  constituicao: 'constituicao',
  inteligencia: 'inteligencia',
  sabedoria: 'sabedoria',
  carisma: 'carisma',
};

export function mapSaveAbilityToSheet(
  raw: string | null | undefined,
): StrikeSaveAbility | null {
  if (!raw) return null;
  return SAVE_ABILITY_TO_SHEET[raw] ?? null;
}

export type StrikeOption = {
  slug: string;
  name: string;
  subclassSlug?: string;
  resourceSlug: string | null;
  tableAction: string | null;
  costDice: string | null;
  extraDice: string;
  extraDiceL18: string;
  damageType: string | null;
  saveAbility: StrikeSaveAbility | null;
  onFailCondition: string | null;
  onFailPendingKind: string | null;
  onHitPendingKind: string | null;
  replacesAttackWithSave: boolean;
  secondaryDice: string | null;
  secondaryDiceL18: string | null;
  ignoreTargetArmor: boolean;
  ignoreDamageResistance: boolean;
  addsArenaEffect: boolean;
  arenaEffectSlug: string | null;
  noteOnly: boolean;
};

export function listStrikeOptions(
  catalog: readonly StrikeOption[],
): StrikeOption[] {
  return [...catalog];
}

export function findStrikeOption(
  catalog: readonly StrikeOption[],
  slug: string,
): StrikeOption | undefined {
  return catalog.find((row) => row.slug === slug);
}

/** Filtra por `table_action` do catálogo (ex.: blood-strike). */
export function findStrikeOptionForTableAction(
  catalog: readonly StrikeOption[],
  slug: string,
  tableAction: string,
): StrikeOption | undefined {
  const row = findStrikeOption(catalog, slug);
  if (!row) return undefined;
  if (row.tableAction && row.tableAction !== tableAction) return undefined;
  return row;
}

export function strikeExtraDiceExpression(
  option: StrikeOption,
  level: number,
): string | null {
  if (option.extraDice === '0' && option.extraDiceL18 === '0') return null;
  if (option.extraDice === '0') {
    return level >= 18 ? option.extraDiceL18 : null;
  }
  return level >= 18 ? option.extraDiceL18 : option.extraDice;
}

export function strikeSecondaryDiceExpression(
  option: StrikeOption,
  level: number,
): string | null {
  if (!option.secondaryDice) return null;
  return level >= 18
    ? (option.secondaryDiceL18 ?? option.secondaryDice)
    : option.secondaryDice;
}

export type StrikeSelfCostRoll = {
  costTotal: number;
  expression: string;
  firstTotal: number;
  secondTotal: number | null;
};

/** Rola custo em si a partir de `costDice` do catálogo. */
export function rollStrikeSelfCost(input: {
  costDice: string;
  takeLower?: boolean;
  /** Nível mínimo para takeLower (ex.: 10 Sangue da Criação). */
  takeLowerMinLevel?: number;
  level: number;
  rng?: Rng;
}): StrikeSelfCostRoll {
  const rng = input.rng ?? Math.random;
  const first = rollExpression(input.costDice, rng);
  if (!input.takeLower) {
    return {
      costTotal: first.total,
      expression: first.expression,
      firstTotal: first.total,
      secondTotal: null,
    };
  }
  const minLevel = input.takeLowerMinLevel ?? 10;
  if (input.level < minLevel) {
    throw new Error(`takeLowerCost requires level ${minLevel}+`);
  }
  const second = rollExpression(input.costDice, rng);
  const costTotal = Math.min(first.total, second.total);
  return {
    costTotal,
    expression: `${input.costDice} (menor de ${first.total}/${second.total})`,
    firstTotal: first.total,
    secondTotal: second.total,
  };
}

export function strikeSaveDc(
  abilityModifier: number,
  proficiencyBonus: number,
): number {
  return 8 + abilityModifier + proficiencyBonus;
}
