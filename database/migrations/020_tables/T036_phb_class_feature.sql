-- Tabela rpg.phb_class_feature

CREATE TABLE rpg.phb_class_feature (
  id BIGSERIAL PRIMARY KEY,
  class_id BIGINT NOT NULL REFERENCES rpg.phb_class(id) ON DELETE CASCADE,
  level INTEGER NOT NULL CHECK (level >= 1),
  name TEXT NOT NULL,
  description TEXT NOT NULL,
  UNIQUE (class_id, level, name)
);
