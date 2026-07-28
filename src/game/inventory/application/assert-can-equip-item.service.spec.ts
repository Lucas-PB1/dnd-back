import { AssertCanEquipItemService } from './assert-can-equip-item.service';
import { assertCanEquipItem } from '../domain/assert-can-equip-item';
import type { ResolveEquipmentCompliance } from '../../combat/application/resolve-equipment-compliance';
import type { PlayerCharacter } from '../../shared/infrastructure/player-character.entity';

jest.mock('../domain/assert-can-equip-item', () => ({
  assertCanEquipItem: jest.fn(),
}));

const mockedAssert = assertCanEquipItem as jest.MockedFunction<typeof assertCanEquipItem>;

function character(): PlayerCharacter {
  return {
    id: 'ch1',
    userId: 'u1',
    name: 'Test',
    level: 1,
    classSlug: 'fighter',
    speciesSlug: 'human',
    backgroundSlug: 'soldier',
    subclassSlug: null,
    alignmentSlug: null,
    abilityScores: {
      forca: 16,
      destreza: 14,
      constituicao: 14,
      inteligencia: 10,
      sabedoria: 12,
      carisma: 8,
    },
    hitPointsMax: 12,
    hitPointsCurrent: 12,
    abilityGenerationMethodSlug: null,
    createdAt: new Date(),
    updatedAt: new Date(),
  } as PlayerCharacter;
}

describe('AssertCanEquipItemService', () => {
  let equipmentCompliance: jest.Mocked<Pick<ResolveEquipmentCompliance, 'loadArmorTrainingSlugs'>>;
  let armorCatalog: { findOne: jest.Mock };
  let weapons: { findOne: jest.Mock };
  let feats: { find: jest.Mock };
  let dataSource: { query: jest.Mock };
  let service: AssertCanEquipItemService;

  beforeEach(() => {
    mockedAssert.mockReset();
    equipmentCompliance = { loadArmorTrainingSlugs: jest.fn() };
    armorCatalog = { findOne: jest.fn() };
    weapons = { findOne: jest.fn() };
    feats = { find: jest.fn().mockResolvedValue([{ featSlug: 'alert' }]) };
    dataSource = { query: jest.fn() };
    service = new AssertCanEquipItemService(
      equipmentCompliance as never,
      armorCatalog as never,
      weapons as never,
      feats as never,
      dataSource as never,
    );
  });

  it('armor path loads training and delegates to assertCanEquipItem', async () => {
    armorCatalog.findOne.mockResolvedValue({
      itemSlug: 'leather-armor',
      itemName: 'Armadura de Couro',
      categorySlug: 'light',
      strengthReq: null,
      stealthDisadvantage: false,
    });
    equipmentCompliance.loadArmorTrainingSlugs.mockResolvedValue(['light']);

    await service.assert(character(), 'leather-armor');

    expect(equipmentCompliance.loadArmorTrainingSlugs).toHaveBeenCalledWith('fighter');
    expect(mockedAssert).toHaveBeenCalledWith({
      kind: 'armor',
      piece: {
        itemSlug: 'leather-armor',
        itemName: 'Armadura de Couro',
        categorySlug: 'light',
        strengthReq: null,
        stealthDisadvantage: false,
      },
      armorTrainingSlugs: ['light'],
      featSlugs: ['alert'],
      strengthScore: 16,
    });
    expect(weapons.findOne).not.toHaveBeenCalled();
  });

  it('returns when item is not armor or weapon', async () => {
    armorCatalog.findOne.mockResolvedValue(null);
    weapons.findOne.mockResolvedValue(null);

    await expect(service.assert(character(), 'unknown-item')).resolves.toBeUndefined();
    expect(mockedAssert).not.toHaveBeenCalled();
  });

  it('weapon path loads proficiency slugs and delegates to assertCanEquipItem', async () => {
    armorCatalog.findOne.mockResolvedValue(null);
    weapons.findOne.mockResolvedValue({
      category: 'martial',
      damage: '1d8',
      damageType: 'slashing',
      item: {
        slug: 'longsword',
        name: 'Espada Longa',
        properties: { propertyIds: ['versatile'], versatileDamage: '1d10' },
      },
    });
    dataSource.query.mockResolvedValue([{ slug: 'armas-marciais' }]);

    await service.assert(character(), 'longsword');

    expect(dataSource.query).toHaveBeenCalledWith(
      expect.stringContaining('phb_class_weapon_proficiency'),
      ['fighter'],
    );
    expect(mockedAssert).toHaveBeenCalledWith(
      expect.objectContaining({
        kind: 'weapon',
        weaponProficiencySlugs: ['armas-marciais'],
        featSlugs: ['alert'],
        itemName: 'Espada Longa',
      }),
    );
  });
});
