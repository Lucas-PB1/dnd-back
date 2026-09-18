-- Skinrider's Trance (Path of the Primal Spirit): estado + effect_kind

ALTER TYPE rpg.effect_kind ADD VALUE IF NOT EXISTS 'skinrider_trance';

ALTER TABLE rpg.player_character_state
  ADD COLUMN IF NOT EXISTS skinrider_trance_active BOOLEAN NOT NULL DEFAULT FALSE;

ALTER TABLE rpg.player_character_state
  ADD COLUMN IF NOT EXISTS skinrider_actor_id UUID REFERENCES rpg.game_actor(id) ON DELETE SET NULL;

CREATE INDEX IF NOT EXISTS idx_player_character_state_skinrider_actor
  ON rpg.player_character_state(skinrider_actor_id)
  WHERE skinrider_actor_id IS NOT NULL;
