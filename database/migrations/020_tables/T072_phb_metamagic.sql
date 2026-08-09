-- Catálogo de Metamagia (Feiticeiro PHB 2024)

CREATE TABLE IF NOT EXISTS rpg.phb_metamagic (
  id BIGSERIAL PRIMARY KEY,
  slug TEXT NOT NULL UNIQUE,
  name TEXT NOT NULL,
  description TEXT NOT NULL,
  cost SMALLINT NOT NULL CHECK (cost IN (1, 2)),
  stacks_with_other BOOLEAN NOT NULL DEFAULT FALSE,
  sort_order INTEGER NOT NULL DEFAULT 0,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_phb_metamagic_sort
  ON rpg.phb_metamagic(sort_order);
