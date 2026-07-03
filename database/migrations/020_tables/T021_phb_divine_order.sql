-- Tabela rpg.phb_divine_order

CREATE TABLE rpg.phb_divine_order (
  id BIGSERIAL PRIMARY KEY,
  slug TEXT NOT NULL UNIQUE,
  name TEXT NOT NULL,
  description TEXT NOT NULL
);
