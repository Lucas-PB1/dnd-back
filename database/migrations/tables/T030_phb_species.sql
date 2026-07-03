-- Tabela rpg.phb_species

CREATE TABLE rpg.phb_species (
  id BIGSERIAL PRIMARY KEY,
  slug TEXT NOT NULL UNIQUE,
  name TEXT NOT NULL,
  creature_type TEXT NOT NULL,
  size TEXT NOT NULL,
  speed TEXT NOT NULL,
  description TEXT NOT NULL,
  source_meta JSONB,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
