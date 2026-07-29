-- Tabela rpg.phb_subclass_option_value

CREATE TABLE rpg.phb_subclass_option_value (
  subclass_id   BIGINT NOT NULL,
  option_key    TEXT NOT NULL,
  value_id      TEXT NOT NULL,
  label         TEXT NOT NULL,
  sort_order    INTEGER NOT NULL DEFAULT 0,
  PRIMARY KEY (subclass_id, option_key, value_id),
  FOREIGN KEY (subclass_id, option_key)
    REFERENCES rpg.phb_subclass_option_def(subclass_id, option_key) ON DELETE CASCADE
);
