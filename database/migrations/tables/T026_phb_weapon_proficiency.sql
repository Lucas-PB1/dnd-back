-- Tabela rpg.phb_weapon_proficiency

CREATE TABLE rpg.phb_weapon_proficiency (
  id BIGSERIAL PRIMARY KEY,
  slug TEXT NOT NULL UNIQUE,
  label TEXT NOT NULL UNIQUE
);
