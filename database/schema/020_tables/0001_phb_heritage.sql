CREATE TABLE rpg.phb_heritage (
  id BIGSERIAL PRIMARY KEY,
  slug TEXT NOT NULL UNIQUE,
  name TEXT NOT NULL,
  category rpg.heritage_category NOT NULL,
  creature_type TEXT NOT NULL,
  size_rule TEXT NOT NULL,
  speed_rule TEXT NOT NULL,
  allows_speed_trade BOOLEAN NOT NULL DEFAULT FALSE,
  allows_size_choice BOOLEAN NOT NULL DEFAULT FALSE,
  description TEXT NOT NULL,
  tagline TEXT,
  summary TEXT,
  image_url TEXT,
  source_meta JSONB,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_phb_heritage_category ON rpg.phb_heritage(category);

COMMENT ON TABLE rpg.phb_heritage IS
  'HeranÃ§as Grim Hollow â€” identidade racial (AnÃ£o, Elfo, â€¦) com 8 traÃ§os modulares do pool global.';

COMMENT ON COLUMN rpg.phb_heritage.image_url IS
  'Caminho pÃºblico da ilustraÃ§Ã£o (ex. /catalog/heritages/dwarf.png).';

-- Grim Hollow â€” pool global de traÃ§os modulares (~107)
