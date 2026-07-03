-- Tabela rpg.phb_spell_slot_by_level

CREATE TABLE rpg.phb_spell_slot_by_level (
  pattern_id BIGINT NOT NULL REFERENCES rpg.phb_spell_slot_pattern(id) ON DELETE CASCADE,
  level INTEGER NOT NULL CHECK (level BETWEEN 1 AND 20),
  circle INTEGER NOT NULL CHECK (circle BETWEEN 1 AND 9),
  slot_count INTEGER NOT NULL CHECK (slot_count >= 1),
  PRIMARY KEY (pattern_id, level, circle)
);
