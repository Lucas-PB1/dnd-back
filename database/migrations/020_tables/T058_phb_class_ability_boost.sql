-- Aumentos de atributo concedidos por capacidade de classe em um nível fixo
-- (ex.: Bárbaro "Campeão Primitivo" e Monge "Corpo e Mente" no nível 20),
-- que elevam atributos acima do teto normal de 20 até um teto próprio.
CREATE TABLE IF NOT EXISTS rpg.phb_class_ability_boost (
  id BIGSERIAL PRIMARY KEY,
  class_id BIGINT NOT NULL REFERENCES rpg.phb_class(id) ON DELETE CASCADE,
  ability_slug TEXT NOT NULL REFERENCES rpg.phb_ability(slug),
  label TEXT NOT NULL,
  bonus INTEGER NOT NULL CHECK (bonus > 0),
  score_max INTEGER NOT NULL CHECK (score_max BETWEEN 20 AND 30),
  from_level INTEGER NOT NULL DEFAULT 1 CHECK (from_level BETWEEN 1 AND 20),
  UNIQUE (class_id, ability_slug, from_level)
);
