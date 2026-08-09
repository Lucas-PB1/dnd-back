import { BadRequestException } from '@nestjs/common';
import { DataSource } from 'typeorm';
import type { SpeciesChoiceDto } from '@game/sheet/dto/character-sheet.dto';

const HIGH_ELF_CANTRIP = 'high_elf_cantrip';

/** Detecta troca do truque de Alto Elfo e consome a flag pós-descanso longo. */
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

  const rows = await dataSource.query<
    { high_elf_cantrip_swap_available: boolean }[]
  >(
    `SELECT high_elf_cantrip_swap_available
     FROM rpg.player_character_state
     WHERE character_id = $1
     LIMIT 1`,
    [characterId],
  );
  const available = rows[0]?.high_elf_cantrip_swap_available === true;
  if (!available) {
    throw new BadRequestException(
      'High Elf cantrip can only be swapped after a Long Rest',
    );
  }
  await dataSource.query(
    `UPDATE rpg.player_character_state
     SET high_elf_cantrip_swap_available = false
     WHERE character_id = $1`,
    [characterId],
  );
}
