import { DataSource } from 'typeorm';

export type CharacterTransformationSnapshot = {
  slug: string;
  stage: number;
  choices: { choiceKind: string; choiceSlug: string }[];
};

export async function loadCharacterTransformation(
  dataSource: DataSource,
  characterId: string,
): Promise<CharacterTransformationSnapshot | null> {
  if (!characterId) return null;
  const rows = await dataSource.query<
    { transformation_slug: string; stage: number }[]
  >(
    `SELECT transformation_slug, stage
     FROM rpg.player_character_transformation
     WHERE character_id = $1::uuid
     LIMIT 1`,
    [characterId],
  );
  const row = rows[0];
  if (!row?.transformation_slug?.trim()) return null;

  const choiceRows = await dataSource.query<
    { choice_kind: string; choice_slug: string }[]
  >(
    `SELECT choice_kind, choice_slug
     FROM rpg.player_character_transformation_choice
     WHERE character_id = $1::uuid`,
    [characterId],
  );

  return {
    slug: row.transformation_slug.trim(),
    stage: Number(row.stage),
    choices: choiceRows.map((c) => ({
      choiceKind: c.choice_kind,
      choiceSlug: c.choice_slug,
    })),
  };
}
