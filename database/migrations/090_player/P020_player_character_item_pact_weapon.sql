-- Arma de Pacto (Bruxo · Pacto da Lâmina): no máximo uma por personagem.
ALTER TABLE rpg.player_character_item
  ADD COLUMN IF NOT EXISTS is_pact_weapon BOOLEAN NOT NULL DEFAULT FALSE;

CREATE UNIQUE INDEX IF NOT EXISTS uq_player_character_item_one_pact_weapon
  ON rpg.player_character_item (character_id)
  WHERE is_pact_weapon = TRUE;
