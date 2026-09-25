DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM information_schema.schemata WHERE schema_name = 'auth') THEN
    RAISE NOTICE 'Skipping duel RLS — auth schema not present (local Postgres)';
    RETURN;
  END IF;

  ALTER TABLE rpg.combat_session ENABLE ROW LEVEL SECURITY;
  ALTER TABLE rpg.combat_participant ENABLE ROW LEVEL SECURITY;

  DROP POLICY IF EXISTS combat_session_duel_member_select ON rpg.combat_session;
  CREATE POLICY combat_session_duel_member_select ON rpg.combat_session
    FOR SELECT USING (
      mode = 'duel'
      AND id IN (
        SELECT session_id FROM rpg.combat_participant
        WHERE session_mode = 'duel' AND user_id = auth.uid()
      )
    );

  DROP POLICY IF EXISTS combat_session_duel_creator_insert ON rpg.combat_session;
  CREATE POLICY combat_session_duel_creator_insert ON rpg.combat_session
    FOR INSERT WITH CHECK (mode = 'duel' AND created_by = auth.uid());

  DROP POLICY IF EXISTS combat_session_duel_member_update ON rpg.combat_session;
  CREATE POLICY combat_session_duel_member_update ON rpg.combat_session
    FOR UPDATE USING (
      mode = 'duel'
      AND id IN (
        SELECT session_id FROM rpg.combat_participant
        WHERE session_mode = 'duel' AND user_id = auth.uid()
      )
    );

  DROP POLICY IF EXISTS combat_session_duel_creator_delete ON rpg.combat_session;
  CREATE POLICY combat_session_duel_creator_delete ON rpg.combat_session
    FOR DELETE USING (mode = 'duel' AND created_by = auth.uid());

  DROP POLICY IF EXISTS combat_participant_duel_select ON rpg.combat_participant;
  CREATE POLICY combat_participant_duel_select ON rpg.combat_participant
    FOR SELECT USING (
      session_mode = 'duel'
      AND (
        user_id = auth.uid()
        OR session_id IN (
          SELECT session_id FROM rpg.combat_participant
          WHERE session_mode = 'duel' AND user_id = auth.uid()
        )
      )
    );

  DROP POLICY IF EXISTS combat_participant_duel_own_write ON rpg.combat_participant;
  CREATE POLICY combat_participant_duel_own_write ON rpg.combat_participant
    FOR ALL USING (session_mode = 'duel' AND user_id = auth.uid())
    WITH CHECK (
      session_mode = 'duel'
      AND user_id = auth.uid()
      AND character_id IN (
        SELECT id FROM rpg.player_character WHERE user_id = auth.uid()
      )
    );
END $$;
