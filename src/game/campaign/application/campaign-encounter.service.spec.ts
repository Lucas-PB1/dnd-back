import {
  BadRequestException,
  ForbiddenException,
  NotFoundException,
} from '@nestjs/common';
import { CampaignEncounterService } from './campaign-encounter.service';
import type { CampaignRepository } from '../infrastructure/campaign.repository';
import type { CampaignEncounterRepository } from '../infrastructure/campaign-encounter.repository';
import type { LoadEncounterDto } from './load-encounter-dto';
import type { ActorPersistenceService } from '@game/actor/infrastructure/actor-persistence.service';
import type { CampaignEncounter } from '../infrastructure/campaign-encounter.entity';
import type { CampaignMember } from '../infrastructure/campaign-member.entity';
import type { CampaignEncounterCombatant } from '../infrastructure/campaign-encounter-combatant.entity';
import type { GameActor } from '@game/actor/infrastructure/game-actor.entity';
import type { PhbCreatureTemplate } from '@entities/phb-creature-template.entity';
import type { Repository } from 'typeorm';
import { asDep } from '@common/testing/as-dep';

const enc = (o: Partial<CampaignEncounter> = {}): CampaignEncounter => ({
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
  ...o,
});

const mem = (role: CampaignMember['role']): CampaignMember => ({
  id: 'm1',
  campaignId: 'c1',
  userId: 'u1',
  role,
  joinedAt: new Date(),
});

describe('CampaignEncounterService', () => {
  let service: CampaignEncounterService;
  let campaigns: jest.Mocked<
    Pick<CampaignRepository, 'requireRole' | 'requireMember' | 'listLinkedCharacters'>
  >;
  let encounters: jest.Mocked<
    Pick<
      CampaignEncounterRepository,
      | 'createActive'
      | 'findActiveOrFail'
      | 'findEncounterInCampaignOrFail'
      | 'saveEncounter'
      | 'addActor'
      | 'refreshSortOrders'
      | 'findCombatantByIdOrFail'
      | 'saveCombatant'
      | 'deleteCombatant'
      | 'advanceTurn'
      | 'listCombatants'
    >
  >;
  let loadDto: jest.Mocked<Pick<LoadEncounterDto, 'load'>>;
  let actorPersistence: jest.Mocked<
    Pick<ActorPersistenceService, 'createWithChildren' | 'spawnFromTemplate'>
  >;
  let actors: jest.Mocked<Pick<Repository<GameActor>, 'create' | 'findOne' | 'save'>>;
  let creatureTemplates: jest.Mocked<Pick<Repository<PhbCreatureTemplate>, 'findOne'>>;
  let characterState: { clearResourcesUsedEntryByCharacterId: jest.Mock };
  const dto = { id: 'e1', name: 'Fight' };

  beforeEach(() => {
    campaigns = {
      requireRole: jest.fn().mockResolvedValue(mem('dm')),
      requireMember: jest.fn().mockResolvedValue(mem('dm')),
      listLinkedCharacters: jest.fn().mockResolvedValue([{ characterId: 'char1' }]),
    };
    encounters = {
      createActive: jest.fn().mockResolvedValue(enc()),
      findActiveOrFail: jest.fn().mockResolvedValue(enc()),
      findEncounterInCampaignOrFail: jest.fn().mockResolvedValue(enc()),
      saveEncounter: jest.fn().mockResolvedValue(undefined),
      addActor: jest.fn().mockResolvedValue(undefined),
      refreshSortOrders: jest.fn().mockResolvedValue(undefined),
      findCombatantByIdOrFail: jest.fn(),
      saveCombatant: jest.fn().mockResolvedValue(undefined),
      deleteCombatant: jest.fn().mockResolvedValue(undefined),
      advanceTurn: jest.fn().mockResolvedValue(enc({ currentTurnIndex: 1 })),
      listCombatants: jest.fn().mockResolvedValue([]),
    };
    loadDto = { load: jest.fn().mockResolvedValue(dto) };
    actorPersistence = {
      createWithChildren: jest.fn().mockResolvedValue({
        id: 'actor1',
        name: 'Goblin',
        hitPointsMax: 7,
        hitPointsCurrent: 7,
      } as GameActor),
      spawnFromTemplate: jest.fn(),
    };
    actors = {
      create: jest.fn().mockImplementation((row?: unknown) => row as GameActor),
      findOne: jest.fn(),
      save: jest.fn().mockImplementation(async (row) => row as GameActor),
    };
    creatureTemplates = {
      findOne: jest.fn(),
    };
    const characterStateMock = {
      clearResourcesUsedEntryByCharacterId: jest.fn().mockResolvedValue(undefined),
    };
    characterState = characterStateMock;
    service = new CampaignEncounterService(
      campaigns as unknown as CampaignRepository,
      encounters as unknown as CampaignEncounterRepository,
      loadDto as unknown as LoadEncounterDto,
      actorPersistence as unknown as ActorPersistenceService,
      actors as unknown as Repository<GameActor>,
      creatureTemplates as unknown as Repository<PhbCreatureTemplate>,
      asDep(characterStateMock),
    );
  });

  it('create links campaign PCs and returns loaded dto', async () => {
    await expect(service.create('u1', 'c1', { name: 'Ambush' })).resolves.toEqual(dto);
    expect(encounters.createActive).toHaveBeenCalledWith({
      campaignId: 'c1',
      name: 'Ambush',
      createdBy: 'u1',
      characterIds: ['char1'],
    });
    expect(loadDto.load).toHaveBeenCalledWith(expect.objectContaining({ id: 'e1' }), 'dm');
  });

  it('create propagates Forbidden from requireRole', async () => {
    campaigns.requireRole.mockRejectedValue(new ForbiddenException());
    await expect(service.create('u1', 'c1', { name: 'X' })).rejects.toBeInstanceOf(
      ForbiddenException,
    );
  });

  it('getActive loads for player or forbids hidden encounter', async () => {
    campaigns.requireMember.mockResolvedValue(mem('player'));
    await service.getActive('u1', 'c1');
    expect(loadDto.load).toHaveBeenCalledWith(expect.objectContaining({ id: 'e1' }), 'player');

    encounters.findActiveOrFail.mockResolvedValue(enc({ playersCanView: false }));
    await expect(service.getActive('u1', 'c1')).rejects.toBeInstanceOf(ForbiddenException);
  });

  it('getOne propagates NotFound from repository', async () => {
    encounters.findEncounterInCampaignOrFail.mockRejectedValue(
      new NotFoundException('Encounter not found'),
    );
    await expect(service.getOne('u1', 'c1', 'e1')).rejects.toBeInstanceOf(NotFoundException);
  });

  it('patchEncounter updates active encounter or rejects closed', async () => {
    const active = enc();
    encounters.findEncounterInCampaignOrFail.mockResolvedValue(active);
    await service.patchEncounter('u1', 'c1', 'e1', { name: '  Renamed  ', playersCanView: false });
    expect(active.name).toBe('Renamed');
    expect(encounters.saveEncounter).toHaveBeenCalledWith(active);

    encounters.findEncounterInCampaignOrFail.mockResolvedValue(enc({ status: 'closed' }));
    await expect(
      service.patchEncounter('u1', 'c1', 'e1', { name: 'X' }),
    ).rejects.toBeInstanceOf(BadRequestException);
  });

  it('addCreature creates actor, links combatant and refreshes order', async () => {
    await service.addCreature('u1', 'c1', 'e1', {
      name: 'Goblin',
      hpMax: 7,
      armorClass: 13,
    });
    expect(actorPersistence.createWithChildren).toHaveBeenCalled();
    expect(encounters.addActor).toHaveBeenCalledWith(
      expect.objectContaining({ actorId: 'actor1' }),
    );
    expect(encounters.refreshSortOrders).toHaveBeenCalledWith(
      'e1',
      expect.any(Map),
    );
  });

  it('addCreature spawns from catalog template', async () => {
    creatureTemplates.findOne.mockResolvedValue({
      slug: 'goblin',
      name: 'Goblin',
    } as PhbCreatureTemplate);
    actorPersistence.spawnFromTemplate.mockResolvedValue('actor-catalog');
    actors.findOne.mockResolvedValue({
      id: 'actor-catalog',
      name: 'Goblin #1',
      initiativeModifier: 2,
      hitPointsMax: 7,
      hitPointsCurrent: 7,
      armorClass: 15,
    } as GameActor);

    await service.addCreature('u1', 'c1', 'e1', {
      templateSlug: 'goblin',
      count: 2,
    });
    expect(actorPersistence.spawnFromTemplate).toHaveBeenCalledTimes(2);
    expect(encounters.addActor).toHaveBeenCalledTimes(2);
  });

  it('patchCombatant and removeCombatant mutate combatants', async () => {
    const linkedActor = {
      id: 'actor1',
      name: 'Goblin',
      hitPointsMax: 10,
      hitPointsCurrent: 10,
    } as GameActor;
    const cb = {
      id: 'cb1',
      kind: 'actor',
      actorId: 'actor1',
    } as CampaignEncounterCombatant;
    encounters.findCombatantByIdOrFail.mockResolvedValue(cb);
    actors.findOne.mockResolvedValue(linkedActor);
    encounters.findEncounterInCampaignOrFail.mockResolvedValue(enc());

    await service.patchCombatant('u1', 'c1', 'e1', 'cb1', { hpCurrent: 5 });
    expect(linkedActor.hitPointsCurrent).toBe(5);
    expect(actors.save).toHaveBeenCalledWith(linkedActor);
    expect(encounters.saveCombatant).toHaveBeenCalledWith(cb);

    await service.removeCombatant('u1', 'c1', 'e1', 'cb1');
    expect(encounters.deleteCombatant).toHaveBeenCalledWith(cb);
  });

  it('nextTurn advances turn via repository', async () => {
    await service.nextTurn('u1', 'c1', 'e1');
    expect(encounters.advanceTurn).toHaveBeenCalled();
    expect(loadDto.load).toHaveBeenCalledWith(
      expect.objectContaining({ currentTurnIndex: 1 }),
      'dm',
    );
  });

  it('nextTurn clears Cursemarked lock for current PC', async () => {
    encounters.advanceTurn.mockResolvedValue(enc({ currentTurnIndex: 0 }));
    encounters.listCombatants.mockResolvedValue([
      {
        id: 'cb1',
        encounterId: 'e1',
        kind: 'pc',
        characterId: 'char-cursed',
        actorId: null,
        initiativeTotal: 15,
        initiativeModifier: 2,
        sortOrder: 0,
        isActive: true,
      } as CampaignEncounterCombatant,
    ]);

    await service.nextTurn('u1', 'c1', 'e1');

    expect(characterState.clearResourcesUsedEntryByCharacterId).toHaveBeenCalledWith(
      'char-cursed',
      'cursemarked-bracket-lock',
    );
  });

  it('close sets status or rejects already closed', async () => {
    const active = enc();
    encounters.findEncounterInCampaignOrFail.mockResolvedValue(active);
    await service.close('u1', 'c1', 'e1');
    expect(active.status).toBe('closed');

    encounters.findEncounterInCampaignOrFail.mockResolvedValue(enc({ status: 'closed' }));
    await expect(service.close('u1', 'c1', 'e1')).rejects.toThrow(/already closed/);
  });
});
