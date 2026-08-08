-- Economy actions: class XOR species XOR feat.

ALTER TABLE rpg.phb_class_economy_action
  ADD COLUMN IF NOT EXISTS feat_id BIGINT NULL
    REFERENCES rpg.phb_feat(id) ON DELETE CASCADE;

ALTER TABLE rpg.phb_class_economy_action
  DROP CONSTRAINT IF EXISTS phb_class_economy_action_owner_xor;

ALTER TABLE rpg.phb_class_economy_action
  ADD CONSTRAINT phb_class_economy_action_owner_xor CHECK (
    (class_id IS NOT NULL AND species_id IS NULL AND feat_id IS NULL)
    OR (class_id IS NULL AND species_id IS NOT NULL AND feat_id IS NULL)
    OR (class_id IS NULL AND species_id IS NULL AND feat_id IS NOT NULL)
  );

CREATE INDEX IF NOT EXISTS idx_class_economy_action_feat
  ON rpg.phb_class_economy_action(feat_id);
