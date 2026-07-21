-- Tabela rpg.phb_gnome_lineage

CREATE TABLE rpg.phb_gnome_lineage (
  id BIGSERIAL PRIMARY KEY,
  slug TEXT NOT NULL UNIQUE,
  name TEXT NOT NULL,
  level1_benefit TEXT NOT NULL
);
