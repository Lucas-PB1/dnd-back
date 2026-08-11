-- Tabelas 1d100 de propriedades aleatórias de Artefato (DMG Treasure).
CREATE TABLE IF NOT EXISTS rpg.dmg_artifact_random_property (
  id          BIGSERIAL PRIMARY KEY,
  kind        TEXT NOT NULL CHECK (
    kind IN (
      'minor_beneficial',
      'major_beneficial',
      'minor_detrimental',
      'major_detrimental'
    )
  ),
  roll_min    SMALLINT NOT NULL CHECK (roll_min BETWEEN 1 AND 100),
  roll_max    SMALLINT NOT NULL CHECK (roll_max BETWEEN 1 AND 100),
  slug        TEXT NOT NULL,
  summary_pt  TEXT NOT NULL,
  effect      JSONB NOT NULL DEFAULT '{}'::jsonb,
  CONSTRAINT dmg_artifact_random_property_range_check CHECK (roll_min <= roll_max),
  CONSTRAINT dmg_artifact_random_property_kind_slug_unique UNIQUE (kind, slug)
);

CREATE INDEX IF NOT EXISTS idx_dmg_artifact_random_property_kind
  ON rpg.dmg_artifact_random_property (kind);

CREATE INDEX IF NOT EXISTS idx_dmg_artifact_random_property_roll
  ON rpg.dmg_artifact_random_property (kind, roll_min, roll_max);

COMMENT ON TABLE rpg.dmg_artifact_random_property IS
  'Faixas 1d100 de propriedades aleatórias de artefato (benéfica/prejudicial × menor/maior).';
