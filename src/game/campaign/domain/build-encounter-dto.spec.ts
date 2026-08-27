import { buildCampaignEncounterDto } from './build-encounter-dto';
import type { CampaignEncounter } from '../infrastructure/campaign-encounter.entity';
import type { CampaignEncounterCombatant } from '../infrastructure/campaign-encounter-combatant.entity';
import type { ActorCombatantEnrichment } from '../application/enrich-encounter-actors';

function encounter(
  overrides: Partial<CampaignEncounter> = {},
): CampaignEncounter {
  return {
    id: 'e1',
    campaignId: 'c1',
    name: 'Emboscada',
    status: 'active',
    round: 1,
    currentTurnIndex: 0,
    playersCanView: true,
    creatureHpVisibility: 'percent',
    createdBy: 'u1',
    createdAt: new Date(),
    updatedAt: new Date(),
    ...overrides,
  };
}

function combatant(
  overrides: Partial<CampaignEncounterCombatant>,
): CampaignEncounterCombatant {
  return {
    id: 'cb1',
    encounterId: 'e1',
    kind: 'actor',
    characterId: null,
    actorId: 'actor1',
    initiativeTotal: 12,
    initiativeModifier: 2,
    sortOrder: 0,
    isActive: true,
    ...overrides,
  };
}

const actorEnrichment = (): Map<string, ActorCombatantEnrichment> =>
  new Map([
    [
      'actor1',
      {
        name: 'Goblin',
        armorClass: 15,
        hpCurrent: 3,
        hpMax: 7,
        conditions: [],
      },
    ],
  ]);

describe('buildCampaignEncounterDto', () => {
  it('hides exact creature HP for players when visibility is percent', () => {
    const dto = buildCampaignEncounterDto({
      encounter: encounter(),
      combatants: [combatant({})],
      pcNameById: new Map(),
      pcEnrichmentByCharacterId: new Map(),
      actorEnrichmentByActorId: actorEnrichment(),
      viewer: 'player',
    });
    expect(dto.combatants[0].hpCurrent).toBeNull();
    expect(dto.combatants[0].hpMax).toBeNull();
    expect(dto.combatants[0].hpPercent).toBe(43);
    expect(dto.combatants[0].armorClass).toBe(15);
  });

  it('shows exact creature HP for dm', () => {
    const dto = buildCampaignEncounterDto({
      encounter: encounter(),
      combatants: [combatant({})],
      pcNameById: new Map(),
      pcEnrichmentByCharacterId: new Map(),
      actorEnrichmentByActorId: actorEnrichment(),
      viewer: 'dm',
    });
    expect(dto.combatants[0].hpCurrent).toBe(3);
    expect(dto.combatants[0].hpMax).toBe(7);
    expect(dto.combatants[0].hpPercent).toBe(43);
  });
});
