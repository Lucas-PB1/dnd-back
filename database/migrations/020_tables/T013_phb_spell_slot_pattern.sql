-- Tabela rpg.phb_spell_slot_pattern

CREATE TABLE rpg.phb_spell_slot_pattern (
  id BIGSERIAL PRIMARY KEY,
  slug TEXT NOT NULL UNIQUE,
  name TEXT NOT NULL,
  description TEXT
);
