-- Tabela rpg.phb_geppettin_construction

CREATE TABLE rpg.phb_geppettin_construction (
  id BIGSERIAL PRIMARY KEY,
  slug TEXT NOT NULL UNIQUE,
  name TEXT NOT NULL,
  benefit TEXT NOT NULL
);
