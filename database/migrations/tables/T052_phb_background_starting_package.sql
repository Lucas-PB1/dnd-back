-- Tabela rpg.phb_background_starting_package

CREATE TABLE rpg.phb_background_starting_package (
  id BIGSERIAL PRIMARY KEY,
  background_id BIGINT NOT NULL REFERENCES rpg.phb_background(id) ON DELETE CASCADE,
  slug TEXT NOT NULL,
  label TEXT NOT NULL,
  gold INTEGER CHECK (gold >= 0),
  sort_order INTEGER NOT NULL DEFAULT 0,
  UNIQUE (background_id, slug)
);
