-- Tabela rpg.phb_subclass

CREATE TABLE rpg.phb_subclass (
  id BIGSERIAL PRIMARY KEY,
  slug TEXT NOT NULL UNIQUE,
  class_id BIGINT NOT NULL REFERENCES rpg.phb_class(id) ON DELETE CASCADE,
  name TEXT NOT NULL,
  tagline TEXT,
  summary TEXT,
  description TEXT,
  source_citation_id BIGINT REFERENCES rpg.phb_source_citation(id),
  UNIQUE (class_id, id),
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
