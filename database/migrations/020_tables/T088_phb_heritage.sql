-- Grim Hollow — identidade de herança (17 jogáveis)

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

CREATE TRIGGER tr_phb_heritage_updated_at
  BEFORE UPDATE ON rpg.phb_heritage
  FOR EACH ROW EXECUTE FUNCTION rpg.set_updated_at();

COMMENT ON TABLE rpg.phb_heritage IS
  'Heranças Grim Hollow — identidade racial (Anão, Elfo, …) com 8 traços modulares do pool global.';

COMMENT ON COLUMN rpg.phb_heritage.image_url IS
  'Caminho público da ilustração (ex. /catalog/heritages/dwarf.png).';
