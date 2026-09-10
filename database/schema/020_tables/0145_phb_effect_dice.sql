-- Dados NdM livres (custo em si / dano extra) — satélite de effect.
CREATE TABLE rpg.phb_effect_dice (
  effect_id BIGINT PRIMARY KEY
    REFERENCES rpg.phb_effect(id) ON DELETE CASCADE,
  die TEXT NOT NULL
    CHECK (die ~ '^[0-9]+d[0-9]+$'),
  die_at_level TEXT NULL
    CHECK (die_at_level IS NULL OR die_at_level ~ '^[0-9]+d[0-9]+$'),
  at_level INT NULL CHECK (at_level IS NULL OR at_level BETWEEN 1 AND 20),
  damage_type_slug TEXT NULL
);
