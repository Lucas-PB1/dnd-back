CREATE TABLE rpg.player_character_thread_milestone (
  character_thread_id UUID NOT NULL REFERENCES rpg.player_character_thread(id) ON DELETE CASCADE,
  rank TEXT NOT NULL CHECK (rank IN ('least', 'lesser', 'greater', 'superior')),
  benefit_key TEXT NOT NULL CHECK (char_length(benefit_key) BETWEEN 1 AND 64),
  reached_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  PRIMARY KEY (character_thread_id, rank, benefit_key)
);
