CREATE TABLE rpg.phb_effect_sense (
  effect_id BIGINT PRIMARY KEY
    REFERENCES rpg.phb_effect(id) ON DELETE CASCADE,
  sense_slug rpg.effect_sense_slug NOT NULL,
  range_ft INTEGER NOT NULL CHECK (range_ft > 0),
  duration_minutes INTEGER NULL CHECK (duration_minutes IS NULL OR duration_minutes > 0)
);
