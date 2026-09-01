import { applyBarbarianFighterExtras } from './apply-barbarian-fighter';
import { applyClericExtras } from './apply-cleric';
import { applyGrimHollowFeatExtras } from './apply-grim-hollow-feat-extras';
import { applyPaladinExtras } from './apply-paladin';
import { applyRangerExtras } from './apply-ranger';
import { applySneakAttack } from './apply-sneak-attack';
import { applyWeaponMasteryExtras } from './apply-weapon-extras';
import type { DamageEffect } from './damage-roll-context';

/**
 * Ordem fixa do pipeline de dano — SSOT.
 * Golpe Mortal (em applySneakAttack) dobra o total ANTES de Paladino/Patrulheiro.
 */
export const DAMAGE_EFFECT_PIPELINE: readonly DamageEffect[] = [
  applyWeaponMasteryExtras,
  applyGrimHollowFeatExtras,
  applyBarbarianFighterExtras,
  applySneakAttack,
  applyPaladinExtras,
  applyRangerExtras,
  applyClericExtras,
];
