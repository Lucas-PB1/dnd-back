-- Tabela rpg.phb_feat_category

CREATE TABLE rpg.phb_feat_category (
  id BIGSERIAL PRIMARY KEY,
  slug TEXT NOT NULL UNIQUE,
  name TEXT NOT NULL,
  type_label TEXT NOT NULL,
  sort_order INTEGER NOT NULL DEFAULT 0
);
