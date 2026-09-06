CREATE TABLE rpg.phb_effect_spell (
  effect_id BIGINT PRIMARY KEY
    REFERENCES rpg.phb_effect(id) ON DELETE CASCADE,
  spell_id BIGINT NULL REFERENCES rpg.phb_spell(id) ON DELETE CASCADE,
  option_key TEXT NULL,
  spell_level INTEGER NULL CHECK (spell_level IS NULL OR spell_level BETWEEN 0 AND 9),
  CONSTRAINT phb_effect_spell_target CHECK (
    spell_id IS NOT NULL OR option_key IS NOT NULL
  )
);
