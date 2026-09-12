import { abilityModifier } from '@game/sheet/domain/stats/ability-modifier';
import type { AbilityScores } from '@game/shared/domain/ability-scores';

export type CompanionScaleTemplate = {
  armorClass: number | null;
  companionHpBase: number | null;
  companionHpPerLevel: number | null;
  companionAcAbilitySlug: string | null;
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
  template: CompanionScaleTemplate,
  characterLevel: number,
  abilityScores: AbilityScores,
): ScaledCompanionCombatStats {
  const level = Math.max(1, characterLevel);
  let hitPointsMax: number | null = null;
  if (
    template.companionHpBase != null &&
    template.companionHpPerLevel != null
  ) {
    hitPointsMax =
      template.companionHpBase + template.companionHpPerLevel * level;
  }

  let armorClass = template.armorClass;
  const abilitySlug = template.companionAcAbilitySlug;
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
