-- Recursos com dono item (scope = item).

ALTER TABLE rpg.phb_resource_definition
  ADD COLUMN IF NOT EXISTS item_id BIGINT NULL
    REFERENCES rpg.phb_item(id) ON DELETE CASCADE;

ALTER TABLE rpg.phb_resource_definition
  DROP CONSTRAINT IF EXISTS prd_scope_fk;

ALTER TABLE rpg.phb_resource_definition
  ADD CONSTRAINT prd_scope_fk CHECK (
    (scope = 'species' AND species_id IS NOT NULL AND class_id IS NULL AND subclass_id IS NULL AND feat_id IS NULL AND item_id IS NULL) OR
    (scope = 'class' AND class_id IS NOT NULL AND species_id IS NULL AND subclass_id IS NULL AND feat_id IS NULL AND item_id IS NULL) OR
    (scope = 'subclass' AND subclass_id IS NOT NULL AND species_id IS NULL AND class_id IS NULL AND feat_id IS NULL AND item_id IS NULL) OR
    (scope = 'feat' AND feat_id IS NOT NULL AND species_id IS NULL AND class_id IS NULL AND subclass_id IS NULL AND item_id IS NULL) OR
    (scope = 'item' AND item_id IS NOT NULL AND species_id IS NULL AND class_id IS NULL AND subclass_id IS NULL AND feat_id IS NULL)
  );

CREATE UNIQUE INDEX IF NOT EXISTS uq_resource_item
  ON rpg.phb_resource_definition (item_id, slug)
  WHERE scope = 'item';
