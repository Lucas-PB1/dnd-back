import { CURSEMARKED_BRACKET_LOCK } from '@game/session/domain/cursemarked-bracket';
import type { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';
import type { CampaignEncounter } from '../infrastructure/campaign-encounter.entity';
import type { CampaignEncounterRepository } from '../infrastructure/campaign-encounter.repository';
import { sortCombatantsByInitiative } from '../domain/encounter-initiative';

export async function clearCursemarkedLockForCurrentPc(input: {
  encounters: CampaignEncounterRepository;
  characterState: CharacterStateRepository;
  encounter: CampaignEncounter;
}): Promise<void> {
  const rows = await input.encounters.listCombatants(input.encounter.id);
  const active = sortCombatantsByInitiative(
    rows.map((row) => ({
      ...row,
      combatantId: row.id,
      displayName: row.id,
    })),
  ).filter((row) => row.isActive);
  if (active.length === 0) return;
  const current =
    active[
      Math.min(
        input.encounter.currentTurnIndex,
        Math.max(0, active.length - 1),
      )
    ];
  if (current?.kind !== 'pc' || !current.characterId) return;
  await input.characterState.clearResourcesUsedEntryByCharacterId(
    current.characterId,
    CURSEMARKED_BRACKET_LOCK,
  );
}
