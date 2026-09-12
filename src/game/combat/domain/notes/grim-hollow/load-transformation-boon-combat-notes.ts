import type { DataSource } from 'typeorm';
import type { Cap6BoonCombatNote } from './transformation-combat-notes-data/types';

export async function loadTransformationBoonCombatNotes(
  dataSource: DataSource,
): Promise<Map<string, Cap6BoonCombatNote>> {
  const rows = await dataSource.query<
    Array<{
      boon_id: string;
      name_pt: string;
      economy: string[] | null;
      note_pt: string | null;
    }>
  >(
    `SELECT boon_id, name_pt, economy, note_pt
     FROM rpg.phb_transformation_boon_combat_note`,
  );

  const map = new Map<string, Cap6BoonCombatNote>();
  for (const row of rows) {
    map.set(row.boon_id, {
      namePt: row.name_pt,
      economy: row.economy ?? [],
      ...(row.note_pt ? { notePt: row.note_pt } : {}),
    });
  }
  return map;
}
