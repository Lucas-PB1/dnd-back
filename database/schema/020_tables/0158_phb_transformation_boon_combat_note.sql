CREATE TABLE rpg.phb_transformation_boon_combat_note (
  boon_id TEXT PRIMARY KEY CHECK (length(trim(boon_id)) > 0),
  name_pt TEXT NOT NULL CHECK (length(trim(name_pt)) > 0),
  economy TEXT[] NOT NULL DEFAULT '{}',
  note_pt TEXT
);

COMMENT ON TABLE rpg.phb_transformation_boon_combat_note IS
  'Notas de combate Cap.6 por boon_id (ficha / combat slice).';
