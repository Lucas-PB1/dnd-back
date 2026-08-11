-- Tabelas de geração de item senciente (DMG Treasure — Sentient Magic Items).
CREATE TABLE IF NOT EXISTS rpg.dmg_sentient_trait_table (
  id          BIGSERIAL PRIMARY KEY,
  kind        TEXT NOT NULL CHECK (
    kind IN (
      'alignment',
      'communication',
      'senses',
      'special_purpose',
      'ability_scores'
    )
  ),
  roll_min    SMALLINT NOT NULL CHECK (roll_min >= 1),
  roll_max    SMALLINT NOT NULL CHECK (roll_max >= 1),
  slug        TEXT NOT NULL,
  summary_pt  TEXT NOT NULL,
  payload     JSONB NOT NULL DEFAULT '{}'::jsonb,
  CONSTRAINT dmg_sentient_trait_table_range_check CHECK (roll_min <= roll_max),
  CONSTRAINT dmg_sentient_trait_table_kind_slug_unique UNIQUE (kind, slug)
);

CREATE INDEX IF NOT EXISTS idx_dmg_sentient_trait_table_kind
  ON rpg.dmg_sentient_trait_table (kind);

CREATE INDEX IF NOT EXISTS idx_dmg_sentient_trait_table_roll
  ON rpg.dmg_sentient_trait_table (kind, roll_min, roll_max);

COMMENT ON TABLE rpg.dmg_sentient_trait_table IS
  'Faixas de rolagem para gerar alinhamento/comunicação/sentidos/propósito/attrs de item senciente.';
