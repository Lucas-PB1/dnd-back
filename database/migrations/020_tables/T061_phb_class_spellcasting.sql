-- Tabela rpg.phb_class_spellcasting

CREATE TABLE rpg.phb_class_spellcasting (
  class_id BIGINT PRIMARY KEY REFERENCES rpg.phb_class(id) ON DELETE CASCADE,
  casting_type rpg.casting_type NOT NULL,
  ability_id BIGINT REFERENCES rpg.phb_ability(id),
  focus_label TEXT,
  focus_item_id BIGINT REFERENCES rpg.phb_item(id),
  ritual BOOLEAN NOT NULL DEFAULT FALSE
);
