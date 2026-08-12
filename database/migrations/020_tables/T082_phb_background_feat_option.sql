-- Opções de talento de origem quando o antecedente não tem feat_id fixo.

CREATE TABLE rpg.phb_background_feat_option (
  background_id BIGINT NOT NULL REFERENCES rpg.phb_background(id) ON DELETE CASCADE,
  feat_id BIGINT NOT NULL REFERENCES rpg.phb_feat(id),
  PRIMARY KEY (background_id, feat_id)
);

CREATE INDEX idx_phb_background_feat_option_feat
  ON rpg.phb_background_feat_option (feat_id);
