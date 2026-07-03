-- Tabela rpg.phb_class_primary_ability

CREATE TABLE rpg.phb_class_primary_ability (
  class_id BIGINT NOT NULL REFERENCES rpg.phb_class(id) ON DELETE CASCADE,
  ability_id BIGINT NOT NULL REFERENCES rpg.phb_ability(id),
  sort_order INTEGER NOT NULL DEFAULT 0,
  PRIMARY KEY (class_id, ability_id)
);
