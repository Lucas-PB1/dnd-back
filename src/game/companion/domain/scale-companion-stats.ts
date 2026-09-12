import { abilityModifier } from '@game/sheet/domain/stats/ability-modifier';
import type { AbilityScores } from '@game/shared/domain/ability-scores';

/** Parâmetros de `phb_creature_scale_by_level` + CA base do template. */
export type ScaleByLevel = {
  armorClass: number | null;
  hpBase: number;
  hpPerLevel: number;
  acAbilitySlug: string | null;
};

export type ScaledCompanionCombatStats = {
  hitPointsMax: number | null;
  armorClass: number | null;
};

const ABILITY_KEYS: ReadonlySet<keyof AbilityScores> = new Set([
  'forca',
  'destreza',
  'constituicao',
  'inteligencia',
  'sabedoria',
  'carisma',
]);

export function scaleCompanionCombatStats(
  scale: ScaleByLevel,
  characterLevel: number,
  abilityScores: AbilityScores,
): ScaledCompanionCombatStats {
  const level = Math.max(1, characterLevel);
  const hitPointsMax = scale.hpBase + scale.hpPerLevel * level;

  let armorClass = scale.armorClass;
  const abilitySlug = scale.acAbilitySlug;
  if (
    armorClass != null &&
    abilitySlug &&
    ABILITY_KEYS.has(abilitySlug as keyof AbilityScores)
  ) {
    const score = abilityScores[abilitySlug as keyof AbilityScores];
    armorClass = armorClass + abilityModifier(score);
  }

  return { hitPointsMax, armorClass };
}
