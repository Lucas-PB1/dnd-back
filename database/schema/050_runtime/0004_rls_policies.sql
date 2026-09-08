DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM information_schema.schemata WHERE schema_name = 'auth') THEN
    RAISE NOTICE 'Skipping campaign ownership FKs — auth schema not present';
    RETURN;
  END IF;
  ALTER TABLE rpg.campaign
    ADD CONSTRAINT campaign_created_by_fkey
    FOREIGN KEY (created_by) REFERENCES auth.users(id);
  ALTER TABLE rpg.campaign_member
    ADD CONSTRAINT campaign_member_user_id_fkey
    FOREIGN KEY (user_id) REFERENCES auth.users(id);
  ALTER TABLE rpg.campaign_character
    ADD CONSTRAINT campaign_character_linked_by_fkey
    FOREIGN KEY (linked_by) REFERENCES auth.users(id);
END $$;

-- RLS para campanhas (Supabase — requer schema auth)
