-- Tabela rpg.phb_class_saving_throw

CREATE TABLE rpg.phb_class_saving_throw (
  class_id BIGINT NOT NULL REFERENCES rpg.phb_class(id) ON DELETE CASCADE,
  ability_id BIGINT NOT NULL REFERENCES rpg.phb_ability(id),
  PRIMARY KEY (class_id, ability_id)
);
