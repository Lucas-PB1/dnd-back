import { applyBarbarianFighterExtras } from './apply-barbarian-fighter';
import { applyPaladinExtras } from './apply-paladin';
import { applyRangerExtras } from './apply-ranger';
import { applySneakAttack } from './apply-sneak-attack';
import { applyWeaponMasteryExtras } from './apply-weapon-extras';
import type { DamageEffect } from './damage-roll-context';

/**
 * Ordem fixa do pipeline de dano — SSOT.
 * Golpe Mortal (em applySneakAttack) dobra o total ANTES de Paladino/Guardião.
 */
export const DAMAGE_EFFECT_PIPELINE: readonly DamageEffect[] = [
  applyWeaponMasteryExtras,
  applyBarbarianFighterExtras,
  applySneakAttack,
  applyPaladinExtras,
  applyRangerExtras,
];
