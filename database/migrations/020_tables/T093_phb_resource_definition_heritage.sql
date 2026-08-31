-- Recursos com dono heritage_trait (scope = heritage).

ALTER TABLE rpg.phb_resource_definition
  ADD COLUMN IF NOT EXISTS heritage_trait_id BIGINT NULL
    REFERENCES rpg.phb_heritage_trait(id) ON DELETE CASCADE;

ALTER TABLE rpg.phb_resource_definition
  DROP CONSTRAINT IF EXISTS prd_scope_fk;

ALTER TABLE rpg.phb_resource_definition
  ADD CONSTRAINT prd_scope_fk CHECK (
    (scope = 'species' AND species_id IS NOT NULL AND class_id IS NULL AND subclass_id IS NULL AND feat_id IS NULL AND item_id IS NULL AND heritage_trait_id IS NULL)
    OR (scope = 'class' AND class_id IS NOT NULL AND species_id IS NULL AND subclass_id IS NULL AND feat_id IS NULL AND item_id IS NULL AND heritage_trait_id IS NULL)
    OR (scope = 'subclass' AND subclass_id IS NOT NULL AND species_id IS NULL AND class_id IS NULL AND feat_id IS NULL AND item_id IS NULL AND heritage_trait_id IS NULL)
    OR (scope = 'feat' AND feat_id IS NOT NULL AND species_id IS NULL AND class_id IS NULL AND subclass_id IS NULL AND item_id IS NULL AND heritage_trait_id IS NULL)
    OR (scope = 'item' AND item_id IS NOT NULL AND species_id IS NULL AND class_id IS NULL AND subclass_id IS NULL AND feat_id IS NULL AND heritage_trait_id IS NULL)
    OR (scope = 'heritage' AND heritage_trait_id IS NOT NULL AND species_id IS NULL AND class_id IS NULL AND subclass_id IS NULL AND feat_id IS NULL AND item_id IS NULL)
  );

CREATE UNIQUE INDEX IF NOT EXISTS uq_resource_heritage
  ON rpg.phb_resource_definition (heritage_trait_id, slug)
  WHERE scope = 'heritage';

ALTER TABLE rpg.phb_resource_grant
  ADD COLUMN IF NOT EXISTS min_trait_takes INTEGER NOT NULL DEFAULT 1
    CHECK (min_trait_takes >= 1);
