CREATE TABLE rpg.phb_feat_requirement_ability (
  feat_id BIGINT NOT NULL REFERENCES rpg.phb_feat_requirement(feat_id) ON DELETE CASCADE,
  ability_id BIGINT NOT NULL REFERENCES rpg.phb_ability(id),
  minimum_score INTEGER NOT NULL CHECK (minimum_score BETWEEN 1 AND 30),
  PRIMARY KEY (feat_id, ability_id)
);

-- Aumentos de atributo concedidos por capacidade de classe em um nível fixo
-- (ex.: Bárbaro "Campeão Primitivo" e Monge "Corpo e Mente" no nível 20),
-- que elevam atributos acima do teto normal de 20 até um teto próprio.
