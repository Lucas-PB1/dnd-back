-- RLS para opções de talentos na ficha

DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM information_schema.schemata WHERE schema_name = 'auth') THEN
    RAISE NOTICE 'Skipping player_character_feat_option RLS — auth schema not present';
    RETURN;
  END IF;

  ALTER TABLE rpg.player_character_feat_option ENABLE ROW LEVEL SECURITY;

  DROP POLICY IF EXISTS player_character_feat_option_own ON rpg.player_character_feat_option;
  CREATE POLICY player_character_feat_option_own ON rpg.player_character_feat_option
    FOR ALL USING (
      character_id IN (SELECT id FROM rpg.player_character WHERE user_id = auth.uid())
    );
END $$;
