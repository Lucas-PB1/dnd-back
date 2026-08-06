/**
 * Fórmulas nomeadas de max de recurso (PHB) — SSOT em combat/domain.
 */

import {
  psiEnergyDiceCount,
  superiorityDiceCount,
} from '../../combat/domain/fighter-features';
import { zealotHealingDiceCount } from '../../combat/domain/barbarian-rage';
import type { AbilityMods, ClassResourceScheduleRow, ResourceMaxFormula } from './class-resources';

function abilityModFromFormula(
  formula: ResourceMaxFormula,
  mods: AbilityMods,
): number | null {
  if (formula === 'charisma_mod') return mods.carisma;
  if (formula === 'wisdom_mod') return mods.sabedoria;
  if (formula === 'constitution_mod') return mods.constituicao;
  if (formula === 'intelligence_mod') return mods.inteligencia;
  return null;
}

export function resolveFormulaMax(
  row: ClassResourceScheduleRow,
  level: number,
  proficiencyBonus: number,
  mods: AbilityMods,
): number {
  if (row.maxFormula === 'fixed') return row.fixedMax ?? 0;
  if (row.maxFormula === 'level') return level;
  if (row.maxFormula === 'level_plus_one') return level + 1;
  if (row.maxFormula === 'proficiency_bonus') return proficiencyBonus;
  if (row.maxFormula === 'zealot_healing_dice_count') {
    return zealotHealingDiceCount(level);
  }
  if (row.maxFormula === 'superiority_dice_count') {
    return superiorityDiceCount(level);
  }
  if (row.maxFormula === 'psi_energy_dice_count') {
    return psiEnergyDiceCount(level);
  }
  const ability = abilityModFromFormula(row.maxFormula, mods);
  if (ability != null) return Math.max(1, ability);
  return row.fixedMax ?? 0;
}
