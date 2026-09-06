CREATE TABLE rpg.phb_effect_feat (
  effect_id BIGINT PRIMARY KEY
    REFERENCES rpg.phb_effect(id) ON DELETE CASCADE,
  option_key TEXT NOT NULL,
  feat_category TEXT NULL
    CHECK (feat_category IS NULL OR length(trim(feat_category)) > 0)
);
