-- Sentido especial (visão no escuro, …) ou imunidade a perigo ambiental.
CREATE TABLE rpg.phb_effect_sense_env (
  effect_id BIGINT PRIMARY KEY
    REFERENCES rpg.phb_effect(id) ON DELETE CASCADE,
  sense_env_kind TEXT NOT NULL
    CHECK (sense_env_kind IN ('sense', 'environmental_immunity')),
  sense_slug rpg.effect_sense_slug NULL,
  range_ft INTEGER NULL CHECK (range_ft IS NULL OR range_ft > 0),
  duration_minutes INTEGER NULL CHECK (duration_minutes IS NULL OR duration_minutes > 0),
  hazard_slug rpg.effect_env_hazard NULL,
  CONSTRAINT phb_effect_sense_env_shape CHECK (
    (sense_env_kind = 'sense'
      AND sense_slug IS NOT NULL AND range_ft IS NOT NULL AND hazard_slug IS NULL)
    OR (sense_env_kind = 'environmental_immunity'
      AND hazard_slug IS NOT NULL
      AND sense_slug IS NULL AND range_ft IS NULL AND duration_minutes IS NULL)
  )
);
