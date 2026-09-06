CREATE TABLE rpg.phb_effect_reach (
  effect_id BIGINT PRIMARY KEY
    REFERENCES rpg.phb_effect(id) ON DELETE CASCADE,
  bonus_ft INTEGER NOT NULL CHECK (bonus_ft > 0),
  exclude_property_slugs TEXT[] NULL
);
