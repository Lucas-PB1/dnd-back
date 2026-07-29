-- Cotas de truques / magias preparadas por nível (subclasse conjuradora)

CREATE TABLE IF NOT EXISTS rpg.phb_subclass_progression (
  subclass_id BIGINT NOT NULL REFERENCES rpg.phb_subclass(id) ON DELETE CASCADE,
  level INTEGER NOT NULL CHECK (level BETWEEN 1 AND 20),
  cantrips INTEGER CHECK (cantrips IS NULL OR cantrips >= 0),
  prepared_spells INTEGER CHECK (prepared_spells IS NULL OR prepared_spells >= 0),
  PRIMARY KEY (subclass_id, level)
);

CREATE INDEX IF NOT EXISTS idx_subclass_progression_subclass
  ON rpg.phb_subclass_progression(subclass_id);
