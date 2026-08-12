/**
 * Efeitos mecânicos de Ordem Divina / Ordem Primal — PHB 2024 S023.
 */

export const DIVINE_ORDER_KEY = 'divineOrder';
export const PRIMAL_ORDER_KEY = 'primalOrder';

type ClassOptionLike = { optionKey: string; valueId: string };

function readOrderValue(
  classOptions: readonly ClassOptionLike[] | undefined,
  key: string,
): string | null {
  return classOptions?.find((option) => option.optionKey === key)?.valueId ?? null;
}

export function extraArmorTrainingFromClassOrder(
  classSlug: string | null | undefined,
  classOptions: readonly ClassOptionLike[] | undefined,
): string[] {
  if (classSlug === 'cleric' && readOrderValue(classOptions, DIVINE_ORDER_KEY) === 'protector') {
    return ['heavy'];
  }
  return [];
}

export function extraWeaponProficiencyFromClassOrder(
  classSlug: string | null | undefined,
  classOptions: readonly ClassOptionLike[] | undefined,
): string[] {
  const divine = readOrderValue(classOptions, DIVINE_ORDER_KEY);
  const primal = readOrderValue(classOptions, PRIMAL_ORDER_KEY);
  if (
    (classSlug === 'cleric' && divine === 'protector') ||
    (classSlug === 'druid' && primal === 'warden')
  ) {
    return ['armas-marciais'];
  }
  return [];
}

export function extraCantripsFromClassOrder(
  classOptions: readonly ClassOptionLike[] | undefined,
): number {
  const divine = readOrderValue(classOptions, DIVINE_ORDER_KEY);
  const primal = readOrderValue(classOptions, PRIMAL_ORDER_KEY);
  if (divine === 'thaumaturge' || primal === 'magician') return 1;
  return 0;
}

/** Bônus extra (mod. Sabedoria, mín. +1) em perícias de Ordem. */
export function classOrderSkillCheckBonus(
  skillSlug: string,
  classOptions: readonly ClassOptionLike[] | undefined,
  wisdomModifier: number,
): number {
  const extra = Math.max(wisdomModifier, 1);
  const divine = readOrderValue(classOptions, DIVINE_ORDER_KEY);
  const primal = readOrderValue(classOptions, PRIMAL_ORDER_KEY);
  if (
    divine === 'thaumaturge' &&
    (skillSlug === 'arcana' || skillSlug === 'religion')
  ) {
    return extra;
  }
  if (
    primal === 'magician' &&
    (skillSlug === 'arcana' || skillSlug === 'nature')
  ) {
    return extra;
  }
  return 0;
}
