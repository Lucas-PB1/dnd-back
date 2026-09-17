export type DamageAffinityKind = 'resistance' | 'vulnerability' | 'immunity';

export type DamageTypeDefenses = {
  immunities: readonly string[];
  resistances: readonly string[];
  vulnerabilities: readonly string[];
};

export type DamageTypeModifierResult = {
  damage: number;
  applied: 'none' | 'immunity' | 'resistance' | 'vulnerability' | 'cancel';
};

const EMPTY: DamageTypeDefenses = {
  immunities: [],
  resistances: [],
  vulnerabilities: [],
};

export function emptyDamageTypeDefenses(): DamageTypeDefenses {
  return EMPTY;
}

function norm(slug: string): string {
  return slug.trim().toLowerCase();
}

function has(list: readonly string[], type: string): boolean {
  return list.some((row) => norm(row) === type);
}

/**
 * PHB: imunidade zera; resist+vuln no mesmo tipo se cancelam;
 * só resist → metade; só vuln → dobro (floor).
 */
export function applyDamageTypeModifiers(input: {
  damage: number;
  damageTypeSlug: string | null | undefined;
  defenses: DamageTypeDefenses;
}): DamageTypeModifierResult {
  const raw = Math.max(0, input.damage);
  const type = input.damageTypeSlug?.trim()
    ? norm(input.damageTypeSlug)
    : null;
  if (!type || raw === 0) {
    return { damage: raw, applied: 'none' };
  }
  const { immunities, resistances, vulnerabilities } = input.defenses;
  if (has(immunities, type)) {
    return { damage: 0, applied: 'immunity' };
  }
  const resist = has(resistances, type);
  const vuln = has(vulnerabilities, type);
  if (resist && vuln) {
    return { damage: raw, applied: 'cancel' };
  }
  if (resist) {
    return { damage: Math.floor(raw / 2), applied: 'resistance' };
  }
  if (vuln) {
    return { damage: raw * 2, applied: 'vulnerability' };
  }
  return { damage: raw, applied: 'none' };
}

export function defensesFromAffinityRows(
  rows: readonly { damageTypeSlug: string; kind: DamageAffinityKind }[],
): DamageTypeDefenses {
  const immunities: string[] = [];
  const resistances: string[] = [];
  const vulnerabilities: string[] = [];
  for (const row of rows) {
    const slug = norm(row.damageTypeSlug);
    if (row.kind === 'immunity') immunities.push(slug);
    else if (row.kind === 'resistance') resistances.push(slug);
    else if (row.kind === 'vulnerability') vulnerabilities.push(slug);
  }
  return { immunities, resistances, vulnerabilities };
}
