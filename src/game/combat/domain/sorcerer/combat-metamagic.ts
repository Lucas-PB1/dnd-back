import type { AdvantageMode } from '@game/dice/domain/dice';
import { rollDie } from '@game/dice/domain/dice';

/** Metamagias com efeito tipado em `resolveCombatSpell`. */
export const COMBAT_METAMAGIC_SLUGS = [
  'heightened-spell',
  'seeking-spell',
  'empowered-spell',
  'careful-spell',
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

export function wantsEmpoweredSpell(
  metamagicSlug: string | null | undefined,
): boolean {
  return metamagicSlug === 'empowered-spell';
}

export function wantsCarefulSpell(
  metamagicSlug: string | null | undefined,
): boolean {
  return metamagicSlug === 'careful-spell';
}

export function carefulProtectsCombatTarget(
  metamagicSlug: string | null | undefined,
  carefulExcludeTargetIds: readonly string[] | undefined,
  targetId: string | null | undefined,
): boolean {
  if (!wantsCarefulSpell(metamagicSlug) || !targetId?.trim()) return false;
  return (carefulExcludeTargetIds ?? []).includes(targetId);
}

/** Quantidade de dados a re-rolar (mod Carisma, mín. 1). */
export function empoweredRerollCount(charismaModifier: number): number {
  if (!Number.isFinite(charismaModifier)) return 1;
  return Math.max(1, Math.floor(charismaModifier));
}

/**
 * Rola `count` dados e, se empowered, re-rola até `rerollCount` dos menores
 * (cada dado no máx. uma vez).
 */
export function rollDiceTotalMaybeEmpowered(input: {
  die: number;
  count: number;
  flatPerDie: number;
  empowered: boolean;
  rerollCount: number;
}): number {
  const faces: number[] = [];
  for (let i = 0; i < input.count; i += 1) {
    faces.push(rollDie(input.die));
  }
  if (input.empowered && faces.length > 0) {
    const n = Math.min(
      Math.max(0, input.rerollCount),
      faces.length,
    );
    const order = faces
      .map((value, index) => ({ value, index }))
      .sort((a, b) => a.value - b.value || a.index - b.index);
    for (let i = 0; i < n; i += 1) {
      faces[order[i]!.index] = rollDie(input.die);
    }
  }
  return faces.reduce((sum, face) => sum + face + input.flatPerDie, 0);
}
