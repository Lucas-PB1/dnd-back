-- Tabela rpg.phb_armor_category

CREATE TABLE rpg.phb_armor_category (
  id BIGSERIAL PRIMARY KEY,
  slug TEXT NOT NULL UNIQUE,
  name TEXT NOT NULL,
  don_doff TEXT,
  sort_order INTEGER NOT NULL DEFAULT 0
);
