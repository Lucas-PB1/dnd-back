-- Tabela rpg.phb_class_armor_training

CREATE TABLE rpg.phb_class_armor_training (
  class_id BIGINT NOT NULL REFERENCES rpg.phb_class(id) ON DELETE CASCADE,
  category_id BIGINT NOT NULL REFERENCES rpg.phb_armor_category(id),
  PRIMARY KEY (class_id, category_id)
);
