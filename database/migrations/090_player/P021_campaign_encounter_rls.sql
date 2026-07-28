-- RLS para encontro de campanha (Supabase — requer schema auth)

DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM information_schema.schemata WHERE schema_name = 'auth') THEN
    RAISE NOTICE 'Skipping campaign encounter RLS — auth schema not present (local Postgres)';
    RETURN;
  END IF;

  ALTER TABLE rpg.campaign_encounter ENABLE ROW LEVEL SECURITY;
  ALTER TABLE rpg.campaign_encounter_combatant ENABLE ROW LEVEL SECURITY;

  DROP POLICY IF EXISTS campaign_encounter_member_select ON rpg.campaign_encounter;
  CREATE POLICY campaign_encounter_member_select ON rpg.campaign_encounter
    FOR SELECT USING (
      campaign_id IN (
        SELECT campaign_id FROM rpg.campaign_member WHERE user_id = auth.uid()
      )
    );

  DROP POLICY IF EXISTS campaign_encounter_staff_write ON rpg.campaign_encounter;
  CREATE POLICY campaign_encounter_staff_write ON rpg.campaign_encounter
    FOR ALL USING (
      campaign_id IN (
        SELECT campaign_id FROM rpg.campaign_member
        WHERE user_id = auth.uid() AND role IN ('dm', 'assistant')
      )
    )
    WITH CHECK (
      campaign_id IN (
        SELECT campaign_id FROM rpg.campaign_member
        WHERE user_id = auth.uid() AND role IN ('dm', 'assistant')
      )
    );

  DROP POLICY IF EXISTS campaign_encounter_combatant_member_select
    ON rpg.campaign_encounter_combatant;
  CREATE POLICY campaign_encounter_combatant_member_select
    ON rpg.campaign_encounter_combatant
    FOR SELECT USING (
      encounter_id IN (
        SELECT e.id
        FROM rpg.campaign_encounter e
        JOIN rpg.campaign_member m ON m.campaign_id = e.campaign_id
        WHERE m.user_id = auth.uid()
      )
    );

  DROP POLICY IF EXISTS campaign_encounter_combatant_staff_write
    ON rpg.campaign_encounter_combatant;
  CREATE POLICY campaign_encounter_combatant_staff_write
    ON rpg.campaign_encounter_combatant
    FOR ALL USING (
      encounter_id IN (
        SELECT e.id
        FROM rpg.campaign_encounter e
        JOIN rpg.campaign_member m ON m.campaign_id = e.campaign_id
        WHERE m.user_id = auth.uid() AND m.role IN ('dm', 'assistant')
      )
    )
    WITH CHECK (
      encounter_id IN (
        SELECT e.id
        FROM rpg.campaign_encounter e
        JOIN rpg.campaign_member m ON m.campaign_id = e.campaign_id
        WHERE m.user_id = auth.uid() AND m.role IN ('dm', 'assistant')
      )
    );
END $$;
