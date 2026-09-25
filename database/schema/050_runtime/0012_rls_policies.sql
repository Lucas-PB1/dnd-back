DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM information_schema.schemata WHERE schema_name = 'auth') THEN
    RAISE NOTICE 'Skipping skirmish RLS — auth schema not present (local Postgres)';
    RETURN;
  END IF;

  ALTER TABLE rpg.combat_session ENABLE ROW LEVEL SECURITY;
  ALTER TABLE rpg.combat_participant ENABLE ROW LEVEL SECURITY;

  DROP POLICY IF EXISTS combat_session_skirmish_owner_select ON rpg.combat_session;
  CREATE POLICY combat_session_skirmish_owner_select ON rpg.combat_session
    FOR SELECT USING (mode = 'skirmish' AND created_by = auth.uid());

  DROP POLICY IF EXISTS combat_session_skirmish_owner_insert ON rpg.combat_session;
  CREATE POLICY combat_session_skirmish_owner_insert ON rpg.combat_session
    FOR INSERT WITH CHECK (
      mode = 'skirmish'
      AND created_by = auth.uid()
      AND character_id IN (
        SELECT id FROM rpg.player_character WHERE user_id = auth.uid()
      )
    );

  DROP POLICY IF EXISTS combat_session_skirmish_owner_update ON rpg.combat_session;
  CREATE POLICY combat_session_skirmish_owner_update ON rpg.combat_session
    FOR UPDATE USING (mode = 'skirmish' AND created_by = auth.uid());

  DROP POLICY IF EXISTS combat_session_skirmish_owner_delete ON rpg.combat_session;
  CREATE POLICY combat_session_skirmish_owner_delete ON rpg.combat_session
    FOR DELETE USING (mode = 'skirmish' AND created_by = auth.uid());

  DROP POLICY IF EXISTS combat_participant_skirmish_owner_select ON rpg.combat_participant;
  CREATE POLICY combat_participant_skirmish_owner_select ON rpg.combat_participant
    FOR SELECT USING (
      session_mode = 'skirmish'
      AND session_id IN (
        SELECT id FROM rpg.combat_session
        WHERE mode = 'skirmish' AND created_by = auth.uid()
      )
    );

  DROP POLICY IF EXISTS combat_participant_skirmish_owner_write ON rpg.combat_participant;
  CREATE POLICY combat_participant_skirmish_owner_write ON rpg.combat_participant
    FOR ALL USING (
      session_mode = 'skirmish'
      AND session_id IN (
        SELECT id FROM rpg.combat_session
        WHERE mode = 'skirmish' AND created_by = auth.uid()
      )
    )
    WITH CHECK (
      session_mode = 'skirmish'
      AND session_id IN (
        SELECT id FROM rpg.combat_session
        WHERE mode = 'skirmish' AND created_by = auth.uid()
      )
    );
END $$;
