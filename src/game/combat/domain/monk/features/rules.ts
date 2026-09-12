
import type { EquippedWeaponPiece } from '../../weapon-attacks/weapon-attack.types';
import {
  FEATURE_SCHEDULE_KEYS,
  scheduleIntAtLevel,
  scheduleValueAtLevel,
  type FeatureScheduleBand,
} from '../../feature-schedule';
import { meetsFeatureGate } from '../../feature-gates';

export const MONK_UNARMED_ITEM_SLUG = 'unarmed-strike';

export type MonkSubclassSlug =
  | 'open-hand'
  | 'elements'
  | 'mercy'
  | 'shadow'
  | 'warrior-of-the-street';

export function isMonkClass(classSlug: string | null | undefined): boolean {
  return classSlug === 'monk';
}

export function hasEvasion(
  level: number,
  unlockLevel: number | null | undefined,
): boolean {
  return meetsFeatureGate(level, unlockLevel);
}

export function hasDiamondSoul(
  level: number,
  unlockLevel: number | null | undefined,
): boolean {
  return meetsFeatureGate(level, unlockLevel);
}

export function martialArtsDieFaces(
  level: number,
  bands: readonly FeatureScheduleBand[],
): 6 | 8 | 10 | 12 {
  const faces = scheduleIntAtLevel(
    bands,
    FEATURE_SCHEDULE_KEYS.martialArtsDieFaces,
    level,
    6,
  );
  if (faces === 12 || faces === 10 || faces === 8 || faces === 6) return faces;
  return 6;
}

export function martialArtsDie(
  level: number,
  bands: readonly FeatureScheduleBand[],
): string {
  return `1d${martialArtsDieFaces(level, bands)}`;
}

export function monkFocusSaveDc(input: {
  wisdomModifier: number;
  proficiencyBonus: number;
}): number {
  return 8 + input.wisdomModifier + input.proficiencyBonus;
}

export function unarmoredMovementBonusMeters(input: {
  classSlug?: string | null;
  level?: number;
  featureSchedules: readonly FeatureScheduleBand[];
}): number {
  if (!isMonkClass(input.classSlug)) return 0;
  const level = input.level ?? 0;
  return (
    scheduleValueAtLevel(
      input.featureSchedules,
      FEATURE_SCHEDULE_KEYS.unarmoredSpeedBonusM,
      level,
    ) ?? 0
  );
}

export function isMonkWeaponForAttack(
  piece: EquippedWeaponPiece,
  mode: 'melee' | 'ranged',
): boolean {
  if (mode !== 'melee') return false;
  if (piece.itemSlug === MONK_UNARMED_ITEM_SLUG) return true;
  if (piece.category === 'simple') return true;
  return piece.category === 'martial' && piece.propertySlugs.includes('light');
}

export function monkAttacksPerAction(
  level: number,
  bands: readonly FeatureScheduleBand[],
): number {
  return scheduleIntAtLevel(
    bands,
    FEATURE_SCHEDULE_KEYS.attacksPerAction,
    level,
    1,
  );
}
