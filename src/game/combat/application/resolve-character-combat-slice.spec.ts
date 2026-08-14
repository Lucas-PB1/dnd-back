import { DEFAULT_ABILITY_SCORES } from '@game/shared/infrastructure/player-character.entity';
import { resolveCharacterCombatSlice } from './resolve-character-combat-slice';

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
      query: jest.fn().mockResolvedValue([
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
      ]),
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
      dataSource: dataSource as never,
      equippedArmorClass: equippedArmorClass as never,
      equippedWeaponAttacks: equippedWeaponAttacks as never,
      equipmentCompliance: equipmentCompliance as never,
      permanentItemEffects: permanentItemEffects as never,
    });

    expect(dataSource.query).toHaveBeenCalledTimes(1);
    expect(dataSource.query).toHaveBeenCalledWith(
      expect.stringContaining('get_character_combat_bundle'),
      ['ch1', 'fighter', null],
    );
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
