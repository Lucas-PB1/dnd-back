import type { DataSource } from 'typeorm';
import {
  CURSEMARKED_THREAD_SLUG,
  parseCursemarkedRollKinds,
  pickHighestCursemarkedBracket,
  type CursemarkedBracketRule,
} from '@game/session/domain/cursemarked-bracket';

export async function loadCursemarkedBracketRules(
  dataSource: DataSource,
): Promise<CursemarkedBracketRule[]> {
  const rows = await dataSource.query<
    Array<{
      benefit_key: string;
      bracket_max_kept: number;
      bracket_roll_kinds: string[] | null;
      bracket_trigger_note: string;
      milestone_sort: number;
    }>
  >(
    `SELECT b.benefit_key,
            b.bracket_max_kept,
            b.bracket_roll_kinds,
            b.bracket_trigger_note,
            m.sort_order AS milestone_sort
     FROM rpg.phb_character_thread_milestone_benefit b
     JOIN rpg.phb_character_thread_milestone m ON m.id = b.milestone_id
     WHERE m.thread_slug = $1
       AND b.bracket_max_kept IS NOT NULL
       AND b.bracket_trigger_note IS NOT NULL`,
    [CURSEMARKED_THREAD_SLUG],
  );

  return rows.map((row) => ({
    benefitKey: row.benefit_key,
    maxKept: Number(row.bracket_max_kept),
    rollKinds: parseCursemarkedRollKinds(row.bracket_roll_kinds ?? []),
    note: row.bracket_trigger_note,
    rankOrder: Number(row.milestone_sort),
  }));
}

export async function loadActiveCursemarkedBracketBenefit(
  dataSource: DataSource,
  characterId: string,
): Promise<CursemarkedBracketRule | null> {
  if (!characterId) return null;
  const rules = await loadCursemarkedBracketRules(dataSource);
  if (rules.length === 0) return null;
  const keys = rules.map((r) => r.benefitKey);
  const rows = await dataSource.query<{ benefit_key: string }[]>(
    `SELECT m.benefit_key
     FROM rpg.player_character_thread pct
     JOIN rpg.player_character_thread_milestone m
       ON m.character_thread_id = pct.id
     WHERE pct.character_id = $1::uuid
       AND pct.status = 'active'
       AND pct.thread_slug = $2
       AND m.benefit_key = ANY($3::text[])`,
    [characterId, CURSEMARKED_THREAD_SLUG, keys],
  );
  return pickHighestCursemarkedBracket(
    rows.map((row) => row.benefit_key),
    rules,
  );
}
