-- Trackers de sessão Pack 2: Colégio das Máscaras / Beastborne.
ALTER TABLE rpg.player_character_state
  ADD COLUMN IF NOT EXISTS persona_masks JSONB NOT NULL DEFAULT '[]'::jsonb;

ALTER TABLE rpg.player_character_state
  ADD COLUMN IF NOT EXISTS bestial_aspect_level INTEGER NOT NULL DEFAULT 0
  CHECK (bestial_aspect_level >= 0 AND bestial_aspect_level <= 5);
