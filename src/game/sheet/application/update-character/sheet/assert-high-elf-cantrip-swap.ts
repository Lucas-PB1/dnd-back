import { BadRequestException } from '@nestjs/common';
import { DataSource } from 'typeorm';
import type { SpeciesChoiceDto } from '@game/sheet/dto/character-sheet.dto';

const HIGH_ELF_CANTRIP = 'high_elf_cantrip';

export async function assertAndConsumeHighElfCantripSwap(
  dataSource: DataSource,
  characterId: string,
  previousChoices: readonly SpeciesChoiceDto[],
  nextChoices: readonly SpeciesChoiceDto[],
): Promise<void> {
  const previous = previousChoices.find((c) => c.choiceKind === HIGH_ELF_CANTRIP)
    ?.choiceSlug;
  const next = nextChoices.find((c) => c.choiceKind === HIGH_ELF_CANTRIP)?.choiceSlug;
  if (next === undefined || next === previous) return;

  const rows = await dataSource.query<{ available: boolean | null }[]>(
    `SELECT (feature_state->>'highElfCantripSwapAvailable')::boolean AS available
     FROM rpg.player_character_state
     WHERE character_id = $1
     LIMIT 1`,
    [characterId],
  );
  const available = rows[0]?.available === true;
  if (!available) {
    throw new BadRequestException(
      'High Elf cantrip can only be swapped after a Long Rest',
    );
  }
  await dataSource.query(
    `UPDATE rpg.player_character_state
     SET feature_state = feature_state - 'highElfCantripSwapAvailable'
     WHERE character_id = $1`,
    [characterId],
  );
}
