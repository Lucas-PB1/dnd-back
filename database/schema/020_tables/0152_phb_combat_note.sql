-- Notas de combate unificadas (classe/subclasse/heritage/boon) — GEN-3.

CREATE TABLE rpg.phb_combat_note (
  id BIGSERIAL PRIMARY KEY,
  source_kind rpg.combat_note_source NOT NULL,
  class_id BIGINT REFERENCES rpg.phb_class(id) ON DELETE CASCADE,
  subclass_id BIGINT REFERENCES rpg.phb_subclass(id) ON DELETE CASCADE,
  unlock_level INTEGER CHECK (unlock_level IS NULL OR unlock_level BETWEEN 1 AND 20),
  trait_id BIGINT REFERENCES rpg.phb_heritage_trait(id) ON DELETE CASCADE,
  min_trait_takes INTEGER CHECK (min_trait_takes IS NULL OR min_trait_takes >= 1),
  boon_id TEXT CHECK (boon_id IS NULL OR length(trim(boon_id)) > 0),
  name_pt TEXT,
  economy TEXT[] NOT NULL DEFAULT '{}',
  note TEXT,
  sort_order INTEGER NOT NULL DEFAULT 0,
  CONSTRAINT phb_combat_note_shape CHECK (
    (
      source_kind = 'class_level'::rpg.combat_note_source
      AND class_id IS NOT NULL AND subclass_id IS NULL
      AND trait_id IS NULL AND boon_id IS NULL
      AND unlock_level IS NOT NULL AND min_trait_takes IS NULL
      AND name_pt IS NULL
      AND note IS NOT NULL AND length(trim(note)) > 0
    )
    OR (
      source_kind = 'subclass_level'::rpg.combat_note_source
      AND subclass_id IS NOT NULL AND class_id IS NULL
      AND trait_id IS NULL AND boon_id IS NULL
      AND unlock_level IS NOT NULL AND min_trait_takes IS NULL
      AND name_pt IS NULL
      AND note IS NOT NULL AND length(trim(note)) > 0
    )
    OR (
      source_kind = 'heritage_trait'::rpg.combat_note_source
      AND trait_id IS NOT NULL AND min_trait_takes IS NOT NULL
      AND class_id IS NULL AND subclass_id IS NULL AND boon_id IS NULL
      AND unlock_level IS NULL AND name_pt IS NULL
      AND note IS NOT NULL AND length(trim(note)) > 0
    )
    OR (
      source_kind = 'transformation_boon'::rpg.combat_note_source
      AND boon_id IS NOT NULL AND name_pt IS NOT NULL AND length(trim(name_pt)) > 0
      AND class_id IS NULL AND subclass_id IS NULL AND trait_id IS NULL
      AND unlock_level IS NULL AND min_trait_takes IS NULL
    )
  )
);

CREATE INDEX idx_phb_combat_note_class
  ON rpg.phb_combat_note (class_id, unlock_level)
  WHERE class_id IS NOT NULL;

CREATE INDEX idx_phb_combat_note_subclass
  ON rpg.phb_combat_note (subclass_id, unlock_level)
  WHERE subclass_id IS NOT NULL;

CREATE INDEX idx_phb_combat_note_trait
  ON rpg.phb_combat_note (trait_id)
  WHERE trait_id IS NOT NULL;

CREATE UNIQUE INDEX uq_phb_combat_note_heritage
  ON rpg.phb_combat_note (trait_id, min_trait_takes)
  WHERE source_kind = 'heritage_trait'::rpg.combat_note_source;

CREATE UNIQUE INDEX uq_phb_combat_note_boon
  ON rpg.phb_combat_note (boon_id)
  WHERE source_kind = 'transformation_boon'::rpg.combat_note_source;

COMMENT ON TABLE rpg.phb_combat_note IS
  'Notas de combate de mesa por fonte (GEN-3: level + heritage + transformation boon).';
