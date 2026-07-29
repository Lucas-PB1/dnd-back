-- Tabela rpg.phb_feat

CREATE TABLE rpg.phb_feat (
  id BIGSERIAL PRIMARY KEY,
  slug TEXT NOT NULL UNIQUE,
  name TEXT NOT NULL,
  category_id BIGINT NOT NULL REFERENCES rpg.phb_feat_category(id),
  repeatable BOOLEAN NOT NULL DEFAULT FALSE,
  prerequisite TEXT,
  source_citation_id BIGINT REFERENCES rpg.phb_source_citation(id),
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
