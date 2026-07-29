-- Tabela rpg.phb_item

CREATE TABLE rpg.phb_item (
  id BIGSERIAL PRIMARY KEY,
  slug TEXT NOT NULL UNIQUE,
  item_type rpg.item_type NOT NULL,
  name TEXT NOT NULL,
  cost JSONB,
  weight TEXT,
  description TEXT,
  properties JSONB,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
