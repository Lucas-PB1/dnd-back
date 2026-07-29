-- Estado de combate do Bárbaro (Fúria / Ataque Imprudente).
ALTER TABLE rpg.player_character_state
  ADD COLUMN IF NOT EXISTS rage_active BOOLEAN NOT NULL DEFAULT FALSE;

ALTER TABLE rpg.player_character_state
  ADD COLUMN IF NOT EXISTS reckless_active BOOLEAN NOT NULL DEFAULT FALSE;
