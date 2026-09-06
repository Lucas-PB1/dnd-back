CREATE TABLE rpg.phb_effect_note (
  effect_id BIGINT PRIMARY KEY
    REFERENCES rpg.phb_effect(id) ON DELETE CASCADE,
  note TEXT NOT NULL CHECK (length(trim(note)) > 0)
);
