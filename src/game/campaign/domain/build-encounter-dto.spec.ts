import { buildCampaignEncounterDto } from './build-encounter-dto';
import type { CampaignEncounter } from '../infrastructure/campaign-encounter.entity';
import type { CampaignEncounterCombatant } from '../infrastructure/campaign-encounter-combatant.entity';

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
    kind: 'creature',
    characterId: null,
    displayName: 'Goblin',
    hpCurrent: 3,
    hpMax: 7,
    armorClass: 15,
    initiativeTotal: 12,
    initiativeModifier: 2,
    sortOrder: 0,
    isActive: true,
    ...overrides,
  };
}

describe('buildCampaignEncounterDto', () => {
  it('hides exact creature HP for players when visibility is percent', () => {
    const dto = buildCampaignEncounterDto({
      encounter: encounter(),
      combatants: [combatant({})],
      pcNameById: new Map(),
      pcEnrichmentByCharacterId: new Map(),
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
      viewer: 'dm',
    });
    expect(dto.combatants[0].hpCurrent).toBe(3);
    expect(dto.combatants[0].hpMax).toBe(7);
    expect(dto.combatants[0].hpPercent).toBe(43);
  });
});
