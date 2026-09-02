import { DataSource } from 'typeorm';

export async function loadCharacterFeatSlugs(
  dataSource: DataSource,
  characterId: string,
): Promise<string[]> {
  if (!characterId) return [];
  const rows = await dataSource.query<{ feat_slug: string }[]>(
    `SELECT DISTINCT feat_slug
     FROM rpg.player_character_feat
     WHERE character_id = $1
     ORDER BY feat_slug`,
    [characterId],
  );
  return rows.map((row) => row.feat_slug);
}

export async function loadClassProgressionSnapshot(
  dataSource: DataSource,
  classSlug: string,
  level: number,
): Promise<{
  proficiencyBonus: number;
  channelDivinity: number | null;
} | null> {
  const rows = await dataSource.query<
    { proficiency_bonus: number; channel_divinity: number | null }[]
  >(
    `SELECT cp.proficiency_bonus, cp.channel_divinity
     FROM rpg.phb_class_progression cp
     JOIN rpg.phb_class c ON c.id = cp.class_id
     WHERE c.slug = $1 AND cp.level = $2
     LIMIT 1`,
    [classSlug, level],
  );
  const row = rows[0];
  if (!row) return null;
  return {
    proficiencyBonus: row.proficiency_bonus,
    channelDivinity: row.channel_divinity,
  };
}

/** Itens equipados (+ sintonizados se exigir), charms anexados e consumíveis com quantity > 0. */
export async function loadActiveItemSlugs(
  dataSource: DataSource,
  characterId: string,
): Promise<string[]> {
  if (!characterId) return [];
  const rows = await dataSource.query<{ item_slug: string }[]>(
    `SELECT DISTINCT item_slug FROM (
       SELECT pci.item_slug
       FROM rpg.player_character_item pci
       JOIN rpg.phb_item i ON i.slug = pci.item_slug
       WHERE pci.character_id = $1
         AND pci.location = 'equipped'
         AND (
           COALESCE((i.properties->>'requiresAttunement')::boolean, false) = false
           OR pci.attuned = true
         )
       UNION ALL
       SELECT pci.attached_charm_slug AS item_slug
       FROM rpg.player_character_item pci
       WHERE pci.character_id = $1
         AND pci.location = 'equipped'
         AND pci.attached_charm_slug IS NOT NULL
       UNION ALL
       SELECT pci.attached_coverage_slug AS item_slug
       FROM rpg.player_character_item pci
       JOIN rpg.phb_item cov ON cov.slug = pci.attached_coverage_slug
       WHERE pci.character_id = $1
         AND pci.location = 'equipped'
         AND pci.attached_coverage_slug IS NOT NULL
         AND (
           COALESCE((cov.properties->>'requiresAttunement')::boolean, false) = false
           OR pci.attached_coverage_attuned = true
         )
       UNION ALL
       SELECT pci.item_slug
       FROM rpg.player_character_item pci
       JOIN rpg.phb_item i ON i.slug = pci.item_slug
       WHERE pci.character_id = $1
         AND pci.quantity > 0
         AND COALESCE((i.properties->>'consumable')::boolean, false) = true
     ) active
     ORDER BY item_slug`,
    [characterId],
  );
  return rows.map((row) => row.item_slug);
}
