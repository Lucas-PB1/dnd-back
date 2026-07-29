-- Tabela rpg.phb_class_starting_package

CREATE TABLE rpg.phb_class_starting_package (
  id BIGSERIAL PRIMARY KEY,
  class_id BIGINT NOT NULL REFERENCES rpg.phb_class(id) ON DELETE CASCADE,
  slug TEXT NOT NULL,
  label TEXT NOT NULL,
  sort_order INTEGER NOT NULL DEFAULT 0,
  UNIQUE (class_id, slug)
);
