-- Tabela rpg.phb_mandrake_season

CREATE TABLE rpg.phb_mandrake_season (
  id BIGSERIAL PRIMARY KEY,
  slug TEXT NOT NULL UNIQUE,
  name TEXT NOT NULL,
  benefit TEXT NOT NULL
);
