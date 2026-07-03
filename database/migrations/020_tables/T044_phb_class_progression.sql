-- Tabela rpg.phb_class_progression

CREATE TABLE rpg.phb_class_progression (
  class_id BIGINT NOT NULL REFERENCES rpg.phb_class(id) ON DELETE CASCADE,
  level INTEGER NOT NULL CHECK (level BETWEEN 1 AND 20),
  proficiency_bonus INTEGER NOT NULL CHECK (proficiency_bonus BETWEEN 2 AND 6),
  cantrips INTEGER CHECK (cantrips >= 0),
  prepared_spells INTEGER CHECK (prepared_spells >= 0),
  channel_divinity INTEGER CHECK (channel_divinity >= 0),
  PRIMARY KEY (class_id, level)
);
