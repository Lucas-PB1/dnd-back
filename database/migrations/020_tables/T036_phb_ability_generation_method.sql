-- Tabela rpg.phb_ability_generation_method

CREATE TABLE rpg.phb_ability_generation_method (
  id BIGSERIAL PRIMARY KEY,
  slug TEXT NOT NULL UNIQUE,
  name TEXT NOT NULL,
  description TEXT NOT NULL
);
