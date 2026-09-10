-- Membro do duelo: exatamente um PC próprio por conta (máx. 2 membros — app).
-- Vitals de instância (≠ ficha): snapshot no startCombat; writes só aqui durante o combate.
CREATE TABLE rpg.duel_member (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  duel_id UUID NOT NULL REFERENCES rpg.duel(id) ON DELETE CASCADE,
  user_id UUID NOT NULL,
  character_id UUID NOT NULL REFERENCES rpg.player_character(id) ON DELETE CASCADE,
  ready BOOLEAN NOT NULL DEFAULT FALSE,
  initiative INT,
  hit_points_current INT NULL CHECK (hit_points_current IS NULL OR hit_points_current >= 0),
  hit_points_max INT NULL CHECK (hit_points_max IS NULL OR hit_points_max >= 1),
  temp_hp INT NOT NULL DEFAULT 0 CHECK (temp_hp >= 0),
  conditions TEXT[] NOT NULL DEFAULT '{}',
  speed_penalty_m INT NOT NULL DEFAULT 0 CHECK (speed_penalty_m >= 0),
  joined_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  UNIQUE (duel_id, user_id),
  UNIQUE (duel_id, character_id),
  CONSTRAINT duel_member_hp_bounds CHECK (
    hit_points_current IS NULL
    OR hit_points_max IS NULL
    OR hit_points_current <= hit_points_max
  )
);

CREATE INDEX idx_duel_member_user_id ON rpg.duel_member(user_id);
CREATE INDEX idx_duel_member_duel_id ON rpg.duel_member(duel_id);
CREATE INDEX idx_duel_member_character_id ON rpg.duel_member(character_id);
