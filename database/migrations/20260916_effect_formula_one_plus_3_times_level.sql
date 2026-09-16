-- Fórmula de Sentinela Imortal (1 + 3 × nível). Idempotente.

ALTER TYPE rpg.effect_amount_formula ADD VALUE IF NOT EXISTS 'one_plus_3_times_level';
