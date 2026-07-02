-- Migration 009: ENUMs para mecânicas de subclasse (commit isolado — PG exige transação separada)

DO $$ BEGIN
  ALTER TYPE rpg.resource_scope ADD VALUE 'subclass';
EXCEPTION
  WHEN duplicate_object THEN NULL;
END $$;

DO $$ BEGIN
  CREATE TYPE rpg.subclass_feature_kind AS ENUM (
    'passive',
    'resource',
    'choice',
    'always_prepared',
    'spellcasting',
    'spellbook_bonus'
  );
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

DO $$ BEGIN
  CREATE TYPE rpg.resource_max_formula AS ENUM (
    'fixed',
    'proficiency_bonus',
    'charisma_mod',
    'wisdom_mod',
    'constitution_mod',
    'intelligence_mod',
    'level'
  );
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;
