import type { AdvantageMode } from '@game/dice/domain/dice';

/** Metamagias com efeito tipado em `resolveCombatSpell` (PVE-6a). */
export const COMBAT_METAMAGIC_SLUGS = [
  'heightened-spell',
  'seeking-spell',
] as const;

export type CombatMetamagicSlug = (typeof COMBAT_METAMAGIC_SLUGS)[number];

export function isCombatMetamagicSlug(
  slug: string | null | undefined,
): slug is CombatMetamagicSlug {
  return (
    typeof slug === 'string' &&
    (COMBAT_METAMAGIC_SLUGS as readonly string[]).includes(slug)
  );
}

export function saveAdvantageForMetamagic(
  metamagicSlug: string | null | undefined,
): AdvantageMode {
  return metamagicSlug === 'heightened-spell' ? 'disadvantage' : 'normal';
}

export function wantsSeekingSpell(
  metamagicSlug: string | null | undefined,
): boolean {
  return metamagicSlug === 'seeking-spell';
}
