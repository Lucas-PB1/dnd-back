CREATE TABLE rpg.phb_heritage_trait (
  id BIGSERIAL PRIMARY KEY,
  slug TEXT NOT NULL UNIQUE,
  anchor_id TEXT NOT NULL,
  category rpg.heritage_trait_category NOT NULL,
  name TEXT NOT NULL,
  description TEXT NOT NULL,
  benefit_base TEXT NOT NULL,
  benefit_improved TEXT,
  improved_name TEXT,
  max_takes INTEGER CHECK (max_takes IS NULL OR max_takes >= 1),
  take_mode rpg.heritage_trait_take_mode NOT NULL DEFAULT 'stack',
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_phb_heritage_trait_category ON rpg.phb_heritage_trait(category);
CREATE INDEX idx_phb_heritage_trait_anchor ON rpg.phb_heritage_trait(anchor_id);

COMMENT ON TABLE rpg.phb_heritage_trait IS
  'TraÃ§os modulares GH â€” pool global; repetiÃ§Ã£o aplica benefit_improved conforme max_takes/take_mode.';
