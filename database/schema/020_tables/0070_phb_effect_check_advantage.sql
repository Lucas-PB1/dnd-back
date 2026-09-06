CREATE TABLE rpg.phb_effect_check_advantage (
  effect_id BIGINT PRIMARY KEY
    REFERENCES rpg.phb_effect(id) ON DELETE CASCADE,
  skill_slug TEXT NULL,
  circumstance_tag TEXT NULL,
  ability_slug TEXT NULL,
  CONSTRAINT phb_effect_check_advantage_scope CHECK (
    skill_slug IS NOT NULL OR circumstance_tag IS NOT NULL OR ability_slug IS NOT NULL
  )
);
