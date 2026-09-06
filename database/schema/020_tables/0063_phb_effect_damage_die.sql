CREATE TABLE rpg.phb_effect_damage_die (
  effect_id BIGINT PRIMARY KEY
    REFERENCES rpg.phb_effect(id) ON DELETE CASCADE,
  applies_to rpg.effect_damage_applies_to NOT NULL,
  die TEXT NOT NULL CHECK (die ~ '^[0-9]+d[0-9]+$')
);
