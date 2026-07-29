-- Tabela rpg.phb_alignment

CREATE TABLE rpg.phb_alignment (
  id BIGSERIAL PRIMARY KEY,
  slug TEXT NOT NULL UNIQUE,
  name TEXT NOT NULL,
  abbreviation TEXT,
  description TEXT
);
