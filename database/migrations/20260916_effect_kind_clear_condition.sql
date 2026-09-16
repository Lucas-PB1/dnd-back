-- Condição encerrada na ficha (Curar Veneno, Resguardo Mental). Idempotente.

ALTER TYPE rpg.effect_kind ADD VALUE IF NOT EXISTS 'clear_condition';
