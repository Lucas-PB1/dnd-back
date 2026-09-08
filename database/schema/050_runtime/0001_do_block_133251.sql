DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM information_schema.schemata WHERE schema_name = 'auth') THEN
    RAISE NOTICE 'Skipping player_character.user_id FK — auth schema not present';
    RETURN;
  END IF;
  ALTER TABLE rpg.player_character
    ADD CONSTRAINT player_character_user_id_fkey
    FOREIGN KEY (user_id) REFERENCES auth.users(id);
END $$;

-- Perícias escolhidas da pool da classe (PHB skill choice)
