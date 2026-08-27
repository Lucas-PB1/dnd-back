-- Character Threads — estado na ficha (1 ativo por personagem)

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

CREATE TABLE rpg.player_character_thread_milestone (
  character_thread_id UUID NOT NULL REFERENCES rpg.player_character_thread(id) ON DELETE CASCADE,
  rank TEXT NOT NULL CHECK (rank IN ('least', 'lesser', 'greater', 'superior')),
  benefit_key TEXT NOT NULL CHECK (char_length(benefit_key) BETWEEN 1 AND 64),
  reached_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  PRIMARY KEY (character_thread_id, rank, benefit_key)
);

DO $$
BEGIN
  ALTER TABLE rpg.player_character_thread ENABLE ROW LEVEL SECURITY;
  ALTER TABLE rpg.player_character_thread_milestone ENABLE ROW LEVEL SECURITY;

  DROP POLICY IF EXISTS player_character_thread_own ON rpg.player_character_thread;
  CREATE POLICY player_character_thread_own ON rpg.player_character_thread
    FOR ALL USING (
      character_id IN (
        SELECT id FROM rpg.player_character WHERE user_id = auth.uid()
      )
    )
    WITH CHECK (
      character_id IN (
        SELECT id FROM rpg.player_character WHERE user_id = auth.uid()
      )
    );

  DROP POLICY IF EXISTS player_character_thread_milestone_own ON rpg.player_character_thread_milestone;
  CREATE POLICY player_character_thread_milestone_own ON rpg.player_character_thread_milestone
    FOR ALL USING (
      character_thread_id IN (
        SELECT t.id
          FROM rpg.player_character_thread t
          JOIN rpg.player_character c ON c.id = t.character_id
         WHERE c.user_id = auth.uid()
      )
    )
    WITH CHECK (
      character_thread_id IN (
        SELECT t.id
          FROM rpg.player_character_thread t
          JOIN rpg.player_character c ON c.id = t.character_id
         WHERE c.user_id = auth.uid()
      )
    );
EXCEPTION
  WHEN undefined_function THEN
    -- auth.uid() pode não existir em Postgres local sem Supabase
    NULL;
END $$;
