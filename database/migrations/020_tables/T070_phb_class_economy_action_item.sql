-- Economy actions: class XOR species XOR feat XOR item.

ALTER TABLE rpg.phb_class_economy_action
  ADD COLUMN IF NOT EXISTS item_id BIGINT NULL
    REFERENCES rpg.phb_item(id) ON DELETE CASCADE;

ALTER TABLE rpg.phb_class_economy_action
  DROP CONSTRAINT IF EXISTS phb_class_economy_action_owner_xor;

ALTER TABLE rpg.phb_class_economy_action
  ADD CONSTRAINT phb_class_economy_action_owner_xor CHECK (
    (class_id IS NOT NULL AND species_id IS NULL AND feat_id IS NULL AND item_id IS NULL)
    OR (class_id IS NULL AND species_id IS NOT NULL AND feat_id IS NULL AND item_id IS NULL)
    OR (class_id IS NULL AND species_id IS NULL AND feat_id IS NOT NULL AND item_id IS NULL)
    OR (class_id IS NULL AND species_id IS NULL AND feat_id IS NULL AND item_id IS NOT NULL)
  );

CREATE INDEX IF NOT EXISTS idx_class_economy_action_item
  ON rpg.phb_class_economy_action(item_id);
