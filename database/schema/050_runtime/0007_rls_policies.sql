DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM information_schema.schemata WHERE schema_name = 'auth') THEN
    RAISE NOTICE 'Skipping campaign_encounter.created_by FK â€” auth schema not present';
    RETURN;
  END IF;
  ALTER TABLE rpg.campaign_encounter
    ADD CONSTRAINT campaign_encounter_created_by_fkey
    FOREIGN KEY (created_by) REFERENCES auth.users(id);
END $$;

-- RLS para encontro de campanha (Supabase â€” requer schema auth)
