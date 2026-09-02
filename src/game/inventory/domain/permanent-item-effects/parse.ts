import { STANDARD_ABILITY_SCORE_CAP } from '@game/sheet/domain/validation/feats/epic-boon-feat-options';
import {
  EMPTY_PERMANENT_ITEM_EFFECTS,
  type PermanentItemEffects,
} from './types';

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
