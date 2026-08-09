import { applyPactWeaponFlag } from './inventory-item-ops';
import type { PlayerCharacterItem } from '../player-character-item.entity';

function itemRow(overrides: Partial<PlayerCharacterItem> = {}): PlayerCharacterItem {
  return {
    characterId: 'ch1',
    itemSlug: 'longsword',
    quantity: 1,
    location: 'backpack',
    equipmentSlot: null,
    attuned: false,
    isPactWeapon: false,
    attachedCharmSlug: null,
    ...overrides,
  } as PlayerCharacterItem;
}

describe('applyPactWeaponFlag', () => {
  it('clears previous pact weapons when marking a new one', async () => {
    const previous = itemRow({
      itemSlug: 'dagger',
      isPactWeapon: true,
    });
    const row = itemRow({ itemSlug: 'longsword' });
    const items = {
      find: jest.fn().mockResolvedValue([previous]),
      save: jest.fn(async (saved) => saved),
    };

    await applyPactWeaponFlag({
      items: items as never,
      characterId: 'ch1',
      row,
      pactWeapon: true,
    });

    expect(previous.isPactWeapon).toBe(false);
    expect(items.save).toHaveBeenCalledWith(previous);
    expect(row.isPactWeapon).toBe(true);
  });

  it('only unsets the flag when pactWeapon is false', async () => {
    const row = itemRow({ isPactWeapon: true });
    const items = {
      find: jest.fn(),
      save: jest.fn(),
    };

    await applyPactWeaponFlag({
      items: items as never,
      characterId: 'ch1',
      row,
      pactWeapon: false,
    });

    expect(row.isPactWeapon).toBe(false);
    expect(items.find).not.toHaveBeenCalled();
  });
});
