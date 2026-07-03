-- Tabela rpg.phb_spell_class

CREATE TABLE rpg.phb_spell_class (
  spell_id BIGINT NOT NULL REFERENCES rpg.phb_spell(id) ON DELETE CASCADE,
  class_id BIGINT NOT NULL REFERENCES rpg.phb_class(id) ON DELETE CASCADE,
  PRIMARY KEY (spell_id, class_id)
);
