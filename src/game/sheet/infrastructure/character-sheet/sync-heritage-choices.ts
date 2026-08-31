import { DataSource } from 'typeorm';
import type { SpeciesChoiceDto } from '@game/sheet/dto/character-sheet.dto';
import {
  HERITAGE_SIZE_KIND,
  HERITAGE_SPEED_TRADE_KIND,
  heritageTraitSlotIndex,
  isHeritageTraitSlot,
} from '@game/sheet/domain/heritage/aggregate-trait-takes';

export async function syncHeritageChoices(
  dataSource: DataSource,
  characterId: string,
  choices: readonly SpeciesChoiceDto[],
): Promise<void> {
  await dataSource.query(
    `DELETE FROM rpg.player_character_heritage_trait WHERE character_id = $1`,
    [characterId],
  );
  await dataSource.query(
    `DELETE FROM rpg.player_character_heritage_config WHERE character_id = $1`,
    [characterId],
  );

  for (const choice of choices) {
    if (!isHeritageTraitSlot(choice.choiceKind)) continue;
    const slotIndex = heritageTraitSlotIndex(choice.choiceKind);
    if (!slotIndex || !choice.choiceSlug?.trim()) continue;
    await dataSource.query(
      `INSERT INTO rpg.player_character_heritage_trait (character_id, slot_index, trait_id)
       SELECT $1::uuid, $2::int, ht.id
       FROM rpg.phb_heritage_trait ht
       WHERE ht.slug = $3
       ON CONFLICT (character_id, slot_index) DO UPDATE SET trait_id = EXCLUDED.trait_id`,
      [characterId, slotIndex, choice.choiceSlug.trim()],
    );
  }

  const speedTrade = choices.find(
    (choice) => choice.choiceKind === HERITAGE_SPEED_TRADE_KIND,
  );
  const sizeChoice = choices.find(
    (choice) => choice.choiceKind === HERITAGE_SIZE_KIND,
  );
  if (speedTrade || sizeChoice) {
    await dataSource.query(
      `INSERT INTO rpg.player_character_heritage_config (character_id, speed_trade, size_choice)
       VALUES ($1::uuid, $2, $3)
       ON CONFLICT (character_id) DO UPDATE SET
         speed_trade = EXCLUDED.speed_trade,
         size_choice = EXCLUDED.size_choice`,
      [
        characterId,
        speedTrade?.choiceSlug ?? null,
        sizeChoice?.choiceSlug ?? null,
      ],
    );
  }
}
