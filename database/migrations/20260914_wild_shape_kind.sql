-- Enum isolado: novo valor precisa de COMMIT antes do uso.
ALTER TYPE rpg.effect_kind ADD VALUE IF NOT EXISTS 'wild_shape';
