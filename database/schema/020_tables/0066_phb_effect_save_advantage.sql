CREATE TABLE rpg.phb_effect_save_advantage (
  effect_id BIGINT PRIMARY KEY
    REFERENCES rpg.phb_effect(id) ON DELETE CASCADE,
  ability_slugs TEXT[] NULL,
  condition_slug TEXT NULL
    CHECK (condition_slug IS NULL OR length(trim(condition_slug)) > 0),
  CONSTRAINT phb_effect_save_advantage_scope CHECK (
    ability_slugs IS NOT NULL OR condition_slug IS NOT NULL
  )
);
