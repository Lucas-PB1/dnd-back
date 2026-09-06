CREATE TABLE rpg.phb_effect_rest_quirk (
  effect_id BIGINT PRIMARY KEY
    REFERENCES rpg.phb_effect(id) ON DELETE CASCADE,
  long_rest_hours INTEGER NOT NULL DEFAULT 8
    CHECK (long_rest_hours BETWEEN 1 AND 8),
  no_sleep BOOLEAN NOT NULL DEFAULT FALSE,
  magic_cannot_force_sleep BOOLEAN NOT NULL DEFAULT FALSE,
  no_food_drink_air BOOLEAN NOT NULL DEFAULT FALSE
);
