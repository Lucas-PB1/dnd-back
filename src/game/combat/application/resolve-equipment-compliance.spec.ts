import { DataSource, Repository } from 'typeorm';
import { VPhbArmor } from '../../../entities/views/v-phb-armor.entity';
import { PhbWeapon } from '../../../entities/phb-weapon.entity';
import { ResolveEquipmentCompliance } from './resolve-equipment-compliance';
import type { PlayerCharacterItem } from '../../inventory/infrastructure/player-character-item.entity';

function weapon(slug: string, category: string, propertyIds: string[]) {
  return {
    category,
    damage: '1d8',
    damageType: 'slashing',
    item: { slug, name: slug, properties: { propertyIds, versatileDamage: '1d10' } },
  };
}

describe('ResolveEquipmentCompliance', () => {
  let inventoryItems: { find: jest.Mock };
  let armorCatalog: { find: jest.Mock };
  let weapons: { find: jest.Mock };
  let dataSource: { query: jest.Mock };
  let service: ResolveEquipmentCompliance;

  beforeEach(() => {
    inventoryItems = { find: jest.fn() };
    armorCatalog = { find: jest.fn() };
    weapons = { find: jest.fn() };
    dataSource = { query: jest.fn().mockResolvedValue([{ slug: 'light' }, { slug: 'medium' }]) };
    service = new ResolveEquipmentCompliance(
      inventoryItems as unknown as Repository<PlayerCharacterItem>,
      armorCatalog as unknown as Repository<VPhbArmor>,
      weapons as unknown as Repository<PhbWeapon>,
      dataSource as unknown as DataSource,
    );
  });

  it('loadArmorTrainingSlugs returns class armor categories', async () => {
    await expect(service.loadArmorTrainingSlugs('fighter')).resolves.toEqual(['light', 'medium']);
    expect(dataSource.query).toHaveBeenCalledWith(expect.stringContaining('phb_class_proficiency'), ['fighter']);
  });

  it('resolve loads armor/weapons and honors weaponPieces override', async () => {
    inventoryItems.find.mockResolvedValue([
      { itemSlug: 'leather-armor', location: 'equipped', equipmentSlot: 'armor' },
      { itemSlug: 'longsword', location: 'equipped', equipmentSlot: 'main_hand' },
    ]);
    armorCatalog.find.mockResolvedValue([
      { itemSlug: 'leather-armor', itemName: 'Couro', categorySlug: 'light', strengthReq: null, stealthDisadvantage: false },
    ]);
    weapons.find.mockResolvedValue([weapon('longsword', 'martial', ['versatile'])]);
    const loaded = await service.resolve('ch1', { classSlug: 'fighter', strengthScore: 16, sizeCategory: 'medium' });
    expect(loaded.lacksArmorTraining).toBe(false);
    expect(armorCatalog.find).toHaveBeenCalled();

    inventoryItems.find.mockResolvedValue([]);
    const overridden = await service.resolve('ch1', {
      classSlug: 'fighter',
      strengthScore: 10,
      weaponPieces: [{
        itemSlug: 'dagger', itemName: 'Adaga', category: 'simple', damage: '1d4', damageType: 'piercing',
        versatileDamage: null, propertySlugs: ['light'], equipmentSlot: 'main_hand',
      }],
    });
    expect(overridden.stealthDisadvantage).toBe(false);
    expect(weapons.find).toHaveBeenCalledTimes(1);
  });

  it('resolve skips armor lookup and unknown weapons', async () => {
    inventoryItems.find.mockResolvedValue([
      { itemSlug: 'longsword', location: 'equipped', equipmentSlot: 'main_hand' },
      { itemSlug: 'missing', location: 'equipped', equipmentSlot: 'main_hand' },
    ]);
    weapons.find.mockResolvedValue([]);
    const result = await service.resolve('ch1', { classSlug: 'fighter', strengthScore: 16, featSlugs: ['dual-wielder'] });
    expect(armorCatalog.find).not.toHaveBeenCalled();
    expect(result.warnings.some((w) => w.code === 'dual_wield_needs_feat')).toBe(false);
  });

  it('resolve flags untrained heavy armor and strength/stealth penalties', async () => {
    dataSource.query.mockResolvedValueOnce([{ slug: 'light' }]).mockResolvedValueOnce([{ slug: 'heavy' }]);
    armorCatalog.find
      .mockResolvedValueOnce([
        { itemSlug: 'plate', itemName: 'Placas', categorySlug: 'heavy', strengthReq: 15, stealthDisadvantage: true },
      ])
      .mockResolvedValueOnce([
        { itemSlug: 'splint', itemName: 'Talas', categorySlug: 'heavy', strengthReq: 15, stealthDisadvantage: true },
      ]);
    weapons.find.mockResolvedValue([]);
    inventoryItems.find
      .mockResolvedValueOnce([{ itemSlug: 'plate', location: 'equipped', equipmentSlot: 'armor' }])
      .mockResolvedValueOnce([{ itemSlug: 'splint', location: 'equipped', equipmentSlot: 'armor' }]);

    const untrained = await service.resolve('ch1', { classSlug: 'wizard', strengthScore: 16 });
    expect(untrained.lacksArmorTraining).toBe(true);

    const weak = await service.resolve('ch1', { classSlug: 'fighter', strengthScore: 12 });
    expect(weak.strengthPenalty).toMatchObject({ required: 15, actual: 12, itemSlug: 'splint' });
    expect(weak.stealthDisadvantage).toBe(true);
    expect(weak.speedPenaltyMeters).toBe(3);
  });

  it.each([
    ['dual_wield_needs_feat', 'longsword', ['versatile']],
    ['dual_wield_two_handed_off_hand', 'greatclub', ['two-handed']],
  ])('resolve warns on %s', async (code, offSlug, offProps) => {
    inventoryItems.find.mockResolvedValue([
      { itemSlug: 'dagger', location: 'equipped', equipmentSlot: 'main_hand' },
      { itemSlug: offSlug, location: 'equipped', equipmentSlot: 'off_hand' },
    ]);
    armorCatalog.find.mockResolvedValue([]);
    weapons.find.mockResolvedValue([
      weapon('dagger', 'simple', ['light', 'finesse']),
      weapon(offSlug, 'simple', offProps),
    ]);
    const result = await service.resolve('ch1', { classSlug: 'fighter', strengthScore: 16, featSlugs: [] });
    expect(result.warnings.some((w) => w.code === code)).toBe(true);
  });
});
