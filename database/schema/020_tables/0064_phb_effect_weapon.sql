CREATE TABLE rpg.phb_effect_weapon (
  effect_id BIGINT PRIMARY KEY
    REFERENCES rpg.phb_effect(id) ON DELETE CASCADE,
  property_slug TEXT NULL
    CHECK (property_slug IS NULL OR length(trim(property_slug)) > 0),
  range_normal_ft INTEGER NULL
    CHECK (range_normal_ft IS NULL OR range_normal_ft > 0),
  range_long_ft INTEGER NULL
    CHECK (range_long_ft IS NULL OR range_long_ft > 0),
  CONSTRAINT phb_effect_weapon_mode CHECK (
    (
      property_slug IS NOT NULL
      AND range_normal_ft IS NULL
      AND range_long_ft IS NULL
    )
    OR (
      property_slug IS NULL
      AND range_normal_ft IS NOT NULL
      AND range_long_ft IS NOT NULL
      AND range_long_ft >= range_normal_ft
    )
  )
);
