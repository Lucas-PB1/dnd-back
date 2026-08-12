import type { AbilityScores } from '@game/shared/infrastructure/player-character.entity';

export type ManikinArmorPresetSlug =
  | 'infiltrator'
  | 'sentinel'
  | 'tormentor';

export type ManikinArmorPresetResult = {
  armorClass: number;
  label: string;
  /** Sentinel/Tormentor: conta como armadura média/pesada (estilo Defensivo). */
  countsAsWornArmor: boolean;
};

function abilityMod(score: number): number {
  return Math.floor((score - 10) / 2);
}

/**
 * CA do Manikin via `manikin_armor` (armorPresetId).
 * Só aplica se não houver armadura de corpo vestida.
 */
export function computeManikinArmorPreset(
  scores: AbilityScores,
  presetSlug: string,
): ManikinArmorPresetResult | null {
  const dex = abilityMod(scores.destreza);
  const str = abilityMod(scores.forca);

  switch (presetSlug as ManikinArmorPresetSlug) {
    case 'infiltrator':
      return {
        armorClass: 11 + dex,
        label: 'Manikin (Infiltrador)',
        countsAsWornArmor: false,
      };
    case 'sentinel': {
      const withDex = 13 + Math.min(dex, 2);
      const withStr = 13 + Math.min(str, 3);
      return {
        armorClass: Math.max(withDex, withStr),
        label: 'Manikin (Sentinela)',
        countsAsWornArmor: true,
      };
    }
    case 'tormentor':
      return {
        armorClass: 16 + Math.min(str, 2),
        label: 'Manikin (Tormentador)',
        countsAsWornArmor: true,
      };
    default:
      return null;
  }
}

export function manikinArmorPresetFromChoices(
  speciesSlug: string | null | undefined,
  speciesChoices: readonly { choiceKind: string; choiceSlug: string }[] | undefined,
): string | null {
  if (speciesSlug !== 'manikin' || !speciesChoices?.length) return null;
  return (
    speciesChoices.find((c) => c.choiceKind === 'manikin_armor')?.choiceSlug ??
    null
  );
}
