-- Economy actions: class XOR species; filtro opcional por escolha de espécie.

ALTER TABLE rpg.phb_class_economy_action
  ALTER COLUMN class_id DROP NOT NULL;

ALTER TABLE rpg.phb_class_economy_action
  ADD COLUMN IF NOT EXISTS species_id BIGINT NULL
    REFERENCES rpg.phb_species(id) ON DELETE CASCADE;

ALTER TABLE rpg.phb_class_economy_action
  ADD COLUMN IF NOT EXISTS requires_option_key TEXT NULL;

ALTER TABLE rpg.phb_class_economy_action
  ADD COLUMN IF NOT EXISTS requires_option_value TEXT NULL;

DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_constraint
    WHERE conname = 'phb_class_economy_action_owner_xor'
  ) THEN
    ALTER TABLE rpg.phb_class_economy_action
      ADD CONSTRAINT phb_class_economy_action_owner_xor CHECK (
        (class_id IS NOT NULL AND species_id IS NULL)
        OR (class_id IS NULL AND species_id IS NOT NULL)
      );
  END IF;
END $$;

CREATE INDEX IF NOT EXISTS idx_class_economy_action_species
  ON rpg.phb_class_economy_action(species_id);
