import { DataSource } from 'typeorm';
import type { CharacterTransformation } from '@game/sheet/domain/transformation/validate-transformation';

export async function syncTransformation(
  dataSource: DataSource,
  characterId: string,
  transformation: CharacterTransformation | null,
): Promise<void> {
  await dataSource.query(
    `DELETE FROM rpg.player_character_transformation WHERE character_id = $1`,
    [characterId],
  );
  if (!transformation) return;

  const slug = transformation.slug.trim();
  const stage = Number(transformation.stage);
  await dataSource.query(
    `INSERT INTO rpg.player_character_transformation
       (character_id, transformation_slug, stage)
     VALUES ($1::uuid, $2, $3::smallint)`,
    [characterId, slug, stage],
  );

  for (const choice of transformation.choices ?? []) {
    const kind = choice.choiceKind.trim();
    const value = choice.choiceSlug.trim();
    if (!kind || !value) continue;
    await dataSource.query(
      `INSERT INTO rpg.player_character_transformation_choice
         (character_id, choice_kind, choice_slug)
       VALUES ($1::uuid, $2, $3)`,
      [characterId, kind, value],
    );
  }
}
