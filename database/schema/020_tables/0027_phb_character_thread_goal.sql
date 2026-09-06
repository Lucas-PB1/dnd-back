CREATE TABLE rpg.phb_character_thread_goal (
  id BIGSERIAL PRIMARY KEY,
  thread_slug TEXT NOT NULL REFERENCES rpg.phb_character_thread(slug) ON DELETE CASCADE,
  sort_order INT NOT NULL CHECK (sort_order BETWEEN 1 AND 6),
  text TEXT NOT NULL,
  UNIQUE (thread_slug, sort_order)
);
