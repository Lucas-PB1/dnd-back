DO $$ BEGIN
  ALTER TYPE rpg.resource_max_formula ADD VALUE 'level_plus_one';
EXCEPTION
  WHEN duplicate_object THEN NULL;
END $$;
