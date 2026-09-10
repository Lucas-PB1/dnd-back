-- Pending-only (ex.: blood-constrain / blood-withering): condition_slug opcional.
ALTER TABLE rpg.phb_effect_condition
  ALTER COLUMN condition_slug DROP NOT NULL;

ALTER TABLE rpg.phb_effect_condition
  DROP CONSTRAINT IF EXISTS phb_effect_condition_payload_check;

ALTER TABLE rpg.phb_effect_condition
  ADD CONSTRAINT phb_effect_condition_payload_check CHECK (
    condition_slug IS NOT NULL OR pending_kind IS NOT NULL
  );

-- Strike packages migrados para phb_effect + option_value (Sabujo).
DROP TABLE IF EXISTS rpg.phb_strike_option;
