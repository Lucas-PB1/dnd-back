-- Movimento forçado tipado (ex.: Push 3 m). Sem grid: runtime registra marca/log.
CREATE TABLE rpg.phb_effect_forced_movement (
  effect_id BIGINT PRIMARY KEY
    REFERENCES rpg.phb_effect(id) ON DELETE CASCADE,
  distance_m INT NOT NULL CHECK (distance_m > 0),
  max_target_size TEXT NULL
);
