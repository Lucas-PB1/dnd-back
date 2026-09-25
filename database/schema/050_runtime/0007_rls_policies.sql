DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM information_schema.schemata WHERE schema_name = 'auth') THEN
    RAISE NOTICE 'Skipping combat_session.created_by FK — auth schema not present';
    RETURN;
  END IF;
  ALTER TABLE rpg.combat_session
    ADD CONSTRAINT combat_session_created_by_fkey
    FOREIGN KEY (created_by) REFERENCES auth.users(id);
END $$;

-- RLS para encontro de campanha (Supabase — requer schema auth)
