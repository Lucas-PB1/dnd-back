-- Tabela rpg.phb_class_fighting_style

CREATE TABLE rpg.phb_class_fighting_style (
  class_id BIGINT NOT NULL REFERENCES rpg.phb_class(id) ON DELETE CASCADE,
  fighting_style_id BIGINT NOT NULL REFERENCES rpg.phb_fighting_style(id) ON DELETE CASCADE,
  PRIMARY KEY (class_id, fighting_style_id)
);
