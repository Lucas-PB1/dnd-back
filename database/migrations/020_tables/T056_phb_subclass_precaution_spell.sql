-- Subclass precaution spells (Dungeoneer Fighter)

CREATE TABLE rpg.phb_subclass_precaution_spell (
  subclass_id   BIGINT NOT NULL REFERENCES rpg.phb_subclass(id) ON DELETE CASCADE,
  spell_id      BIGINT NOT NULL REFERENCES rpg.phb_spell(id) ON DELETE CASCADE,
  PRIMARY KEY (subclass_id, spell_id)
);

CREATE INDEX idx_subclass_precaution_spell_subclass ON rpg.phb_subclass_precaution_spell(subclass_id);
CREATE INDEX idx_subclass_precaution_spell_spell ON rpg.phb_subclass_precaution_spell(spell_id);
