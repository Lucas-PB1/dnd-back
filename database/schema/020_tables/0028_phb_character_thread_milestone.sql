CREATE TABLE rpg.phb_character_thread_milestone (
  id BIGSERIAL PRIMARY KEY,
  thread_slug TEXT NOT NULL REFERENCES rpg.phb_character_thread(slug) ON DELETE CASCADE,
  rank TEXT NOT NULL CHECK (rank IN ('least', 'lesser', 'greater', 'superior')),
  sort_order INT NOT NULL CHECK (sort_order BETWEEN 1 AND 4),
  UNIQUE (thread_slug, rank),
  UNIQUE (thread_slug, sort_order)
);
