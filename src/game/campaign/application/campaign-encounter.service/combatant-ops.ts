import type { Repository } from 'typeorm';
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
import { DEFAULT_ABILITY_SCORES } from '@game/shared/domain/ability-scores';

export type EncounterCombatantDeps = {
  campaigns: CampaignRepository;
  encounters: CampaignEncounterRepository;
  loadDto: LoadEncounterDto;
  actorPersistence: ActorPersistenceService;
  actors: Repository<GameActor>;
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

  const actor = await deps.actorPersistence.createWithChildren(
    deps.actors.create({
      ownerUserId: userId,
      campaignId,
      actorKind: 'creature',
      name: dto.name.trim(),
      hitPointsMax: dto.hpMax,
      hitPointsCurrent: dto.hpCurrent ?? dto.hpMax,
      armorClass: dto.armorClass,
      initiativeModifier: dto.initiativeModifier ?? null,
      abilityScores: DEFAULT_ABILITY_SCORES,
    }),
    { actorKind: 'creature', name: dto.name },
  );

  await deps.encounters.addActor({
    encounterId: encounter.id,
    actorId: actor.id,
    initiativeModifier: dto.initiativeModifier ?? null,
  });
  await deps.encounters.refreshSortOrders(
    encounter.id,
    new Map([[actor.id, actor.name]]),
  );
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
