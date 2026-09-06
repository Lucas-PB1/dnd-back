CREATE TABLE rpg.phb_effect_resource (
  effect_id BIGINT PRIMARY KEY
    REFERENCES rpg.phb_effect(id) ON DELETE CASCADE,
  resource_id BIGINT NOT NULL
    REFERENCES rpg.phb_resource_definition(id) ON DELETE CASCADE,
  max_formula rpg.resource_max_formula NOT NULL,
  fixed_max INTEGER CHECK (fixed_max IS NULL OR fixed_max >= 0),
  recover_one_on_short BOOLEAN NOT NULL DEFAULT FALSE,
  recover_all_on_short BOOLEAN NOT NULL DEFAULT FALSE,
  recover_all_on_long BOOLEAN NOT NULL DEFAULT TRUE,
  recover_on_long_dice TEXT NULL,
  CONSTRAINT phb_effect_resource_formula_fixed CHECK (
    (max_formula = 'fixed' AND fixed_max IS NOT NULL)
    OR (max_formula <> 'fixed' AND fixed_max IS NULL)
  )
);
