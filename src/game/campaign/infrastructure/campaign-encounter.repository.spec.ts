import { BadRequestException, NotFoundException } from '@nestjs/common';
import { Repository } from 'typeorm';
import type { CampaignRepository } from './campaign.repository';
import { CampaignEncounterRepository } from './campaign-encounter.repository';
import type { CampaignEncounter } from './campaign-encounter.entity';
import type { CampaignEncounterCombatant } from './campaign-encounter-combatant.entity';

function encounter(overrides: Partial<CampaignEncounter> = {}): CampaignEncounter {
  return {
    id: 'enc1',
    campaignId: 'camp1',
    name: 'Ambush',
    status: 'active',
    round: 1,
    currentTurnIndex: 0,
    playersCanView: false,
    creatureHpVisibility: 'percent',
    createdBy: 'u1',
    ...overrides,
  } as CampaignEncounter;
}

function combatant(overrides: Partial<CampaignEncounterCombatant> = {}): CampaignEncounterCombatant {
  return {
    id: 'cb1', encounterId: 'enc1', kind: 'pc', characterId: 'ch1', actorId: null,
    initiativeTotal: 18,
    initiativeModifier: 3, sortOrder: 0, isActive: true, ...overrides,
  } as CampaignEncounterCombatant;
}

describe('CampaignEncounterRepository', () => {
  let encounters: { findOne: jest.Mock; create: jest.Mock; save: jest.Mock };
  let combatants: {
    find: jest.Mock;
    findOne: jest.Mock;
    count: jest.Mock;
    create: jest.Mock;
    save: jest.Mock;
    remove: jest.Mock;
  };
  let campaigns: { findCharactersByIds: jest.Mock };
  let repository: CampaignEncounterRepository;

  beforeEach(() => {
    encounters = {
      findOne: jest.fn(),
      create: jest.fn((row) => ({ id: 'enc1', ...row })),
      save: jest.fn(async (row) => row),
    };
    combatants = {
      find: jest.fn(),
      findOne: jest.fn(),
      count: jest.fn(),
      create: jest.fn((row) => ({ id: 'cb-new', ...row })),
      save: jest.fn(async (rows) => rows),
      remove: jest.fn(),
    };
    campaigns = { findCharactersByIds: jest.fn().mockResolvedValue([{ id: 'ch1', name: 'Aragorn' }]) };
    repository = new CampaignEncounterRepository(
      encounters as unknown as Repository<CampaignEncounter>,
      combatants as unknown as Repository<CampaignEncounterCombatant>,
      campaigns as unknown as CampaignRepository,
    );
  });

  describe('createActive', () => {
    it('creates encounter and optional pc combatants', async () => {
      encounters.findOne.mockResolvedValue(null);
      await repository.createActive({
        campaignId: 'camp1', name: 'Empty', createdBy: 'u1', characterIds: [],
      });
      expect(combatants.save).not.toHaveBeenCalled();

      const result = await repository.createActive({
        campaignId: 'camp1', name: '  Fight  ', createdBy: 'u1', characterIds: ['ch1', 'ch2'],
      });
      expect(result.name).toBe('Fight');
      expect(combatants.save).toHaveBeenCalledWith(
        expect.arrayContaining([
          expect.objectContaining({ kind: 'pc', characterId: 'ch1', sortOrder: 0 }),
          expect.objectContaining({ kind: 'pc', characterId: 'ch2', sortOrder: 1 }),
        ]),
      );
    });

    it('rejects when campaign already has active encounter', async () => {
      encounters.findOne.mockResolvedValue(encounter());
      await expect(repository.createActive({
        campaignId: 'camp1', name: 'X', createdBy: 'u1', characterIds: [],
      })).rejects.toBeInstanceOf(BadRequestException);
    });
  });

  describe('addActor', () => {
    it('appends actor combatant with next sort order', async () => {
      combatants.count.mockResolvedValue(2);
      const row = await repository.addActor({
        encounterId: 'enc1',
        actorId: 'actor-1',
        initiativeModifier: 2,
      });
      expect(combatants.create).toHaveBeenCalledWith(
        expect.objectContaining({
          kind: 'actor',
          actorId: 'actor-1',
          sortOrder: 2,
        }),
      );
      expect(row.actorId).toBe('actor-1');
    });
  });

  describe('findCombatantByIdOrFail', () => {
    it('returns row or throws NotFoundException', async () => {
      const row = combatant();
      combatants.findOne.mockResolvedValueOnce(row).mockResolvedValueOnce(null);
      await expect(repository.findCombatantByIdOrFail('enc1', 'cb1')).resolves.toBe(row);
      await expect(repository.findCombatantByIdOrFail('enc1', 'x')).rejects.toBeInstanceOf(NotFoundException);
    });
  });

  describe('refreshSortOrders', () => {
    it('sorts by initiative and saves updated order', async () => {
      const low = combatant({ id: 'cb-low', initiativeTotal: 10, sortOrder: 0 });
      const high = combatant({ id: 'cb-high', initiativeTotal: 20, sortOrder: 1 });
      combatants.find.mockResolvedValue([low, high]);
      const saved = await repository.refreshSortOrders('enc1');
      expect(high.sortOrder).toBe(0);
      expect(low.sortOrder).toBe(1);
      expect(combatants.save).toHaveBeenCalledWith(saved);
      expect(campaigns.findCharactersByIds).toHaveBeenCalledWith(['ch1', 'ch1']);
    });

    it('uses actor name map when kind is actor', async () => {
      const actorCombatant = combatant({
        id: 'cb-actor',
        kind: 'actor',
        characterId: null,
        actorId: 'actor-1',
        initiativeTotal: 15,
        sortOrder: 1,
      });
      const pc = combatant({ id: 'cb-pc', initiativeTotal: 12, sortOrder: 0 });
      combatants.find.mockResolvedValue([pc, actorCombatant]);
      await repository.refreshSortOrders('enc1', new Map([['actor-1', 'Goblin']]));
      expect(actorCombatant.sortOrder).toBe(0);
      expect(pc.sortOrder).toBe(1);
      expect(campaigns.findCharactersByIds).toHaveBeenCalledWith(['ch1']);
    });
  });

  describe('deleteCombatant', () => {
    it('removes combatant row', async () => {
      const row = combatant();
      await repository.deleteCombatant(row);
      expect(combatants.remove).toHaveBeenCalledWith(row);
    });
  });

  describe('advanceTurn', () => {
    it('increments turn index within round', async () => {
      const enc = encounter({ currentTurnIndex: 0, round: 1 });
      combatants.find.mockResolvedValue([combatant(), combatant({ id: 'cb2' })]);
      const saved = await repository.advanceTurn(enc);
      expect(saved.currentTurnIndex).toBe(1);
      expect(saved.round).toBe(1);
    });

    it('wraps to next round at end of initiative order', async () => {
      const enc = encounter({ currentTurnIndex: 1, round: 1 });
      combatants.find.mockResolvedValue([combatant(), combatant({ id: 'cb2' })]);
      const saved = await repository.advanceTurn(enc);
      expect(saved.currentTurnIndex).toBe(0);
      expect(saved.round).toBe(2);
    });

    it('ignores inactive combatants when advancing turn', async () => {
      const enc = encounter({ currentTurnIndex: 0, round: 1 });
      combatants.find.mockResolvedValue([
        combatant(),
        combatant({ id: 'cb2', isActive: false }),
      ]);
      const saved = await repository.advanceTurn(enc);
      expect(saved.currentTurnIndex).toBe(0);
      expect(saved.round).toBe(2);
    });
  });
});
