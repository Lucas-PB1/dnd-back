-- Sintonia de itens mágicos no inventário (máx. 3 aplicado no domínio)

ALTER TABLE rpg.player_character_item
  ADD COLUMN IF NOT EXISTS attuned BOOLEAN NOT NULL DEFAULT FALSE;

CREATE INDEX IF NOT EXISTS idx_player_character_item_attuned
  ON rpg.player_character_item(character_id)
  WHERE attuned = TRUE;
