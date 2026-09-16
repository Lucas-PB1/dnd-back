-- Fórmulas de apply de ficha (Bênção da Recuperação / Líder Inspirador). Idempotente.

ALTER TYPE rpg.effect_amount_formula ADD VALUE IF NOT EXISTS 'one_plus_half_hp_max';
ALTER TYPE rpg.effect_amount_formula ADD VALUE IF NOT EXISTS 'level_plus_flat';
