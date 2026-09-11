import type {
  CampaignEncounterCombatant,
  EncounterCombatantKind,
} from '@game/campaign/infrastructure/campaign-encounter-combatant.entity';

/** Fixture compartilhada de combatant de encontro (specs de campaign). */
export function combatantFixture(
  overrides: Partial<CampaignEncounterCombatant> = {},
): CampaignEncounterCombatant {
  return {
    id: 'cb1',
    encounterId: 'e1',
    kind: 'actor' as EncounterCombatantKind,
    characterId: null,
    actorId: 'actor1',
    initiativeTotal: null,
    initiativeModifier: 2,
    sortOrder: 0,
    isActive: true,
    hitPointsCurrent: null,
    hitPointsMax: null,
    tempHp: 0,
    conditions: [],
    ...overrides,
  };
}
