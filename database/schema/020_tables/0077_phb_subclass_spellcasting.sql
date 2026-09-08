CREATE TABLE rpg.phb_subclass_spellcasting (
  subclass_id BIGINT PRIMARY KEY REFERENCES rpg.phb_subclass(id) ON DELETE CASCADE,
  casting_type rpg.casting_type NOT NULL,
  ability_id BIGINT REFERENCES rpg.phb_ability(id),
  focus_label TEXT,
  focus_item_id BIGINT REFERENCES rpg.phb_item(id),
  spell_list_class_id BIGINT NOT NULL REFERENCES rpg.phb_class(id),
  spell_slot_pattern_id BIGINT NOT NULL REFERENCES rpg.phb_spell_slot_pattern(id),
  ritual BOOLEAN NOT NULL DEFAULT FALSE
);

CREATE INDEX idx_subclass_spellcasting_list
  ON rpg.phb_subclass_spellcasting(spell_list_class_id);

-- Cotas de truques / magias preparadas por nível (subclasse conjuradora)
