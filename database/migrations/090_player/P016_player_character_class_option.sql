-- Opções de classe na ficha (ex.: Especialização / Expertise)

CREATE TABLE IF NOT EXISTS rpg.player_character_class_option (
  character_id UUID NOT NULL REFERENCES rpg.player_character(id) ON DELETE CASCADE,
  option_key TEXT NOT NULL,
  value_id TEXT NOT NULL,
  PRIMARY KEY (character_id, option_key)
);

CREATE INDEX IF NOT EXISTS idx_player_character_class_option_character
  ON rpg.player_character_class_option(character_id);

DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM information_schema.schemata WHERE schema_name = 'auth') THEN
    RAISE NOTICE 'Skipping player_character_class_option RLS — auth schema not present';
    RETURN;
  END IF;

  ALTER TABLE rpg.player_character_class_option ENABLE ROW LEVEL SECURITY;

  DROP POLICY IF EXISTS player_character_class_option_own ON rpg.player_character_class_option;
  CREATE POLICY player_character_class_option_own ON rpg.player_character_class_option
    FOR ALL USING (
      character_id IN (SELECT id FROM rpg.player_character WHERE user_id = auth.uid())
    );
END $$;
