CREATE TABLE rpg.phb_effect_environmental_immunity (
  effect_id BIGINT PRIMARY KEY
    REFERENCES rpg.phb_effect(id) ON DELETE CASCADE,
  hazard_slug rpg.effect_env_hazard NOT NULL
);

-- Class economy actions (Actions tab catalog)
