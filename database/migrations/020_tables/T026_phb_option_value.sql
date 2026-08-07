-- Lote C: option_value unificado (+ colunas tipadas do Lote B para species)

CREATE TABLE rpg.phb_option_value (
  scope rpg.option_scope NOT NULL,
  owner_id BIGINT NOT NULL,
  option_key TEXT NOT NULL,
  value_id TEXT NOT NULL,
  label TEXT NOT NULL,
  sort_order INTEGER NOT NULL DEFAULT 0,
  benefit TEXT,
  level1_benefit TEXT,
  damage_type TEXT,
  spell_level1_id BIGINT REFERENCES rpg.phb_spell(id),
  spell_level3_id BIGINT REFERENCES rpg.phb_spell(id),
  spell_level5_id BIGINT REFERENCES rpg.phb_spell(id),
  spell_1_id BIGINT REFERENCES rpg.phb_spell(id),
  spell_2_id BIGINT REFERENCES rpg.phb_spell(id),
  PRIMARY KEY (scope, owner_id, option_key, value_id),
  FOREIGN KEY (scope, owner_id, option_key)
    REFERENCES rpg.phb_option_def(scope, owner_id, option_key) ON DELETE CASCADE
);

CREATE INDEX idx_phb_option_value_scope_owner
  ON rpg.phb_option_value(scope, owner_id);
