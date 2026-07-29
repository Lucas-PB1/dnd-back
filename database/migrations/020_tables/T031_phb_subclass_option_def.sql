-- Tabela rpg.phb_subclass_option_def

CREATE TABLE rpg.phb_subclass_option_def (
  subclass_id   BIGINT NOT NULL REFERENCES rpg.phb_subclass(id) ON DELETE CASCADE,
  option_key    TEXT NOT NULL,
  label         TEXT NOT NULL,
  unlock_level  INTEGER NOT NULL DEFAULT 3 CHECK (unlock_level BETWEEN 1 AND 20),
  value_type    rpg.option_value_type NOT NULL DEFAULT 'catalog',
  PRIMARY KEY (subclass_id, option_key)
);
