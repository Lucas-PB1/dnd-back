-- Membro do duelo: exatamente um PC próprio por conta (máx. 2 membros — app).
CREATE TABLE rpg.duel_member (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  duel_id UUID NOT NULL REFERENCES rpg.duel(id) ON DELETE CASCADE,
  user_id UUID NOT NULL,
  character_id UUID NOT NULL REFERENCES rpg.player_character(id) ON DELETE CASCADE,
  ready BOOLEAN NOT NULL DEFAULT FALSE,
  initiative INT,
  joined_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  UNIQUE (duel_id, user_id),
  UNIQUE (duel_id, character_id)
);

CREATE INDEX idx_duel_member_user_id ON rpg.duel_member(user_id);
CREATE INDEX idx_duel_member_duel_id ON rpg.duel_member(duel_id);
CREATE INDEX idx_duel_member_character_id ON rpg.duel_member(character_id);
