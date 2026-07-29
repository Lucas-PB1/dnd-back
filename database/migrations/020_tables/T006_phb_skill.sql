-- Tabela rpg.phb_skill

CREATE TABLE rpg.phb_skill (
  id BIGSERIAL PRIMARY KEY,
  slug TEXT NOT NULL UNIQUE,
  name TEXT NOT NULL,
  ability_id BIGINT NOT NULL REFERENCES rpg.phb_ability(id),
  description TEXT
);
