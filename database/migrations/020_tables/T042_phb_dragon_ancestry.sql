-- Tabela rpg.phb_dragon_ancestry

CREATE TABLE rpg.phb_dragon_ancestry (
  id BIGSERIAL PRIMARY KEY,
  slug TEXT NOT NULL UNIQUE,
  name TEXT NOT NULL,
  damage_type TEXT NOT NULL
);
