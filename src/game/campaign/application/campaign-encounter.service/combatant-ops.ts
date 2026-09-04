import type { Repository } from 'typeorm';
import type { PhbCreatureTemplate } from '@entities/phb-creature-template.entity';
import type { ActorPersistenceService } from '@game/actor/infrastructure/actor-persistence.service';
import type { GameActor } from '@game/actor/infrastructure/game-actor.entity';
import type { CampaignRepository } from '../../infrastructure/campaign.repository';
import type { CampaignEncounterRepository } from '../../infrastructure/campaign-encounter.repository';
import type { LoadEncounterDto } from '../load-encounter-dto';
import { requireActiveEncounter } from '../require-active-encounter';
import {
  applyCombatantPatch,
} from '../encounter-combatant-ops';
import type {
  AddEncounterCreatureDto,
  CampaignEncounterDto,
  PatchEncounterCombatantDto,
} from '../../dto/encounter.dto';
import { spawnEncounterCreatures } from './spawn-encounter-creatures';

export type EncounterCombatantDeps = {
  campaigns: CampaignRepository;
  encounters: CampaignEncounterRepository;
  loadDto: LoadEncounterDto;
  actorPersistence: ActorPersistenceService;
  actors: Repository<GameActor>;
  creatureTemplates: Repository<PhbCreatureTemplate>;
};

export async function addEncounterCreature(
  deps: EncounterCombatantDeps,
  userId: string,
  campaignId: string,
  encounterId: string,
  dto: AddEncounterCreatureDto,
): Promise<CampaignEncounterDto> {
  await deps.campaigns.requireRole(campaignId, userId, ['dm', 'assistant']);
  const encounter = await requireActiveEncounter(
    deps.encounters,
    campaignId,
    encounterId,
  );

  const actors = await spawnEncounterCreatures({
    actorPersistence: deps.actorPersistence,
    actors: deps.actors,
    templates: deps.creatureTemplates,
    userId,
    campaignId,
    dto,
  });

  const nameByActorId = new Map<string, string>();
  for (const actor of actors) {
    await deps.encounters.addActor({
      encounterId: encounter.id,
      actorId: actor.id,
      initiativeModifier: actor.initiativeModifier,
    });
    nameByActorId.set(actor.id, actor.name);
  }
  await deps.encounters.refreshSortOrders(encounter.id, nameByActorId);
  return deps.loadDto.load(encounter, 'dm');
}

export async function patchEncounterCombatant(
  deps: EncounterCombatantDeps,
  userId: string,
  campaignId: string,
  encounterId: string,
  combatantId: string,
  dto: PatchEncounterCombatantDto,
): Promise<CampaignEncounterDto> {
  await deps.campaigns.requireRole(campaignId, userId, ['dm', 'assistant']);
  await requireActiveEncounter(deps.encounters, campaignId, encounterId);
  const combatant = await deps.encounters.findCombatantByIdOrFail(
    encounterId,
    combatantId,
  );
  const linkedActor =
    combatant.kind === 'actor' && combatant.actorId
      ? await deps.actors.findOne({ where: { id: combatant.actorId } })
      : null;
  applyCombatantPatch(combatant, dto, linkedActor);
  if (linkedActor) {
    await deps.actors.save(linkedActor);
  }
  await deps.encounters.saveCombatant(combatant);
  await deps.encounters.refreshSortOrders(
    encounterId,
    linkedActor ? new Map([[linkedActor.id, linkedActor.name]]) : new Map(),
  );
  return deps.loadDto.load(
    await deps.encounters.findEncounterInCampaignOrFail(campaignId, encounterId),
    'dm',
  );
}

export async function removeEncounterCombatant(
  deps: EncounterCombatantDeps,
  userId: string,
  campaignId: string,
  encounterId: string,
  combatantId: string,
): Promise<CampaignEncounterDto> {
  await deps.campaigns.requireRole(campaignId, userId, ['dm', 'assistant']);
  const encounter = await requireActiveEncounter(
    deps.encounters,
    campaignId,
    encounterId,
  );
  const combatant = await deps.encounters.findCombatantByIdOrFail(
    encounter.id,
    combatantId,
  );
  await deps.encounters.deleteCombatant(combatant);
  await deps.encounters.refreshSortOrders(encounter.id);
  return deps.loadDto.load(encounter, 'dm');
}
