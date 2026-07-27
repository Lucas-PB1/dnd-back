-- Distribuição de bônus do antecedente: +2/+1 ou +1 em três atributos (PHB 2024)

ALTER TABLE rpg.player_character
  ADD COLUMN IF NOT EXISTS background_boost_mode TEXT NOT NULL DEFAULT 'plus2plus1',
  ADD COLUMN IF NOT EXISTS background_boost_plus1_slugs TEXT[];

DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1
    FROM pg_constraint
    WHERE conname = 'player_character_background_boost_mode_check'
  ) THEN
    ALTER TABLE rpg.player_character
      ADD CONSTRAINT player_character_background_boost_mode_check
      CHECK (background_boost_mode IN ('plus2plus1', 'plus1x3'));
  END IF;
END $$;
