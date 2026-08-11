import { DEFAULT_ABILITY_SCORES } from '@game/shared/infrastructure/player-character.entity';
import { resolveCharacterCombatSlice } from './resolve-character-combat-slice';

/**
 * Conta leituras em `player_character_item` no caminho do combat slice.
 * Usado como baseline/after da Fase 2.1 (dedupe de inventário).
 */
describe('resolveCharacterCombatSlice inventory query count', () => {
  it('loads inventory once when resolvers accept a shared snapshot', async () => {
    const inventoryRows = [
      {
        characterId: 'ch1',
        itemSlug: 'leather-armor',
        location: 'equipped',
        equipmentSlot: 'armor',
        attuned: false,
        attachedCoverageSlug: null,
        attachedCoverageAttuned: false,
        attachedCoverageBonus: null,
      },
      {
        characterId: 'ch1',
        itemSlug: 'longsword',
        location: 'equipped',
        equipmentSlot: 'main_hand',
        attuned: false,
        attachedCoverageSlug: null,
        attachedCoverageAttuned: false,
        attachedCoverageBonus: null,
      },
      {
        characterId: 'ch1',
        itemSlug: 'rations',
        location: 'backpack',
        equipmentSlot: null,
        attuned: false,
        attachedCoverageSlug: null,
        attachedCoverageAttuned: false,
        attachedCoverageBonus: null,
      },
    ];

    const findCalls: unknown[] = [];
    const existCalls: unknown[] = [];
    const inventoryItems = {
      find: jest.fn(async (opts: unknown) => {
        findCalls.push(opts);
        return inventoryRows;
      }),
      exist: jest.fn(async (opts: unknown) => {
        existCalls.push(opts);
        return false;
      }),
    };

    const permanentItemEffects = {
      resolve: jest.fn(async (_id: string, opts?: { inventoryRows?: unknown[] }) => {
        // Se o slice passar snapshot, o service não precisa achar de novo —
        // o mock só registra se ainda cair no repo via slice.
        if (!opts?.inventoryRows) {
          await inventoryItems.find({ where: { characterId: 'ch1' } });
        }
        return {
          abilityBonuses: {},
          abilityScoreCaps: {},
          acBonus: 0,
          sourceNames: [],
          attackBonus: 0,
          damageBonus: 0,
          speedBonusMeters: 0,
          hpBonus: 0,
        };
      }),
    };

    const equippedArmorClass = {
      resolve: jest.fn(
        async (
          _id: string,
          _scores: unknown,
          ctx: { equippedItems?: unknown[] } = {},
        ) => {
          if (!ctx.equippedItems) {
            await inventoryItems.find({
              where: { characterId: 'ch1', location: 'equipped' },
            });
          }
          return { armorClass: 11, armorClassNote: 'test' };
        },
      ),
    };

    const equippedWeaponAttacks = {
      resolve: jest.fn(
        async (
          _id: string,
          _scores: unknown,
          ctx: { equippedItems?: unknown[] },
        ) => {
          if (!ctx.equippedItems) {
            await inventoryItems.find({
              where: {
                characterId: 'ch1',
                location: 'equipped',
              },
            });
          }
          return [];
        },
      ),
    };

    const equipmentCompliance = {
      resolve: jest.fn(
        async (_id: string, input: { equippedItems?: unknown[] }) => {
          if (!input.equippedItems) {
            await inventoryItems.find({
              where: { characterId: 'ch1', location: 'equipped' },
            });
          }
          return {
            warnings: [],
            cannotCastSpells: false,
            speedPenaltyMeters: 0,
          };
        },
      ),
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
      equippedArmorClass: equippedArmorClass as never,
      equippedWeaponAttacks: equippedWeaponAttacks as never,
      equipmentCompliance: equipmentCompliance as never,
      inventoryItems: inventoryItems as never,
      permanentItemEffects: permanentItemEffects as never,
    });

    const inventoryReads = findCalls.length + existCalls.length;
    // After Fase 2.1: 1 find (all rows). Before: 1 find all + 1 exist + 3 find equipped = 5.
    expect({
      findCalls: findCalls.length,
      existCalls: existCalls.length,
      inventoryReads,
    }).toEqual({
      findCalls: 1,
      existCalls: 0,
      inventoryReads: 1,
    });
    expect(permanentItemEffects.resolve).toHaveBeenCalledWith(
      'ch1',
      expect.objectContaining({ inventoryRows }),
    );
    expect(equippedArmorClass.resolve).toHaveBeenCalledWith(
      'ch1',
      expect.anything(),
      expect.objectContaining({ equippedItems: expect.any(Array) }),
    );
  });
});
