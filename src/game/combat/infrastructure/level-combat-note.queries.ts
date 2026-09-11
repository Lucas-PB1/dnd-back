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
    SELECT n.owner_kind AS "ownerKind",
           COALESCE(c.slug, s.slug) AS "ownerSlug",
           n.unlock_level AS "unlockLevel",
           n.note AS note,
           n.sort_order AS "sortOrder"
    FROM rpg.phb_level_combat_note n
    LEFT JOIN rpg.phb_class c ON c.id = n.class_id
    LEFT JOIN rpg.phb_subclass s ON s.id = n.subclass_id
    WHERE (n.owner_kind = 'class' AND c.slug = $1)
       OR ($2::text IS NOT NULL AND n.owner_kind = 'subclass' AND s.slug = $2)
    ORDER BY n.unlock_level, n.sort_order, n.id
    `,
    [classSlug, subclassSlug],
  );
  return raw as LevelCombatNoteRow[];
}
