CREATE TABLE rpg.phb_feat_requirement_weapon_proficiency (
  feat_id BIGINT NOT NULL REFERENCES rpg.phb_feat_requirement(feat_id) ON DELETE CASCADE,
  proficiency_slug TEXT NOT NULL,
  PRIMARY KEY (feat_id, proficiency_slug)
);
