-- Tabela rpg.phb_fighting_style

CREATE TABLE rpg.phb_fighting_style (
  id BIGSERIAL PRIMARY KEY,
  slug TEXT NOT NULL UNIQUE,
  name TEXT NOT NULL,
  description TEXT NOT NULL
);
