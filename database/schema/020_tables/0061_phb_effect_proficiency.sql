CREATE TABLE rpg.phb_effect_proficiency (
  effect_id BIGINT PRIMARY KEY
    REFERENCES rpg.phb_effect(id) ON DELETE CASCADE,
  option_key TEXT NOT NULL,
  proficiency_kind rpg.effect_proficiency_kind NOT NULL
);
