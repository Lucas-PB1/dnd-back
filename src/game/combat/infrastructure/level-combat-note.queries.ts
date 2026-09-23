import type { DataSource } from 'typeorm';

export type LevelCombatNoteRow = {
  ownerKind: 'class' | 'subclass';
  ownerSlug: string;
  unlockLevel: number;
  note: string;
  sortOrder: number;
};

export async function loadLevelCombatNotes(
  dataSource: DataSource,
  classSlug: string,
  subclassSlug: string | null,
): Promise<LevelCombatNoteRow[]> {
  const raw = await dataSource.query(
    `
    SELECT CASE n.source_kind
             WHEN 'class_level'::rpg.combat_note_source THEN 'class'
             ELSE 'subclass'
           END AS "ownerKind",
           COALESCE(c.slug, s.slug) AS "ownerSlug",
           n.unlock_level AS "unlockLevel",
           n.note AS note,
           n.sort_order AS "sortOrder"
    FROM rpg.phb_combat_note n
    LEFT JOIN rpg.phb_class c ON c.id = n.class_id
    LEFT JOIN rpg.phb_subclass s ON s.id = n.subclass_id
    WHERE (n.source_kind = 'class_level'::rpg.combat_note_source AND c.slug = $1)
       OR ($2::text IS NOT NULL
           AND n.source_kind = 'subclass_level'::rpg.combat_note_source
           AND s.slug = $2)
    ORDER BY n.unlock_level, n.sort_order, n.id
    `,
    [classSlug, subclassSlug],
  );
  return raw as LevelCombatNoteRow[];
}
