-- Tabela rpg.phb_class_skill_pool

CREATE TABLE rpg.phb_class_skill_pool (
  class_id BIGINT NOT NULL REFERENCES rpg.phb_class(id) ON DELETE CASCADE,
  skill_id BIGINT NOT NULL REFERENCES rpg.phb_skill(id),
  PRIMARY KEY (class_id, skill_id)
);
