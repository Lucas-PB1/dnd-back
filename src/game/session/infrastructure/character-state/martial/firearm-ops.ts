import { DataSource, Repository } from 'typeorm';
import { PlayerCharacterState } from '../../player-character-state.entity';

export async function loadReloadCapacity(
  dataSource: DataSource,
  itemSlug: string,
): Promise<number> {
  const rows = await dataSource.query<{ reload: number | null }[]>(
    `SELECT CASE
       WHEN jsonb_typeof(i.properties->'reload') = 'number'
         THEN (i.properties->>'reload')::int
       ELSE NULL
     END AS reload
     FROM rpg.phb_item i
     WHERE i.slug = $1
     LIMIT 1`,
    [itemSlug],
  );
  return Number(rows[0]?.reload ?? 0);
}

export async function reloadAllFirearms(input: {
  stateRepo: Repository<PlayerCharacterState>;
  dataSource: DataSource;
  findOrCreate: () => Promise<PlayerCharacterState>;
}): Promise<void> {
  const state = await input.findOrCreate();
  const slugs = Object.keys(state.firearmChambers ?? {});
  for (const itemSlug of slugs) {
    const capacity = await loadReloadCapacity(input.dataSource, itemSlug);
    if (capacity > 0) {
      state.firearmChambers = {
        ...(state.firearmChambers ?? {}),
        [itemSlug]: capacity,
      };
    }
  }
  await input.stateRepo.save(state);
}
