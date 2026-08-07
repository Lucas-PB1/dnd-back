-- Tabela rpg.phb_subclass_feature

CREATE TABLE rpg.phb_subclass_feature (
  id BIGSERIAL PRIMARY KEY,
  subclass_id BIGINT NOT NULL REFERENCES rpg.phb_subclass(id) ON DELETE CASCADE,
  level INTEGER NOT NULL CHECK (level >= 1),
  name TEXT NOT NULL,
  description TEXT NOT NULL,
  feature_kind rpg.subclass_feature_kind NOT NULL DEFAULT 'passive',
  option_key TEXT,
  UNIQUE (subclass_id, level, name)
);
