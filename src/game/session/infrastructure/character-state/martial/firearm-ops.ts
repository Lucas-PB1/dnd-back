import { DataSource, Repository } from 'typeorm';
import { PlayerCharacterState } from '@game/session/infrastructure/player-character-state.entity';
import { loadItemReloadCapacity } from '../../queries/item-reload-capacity.queries';

export { loadItemReloadCapacity as loadReloadCapacity } from '../../queries/item-reload-capacity.queries';

export async function reloadAllFirearms(input: {
  stateRepo: Repository<PlayerCharacterState>;
  dataSource: DataSource;
  findOrCreate: () => Promise<PlayerCharacterState>;
}): Promise<void> {
  const state = await input.findOrCreate();
  const slugs = Object.keys(state.firearmChambers ?? {});
  for (const itemSlug of slugs) {
    const capacity = await loadItemReloadCapacity(input.dataSource, itemSlug);
    if (capacity > 0) {
      state.firearmChambers = {
        ...(state.firearmChambers ?? {}),
        [itemSlug]: capacity,
      };
    }
  }
  await input.stateRepo.save(state);
}
