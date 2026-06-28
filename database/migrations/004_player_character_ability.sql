-- Fase 5.1 — atributos normalizados (FK phb_ability)

CREATE TABLE IF NOT EXISTS rpg.player_character_ability (
  character_id TEXT NOT NULL REFERENCES rpg.player_character(id) ON DELETE CASCADE,
  ability_id   BIGINT NOT NULL REFERENCES rpg.phb_ability(id),
  score        INTEGER NOT NULL CHECK (score BETWEEN 1 AND 30),
  PRIMARY KEY (character_id, ability_id)
);

DO $$
BEGIN
  IF EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_schema = 'rpg' AND table_name = 'player_character' AND column_name = 'forca'
  ) THEN
    INSERT INTO rpg.player_character_ability (character_id, ability_id, score)
    SELECT pc.id, a.id, v.score
    FROM rpg.player_character pc
    CROSS JOIN LATERAL (
      VALUES
        ('forca', pc.forca),
        ('destreza', pc.destreza),
        ('constituicao', pc.constituicao),
        ('inteligencia', pc.inteligencia),
        ('sabedoria', pc.sabedoria),
        ('carisma', pc.carisma)
    ) AS v(slug, score)
    JOIN rpg.phb_ability a ON a.slug = v.slug
    ON CONFLICT (character_id, ability_id) DO UPDATE SET score = EXCLUDED.score;

    ALTER TABLE rpg.player_character
      DROP COLUMN forca,
      DROP COLUMN destreza,
      DROP COLUMN constituicao,
      DROP COLUMN inteligencia,
      DROP COLUMN sabedoria,
      DROP COLUMN carisma;
  END IF;
END $$;

CREATE OR REPLACE VIEW rpg.v_character_abilities AS
SELECT
  pc.id AS character_id,
  pc.name AS character_name,
  a.slug AS ability_slug,
  a.name AS ability_name,
  pca.score
FROM rpg.player_character_ability pca
JOIN rpg.player_character pc ON pc.id = pca.character_id
JOIN rpg.phb_ability a ON a.id = pca.ability_id;
