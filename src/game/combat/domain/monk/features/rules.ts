/**
 * Regras numéricas de combate do Monge (PHB 2024): Artes Marciais, Foco e movimento.
 */
import type { EquippedWeaponPiece } from '../../weapon-attacks/weapon-attack.types';

/** Slug sintético do Ataque Desarmado (não existe item no catálogo). */
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

/** Dado de Artes Marciais: 1d6 → 1d8 → 1d10 → 1d12. */
export function martialArtsDieFaces(level: number): 6 | 8 | 10 | 12 {
  if (level >= 17) return 12;
  if (level >= 11) return 10;
  if (level >= 5) return 8;
  return 6;
}

export function martialArtsDie(level: number): string {
  return `1d${martialArtsDieFaces(level)}`;
}

/** CD de Foco (Empurrar/Imobilizar, Golpe Atordoante etc.): 8 + SAB + PB. */
export function monkFocusSaveDc(input: {
  wisdomModifier: number;
  proficiencyBonus: number;
}): number {
  return 8 + input.wisdomModifier + input.proficiencyBonus;
}

/** Movimento sem Armadura (metros): +3 → +4,5 → +6 → +7,5 → +9. */
export function unarmoredMovementBonusMeters(input: {
  classSlug?: string | null;
  level?: number;
}): number {
  if (!isMonkClass(input.classSlug)) return 0;
  const level = input.level ?? 0;
  if (level >= 18) return 9;
  if (level >= 14) return 7.5;
  if (level >= 10) return 6;
  if (level >= 6) return 4.5;
  if (level >= 2) return 3;
  return 0;
}

/**
 * Arma de Monge para fins de Artes Marciais: Ataque Desarmado, armas Simples
 * corpo a corpo e armas Marciais corpo a corpo com a propriedade Leve.
 */
export function isMonkWeaponForAttack(
  piece: EquippedWeaponPiece,
  mode: 'melee' | 'ranged',
): boolean {
  if (mode !== 'melee') return false;
  if (piece.itemSlug === MONK_UNARMED_ITEM_SLUG) return true;
  if (piece.category === 'simple') return true;
  return piece.category === 'martial' && piece.propertySlugs.includes('light');
}

/** Ataque Extra do Monge (nível 5): dois ataques na ação Atacar. */
export function monkAttacksPerAction(level: number): number {
  return level >= 5 ? 2 : 1;
}
