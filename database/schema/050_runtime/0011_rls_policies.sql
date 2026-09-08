DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM information_schema.schemata WHERE schema_name = 'auth') THEN
    RAISE NOTICE 'Skipping duel RLS — auth schema not present (local Postgres)';
    RETURN;
  END IF;

  ALTER TABLE rpg.duel ENABLE ROW LEVEL SECURITY;
  ALTER TABLE rpg.duel_member ENABLE ROW LEVEL SECURITY;

  DROP POLICY IF EXISTS duel_member_select ON rpg.duel;
  CREATE POLICY duel_member_select ON rpg.duel
    FOR SELECT USING (
      id IN (SELECT duel_id FROM rpg.duel_member WHERE user_id = auth.uid())
    );

  DROP POLICY IF EXISTS duel_creator_insert ON rpg.duel;
  CREATE POLICY duel_creator_insert ON rpg.duel
    FOR INSERT WITH CHECK (created_by = auth.uid());

  DROP POLICY IF EXISTS duel_member_update ON rpg.duel;
  CREATE POLICY duel_member_update ON rpg.duel
    FOR UPDATE USING (
      id IN (SELECT duel_id FROM rpg.duel_member WHERE user_id = auth.uid())
    );

  DROP POLICY IF EXISTS duel_creator_delete ON rpg.duel;
  CREATE POLICY duel_creator_delete ON rpg.duel
    FOR DELETE USING (created_by = auth.uid());

  DROP POLICY IF EXISTS duel_member_own_select ON rpg.duel_member;
  CREATE POLICY duel_member_own_select ON rpg.duel_member
    FOR SELECT USING (
      user_id = auth.uid()
      OR duel_id IN (
        SELECT duel_id FROM rpg.duel_member WHERE user_id = auth.uid()
      )
    );

  DROP POLICY IF EXISTS duel_member_own_write ON rpg.duel_member;
  CREATE POLICY duel_member_own_write ON rpg.duel_member
    FOR ALL USING (user_id = auth.uid())
    WITH CHECK (
      user_id = auth.uid()
      AND character_id IN (
        SELECT id FROM rpg.player_character WHERE user_id = auth.uid()
      )
    );
END $$;
