-- Regras extras de temp_hp (ex.: recarga de Proteção Arcana via slot).
CREATE TABLE rpg.phb_effect_temp_hp (
  effect_id BIGINT PRIMARY KEY
    REFERENCES rpg.phb_effect(id) ON DELETE CASCADE,
  consume_spell_slot BOOLEAN NOT NULL DEFAULT false,
  amount_per_slot_level INTEGER NULL
    CHECK (amount_per_slot_level IS NULL OR amount_per_slot_level >= 1),
  ward_temp_hp_cap BOOLEAN NOT NULL DEFAULT false
);
