import type { AbilityScores } from '../../shared/infrastructure/player-character.entity';
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
};

export const EMPTY_PERMANENT_ITEM_EFFECTS: PermanentItemEffects = {
  acBonus: 0,
  attackBonus: 0,
  damageBonus: 0,
  abilityBonuses: {},
  savingThrowBonuses: {},
  speedBonusMeters: 0,
  hpBonus: 0,
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

/** Aplica bônus de atributo de itens ativos sobre uma cópia das pontuações. */
export function applyItemAbilityBonuses(
  scores: AbilityScores,
  abilityBonuses: PermanentItemEffects['abilityBonuses'],
): AbilityScores {
  const next: AbilityScores = { ...scores };
  for (const [key, amount] of Object.entries(abilityBonuses) as [
    keyof AbilityScores,
    number | undefined,
  ][]) {
    if (!amount) continue;
    next[key] = (next[key] ?? 0) + amount;
  }
  return next;
}

/** Soma efeitos permanentes só dos itens ativos (equipados + sintonizados se preciso). */
export function resolveActivePermanentItemEffects(
  items: readonly InventoryItemForEffects[],
): PermanentItemEffects & { sourceNames: string[] } {
  let total: PermanentItemEffects = { ...EMPTY_PERMANENT_ITEM_EFFECTS };
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
    };
    if (item.itemName) sourceNames.push(item.itemName);
  }

  return { ...total, sourceNames };
}
