import type { CampaignEncounter } from '../infrastructure/campaign-encounter.entity';
import type { CampaignEncounterCombatant } from '../infrastructure/campaign-encounter-combatant.entity';
import {
  hitPointsPercent,
  sortCombatantsByInitiative,
} from './encounter-initiative';
import type { CampaignEncounterDto } from '../dto/encounter.dto';
import type { ActorCombatantEnrichment } from '../application/enrich-encounter-actors';

export type EncounterViewer = 'dm' | 'player';

export type PcCombatantEnrichment = {
  level: number;
  armorClass: number;
  hpCurrent: number | null;
  hpMax: number | null;
  featSlugs: string[];
  conditions: string[];
  inspiration: boolean;
};

export function buildCampaignEncounterDto(input: {
  encounter: CampaignEncounter;
  combatants: CampaignEncounterCombatant[];
  pcNameById: Map<string, string>;
  pcEnrichmentByCharacterId: Map<string, PcCombatantEnrichment>;
  actorEnrichmentByActorId: Map<string, ActorCombatantEnrichment>;
  viewer: EncounterViewer;
}): CampaignEncounterDto {
  const sorted = sortCombatantsByInitiative(
    input.combatants.map((row) => ({
      ...row,
      combatantId: row.id,
      displayName: resolveDisplayName(row, input.pcNameById, input.actorEnrichmentByActorId),
    })),
  );
  const active = sorted.filter((row) => row.isActive);
  const current =
    active.length > 0
      ? active[
          Math.min(
            input.encounter.currentTurnIndex,
            Math.max(0, active.length - 1),
          )
        ]
      : null;

  return {
    id: input.encounter.id,
    campaignId: input.encounter.campaignId,
    name: input.encounter.name,
    status: input.encounter.status,
    round: input.encounter.round,
    currentTurnIndex: input.encounter.currentTurnIndex,
    playersCanView: input.encounter.playersCanView,
    creatureHpVisibility: input.encounter.creatureHpVisibility,
    currentCombatantId: current?.id ?? null,
    currentCharacterId: current?.characterId ?? null,
    currentActorId: current?.actorId ?? null,
    combatants: sorted.map((row) =>
      mapCombatantDto({
        row,
        displayName: row.displayName,
        isCurrentTurn: current?.id === row.id,
        pcEnrichment: row.characterId
          ? input.pcEnrichmentByCharacterId.get(row.characterId)
          : undefined,
        actorEnrichment: row.actorId
          ? input.actorEnrichmentByActorId.get(row.actorId)
          : undefined,
        viewer: input.viewer,
        creatureHpVisibility: input.encounter.creatureHpVisibility,
      }),
    ),
  };
}

function resolveDisplayName(
  row: CampaignEncounterCombatant,
  pcNameById: Map<string, string>,
  actorEnrichmentByActorId: Map<string, ActorCombatantEnrichment>,
): string {
  if (row.kind === 'actor' && row.actorId) {
    return actorEnrichmentByActorId.get(row.actorId)?.name ?? 'Actor';
  }
  if (row.characterId) {
    return pcNameById.get(row.characterId) ?? row.characterId;
  }
  return 'Combatente';
}

function mapCombatantDto(input: {
  row: CampaignEncounterCombatant & { displayName: string };
  displayName: string;
  isCurrentTurn: boolean;
  pcEnrichment?: PcCombatantEnrichment;
  actorEnrichment?: ActorCombatantEnrichment;
  viewer: EncounterViewer;
  creatureHpVisibility: CampaignEncounter['creatureHpVisibility'];
}): CampaignEncounterDto['combatants'][number] {
  const base = {
    id: input.row.id,
    kind: input.row.kind,
    characterId: input.row.characterId,
    actorId: input.row.actorId,
    displayName: input.displayName,
    initiativeTotal: input.row.initiativeTotal,
    initiativeModifier: input.row.initiativeModifier,
    sortOrder: input.row.sortOrder,
    isActive: input.row.isActive,
    isCurrentTurn: input.isCurrentTurn,
    level: null as number | null,
    armorClass: null as number | null,
    hpCurrent: null as number | null,
    hpMax: null as number | null,
    hpPercent: null as number | null,
    featSlugs: [] as string[],
    conditions: [] as string[],
    inspiration: null as boolean | null,
  };

  if (input.row.kind === 'pc' && input.pcEnrichment) {
    return {
      ...base,
      level: input.pcEnrichment.level,
      armorClass: input.pcEnrichment.armorClass,
      hpCurrent: input.pcEnrichment.hpCurrent,
      hpMax: input.pcEnrichment.hpMax,
      hpPercent: hitPointsPercent(
        input.pcEnrichment.hpCurrent,
        input.pcEnrichment.hpMax,
      ),
      featSlugs: input.pcEnrichment.featSlugs,
      conditions: input.pcEnrichment.conditions,
      inspiration: input.pcEnrichment.inspiration,
    };
  }

  if (input.row.kind === 'actor' && input.actorEnrichment) {
    return {
      ...base,
      armorClass: input.actorEnrichment.armorClass,
      conditions: input.actorEnrichment.conditions,
      ...creatureHpFields({
        hpCurrent: input.actorEnrichment.hpCurrent,
        hpMax: input.actorEnrichment.hpMax,
        viewer: input.viewer,
        visibility: input.creatureHpVisibility,
      }),
    };
  }

  return base;
}

function creatureHpFields(input: {
  hpCurrent: number | null;
  hpMax: number | null;
  viewer: EncounterViewer;
  visibility: CampaignEncounter['creatureHpVisibility'];
}): Pick<
  CampaignEncounterDto['combatants'][number],
  'hpCurrent' | 'hpMax' | 'hpPercent'
> {
  if (input.viewer === 'dm' || input.visibility === 'exact') {
    return {
      hpCurrent: input.hpCurrent,
      hpMax: input.hpMax,
      hpPercent: hitPointsPercent(input.hpCurrent, input.hpMax),
    };
  }
  if (input.visibility === 'percent') {
    return {
      hpCurrent: null,
      hpMax: null,
      hpPercent: hitPointsPercent(input.hpCurrent, input.hpMax),
    };
  }
  return { hpCurrent: null, hpMax: null, hpPercent: null };
}
