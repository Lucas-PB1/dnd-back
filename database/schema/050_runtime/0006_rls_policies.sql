DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM information_schema.schemata WHERE schema_name = 'auth') THEN
    RAISE NOTICE 'Skipping player_character_state RLS â€” auth schema not present';
    RETURN;
  END IF;

  ALTER TABLE rpg.player_character_state ENABLE ROW LEVEL SECURITY;

  DROP POLICY IF EXISTS player_character_state_own ON rpg.player_character_state;
  CREATE POLICY player_character_state_own ON rpg.player_character_state
    FOR ALL USING (
      character_id IN (SELECT id FROM rpg.player_character WHERE user_id = auth.uid())
    );
END $$;
