CREATE TABLE rpg.phb_effect_combat_mod (
  effect_id BIGINT PRIMARY KEY
    REFERENCES rpg.phb_effect(id) ON DELETE CASCADE,
  mod_kind rpg.effect_combat_mod_kind NOT NULL,
  flat_bonus INTEGER NOT NULL DEFAULT 0,
  per_level_bonus INTEGER NOT NULL DEFAULT 0,
  from_level INTEGER NOT NULL DEFAULT 1 CHECK (from_level >= 1),
  second_ability_slug TEXT REFERENCES rpg.phb_ability(slug),
  allows_shield BOOLEAN NOT NULL DEFAULT FALSE,
  CONSTRAINT phb_effect_combat_mod_fields CHECK (
    (mod_kind = 'hp_bonus' AND second_ability_slug IS NULL)
    OR (mod_kind = 'unarmored_defense' AND second_ability_slug IS NOT NULL
        AND flat_bonus = 0 AND per_level_bonus = 0)
  )
);
