CREATE TABLE rpg.phb_heritage_combat_note (
  id BIGSERIAL PRIMARY KEY,
  trait_id BIGINT NOT NULL REFERENCES rpg.phb_heritage_trait(id) ON DELETE CASCADE,
  min_trait_takes INTEGER NOT NULL DEFAULT 1 CHECK (min_trait_takes >= 1),
  note TEXT NOT NULL CHECK (length(trim(note)) > 0),
  UNIQUE (trait_id, min_trait_takes)
);

CREATE INDEX idx_phb_heritage_combat_note_trait
  ON rpg.phb_heritage_combat_note (trait_id);

COMMENT ON TABLE rpg.phb_heritage_combat_note IS
  'Notas de combate por traço de heritage (tier por min_trait_takes; {takes} = contagem).';
