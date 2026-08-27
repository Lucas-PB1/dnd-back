import { BadRequestException, ForbiddenException } from '@nestjs/common';
import { CampaignEncounterInitiativeService } from './campaign-encounter-initiative.service';
import type { CampaignRepository } from '../infrastructure/campaign.repository';
import type { CampaignEncounterRepository } from '../infrastructure/campaign-encounter.repository';
import type { CharacterRollsService } from '@game/dice/application/character-rolls.service';
import type { LoadEncounterDto } from './load-encounter-dto';
import type { CampaignEncounter } from '../infrastructure/campaign-encounter.entity';
import type { CampaignMember } from '../infrastructure/campaign-member.entity';
import type { CampaignEncounterCombatant } from '../infrastructure/campaign-encounter-combatant.entity';
import { rollD20Check } from '@game/dice/domain/dice';

jest.mock('@game/dice/domain/dice', () => ({
  ...jest.requireActual('@game/dice/domain/dice'),
  rollD20Check: jest.fn(),
}));

const mockRoll = rollD20Check as jest.MockedFunction<typeof rollD20Check>;

const enc = (): CampaignEncounter => ({
  id: 'e1',
  campaignId: 'c1',
  name: 'Fight',
  status: 'active',
  round: 1,
  currentTurnIndex: 0,
  playersCanView: true,
  creatureHpVisibility: 'percent',
  createdBy: 'u1',
  createdAt: new Date(),
  updatedAt: new Date(),
});

const cb = (o: Partial<CampaignEncounterCombatant>): CampaignEncounterCombatant => ({
  id: 'cb1',
  encounterId: 'e1',
  kind: 'actor',
  characterId: null,
  actorId: 'actor1',
  initiativeTotal: null,
  initiativeModifier: 2,
  sortOrder: 0,
  isActive: true,
  ...o,
});

const d20 = (total: number) => ({
  expression: '1d20+2',
  total,
  modifier: 2,
  mode: 'normal' as const,
  d20: { count: 1, sides: 20, rolls: [total - 2], kept: [total - 2] },
});

describe('CampaignEncounterInitiativeService', () => {
  let service: CampaignEncounterInitiativeService;
  let campaigns: jest.Mocked<
    Pick<CampaignRepository, 'requireMember' | 'requireRole' | 'findCharactersByIds'>
  >;
  let encounters: jest.Mocked<
    Pick<
      CampaignEncounterRepository,
      | 'findEncounterInCampaignOrFail'
      | 'findCombatantByIdOrFail'
      | 'saveCombatant'
      | 'refreshSortOrders'
      | 'listCombatants'
      | 'saveEncounter'
    >
  >;
  let rolls: jest.Mocked<Pick<CharacterRollsService, 'rollInitiative'>>;
  let loadDto: jest.Mocked<Pick<LoadEncounterDto, 'load'>>;
  const dtoResponse = { id: 'e1' };

  beforeEach(() => {
    jest.clearAllMocks();
    campaigns = {
      requireMember: jest.fn().mockResolvedValue({ role: 'dm', userId: 'u1' } as CampaignMember),
      requireRole: jest.fn().mockResolvedValue({ role: 'dm' } as CampaignMember),
      findCharactersByIds: jest.fn(),
    };
    encounters = {
      findEncounterInCampaignOrFail: jest.fn().mockResolvedValue(enc()),
      findCombatantByIdOrFail: jest.fn(),
      saveCombatant: jest.fn().mockResolvedValue(undefined),
      refreshSortOrders: jest.fn().mockResolvedValue(undefined),
      listCombatants: jest.fn(),
      saveEncounter: jest.fn().mockResolvedValue(undefined),
    };
    rolls = { rollInitiative: jest.fn() };
    loadDto = { load: jest.fn().mockResolvedValue(dtoResponse) };
    service = new CampaignEncounterInitiativeService(
      campaigns as unknown as CampaignRepository,
      encounters as unknown as CampaignEncounterRepository,
      rolls as unknown as CharacterRollsService,
      loadDto as unknown as LoadEncounterDto,
    );
  });

  it('rollOne rolls actor initiative for dm', async () => {
    const combatant = cb({ initiativeModifier: 2 });
    encounters.findCombatantByIdOrFail.mockResolvedValue(combatant);
    mockRoll.mockReturnValue(d20(15));

    await expect(service.rollOne('u1', 'c1', 'e1', 'cb1', {})).resolves.toEqual(dtoResponse);
    expect(combatant.initiativeTotal).toBe(15);
    expect(encounters.refreshSortOrders).toHaveBeenCalledWith('e1');
  });

  it('rollOne forbids player rolling for actor or closed encounter', async () => {
    campaigns.requireMember.mockResolvedValue({ role: 'player', userId: 'u1' } as CampaignMember);
    encounters.findCombatantByIdOrFail.mockResolvedValue(cb({ kind: 'actor' }));
    await expect(service.rollOne('u1', 'c1', 'e1', 'cb1', {})).rejects.toBeInstanceOf(
      ForbiddenException,
    );

    encounters.findEncounterInCampaignOrFail.mockResolvedValue({ ...enc(), status: 'closed' });
    await expect(service.rollOne('u1', 'c1', 'e1', 'cb1', {})).rejects.toBeInstanceOf(
      BadRequestException,
    );
  });

  it('rollOne allows player rolling own PC', async () => {
    campaigns.requireMember.mockResolvedValue({ role: 'player', userId: 'u1' } as CampaignMember);
    const pc = cb({ kind: 'pc', characterId: 'char1' });
    encounters.findCombatantByIdOrFail.mockResolvedValue(pc);
    campaigns.findCharactersByIds.mockResolvedValue([{ id: 'char1', userId: 'u1' }] as never);
    rolls.rollInitiative.mockResolvedValue({
      kind: 'initiative',
      label: 'Init',
      expression: '1d20+3',
      total: 18,
      modifier: 3,
      rolls: [15],
    });

    await service.rollOne('u1', 'c1', 'e1', 'cb1', { advantage: 'normal' });
    expect(rolls.rollInitiative).toHaveBeenCalledWith('u1', 'char1', { advantage: 'normal' });
    expect(loadDto.load).toHaveBeenCalledWith(expect.objectContaining({ id: 'e1' }), 'player');
  });

  it('rollAll rolls pending combatants and resets turn index', async () => {
    encounters.listCombatants.mockResolvedValue([
      cb({ id: 'cb1', initiativeTotal: null }),
      cb({ id: 'cb2', initiativeTotal: 12 }),
      cb({ id: 'cb3', isActive: false, initiativeTotal: null }),
    ]);
    mockRoll.mockReturnValue(d20(11));
    const encounter = enc();
    encounters.findEncounterInCampaignOrFail.mockResolvedValue(encounter);

    await service.rollAll('u1', 'c1', 'e1', {});

    expect(encounters.saveCombatant).toHaveBeenCalledTimes(1);
    expect(encounter.currentTurnIndex).toBe(0);
    expect(loadDto.load).toHaveBeenCalledWith(encounter, 'dm');
  });

  it('rollAll propagates Forbidden from requireRole', async () => {
    campaigns.requireRole.mockRejectedValue(new ForbiddenException());
    await expect(service.rollAll('u1', 'c1', 'e1', {})).rejects.toBeInstanceOf(ForbiddenException);
  });
});
