-- Pré-requisito: talento(s) já adquiridos.

CREATE TABLE rpg.phb_feat_requirement_feat (
  feat_id BIGINT NOT NULL REFERENCES rpg.phb_feat_requirement(feat_id) ON DELETE CASCADE,
  required_feat_id BIGINT NOT NULL REFERENCES rpg.phb_feat(id),
  PRIMARY KEY (feat_id, required_feat_id),
  CONSTRAINT phb_feat_requirement_feat_no_self CHECK (feat_id <> required_feat_id)
);

CREATE INDEX idx_phb_feat_requirement_feat_required
  ON rpg.phb_feat_requirement_feat (required_feat_id);
