-- Tabela rpg.phb_weapon_mastery

CREATE TABLE rpg.phb_weapon_mastery (
  id BIGSERIAL PRIMARY KEY,
  slug TEXT NOT NULL UNIQUE,
  name TEXT NOT NULL,
  description TEXT NOT NULL
);
