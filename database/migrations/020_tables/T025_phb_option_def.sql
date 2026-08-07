-- Lote C: option_def unificado (subclass | species | feat)
-- owner_id = subclass_id | species_id | feat_id conforme scope (sem FK polimórfica)

CREATE TABLE rpg.phb_option_def (
  scope rpg.option_scope NOT NULL,
  owner_id BIGINT NOT NULL,
  option_key TEXT NOT NULL,
  value_type rpg.option_value_type NOT NULL DEFAULT 'catalog',
  label TEXT,
  sort_order INTEGER NOT NULL DEFAULT 0,
  unlock_level INTEGER CHECK (unlock_level IS NULL OR unlock_level BETWEEN 1 AND 20),
  depends_on_option_key TEXT,
  spell_max_level INTEGER CHECK (spell_max_level IS NULL OR spell_max_level BETWEEN 0 AND 9),
  spell_school_slugs TEXT[],
  spell_ritual_only BOOLEAN NOT NULL DEFAULT FALSE,
  PRIMARY KEY (scope, owner_id, option_key),
  CONSTRAINT phb_option_def_subclass_unlock CHECK (
    scope <> 'subclass' OR unlock_level IS NOT NULL
  )
);

CREATE INDEX idx_phb_option_def_scope_owner
  ON rpg.phb_option_def(scope, owner_id);
