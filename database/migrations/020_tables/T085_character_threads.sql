-- Character Threads (Northlands) — catálogo

CREATE TABLE rpg.phb_character_thread (
  slug TEXT PRIMARY KEY,
  edition_slug TEXT NOT NULL REFERENCES rpg.phb_edition(slug),
  name TEXT NOT NULL CHECK (char_length(name) BETWEEN 1 AND 120),
  summary TEXT NOT NULL,
  special_rules_text TEXT,
  source_citation_id BIGINT REFERENCES rpg.phb_source_citation(id),
  sort_order INT NOT NULL DEFAULT 0
);

CREATE TABLE rpg.phb_character_thread_goal (
  id BIGSERIAL PRIMARY KEY,
  thread_slug TEXT NOT NULL REFERENCES rpg.phb_character_thread(slug) ON DELETE CASCADE,
  sort_order INT NOT NULL CHECK (sort_order BETWEEN 1 AND 6),
  text TEXT NOT NULL,
  UNIQUE (thread_slug, sort_order)
);

CREATE TABLE rpg.phb_character_thread_milestone (
  id BIGSERIAL PRIMARY KEY,
  thread_slug TEXT NOT NULL REFERENCES rpg.phb_character_thread(slug) ON DELETE CASCADE,
  rank TEXT NOT NULL CHECK (rank IN ('least', 'lesser', 'greater', 'superior')),
  sort_order INT NOT NULL CHECK (sort_order BETWEEN 1 AND 4),
  UNIQUE (thread_slug, rank),
  UNIQUE (thread_slug, sort_order)
);

CREATE TABLE rpg.phb_character_thread_milestone_benefit (
  id BIGSERIAL PRIMARY KEY,
  milestone_id BIGINT NOT NULL REFERENCES rpg.phb_character_thread_milestone(id) ON DELETE CASCADE,
  benefit_key TEXT NOT NULL CHECK (char_length(benefit_key) BETWEEN 1 AND 64),
  name TEXT NOT NULL CHECK (char_length(name) BETWEEN 1 AND 120),
  description TEXT NOT NULL,
  -- Se preenchido, o jogador escolhe exatamente um benefício deste grupo ao alcançar o milestone.
  choice_group TEXT,
  sort_order INT NOT NULL DEFAULT 0,
  UNIQUE (milestone_id, benefit_key)
);

CREATE INDEX idx_phb_character_thread_goal_thread
  ON rpg.phb_character_thread_goal(thread_slug);
CREATE INDEX idx_phb_character_thread_milestone_thread
  ON rpg.phb_character_thread_milestone(thread_slug);
CREATE INDEX idx_phb_character_thread_milestone_benefit_ms
  ON rpg.phb_character_thread_milestone_benefit(milestone_id);
