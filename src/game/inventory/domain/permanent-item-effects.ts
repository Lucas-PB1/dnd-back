import type { AbilityScores } from '@game/shared/infrastructure/player-character.entity';
import { STANDARD_ABILITY_SCORE_CAP } from '@game/sheet/domain/validation/feats/epic-boon-feat-options';
import { itemRequiresAttunement } from './attunement';
import { itemEffectsActive } from './item-effects-active';

/** Bônus contínuos estruturados em phb_item.properties.permanentEffects. */
export type PermanentItemEffects = {
  acBonus: number;
  attackBonus: number;
  damageBonus: number;
  abilityBonuses: Partial<
    Record<
      | 'forca'
      | 'destreza'
      | 'constituicao'
      | 'inteligencia'
      | 'sabedoria'
      | 'carisma',
      number
    >
  >;
  savingThrowBonuses: Partial<
    Record<
      | 'forca'
      | 'destreza'
      | 'constituicao'
      | 'inteligencia'
      | 'sabedoria'
      | 'carisma',
      number
    >
  >;
  speedBonusMeters: number;
  hpBonus: number;
  /**
   * Teto para os atributos aumentados por este item. Só ultrapassa 20 quando o
   * item declara explicitamente (ex.: Manual do Vigor Corporal).
   */
  abilityScoreMax: number;
};

export const EMPTY_PERMANENT_ITEM_EFFECTS: PermanentItemEffects = {
  acBonus: 0,
  attackBonus: 0,
  damageBonus: 0,
  abilityBonuses: {},
  savingThrowBonuses: {},
  speedBonusMeters: 0,
  hpBonus: 0,
  abilityScoreMax: STANDARD_ABILITY_SCORE_CAP,
};

function asFiniteNumber(value: unknown): number {
  return typeof value === 'number' && Number.isFinite(value) ? value : 0;
}

function parseAbilityMap(
  value: unknown,
): PermanentItemEffects['abilityBonuses'] {
  if (!value || typeof value !== 'object' || Array.isArray(value)) return {};
  const result: PermanentItemEffects['abilityBonuses'] = {};
  for (const [key, raw] of Object.entries(value)) {
    const amount = asFiniteNumber(raw);
    if (!amount) continue;
    if (
      key === 'forca' ||
      key === 'destreza' ||
      key === 'constituicao' ||
      key === 'inteligencia' ||
      key === 'sabedoria' ||
      key === 'carisma'
    ) {
      result[key] = amount;
    }
  }
  return result;
}

export function parsePermanentItemEffects(
  properties: Record<string, unknown> | null | undefined,
): PermanentItemEffects {
  const raw = properties?.permanentEffects;
  if (!raw || typeof raw !== 'object' || Array.isArray(raw)) {
    return { ...EMPTY_PERMANENT_ITEM_EFFECTS };
  }
  const source = raw as Record<string, unknown>;
  return {
    acBonus: asFiniteNumber(source.acBonus),
    attackBonus: asFiniteNumber(source.attackBonus),
    damageBonus: asFiniteNumber(source.damageBonus),
    abilityBonuses: parseAbilityMap(source.abilityBonuses),
    savingThrowBonuses: parseAbilityMap(source.savingThrowBonuses),
    speedBonusMeters: asFiniteNumber(source.speedBonusMeters),
    hpBonus: asFiniteNumber(source.hpBonus),
    abilityScoreMax: Math.max(
      STANDARD_ABILITY_SCORE_CAP,
      asFiniteNumber(source.abilityScoreMax),
    ),
  };
}

export type InventoryItemForEffects = {
  location: 'equipped' | 'backpack';
  attuned: boolean;
  itemName?: string;
  properties: Record<string, unknown> | null | undefined;
};

function mergeAbilityMaps(
  left: PermanentItemEffects['abilityBonuses'],
  right: PermanentItemEffects['abilityBonuses'],
): PermanentItemEffects['abilityBonuses'] {
  const result: PermanentItemEffects['abilityBonuses'] = { ...left };
  for (const [key, amount] of Object.entries(right) as [
    keyof PermanentItemEffects['abilityBonuses'],
    number,
  ][]) {
    result[key] = (result[key] ?? 0) + amount;
  }
  return result;
}

export type AbilityScoreCaps = Partial<Record<keyof AbilityScores, number>>;

export type ResolvedPermanentItemEffects = Omit<
  PermanentItemEffects,
  'abilityScoreMax'
> & {
  /** Teto por atributo aumentado: 20 salvo item que declare mais. */
  abilityScoreCaps: AbilityScoreCaps;
  sourceNames: string[];
};

/**
 * Aplica bônus de atributo de itens ativos sobre uma cópia das pontuações,
 * respeitando o teto de cada atributo (20 por padrão).
 */
export function applyItemAbilityBonuses(
  scores: AbilityScores,
  abilityBonuses: PermanentItemEffects['abilityBonuses'],
  abilityScoreCaps: AbilityScoreCaps = {},
): AbilityScores {
  const next: AbilityScores = { ...scores };
  for (const [key, amount] of Object.entries(abilityBonuses) as [
    keyof AbilityScores,
    number | undefined,
  ][]) {
    if (!amount) continue;
    const cap = abilityScoreCaps[key] ?? STANDARD_ABILITY_SCORE_CAP;
    next[key] = Math.min(Math.max(cap, scores[key]), scores[key] + amount);
  }
  return next;
}

/** Soma efeitos permanentes só dos itens ativos (equipados + sintonizados se preciso). */
export function resolveActivePermanentItemEffects(
  items: readonly InventoryItemForEffects[],
): ResolvedPermanentItemEffects {
  let total: PermanentItemEffects = { ...EMPTY_PERMANENT_ITEM_EFFECTS };
  const abilityScoreCaps: AbilityScoreCaps = {};
  const sourceNames: string[] = [];

  for (const item of items) {
    const requiresAttunement = itemRequiresAttunement(item.properties);
    if (
      !itemEffectsActive({
        location: item.location,
        attuned: item.attuned,
        requiresAttunement,
      })
    ) {
      continue;
    }

    const effects = parsePermanentItemEffects(item.properties);
    const hasEffect =
      effects.acBonus !== 0 ||
      effects.attackBonus !== 0 ||
      effects.damageBonus !== 0 ||
      effects.speedBonusMeters !== 0 ||
      effects.hpBonus !== 0 ||
      Object.keys(effects.abilityBonuses).length > 0 ||
      Object.keys(effects.savingThrowBonuses).length > 0;
    if (!hasEffect) continue;

    total = {
      acBonus: total.acBonus + effects.acBonus,
      attackBonus: total.attackBonus + effects.attackBonus,
      damageBonus: total.damageBonus + effects.damageBonus,
      abilityBonuses: mergeAbilityMaps(
        total.abilityBonuses,
        effects.abilityBonuses,
      ),
      savingThrowBonuses: mergeAbilityMaps(
        total.savingThrowBonuses,
        effects.savingThrowBonuses,
      ),
      speedBonusMeters: total.speedBonusMeters + effects.speedBonusMeters,
      hpBonus: total.hpBonus + effects.hpBonus,
      abilityScoreMax: STANDARD_ABILITY_SCORE_CAP,
    };
    for (const key of Object.keys(effects.abilityBonuses) as (keyof AbilityScores)[]) {
      abilityScoreCaps[key] = Math.max(
        abilityScoreCaps[key] ?? STANDARD_ABILITY_SCORE_CAP,
        effects.abilityScoreMax,
      );
    }
    if (item.itemName) sourceNames.push(item.itemName);
  }

  const { abilityScoreMax: _ignored, ...totals } = total;
  return { ...totals, abilityScoreCaps, sourceNames };
}
