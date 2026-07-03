-- Tabela rpg.phb_background

CREATE TABLE rpg.phb_background (
  id BIGSERIAL PRIMARY KEY,
  slug TEXT NOT NULL UNIQUE,
  name TEXT NOT NULL,
  description TEXT,
  feat_id BIGINT REFERENCES rpg.phb_feat(id),
  source_citation_id BIGINT REFERENCES rpg.phb_source_citation(id),
  equipment_gold_option INTEGER CHECK (equipment_gold_option >= 0),
  tool_proficiency_description TEXT,
  tool_proficiency_kind TEXT CHECK (tool_proficiency_kind IN ('fixed', 'choice')),
  tool_item_id BIGINT REFERENCES rpg.phb_item(id),
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
