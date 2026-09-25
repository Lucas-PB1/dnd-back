-- Payloads escalares pequenos (quantidade, alcance, companheiro, desconto de compra).
CREATE TABLE rpg.phb_effect_scalar (
  effect_id BIGINT PRIMARY KEY
    REFERENCES rpg.phb_effect(id) ON DELETE CASCADE,
  scalar_kind TEXT NOT NULL
    CHECK (scalar_kind IN ('numeric', 'reach', 'companion', 'purchase_discount')),
  amount_formula rpg.effect_amount_formula NULL,
  flat INTEGER NULL CHECK (flat IS NULL OR flat >= 0),
  bonus_ft INTEGER NULL CHECK (bonus_ft IS NULL OR bonus_ft > 0),
  exclude_property_slugs TEXT[] NULL,
  restore_hp BOOLEAN NULL,
  percent_off INTEGER NULL CHECK (percent_off IS NULL OR percent_off BETWEEN 1 AND 99),
  non_magic_only BOOLEAN NULL,
  food_drink_only BOOLEAN NULL,
  CONSTRAINT phb_effect_scalar_shape CHECK (
    (scalar_kind = 'numeric'
      AND amount_formula IS NOT NULL
      AND ((amount_formula = 'fixed') = (flat IS NOT NULL))
      AND bonus_ft IS NULL AND exclude_property_slugs IS NULL AND restore_hp IS NULL
      AND percent_off IS NULL AND non_magic_only IS NULL AND food_drink_only IS NULL)
    OR (scalar_kind = 'reach'
      AND bonus_ft IS NOT NULL
      AND amount_formula IS NULL AND flat IS NULL AND restore_hp IS NULL
      AND percent_off IS NULL AND non_magic_only IS NULL AND food_drink_only IS NULL)
    OR (scalar_kind = 'companion'
      AND restore_hp IS NOT NULL
      AND amount_formula IS NULL AND flat IS NULL AND bonus_ft IS NULL
      AND exclude_property_slugs IS NULL
      AND percent_off IS NULL AND non_magic_only IS NULL AND food_drink_only IS NULL)
    OR (scalar_kind = 'purchase_discount'
      AND percent_off IS NOT NULL AND non_magic_only IS NOT NULL AND food_drink_only IS NOT NULL
      AND amount_formula IS NULL AND flat IS NULL AND bonus_ft IS NULL
      AND exclude_property_slugs IS NULL AND restore_hp IS NULL)
  )
);
