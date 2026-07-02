DO $$ BEGIN
  ALTER TYPE rpg.resource_max_formula ADD VALUE 'superiority_dice_count';
EXCEPTION
  WHEN duplicate_object THEN NULL;
END $$;

DO $$ BEGIN
  ALTER TYPE rpg.resource_max_formula ADD VALUE 'psi_energy_dice_count';
EXCEPTION
  WHEN duplicate_object THEN NULL;
END $$;

DO $$ BEGIN
  ALTER TYPE rpg.resource_max_formula ADD VALUE 'zealot_healing_dice_count';
EXCEPTION
  WHEN duplicate_object THEN NULL;
END $$;
