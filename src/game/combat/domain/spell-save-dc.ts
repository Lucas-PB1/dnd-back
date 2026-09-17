import type { AbilityModifiers } from '@game/shared/domain/ability-scores';

const ABILITY_KEYS = new Set([
  'forca',
  'destreza',
  'constituicao',
  'inteligencia',
  'sabedoria',
  'carisma',
]);

export function abilityModifierFromSlug(
  mods: AbilityModifiers,
  slug: string | null | undefined,
): number {
  if (!slug || !ABILITY_KEYS.has(slug)) return 0;
  return mods[slug as keyof AbilityModifiers] ?? 0;
}

export function spellSaveDcFromMods(
  proficiencyBonus: number,
  abilityMod: number,
): number {
  return 8 + proficiencyBonus + abilityMod;
}
