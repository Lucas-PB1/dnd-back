export type AttackCoverLevel = 'none' | 'half' | 'three_quarters' | 'full';

export function coverAcBonus(level: AttackCoverLevel): number {
  if (level === 'half') return 2;
  if (level === 'three_quarters') return 5;
  return 0;
}

export function isCoverBlockingAttack(level: AttackCoverLevel): boolean {
  return level === 'full';
}

export function ignoresPartialCover(featSlugs: readonly string[]): boolean {
  return featSlugs.includes('sharpshooter');
}

export function ignoresRangedRangePenalties(
  featSlugs: readonly string[],
  mode: 'melee' | 'ranged',
): boolean {
  if (mode !== 'ranged') return false;
  return (
    featSlugs.includes('sharpshooter') ||
    featSlugs.includes('crossbow-expert')
  );
}

export function effectiveCoverForAttack(input: {
  cover: AttackCoverLevel;
  featSlugs: readonly string[];
}): AttackCoverLevel {
  if (input.cover === 'none' || input.cover === 'full') return input.cover;
  if (ignoresPartialCover(input.featSlugs)) return 'none';
  return input.cover;
}
