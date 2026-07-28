import { ForbiddenException } from '@nestjs/common';
import {
  applyCombatantInitiativeRoll,
  assertCanRollInitiative,
} from './encounter-initiative-roll';
import type { CharacterRollsService } from '../../dice/application/character-rolls.service';
import type { CampaignEncounterRepository } from '../infrastructure/campaign-encounter.repository';
import type { CampaignRepository } from '../infrastructure/campaign.repository';
import type { CampaignEncounterCombatant } from '../infrastructure/campaign-encounter-combatant.entity';
import { rollD20Check } from '../../dice/domain/dice';

jest.mock('../../dice/domain/dice', () => ({
  ...jest.requireActual('../../dice/domain/dice'),
  rollD20Check: jest.fn(),
}));

const mockRollD20Check = rollD20Check as jest.MockedFunction<typeof rollD20Check>;

function combatant(
  overrides: Partial<CampaignEncounterCombatant>,
): CampaignEncounterCombatant {
  return {
    id: 'cb1',
    encounterId: 'e1',
    kind: 'creature',
    characterId: null,
    displayName: 'Goblin',
    hpCurrent: 5,
    hpMax: 7,
    armorClass: 13,
    initiativeTotal: null,
    initiativeModifier: 2,
    sortOrder: 0,
    isActive: true,
    ...overrides,
  };
}

describe('encounter-initiative-roll', () => {
  const rolls = { rollInitiative: jest.fn() } as unknown as CharacterRollsService;
  const encounters = {
    saveCombatant: jest.fn(),
  } as unknown as CampaignEncounterRepository;
  const campaigns = {
    findCharactersByIds: jest.fn(),
  } as unknown as CampaignRepository;

  beforeEach(() => {
    jest.clearAllMocks();
    encounters.saveCombatant = jest.fn().mockResolvedValue(undefined);
  });

  describe('applyCombatantInitiativeRoll', () => {
    it('uses CharacterRollsService.rollInitiative for PCs', async () => {
      const pc = combatant({ kind: 'pc', characterId: 'char1' });
      rolls.rollInitiative = jest.fn().mockResolvedValue({
        kind: 'initiative',
        label: 'Init',
        expression: '1d20+3',
        total: 18,
        modifier: 3,
        rolls: [15],
      });

      await applyCombatantInitiativeRoll({
        rolls,
        encounters,
        userId: 'u1',
        combatant: pc,
        dto: { advantage: 'normal' },
      });

      expect(rolls.rollInitiative).toHaveBeenCalledWith('u1', 'char1', {
        advantage: 'normal',
      });
      expect(pc.initiativeTotal).toBe(18);
      expect(pc.initiativeModifier).toBe(3);
      expect(encounters.saveCombatant).toHaveBeenCalledWith(pc);
    });

    it('uses d20+modifier for creatures', async () => {
      const creature = combatant({ kind: 'creature', initiativeModifier: 2 });
      mockRollD20Check.mockReturnValue({
        expression: '1d20+2',
        total: 14,
        modifier: 2,
        mode: 'normal',
        d20: { count: 1, sides: 20, rolls: [12], kept: [12] },
      });

      await applyCombatantInitiativeRoll({
        rolls,
        encounters,
        userId: 'u1',
        combatant: creature,
        dto: {},
      });

      expect(rolls.rollInitiative).not.toHaveBeenCalled();
      expect(mockRollD20Check).toHaveBeenCalledWith(2, 'normal');
      expect(creature.initiativeTotal).toBe(14);
      expect(creature.initiativeModifier).toBe(2);
      expect(encounters.saveCombatant).toHaveBeenCalledWith(creature);
    });
  });

  describe('assertCanRollInitiative', () => {
    it('allows dm and assistant', async () => {
      await expect(
        assertCanRollInitiative({
          campaigns,
          userId: 'u1',
          role: 'dm',
          combatant: combatant({ kind: 'creature' }),
        }),
      ).resolves.toBeUndefined();

      await expect(
        assertCanRollInitiative({
          campaigns,
          userId: 'u1',
          role: 'assistant',
          combatant: combatant({ kind: 'creature' }),
        }),
      ).resolves.toBeUndefined();
    });

    it('allows player rolling for own PC', async () => {
      campaigns.findCharactersByIds = jest
        .fn()
        .mockResolvedValue([{ id: 'char1', userId: 'u1' }]);

      await expect(
        assertCanRollInitiative({
          campaigns,
          userId: 'u1',
          role: 'player',
          combatant: combatant({ kind: 'pc', characterId: 'char1' }),
        }),
      ).resolves.toBeUndefined();
    });

    it('forbids player rolling for other PC or creature', async () => {
      campaigns.findCharactersByIds = jest
        .fn()
        .mockResolvedValue([{ id: 'char2', userId: 'other' }]);

      await expect(
        assertCanRollInitiative({
          campaigns,
          userId: 'u1',
          role: 'player',
          combatant: combatant({ kind: 'pc', characterId: 'char2' }),
        }),
      ).rejects.toThrow(ForbiddenException);

      await expect(
        assertCanRollInitiative({
          campaigns,
          userId: 'u1',
          role: 'player',
          combatant: combatant({ kind: 'creature' }),
        }),
      ).rejects.toThrow(ForbiddenException);
    });
  });
});
