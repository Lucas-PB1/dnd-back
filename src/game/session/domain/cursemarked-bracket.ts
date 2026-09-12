

export const CURSEMARKED_THREAD_SLUG = 'cursemarked';
export const CURSEMARKED_BRACKET_LOCK = 'cursemarked-bracket-lock';
export const CURSEMARKED_GREATER_SACRIFICE = 'cursemarked-greater-sacrifice';

export type CursemarkedRollKind = 'attack' | 'skill' | 'save';

export type CursemarkedBracketRule = {
  benefitKey: string;
  maxKept: number;
  rollKinds: readonly CursemarkedRollKind[];
  note: string;
  rankOrder: number;
};

const ROLL_KINDS = new Set<CursemarkedRollKind>(['attack', 'skill', 'save']);

export function parseCursemarkedRollKinds(
  raw: readonly string[] | null | undefined,
): CursemarkedRollKind[] {
  if (!raw?.length) return [];
  return raw.filter((k): k is CursemarkedRollKind =>
    ROLL_KINDS.has(k as CursemarkedRollKind),
  );
}

export function pickHighestCursemarkedBracket(
  benefitKeys: readonly string[],
  rules: readonly CursemarkedBracketRule[],
): CursemarkedBracketRule | null {
  let best: CursemarkedBracketRule | null = null;
  for (const key of benefitKeys) {
    const rule = rules.find((r) => r.benefitKey === key);
    if (!rule) continue;
    if (!best || rule.rankOrder > best.rankOrder) best = rule;
  }
  return best;
}

export function cursemarkedBracketTriggers(input: {
  rule: CursemarkedBracketRule;
  kind: CursemarkedRollKind;
  kept: number;
}): boolean {
  const { rule, kind, kept } = input;
  if (kept < 1 || kept > rule.maxKept) return false;
  return rule.rollKinds.includes(kind);
}

export function cursemarkedBracketNote(rule: CursemarkedBracketRule): string {
  return rule.note;
}
