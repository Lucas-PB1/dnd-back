-- Magias como dono de phb_effect (cura/PV temp. no cast da ficha).

DO $$ BEGIN
  ALTER TYPE rpg.effect_owner_kind ADD VALUE IF NOT EXISTS 'spell';
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;
