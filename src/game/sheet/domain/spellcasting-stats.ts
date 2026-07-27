import type { AbilityKey } from '../../build/domain/ability-generation';
import type { AbilityModifiers } from './character-derived-stats';

export function computeSpellSaveDc(
  proficiencyBonus: number,
  abilityMod: number,
): number {
  return 8 + proficiencyBonus + abilityMod;
}

export function computeSpellAttackBonus(
  proficiencyBonus: number,
  abilityMod: number,
): number {
  return proficiencyBonus + abilityMod;
}

export function spellcastingDerivedStats(input: {
  spellcastingAbilitySlug: AbilityKey | null;
  proficiencyBonus: number;
  abilityModifiers: AbilityModifiers;
}): {
  spellcastingAbilitySlug: AbilityKey | null;
  spellSaveDc: number | null;
  spellAttackBonus: number | null;
} {
  const ability = input.spellcastingAbilitySlug;
  if (!ability) {
    return {
      spellcastingAbilitySlug: null,
      spellSaveDc: null,
      spellAttackBonus: null,
    };
  }
  const mod = input.abilityModifiers[ability];
  return {
    spellcastingAbilitySlug: ability,
    spellSaveDc: computeSpellSaveDc(input.proficiencyBonus, mod),
    spellAttackBonus: computeSpellAttackBonus(input.proficiencyBonus, mod),
  };
}
