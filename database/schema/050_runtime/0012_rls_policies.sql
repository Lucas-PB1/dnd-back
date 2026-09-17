DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM information_schema.schemata WHERE schema_name = 'auth') THEN
    RAISE NOTICE 'Skipping skirmish RLS — auth schema not present (local Postgres)';
    RETURN;
  END IF;

  ALTER TABLE rpg.skirmish ENABLE ROW LEVEL SECURITY;
  ALTER TABLE rpg.skirmish_combatant ENABLE ROW LEVEL SECURITY;

  DROP POLICY IF EXISTS skirmish_owner_select ON rpg.skirmish;
  CREATE POLICY skirmish_owner_select ON rpg.skirmish
    FOR SELECT USING (user_id = auth.uid());

  DROP POLICY IF EXISTS skirmish_owner_insert ON rpg.skirmish;
  CREATE POLICY skirmish_owner_insert ON rpg.skirmish
    FOR INSERT WITH CHECK (
      user_id = auth.uid()
      AND character_id IN (
        SELECT id FROM rpg.player_character WHERE user_id = auth.uid()
      )
    );

  DROP POLICY IF EXISTS skirmish_owner_update ON rpg.skirmish;
  CREATE POLICY skirmish_owner_update ON rpg.skirmish
    FOR UPDATE USING (user_id = auth.uid());

  DROP POLICY IF EXISTS skirmish_owner_delete ON rpg.skirmish;
  CREATE POLICY skirmish_owner_delete ON rpg.skirmish
    FOR DELETE USING (user_id = auth.uid());

  DROP POLICY IF EXISTS skirmish_combatant_owner_select ON rpg.skirmish_combatant;
  CREATE POLICY skirmish_combatant_owner_select ON rpg.skirmish_combatant
    FOR SELECT USING (
      skirmish_id IN (SELECT id FROM rpg.skirmish WHERE user_id = auth.uid())
    );

  DROP POLICY IF EXISTS skirmish_combatant_owner_write ON rpg.skirmish_combatant;
  CREATE POLICY skirmish_combatant_owner_write ON rpg.skirmish_combatant
    FOR ALL USING (
      skirmish_id IN (SELECT id FROM rpg.skirmish WHERE user_id = auth.uid())
    )
    WITH CHECK (
      skirmish_id IN (SELECT id FROM rpg.skirmish WHERE user_id = auth.uid())
    );
END $$;
