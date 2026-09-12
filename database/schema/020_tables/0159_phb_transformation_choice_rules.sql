CREATE TABLE rpg.phb_transformation_stage_rule (
  id BIGSERIAL PRIMARY KEY,
  feat_id BIGINT NOT NULL REFERENCES rpg.phb_feat(id) ON DELETE CASCADE,
  stage INTEGER NOT NULL CHECK (stage BETWEEN 1 AND 4),
  mode rpg.transformation_stage_mode NOT NULL,
  UNIQUE (feat_id, stage)
);

CREATE INDEX idx_phb_transformation_stage_rule_feat
  ON rpg.phb_transformation_stage_rule (feat_id);

CREATE TABLE rpg.phb_transformation_stage_auto_boon (
  stage_rule_id BIGINT NOT NULL
    REFERENCES rpg.phb_transformation_stage_rule(id) ON DELETE CASCADE,
  boon_id TEXT NOT NULL CHECK (length(trim(boon_id)) > 0),
  sort_order INTEGER NOT NULL DEFAULT 0,
  PRIMARY KEY (stage_rule_id, boon_id)
);

CREATE TABLE rpg.phb_transformation_stage_pick_key (
  stage_rule_id BIGINT NOT NULL
    REFERENCES rpg.phb_transformation_stage_rule(id) ON DELETE CASCADE,
  pick_key TEXT NOT NULL CHECK (length(trim(pick_key)) > 0),
  sort_order INTEGER NOT NULL DEFAULT 0,
  PRIMARY KEY (stage_rule_id, pick_key)
);

CREATE TABLE rpg.phb_transformation_sub_option (
  id BIGSERIAL PRIMARY KEY,
  feat_id BIGINT NOT NULL REFERENCES rpg.phb_feat(id) ON DELETE CASCADE,
  option_key TEXT NOT NULL CHECK (length(trim(option_key)) > 0),
  from_stage INTEGER NOT NULL CHECK (from_stage BETWEEN 1 AND 4),
  when_choice_key TEXT,
  when_choice_value TEXT,
  UNIQUE (feat_id, option_key),
  CONSTRAINT phb_transformation_sub_option_when CHECK (
    (when_choice_key IS NULL AND when_choice_value IS NULL)
    OR (when_choice_key IS NOT NULL AND when_choice_value IS NOT NULL)
  )
);

CREATE INDEX idx_phb_transformation_sub_option_feat
  ON rpg.phb_transformation_sub_option (feat_id);

CREATE TABLE rpg.phb_transformation_require_match (
  id BIGSERIAL PRIMARY KEY,
  feat_id BIGINT NOT NULL REFERENCES rpg.phb_feat(id) ON DELETE CASCADE,
  later_key TEXT NOT NULL CHECK (length(trim(later_key)) > 0),
  earlier_key TEXT NOT NULL CHECK (length(trim(earlier_key)) > 0),
  UNIQUE (feat_id, later_key, earlier_key)
);

CREATE TABLE rpg.phb_transformation_require_match_pair (
  match_id BIGINT NOT NULL
    REFERENCES rpg.phb_transformation_require_match(id) ON DELETE CASCADE,
  earlier_value TEXT NOT NULL CHECK (length(trim(earlier_value)) > 0),
  later_value TEXT NOT NULL CHECK (length(trim(later_value)) > 0),
  PRIMARY KEY (match_id, earlier_value)
);

COMMENT ON TABLE rpg.phb_transformation_stage_rule IS
  'Cap.6 — modo/auto/picks por estágio de transformação (SSOT choice rules).';
