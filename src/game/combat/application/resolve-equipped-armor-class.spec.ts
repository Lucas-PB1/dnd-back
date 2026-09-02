import { ResolveEquippedArmorClass } from './resolve-equipped-armor-class';
import { DEFAULT_ABILITY_SCORES } from '@game/shared/infrastructure/player-character.entity';
import { asDep } from '@common/testing/as-dep';

describe('ResolveEquippedArmorClass', () => {
  let inventoryItems: { find: jest.Mock };
  let armorCatalog: { find: jest.Mock };
  let combatCatalog: { loadUnarmoredDefenses: jest.Mock };
  let service: ResolveEquippedArmorClass;

  beforeEach(() => {
    inventoryItems = { find: jest.fn() };
    armorCatalog = { find: jest.fn() };
    combatCatalog = { loadUnarmoredDefenses: jest.fn().mockResolvedValue([]) };
    service = new ResolveEquippedArmorClass(
      asDep(inventoryItems),
      asDep(armorCatalog),
      asDep(combatCatalog),
    );
  });

  it('computes unarmored AC when no armor equipped', async () => {
    inventoryItems.find.mockResolvedValue([]);
    const result = await service.resolve('ch1', DEFAULT_ABILITY_SCORES, {
      classSlug: 'barbarian',
    });
    expect(armorCatalog.find).not.toHaveBeenCalled();
    expect(combatCatalog.loadUnarmoredDefenses).toHaveBeenCalledWith({
      classSlug: 'barbarian',
      subclassSlug: undefined,
    });
    expect(result.armorClass).toBeGreaterThanOrEqual(10);
  });

  it('loads catalog pieces for armor/shield slots', async () => {
    inventoryItems.find.mockResolvedValue([
      { itemSlug: 'leather-armor', equipmentSlot: 'armor' },
      { itemSlug: 'shield', equipmentSlot: 'shield' },
      { itemSlug: 'longsword', equipmentSlot: 'main_hand' },
    ]);
    armorCatalog.find.mockResolvedValue([
      {
        itemSlug: 'leather-armor',
        itemName: 'Couro',
        categorySlug: 'light',
        acBase: 11,
      },
      {
        itemSlug: 'shield',
        itemName: 'Escudo',
        categorySlug: 'shield',
        acBase: 2,
      },
    ]);

    const result = await service.resolve('ch1', DEFAULT_ABILITY_SCORES, {
      featSlugs: ['dual-wielder'],
      fightingStyleSlugs: ['defense'],
    });
    expect(armorCatalog.find).toHaveBeenCalled();
    expect(result.armorClass).toBeGreaterThanOrEqual(11);
  });

  it('skips inventory find when equippedItems snapshot is provided', async () => {
    armorCatalog.find.mockResolvedValue([]);
    const result = await service.resolve('ch1', DEFAULT_ABILITY_SCORES, {
      equippedItems: [],
    });
    expect(inventoryItems.find).not.toHaveBeenCalled();
    expect(result.armorClass).toBeGreaterThanOrEqual(10);
  });
});
