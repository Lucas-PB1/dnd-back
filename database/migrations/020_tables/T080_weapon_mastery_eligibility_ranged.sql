-- Permite elegibilidade de maestria só para armas à distância (Pistoleiro Valda).
DO $$
DECLARE
  constraint_name text;
BEGIN
  SELECT con.conname INTO constraint_name
  FROM pg_constraint con
  JOIN pg_class rel ON rel.oid = con.conrelid
  JOIN pg_namespace nsp ON nsp.oid = rel.relnamespace
  WHERE nsp.nspname = 'rpg'
    AND rel.relname = 'phb_class'
    AND con.contype = 'c'
    AND pg_get_constraintdef(con.oid) ILIKE '%weapon_mastery_eligibility%';

  IF constraint_name IS NOT NULL THEN
    EXECUTE format(
      'ALTER TABLE rpg.phb_class DROP CONSTRAINT %I',
      constraint_name
    );
  END IF;
END $$;

ALTER TABLE rpg.phb_class
  ADD CONSTRAINT phb_class_weapon_mastery_eligibility_check CHECK (
    weapon_mastery_eligibility IS NULL
    OR weapon_mastery_eligibility IN ('any', 'melee', 'ranged')
  );
