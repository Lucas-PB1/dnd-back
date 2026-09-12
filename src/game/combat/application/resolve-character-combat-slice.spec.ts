import { DEFAULT_ABILITY_SCORES } from '@game/shared/infrastructure/player-character.entity';
import { resolveCharacterCombatSlice } from './resolve-character-combat-slice';
import { asDep } from '@common/testing/as-dep';

describe('resolveCharacterCombatSlice combat bundle', () => {
  it('loads combat data via one RPC and reuses the snapshot', async () => {
    const inventoryRows = [
      {
        characterId: 'ch1',
        itemSlug: 'leather-armor',
        quantity: 1,
        location: 'equipped',
        equipmentSlot: 'armor',
        attuned: false,
        isPactWeapon: false,
        attachedCharmSlug: null,
        attachedCoverageSlug: null,
        attachedCoverageBonus: null,
        attachedCoverageAttuned: false,
        attachedCoverageSpellSlug: null,
        boundSpellSlug: null,
        instanceProperties: null,
        containedInItemSlug: null,
      },
      {
        characterId: 'ch1',
        itemSlug: 'longsword',
        quantity: 1,
        location: 'equipped',
        equipmentSlot: 'main_hand',
        attuned: false,
        isPactWeapon: false,
        attachedCharmSlug: null,
        attachedCoverageSlug: null,
        attachedCoverageBonus: null,
        attachedCoverageAttuned: false,
        attachedCoverageSpellSlug: null,
        boundSpellSlug: null,
        instanceProperties: null,
        containedInItemSlug: null,
      },
    ];

    const dataSource = {
      query: jest.fn().mockImplementation((sql: string) => {
        if (String(sql).includes('get_character_combat_bundle')) {
          return Promise.resolve([
            {
              bundle: {
                inventory: inventoryRows,
                activeItemSlugs: ['leather-armor', 'longsword'],
                items: [
                  { slug: 'leather-armor', name: 'Couro', properties: {} },
                  { slug: 'longsword', name: 'Espada longa', properties: {} },
                ],
                armor: [
                  {
                    itemSlug: 'leather-armor',
                    itemName: 'Couro',
                    categorySlug: 'light',
                    acBase: 11,
                    strengthReq: null,
                    stealthDisadvantage: false,
                  },
                ],
                unarmoredDefenses: [],
              },
            },
          ]);
        }
        return Promise.resolve([]);
      }),
      getRepository: jest.fn().mockImplementation(() => ({
        findOne: jest.fn().mockResolvedValue(null),
        find: jest.fn().mockResolvedValue([]),
        createQueryBuilder: jest.fn().mockReturnValue({
          innerJoin: jest.fn().mockReturnThis(),
          where: jest.fn().mockReturnThis(),
          getMany: jest.fn().mockResolvedValue([]),
        }),
      })),
    };

    const permanentItemEffects = {
      resolve: jest.fn().mockResolvedValue({
        abilityBonuses: {},
        abilityScoreCaps: {},
        acBonus: 0,
        sourceNames: [],
        attackBonus: 0,
        damageBonus: 0,
        speedBonusMeters: 0,
        hpBonus: 0,
      }),
    };

    const equippedArmorClass = {
      resolve: jest.fn().mockResolvedValue({
        armorClass: 11,
        armorClassNote: 'test',
      }),
    };
    const equippedWeaponAttacks = {
      resolve: jest.fn().mockResolvedValue([]),
    };
    const equipmentCompliance = {
      resolve: jest.fn().mockResolvedValue({
        warnings: [],
        cannotCastSpells: false,
        speedPenaltyMeters: 0,
      }),
    };

    await resolveCharacterCombatSlice({
      characterId: 'ch1',
      abilityScores: DEFAULT_ABILITY_SCORES,
      classSlug: 'fighter',
      subclassSlug: null,
      speciesSlug: 'human',
      level: 5,
      proficiencyBonus: 3,
      featSlugs: [],
      fightingStyleSlugs: [],
      masteredWeaponSlugs: [],
      sizeCategory: 'medium',
      dataSource: asDep(dataSource),
      equippedArmorClass: asDep(equippedArmorClass),
      equippedWeaponAttacks: asDep(equippedWeaponAttacks),
      equipmentCompliance: asDep(equipmentCompliance),
      permanentItemEffects: asDep(permanentItemEffects),
    });

    expect(dataSource.query).toHaveBeenCalledWith(
      expect.stringContaining('get_character_combat_bundle'),
      ['ch1', 'fighter', null],
    );
    expect(
      dataSource.query.mock.calls.filter((call) =>
        String(call[0]).includes('get_character_combat_bundle'),
      ),
    ).toHaveLength(1);
    expect(permanentItemEffects.resolve).toHaveBeenCalledWith(
      'ch1',
      expect.objectContaining({
        inventoryRows: expect.any(Array),
        catalogItems: expect.any(Array),
      }),
    );
    expect(equippedArmorClass.resolve).toHaveBeenCalledWith(
      'ch1',
      expect.anything(),
      expect.objectContaining({
        equippedItems: expect.any(Array),
        armorCatalogRows: expect.any(Array),
      }),
    );
  });
});
