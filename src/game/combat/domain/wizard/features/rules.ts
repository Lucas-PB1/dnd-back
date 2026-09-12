

import {
  FEATURE_SCHEDULE_KEYS,
  scheduleIntAtLevel,
  type FeatureScheduleBand,
} from '../../feature-schedule';

export const MAGIC_MISSILE_SPELL_SLUG = 'misseis-magicos';
export const MAGIC_MISSILE_MAGE_SUBCLASS = 'magic-missile-mage';
export const MAGIC_MISSILE_FREE_RESOURCE = 'magic-missile-free';
export const MISSILE_SHIELD_RESOURCE = 'missile-shield';
export const GIGA_MISSILE_RESOURCE = 'giga-missile';

export const THIRD_EYE_RESOURCE = 'third-eye';
export const SPECTRAL_SUMMON_RESOURCE = 'spectral-summon';
export const ILLUSORY_SELF_RESOURCE = 'illusory-self';

export const SCULPT_SPELLS_UNLOCK_LEVEL = 6;

export const SPELL_MASTERY_LEVEL_1_KEY = 'spellMastery1';
export const SPELL_MASTERY_LEVEL_2_KEY = 'spellMastery2';
export const SPELL_MASTERY_UNLOCK_LEVEL = 18;

export const MAGIC_MISSILE_BASE_DARTS = 3;

export function isWizardClass(classSlug: string | null | undefined): boolean {
  return classSlug === 'wizard';
}

export function isMagicMissileMage(
  subclassSlug: string | null | undefined,
): boolean {
  return subclassSlug === MAGIC_MISSILE_MAGE_SUBCLASS;
}

export function isSpellMasteryOptionKey(optionKey: string): boolean {
  return (
    optionKey === SPELL_MASTERY_LEVEL_1_KEY ||
    optionKey === SPELL_MASTERY_LEVEL_2_KEY
  );
}

export function spellMasteryRequiredLevelForKey(
  optionKey: string,
): 1 | 2 | null {
  if (optionKey === SPELL_MASTERY_LEVEL_1_KEY) return 1;
  if (optionKey === SPELL_MASTERY_LEVEL_2_KEY) return 2;
  return null;
}

export function readSpellMasterySlugs(
  classOptions: readonly { optionKey: string; valueId: string }[] | null | undefined,
): { level1: string | null; level2: string | null } {
  let level1: string | null = null;
  let level2: string | null = null;
  for (const option of classOptions ?? []) {
    if (option.optionKey === SPELL_MASTERY_LEVEL_1_KEY) {
      level1 = option.valueId;
    } else if (option.optionKey === SPELL_MASTERY_LEVEL_2_KEY) {
      level2 = option.valueId;
    }
  }
  return { level1, level2 };
}

export function isSpellMasterySpell(
  spellSlug: string,
  classOptions: readonly { optionKey: string; valueId: string }[] | null | undefined,
): boolean {
  const { level1, level2 } = readSpellMasterySlugs(classOptions);
  return spellSlug === level1 || spellSlug === level2;
}

export function arcaneRecoveryMaxSlotLevels(level: number): number {
  return Math.ceil(level / 2);
}

export function magicMissileExtraDarts(level: number): number {
  if (level >= 14) return 4;
  if (level >= 10) return 3;
  if (level >= 6) return 2;
  if (level >= 3) return 1;
  return 0;
}

export function magicMissileDartCount(
  level: number,
  slotLevelUsed: number | null,
): number {
  const upcastExtra =
    slotLevelUsed != null && slotLevelUsed > 1 ? slotLevelUsed - 1 : 0;
  return (
    MAGIC_MISSILE_BASE_DARTS + upcastExtra + magicMissileExtraDarts(level)
  );
}

export function buildMagicMissileCastNote(input: {
  level: number;
  slotLevelUsed: number | null;
  usedFreeResource: boolean;
  missileShield: boolean;
  gigaMissile: boolean;
  intModifier: number;
}): string {
  const darts = magicMissileDartCount(input.level, input.slotLevelUsed);
  const extras = magicMissileExtraDarts(input.level);
  const parts = [
    `Mísseis Mágicos: ${darts} dardo(s)`,
    extras > 0 ? `(+${extras} da subclasse)` : null,
    input.usedFreeResource ? 'sem espaço (uso gratuito)' : null,
    'penetram Escudo',
  ].filter(Boolean);

  let note = parts.join(' · ');
  if (input.missileShield) {
    note += `. Escudo de Mísseis: orbite até ${Math.min(darts, 5)} dardo(s) (+CA, Emanação 3 m, até 1 min).`;
  }
  if (input.gigaMissile) {
    const bonus = Math.max(1, input.intModifier);
    note += ` Giga-Míssil: +${bonus} de Força em cada dardo.`;
  }
  return note;
}

export function abjurerArcaneWardHp(level: number, intMod: number): number {
  return 2 * level + Math.max(1, intMod);
}

export function portentDiceCount(
  level: number,
  bands: readonly FeatureScheduleBand[],
): number {
  return scheduleIntAtLevel(
    bands,
    FEATURE_SCHEDULE_KEYS.portentD20Count,
    level,
    2,
  );
}
