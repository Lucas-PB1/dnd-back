-- Tabela rpg.phb_spell

CREATE TABLE rpg.phb_spell (
  id BIGSERIAL PRIMARY KEY,
  slug TEXT NOT NULL UNIQUE,
  name TEXT NOT NULL,
  level INTEGER NOT NULL CHECK (level BETWEEN 0 AND 9),
  level_label TEXT NOT NULL,
  school_id BIGINT NOT NULL REFERENCES rpg.phb_spell_school(id),
  casting_time TEXT NOT NULL,
  range TEXT NOT NULL,
  has_verbal BOOLEAN NOT NULL DEFAULT FALSE,
  has_somatic BOOLEAN NOT NULL DEFAULT FALSE,
  has_material BOOLEAN NOT NULL DEFAULT FALSE,
  material_description TEXT,
  components_label TEXT NOT NULL,
  duration TEXT NOT NULL,
  concentration BOOLEAN NOT NULL DEFAULT FALSE,
  ritual BOOLEAN NOT NULL DEFAULT FALSE,
  description TEXT NOT NULL,
  higher_levels TEXT,
  source_citation_id BIGINT REFERENCES rpg.phb_source_citation(id),
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
