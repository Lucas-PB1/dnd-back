-- Notas de combate por nível (classe/subclasse) — texto de ficha.

CREATE TABLE IF NOT EXISTS rpg.phb_level_combat_note (
  id BIGSERIAL PRIMARY KEY,
  owner_kind TEXT NOT NULL CHECK (owner_kind IN ('class', 'subclass')),
  class_id BIGINT REFERENCES rpg.phb_class(id) ON DELETE CASCADE,
  subclass_id BIGINT REFERENCES rpg.phb_subclass(id) ON DELETE CASCADE,
  unlock_level INTEGER NOT NULL CHECK (unlock_level BETWEEN 1 AND 20),
  note TEXT NOT NULL CHECK (length(trim(note)) > 0),
  sort_order INTEGER NOT NULL DEFAULT 0,
  CONSTRAINT phb_level_combat_note_owner CHECK (
    (owner_kind = 'class' AND class_id IS NOT NULL AND subclass_id IS NULL)
    OR (owner_kind = 'subclass' AND subclass_id IS NOT NULL AND class_id IS NULL)
  )
);

CREATE INDEX idx_phb_level_combat_note_class
  ON rpg.phb_level_combat_note (class_id, unlock_level)
  WHERE class_id IS NOT NULL;

CREATE INDEX idx_phb_level_combat_note_subclass
  ON rpg.phb_level_combat_note (subclass_id, unlock_level)
  WHERE subclass_id IS NOT NULL;
