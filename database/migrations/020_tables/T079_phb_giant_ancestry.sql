-- Tabela rpg.phb_giant_ancestry

CREATE TABLE rpg.phb_giant_ancestry (
  id BIGSERIAL PRIMARY KEY,
  slug TEXT NOT NULL UNIQUE,
  name TEXT NOT NULL,
  benefit TEXT NOT NULL
);
