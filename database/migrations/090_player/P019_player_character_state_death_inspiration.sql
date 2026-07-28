-- Death saves + inspiration no estado de mesa (PHB 2024)

ALTER TABLE rpg.player_character_state
  ADD COLUMN IF NOT EXISTS death_save_successes INT NOT NULL DEFAULT 0
    CHECK (death_save_successes BETWEEN 0 AND 3),
  ADD COLUMN IF NOT EXISTS death_save_failures INT NOT NULL DEFAULT 0
    CHECK (death_save_failures BETWEEN 0 AND 3),
  ADD COLUMN IF NOT EXISTS inspiration BOOLEAN NOT NULL DEFAULT FALSE;
