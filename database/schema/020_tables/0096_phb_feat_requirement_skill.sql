CREATE TABLE rpg.phb_feat_requirement_skill (
  feat_id BIGINT NOT NULL REFERENCES rpg.phb_feat_requirement(feat_id) ON DELETE CASCADE,
  skill_id BIGINT NOT NULL REFERENCES rpg.phb_skill(id),
  PRIMARY KEY (feat_id, skill_id)
);
