import type { AbilityScores } from '@game/shared/infrastructure/player-character.entity';
import { abilityModifier } from '@game/shared/domain/ability-scores';

export type SpeciesArmorPresetRow = {
  presetSlug: string;
  label: string;
  baseAc: number;
  abilityASlug: string;
  abilityACap: number | null;
  abilityBSlug: string | null;
  abilityBCap: number | null;
  pickMode: 'single' | 'max_of';
  countsAsWornArmor: boolean;
};

export type SpeciesArmorPresetResult = {
  armorClass: number;
  label: string;
  /** Conta como armadura vestida (estilo Defensivo). */
  countsAsWornArmor: boolean;
};

/** CA a partir de preset do catálogo (`phb_species_armor_preset`). */
export function computeSpeciesArmorPreset(
  scores: AbilityScores,
  preset: SpeciesArmorPresetRow,
): SpeciesArmorPresetResult {
  const withA =
    preset.baseAc +
    cappedAbilityMod(scores, preset.abilityASlug, preset.abilityACap);
  if (preset.pickMode === 'max_of' && preset.abilityBSlug) {
    const withB =
      preset.baseAc +
      cappedAbilityMod(scores, preset.abilityBSlug, preset.abilityBCap);
    return {
      armorClass: Math.max(withA, withB),
      label: preset.label,
      countsAsWornArmor: preset.countsAsWornArmor,
    };
  }
  return {
    armorClass: withA,
    label: preset.label,
    countsAsWornArmor: preset.countsAsWornArmor,
  };
}

/** Escolha cujo valueId existe nos presets da espécie. */
export function armorPresetSlugFromChoices(
  presets: readonly SpeciesArmorPresetRow[],
  speciesChoices:
    | readonly { choiceKind: string; choiceSlug: string }[]
    | undefined,
): string | null {
  if (!presets.length || !speciesChoices?.length) return null;
  const known = new Set(presets.map((p) => p.presetSlug));
  return (
    speciesChoices.find((c) => known.has(c.choiceSlug))?.choiceSlug ?? null
  );
}

export function findArmorPreset(
  presets: readonly SpeciesArmorPresetRow[],
  presetSlug: string | null | undefined,
): SpeciesArmorPresetRow | null {
  if (!presetSlug) return null;
  return presets.find((p) => p.presetSlug === presetSlug) ?? null;
}

function cappedAbilityMod(
  scores: AbilityScores,
  abilitySlug: string,
  cap: number | null,
): number {
  const score = scores[abilitySlug as keyof AbilityScores];
  if (typeof score !== 'number') return 0;
  const mod = abilityModifier(score);
  return cap == null ? mod : Math.min(mod, cap);
}
