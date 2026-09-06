CREATE TABLE rpg.phb_effect_numeric (
  effect_id BIGINT PRIMARY KEY
    REFERENCES rpg.phb_effect(id) ON DELETE CASCADE,
  amount_formula rpg.effect_amount_formula NOT NULL,
  flat INTEGER NULL CHECK (flat IS NULL OR flat >= 0),
  CONSTRAINT phb_effect_numeric_fixed CHECK (
    (amount_formula = 'fixed' AND flat IS NOT NULL)
    OR (amount_formula <> 'fixed' AND flat IS NULL)
  )
);
