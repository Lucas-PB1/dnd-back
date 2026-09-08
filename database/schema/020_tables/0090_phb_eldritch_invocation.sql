CREATE TABLE rpg.phb_eldritch_invocation (
  id BIGSERIAL PRIMARY KEY,
  slug TEXT NOT NULL UNIQUE,
  name TEXT NOT NULL,
  description TEXT NOT NULL,
  min_level INTEGER NOT NULL DEFAULT 1 CHECK (min_level BETWEEN 1 AND 20),
  requires_pact_slug TEXT CHECK (
    requires_pact_slug IS NULL
    OR requires_pact_slug IN (
      'pact-of-the-tome',
      'pact-of-the-blade',
      'pact-of-the-chain'
    )
  ),
  requires_invocation_slug TEXT REFERENCES rpg.phb_eldritch_invocation(slug),
  repeatable BOOLEAN NOT NULL DEFAULT FALSE,
  kind rpg.eldritch_invocation_kind NOT NULL DEFAULT 'passive',
  granted_spell_slug TEXT REFERENCES rpg.phb_spell(slug),
  sort_order INTEGER NOT NULL DEFAULT 0,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_phb_eldritch_invocation_min_level
  ON rpg.phb_eldritch_invocation(min_level);

-- Catálogo de Metamagia (Feiticeiro PHB 2024)
