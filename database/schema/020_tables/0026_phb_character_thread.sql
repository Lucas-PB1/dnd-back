CREATE TABLE rpg.phb_character_thread (
  id BIGSERIAL NOT NULL UNIQUE,
  slug TEXT PRIMARY KEY,
  edition_slug TEXT NOT NULL REFERENCES rpg.phb_edition(slug),
  name TEXT NOT NULL CHECK (char_length(name) BETWEEN 1 AND 120),
  summary TEXT NOT NULL,
  special_rules_text TEXT,
  source_citation_id BIGINT REFERENCES rpg.phb_source_citation(id),
  sort_order INT NOT NULL DEFAULT 0
);
