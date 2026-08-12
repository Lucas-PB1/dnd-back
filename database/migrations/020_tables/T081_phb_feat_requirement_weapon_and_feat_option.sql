-- Proficiência de arma exigida + opção de talento pré-requisito (ex.: Adepto Elemental / tipo).

CREATE TABLE IF NOT EXISTS rpg.phb_feat_requirement_weapon_proficiency (
  feat_id BIGINT NOT NULL REFERENCES rpg.phb_feat_requirement(feat_id) ON DELETE CASCADE,
  proficiency_slug TEXT NOT NULL,
  PRIMARY KEY (feat_id, proficiency_slug)
);

CREATE TABLE IF NOT EXISTS rpg.phb_feat_requirement_feat_option (
  feat_id BIGINT NOT NULL REFERENCES rpg.phb_feat_requirement(feat_id) ON DELETE CASCADE,
  required_feat_id BIGINT NOT NULL REFERENCES rpg.phb_feat(id),
  option_key TEXT NOT NULL,
  value_id TEXT NOT NULL,
  PRIMARY KEY (feat_id, required_feat_id, option_key, value_id)
);

CREATE INDEX IF NOT EXISTS idx_phb_feat_requirement_feat_option_required
  ON rpg.phb_feat_requirement_feat_option (required_feat_id);
