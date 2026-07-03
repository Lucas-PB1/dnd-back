-- Tabela rpg.phb_spell_school

CREATE TABLE rpg.phb_spell_school (
  id BIGSERIAL PRIMARY KEY,
  slug TEXT NOT NULL UNIQUE,
  name TEXT NOT NULL,
  sort_order INTEGER NOT NULL DEFAULT 0
);
