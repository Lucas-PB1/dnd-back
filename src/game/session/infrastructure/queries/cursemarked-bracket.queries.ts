import type { DataSource } from 'typeorm';
import {
  CURSEMARKED_BRACKET_BENEFITS,
  CURSEMARKED_THREAD_SLUG,
  pickHighestCursemarkedBracket,
  type CursemarkedBracketBenefit,
} from '@game/session/domain/cursemarked-bracket';

/** Benefício de bracket Cursemarked ativo (maior rank), ou null. */
export async function loadActiveCursemarkedBracketBenefit(
  dataSource: DataSource,
  characterId: string,
): Promise<CursemarkedBracketBenefit | null> {
  if (!characterId) return null;
  const rows = await dataSource.query<{ benefit_key: string }[]>(
    `SELECT m.benefit_key
     FROM rpg.player_character_thread pct
     JOIN rpg.player_character_thread_milestone m
       ON m.character_thread_id = pct.id
     WHERE pct.character_id = $1::uuid
       AND pct.status = 'active'
       AND pct.thread_slug = $2
       AND m.benefit_key = ANY($3::text[])`,
    [characterId, CURSEMARKED_THREAD_SLUG, [...CURSEMARKED_BRACKET_BENEFITS]],
  );
  return pickHighestCursemarkedBracket(rows.map((row) => row.benefit_key));
}
