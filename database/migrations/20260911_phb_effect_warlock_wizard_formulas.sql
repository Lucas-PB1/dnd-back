-- Forward: fórmulas mesa bruxo/mago (slots de pacto, Presságio).

ALTER TYPE rpg.effect_amount_formula ADD VALUE IF NOT EXISTS 'pact_slots_recovery_count';
ALTER TYPE rpg.effect_amount_formula ADD VALUE IF NOT EXISTS 'portent_d20_count';
