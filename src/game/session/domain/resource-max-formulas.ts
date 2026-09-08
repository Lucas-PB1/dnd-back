/**
 * Fórmulas nomeadas de max de recurso (PHB) — SSOT em combat/domain.
 */

import {
  psiEnergyDiceCount,
  superiorityDiceCount,
} from '@game/combat/domain/fighter';
import { zealotHealingDiceCount } from '@game/combat/domain/barbarian';
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
  if (ability != null) {
    // Sabujo de Sangue: pool = 1 + CON (mín. 1). Enum só tem constitution_mod.
    if (
      row.resourceSlug === 'blood-strike' &&
      row.maxFormula === 'constitution_mod'
    ) {
      return Math.max(1, ability + 1);
    }
    return Math.max(1, ability);
  }
  return row.fixedMax ?? 0;
}
