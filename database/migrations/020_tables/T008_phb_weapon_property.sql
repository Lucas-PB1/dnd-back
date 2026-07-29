-- Tabela rpg.phb_weapon_property

CREATE TABLE rpg.phb_weapon_property (
  id BIGSERIAL PRIMARY KEY,
  slug TEXT NOT NULL UNIQUE,
  name TEXT NOT NULL,
  description TEXT NOT NULL
);
