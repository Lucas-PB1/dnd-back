-- Economy actions: class XOR species XOR feat XOR item XOR heritage_trait.

ALTER TABLE rpg.phb_class_economy_action
  ADD COLUMN IF NOT EXISTS heritage_trait_id BIGINT NULL
    REFERENCES rpg.phb_heritage_trait(id) ON DELETE CASCADE;

ALTER TABLE rpg.phb_class_economy_action
  ADD COLUMN IF NOT EXISTS min_trait_takes INTEGER NOT NULL DEFAULT 1
    CHECK (min_trait_takes >= 1);

ALTER TABLE rpg.phb_class_economy_action
  DROP CONSTRAINT IF EXISTS phb_class_economy_action_owner_xor;

ALTER TABLE rpg.phb_class_economy_action
  ADD CONSTRAINT phb_class_economy_action_owner_xor CHECK (
    (class_id IS NOT NULL AND species_id IS NULL AND feat_id IS NULL AND item_id IS NULL AND heritage_trait_id IS NULL)
    OR (class_id IS NULL AND species_id IS NOT NULL AND feat_id IS NULL AND item_id IS NULL AND heritage_trait_id IS NULL)
    OR (class_id IS NULL AND species_id IS NULL AND feat_id IS NOT NULL AND item_id IS NULL AND heritage_trait_id IS NULL)
    OR (class_id IS NULL AND species_id IS NULL AND feat_id IS NULL AND item_id IS NOT NULL AND heritage_trait_id IS NULL)
    OR (class_id IS NULL AND species_id IS NULL AND feat_id IS NULL AND item_id IS NULL AND heritage_trait_id IS NOT NULL)
  );

CREATE INDEX IF NOT EXISTS idx_class_economy_action_heritage_trait
  ON rpg.phb_class_economy_action(heritage_trait_id)
  WHERE heritage_trait_id IS NOT NULL;
