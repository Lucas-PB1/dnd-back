-- Usos gastos de recursos de classe na mesa

ALTER TABLE rpg.player_character_state
  ADD COLUMN IF NOT EXISTS resources_used JSONB NOT NULL DEFAULT '{}'::jsonb;
