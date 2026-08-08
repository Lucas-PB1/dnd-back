-- Recursos com dono talento (scope = feat).

ALTER TABLE rpg.phb_resource_definition
  ADD COLUMN IF NOT EXISTS feat_id BIGINT NULL
    REFERENCES rpg.phb_feat(id) ON DELETE CASCADE;

ALTER TABLE rpg.phb_resource_definition
  DROP CONSTRAINT IF EXISTS prd_scope_fk;

ALTER TABLE rpg.phb_resource_definition
  ADD CONSTRAINT prd_scope_fk CHECK (
    (scope = 'species' AND species_id IS NOT NULL AND class_id IS NULL AND subclass_id IS NULL AND feat_id IS NULL) OR
    (scope = 'class' AND class_id IS NOT NULL AND species_id IS NULL AND subclass_id IS NULL AND feat_id IS NULL) OR
    (scope = 'subclass' AND subclass_id IS NOT NULL AND species_id IS NULL AND class_id IS NULL AND feat_id IS NULL) OR
    (scope = 'feat' AND feat_id IS NOT NULL AND species_id IS NULL AND class_id IS NULL AND subclass_id IS NULL)
  );

CREATE UNIQUE INDEX IF NOT EXISTS uq_resource_feat
  ON rpg.phb_resource_definition (feat_id, slug)
  WHERE scope = 'feat';
