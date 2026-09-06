CREATE TABLE rpg.phb_effect_damage_type (
  effect_id BIGINT PRIMARY KEY
    REFERENCES rpg.phb_effect(id) ON DELETE CASCADE,
  damage_type_slug TEXT NULL
    CHECK (damage_type_slug IS NULL OR length(trim(damage_type_slug)) > 0),
  option_key TEXT NULL,
  CONSTRAINT phb_effect_damage_type_target CHECK (
    damage_type_slug IS NOT NULL OR option_key IS NOT NULL
  )
);
