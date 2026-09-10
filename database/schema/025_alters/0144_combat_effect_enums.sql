-- Alter incremental: enums de combate tipado (maestrias / on_hit).
DO $$ BEGIN
  ALTER TYPE rpg.effect_trigger ADD VALUE IF NOT EXISTS 'on_hit';
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;
DO $$ BEGIN
  ALTER TYPE rpg.effect_trigger ADD VALUE IF NOT EXISTS 'on_miss';
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;
DO $$ BEGIN
  ALTER TYPE rpg.effect_trigger ADD VALUE IF NOT EXISTS 'on_option_use';
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;
DO $$ BEGIN
  ALTER TYPE rpg.effect_trigger ADD VALUE IF NOT EXISTS 'on_save_fail';
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

DO $$ BEGIN
  ALTER TYPE rpg.effect_kind ADD VALUE IF NOT EXISTS 'attack_disadvantage';
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;
DO $$ BEGIN
  ALTER TYPE rpg.effect_kind ADD VALUE IF NOT EXISTS 'apply_condition';
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;
DO $$ BEGIN
  ALTER TYPE rpg.effect_kind ADD VALUE IF NOT EXISTS 'forced_movement';
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;
DO $$ BEGIN
  ALTER TYPE rpg.effect_kind ADD VALUE IF NOT EXISTS 'feature_save';
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;
DO $$ BEGIN
  ALTER TYPE rpg.effect_kind ADD VALUE IF NOT EXISTS 'ability_mod_damage';
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;
DO $$ BEGIN
  ALTER TYPE rpg.effect_kind ADD VALUE IF NOT EXISTS 'self_damage';
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;
DO $$ BEGIN
  ALTER TYPE rpg.effect_kind ADD VALUE IF NOT EXISTS 'extra_damage_dice';
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;
DO $$ BEGIN
  ALTER TYPE rpg.effect_kind ADD VALUE IF NOT EXISTS 'replace_attack_with_save';
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;
DO $$ BEGIN
  ALTER TYPE rpg.effect_kind ADD VALUE IF NOT EXISTS 'ignore_target_armor';
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;
DO $$ BEGIN
  ALTER TYPE rpg.effect_kind ADD VALUE IF NOT EXISTS 'add_arena_effect';
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

DO $$ BEGIN
  ALTER TYPE rpg.effect_owner_kind ADD VALUE IF NOT EXISTS 'weapon_mastery';
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

DO $$ BEGIN
  ALTER TYPE rpg.effect_amount_formula ADD VALUE IF NOT EXISTS 'attack_ability_mod';
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;
DO $$ BEGIN
  ALTER TYPE rpg.effect_amount_formula ADD VALUE IF NOT EXISTS 'eight_plus_mod_plus_pb';
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;
