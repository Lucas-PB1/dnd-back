import { DataSource } from 'typeorm';

/** Feat slugs por personagem — uma query, sem carregar a sheet. */
export async function loadFeatSlugsByCharacterIds(
  dataSource: DataSource,
  characterIds: readonly string[],
): Promise<Map<string, string[]>> {
  const result = new Map<string, string[]>();
  if (characterIds.length === 0) return result;

  for (const id of characterIds) {
    result.set(id, []);
  }

  const rows = await dataSource.query<
    { character_id: string; feat_slug: string }[]
  >(
    `SELECT character_id, feat_slug
     FROM rpg.player_character_feat
     WHERE character_id = ANY($1::uuid[])
     ORDER BY character_id, feat_slug, instance_index`,
    [characterIds],
  );

  for (const row of rows) {
    const list = result.get(row.character_id) ?? [];
    list.push(row.feat_slug);
    result.set(row.character_id, list);
  }

  return result;
}
