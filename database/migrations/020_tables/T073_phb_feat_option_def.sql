-- Definições de opções internas de talentos PHB

CREATE TABLE rpg.phb_feat_option_def (
  feat_id BIGINT NOT NULL REFERENCES rpg.phb_feat(id) ON DELETE CASCADE,
  option_key TEXT NOT NULL,
  label TEXT NOT NULL,
  value_type rpg.option_value_type NOT NULL DEFAULT 'catalog',
  sort_order INTEGER NOT NULL DEFAULT 0,
  depends_on_option_key TEXT NULL,
  spell_max_level INTEGER NULL CHECK (spell_max_level IS NULL OR spell_max_level BETWEEN 0 AND 9),
  PRIMARY KEY (feat_id, option_key)
);

CREATE INDEX idx_phb_feat_option_def_feat ON rpg.phb_feat_option_def(feat_id);
