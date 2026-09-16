-- Fórmula Resistência Incomparável 2× (1d6 + PB). Idempotente.

ALTER TYPE rpg.effect_amount_formula ADD VALUE IF NOT EXISTS 'dice_1d6_plus_pb';
