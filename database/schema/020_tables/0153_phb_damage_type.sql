-- Catálogo de tipos de dano (slug EN → rótulo PT para display).

CREATE TABLE IF NOT EXISTS rpg.phb_damage_type (
  slug TEXT PRIMARY KEY,
  label_pt TEXT NOT NULL CHECK (length(trim(label_pt)) > 0),
  sort_order INTEGER NOT NULL DEFAULT 0
);
