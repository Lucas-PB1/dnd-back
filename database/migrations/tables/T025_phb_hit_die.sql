-- Tabela rpg.phb_hit_die

CREATE TABLE rpg.phb_hit_die (
  id BIGSERIAL PRIMARY KEY,
  slug TEXT NOT NULL UNIQUE,
  sides INTEGER NOT NULL UNIQUE CHECK (sides IN (6, 8, 10, 12)),
  label TEXT NOT NULL
);
