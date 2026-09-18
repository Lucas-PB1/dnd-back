import { inventoryItemToDtoFromCatalog } from './inventory-item-mappers';
import type { PhbItem } from '@entities/equipment/phb-item.entity';
import type { PlayerCharacterItem } from '../player-character-item.entity';

function catalog(
  slug: string,
  properties: Record<string, unknown> | null,
): PhbItem {
  return {
    slug,
    name: slug,
    itemType: 'wondrous',
    properties,
  } as PhbItem;
}

function row(itemSlug: string): PlayerCharacterItem {
  return {
    itemSlug,
    quantity: 1,
    location: 'equipped',
    equipmentSlot: 'worn',
    attuned: true,
    isPactWeapon: false,
  } as PlayerCharacterItem;
}

describe('inventoryItemToDtoFromCatalog cast overlay', () => {
  it('exposes Treasure CD and flags from properties', () => {
    const map = new Map<string, PhbItem>([
      [
        'varinha-de-relampagos',
        catalog('varinha-de-relampagos', {
          spellSaveDc: 15,
          useCasterAbility: true,
          requiresComponents: false,
        }),
      ],
    ]);
    const dto = inventoryItemToDtoFromCatalog(map, row('varinha-de-relampagos'));
    expect(dto.spellSaveDc).toBe(15);
    expect(dto.spellAttackBonus).toBeNull();
    expect(dto.requiresComponents).toBe(false);
    expect(dto.useCasterAbility).toBe(true);
  });

  it('defaults overlay when properties omit cast fields', () => {
    const map = new Map<string, PhbItem>([
      ['longsword', catalog('longsword', { magic: false })],
    ]);
    const dto = inventoryItemToDtoFromCatalog(map, row('longsword'));
    expect(dto.spellSaveDc).toBeNull();
    expect(dto.spellAttackBonus).toBeNull();
    expect(dto.requiresComponents).toBe(false);
    expect(dto.useCasterAbility).toBe(false);
  });
});
