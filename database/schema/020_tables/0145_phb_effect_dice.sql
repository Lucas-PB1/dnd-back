-- Dados NdM de effect: dado de dano por alvo (damage_die) ou dados livres (custo / dano extra).
CREATE TABLE rpg.phb_effect_dice (
  effect_id BIGINT PRIMARY KEY
    REFERENCES rpg.phb_effect(id) ON DELETE CASCADE,
  dice_kind TEXT NOT NULL CHECK (dice_kind IN ('damage_die', 'dice')),
  die TEXT NOT NULL
    CHECK (die ~ '^[0-9]+d[0-9]+$'),
  applies_to rpg.effect_damage_applies_to NULL,
  die_at_level TEXT NULL
    CHECK (die_at_level IS NULL OR die_at_level ~ '^[0-9]+d[0-9]+$'),
  at_level INT NULL CHECK (at_level IS NULL OR at_level BETWEEN 1 AND 20),
  damage_type_slug TEXT NULL,
  CONSTRAINT phb_effect_dice_shape CHECK (
    (dice_kind = 'damage_die'
      AND applies_to IS NOT NULL
      AND die_at_level IS NULL AND at_level IS NULL AND damage_type_slug IS NULL)
    OR (dice_kind = 'dice' AND applies_to IS NULL)
  )
);
