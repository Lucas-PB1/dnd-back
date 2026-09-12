import type { DataSource } from 'typeorm';
import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import type { CharacterResourceSpender } from '@game/session/domain/character-resource-spender';
import {
  CURSEMARKED_BRACKET_LOCK,
  cursemarkedBracketNote,
  cursemarkedBracketTriggers,
  type CursemarkedRollKind,
} from '@game/session/domain/cursemarked-bracket';
import { loadActiveCursemarkedBracketBenefit } from '@game/session/infrastructure/queries/cursemarked-bracket.queries';


export async function applyCursemarkedBracketIfTriggered(input: {
  dataSource: DataSource;
  character: PlayerCharacter;
  resourceSpender: CharacterResourceSpender;
  kind: CursemarkedRollKind;
  kept: number;
  notes: string[];
}): Promise<void> {
  const benefit = await loadActiveCursemarkedBracketBenefit(
    input.dataSource,
    input.character.id,
  );
  if (!benefit) return;
  if (
    !cursemarkedBracketTriggers({
      benefit,
      kind: input.kind,
      kept: input.kept,
    })
  ) {
    return;
  }

  const locked = await input.resourceSpender.getResourcesUsedEntry(
    input.character,
    CURSEMARKED_BRACKET_LOCK,
  );
  if (locked > 0) return;

  input.notes.push(cursemarkedBracketNote(benefit));
  await input.resourceSpender.setResourcesUsedEntry(
    input.character,
    CURSEMARKED_BRACKET_LOCK,
    1,
  );
}
