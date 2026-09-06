CREATE TABLE rpg.phb_effect_purchase_discount (
  effect_id BIGINT PRIMARY KEY
    REFERENCES rpg.phb_effect(id) ON DELETE CASCADE,
  percent_off INTEGER NOT NULL CHECK (percent_off BETWEEN 1 AND 99),
  non_magic_only BOOLEAN NOT NULL DEFAULT TRUE,
  food_drink_only BOOLEAN NOT NULL DEFAULT FALSE
);
