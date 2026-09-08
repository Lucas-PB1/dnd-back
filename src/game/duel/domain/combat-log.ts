import type { DuelCombatLogEntry } from '../infrastructure/duel.entity';

const COMBAT_LOG_MAX = 40;

export function appendCombatLog(
  existing: DuelCombatLogEntry[] | null | undefined,
  text: string,
): DuelCombatLogEntry[] {
  const next = [
    ...(existing ?? []),
    { at: new Date().toISOString(), text },
  ];
  return next.length > COMBAT_LOG_MAX
    ? next.slice(next.length - COMBAT_LOG_MAX)
    : next;
}
