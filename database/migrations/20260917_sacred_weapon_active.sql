ALTER TABLE rpg.player_character_state
  ADD COLUMN IF NOT EXISTS sacred_weapon_active BOOLEAN NOT NULL DEFAULT FALSE;
