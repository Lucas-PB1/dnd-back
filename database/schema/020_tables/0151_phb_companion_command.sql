-- Comandos de mesa do companheiro (labels PT + formato de nota).

CREATE TABLE IF NOT EXISTS rpg.phb_companion_command (
  slug TEXT PRIMARY KEY,
  label_pt TEXT NOT NULL,
  note_kind TEXT NOT NULL CHECK (note_kind IN ('strike', 'bonus_action')),
  sort_order INTEGER NOT NULL DEFAULT 0
);
