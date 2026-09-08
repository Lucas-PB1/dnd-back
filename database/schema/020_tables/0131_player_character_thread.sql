CREATE TABLE rpg.player_character_thread (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  character_id UUID NOT NULL REFERENCES rpg.player_character(id) ON DELETE CASCADE,
  thread_slug TEXT NOT NULL REFERENCES rpg.phb_character_thread(slug),
  status TEXT NOT NULL CHECK (status IN ('active', 'completed', 'abandoned')),
  goal_index INT CHECK (goal_index IS NULL OR goal_index BETWEEN 1 AND 6),
  goal_text TEXT,
  started_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  ended_at TIMESTAMPTZ,
  CHECK (
    (status = 'active' AND ended_at IS NULL)
    OR (status <> 'active' AND ended_at IS NOT NULL)
  )
);

-- No máximo um thread ativo por personagem
CREATE UNIQUE INDEX uq_player_character_thread_one_active
  ON rpg.player_character_thread(character_id)
  WHERE status = 'active';

CREATE INDEX idx_player_character_thread_character
  ON rpg.player_character_thread(character_id);
