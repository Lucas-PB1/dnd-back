CREATE TABLE rpg.phb_effect_cast_economy (
  effect_id BIGINT PRIMARY KEY
    REFERENCES rpg.phb_effect(id) ON DELETE CASCADE,
  economy rpg.effect_cast_economy NOT NULL,
  uses_formula rpg.effect_uses_formula NOT NULL DEFAULT 'fixed',
  fixed_uses INTEGER NULL CHECK (fixed_uses IS NULL OR fixed_uses >= 1),
  CONSTRAINT phb_effect_cast_uses CHECK (
    (uses_formula = 'fixed' AND fixed_uses IS NOT NULL)
    OR (uses_formula = 'proficiency_bonus' AND fixed_uses IS NULL)
    OR (economy <> 'once_per_long_rest')
  )
);
