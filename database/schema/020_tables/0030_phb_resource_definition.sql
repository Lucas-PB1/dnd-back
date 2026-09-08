CREATE TABLE rpg.phb_resource_definition (
  id BIGSERIAL PRIMARY KEY,
  slug TEXT NOT NULL UNIQUE,
  name TEXT NOT NULL,
  scope rpg.resource_scope NOT NULL,
  species_id BIGINT REFERENCES rpg.phb_species(id),
  class_id BIGINT REFERENCES rpg.phb_class(id),
  subclass_id BIGINT REFERENCES rpg.phb_subclass(id) ON DELETE CASCADE,
  feat_id BIGINT NULL REFERENCES rpg.phb_feat(id) ON DELETE CASCADE,
  item_id BIGINT NULL REFERENCES rpg.phb_item(id) ON DELETE CASCADE,
  heritage_trait_id BIGINT NULL REFERENCES rpg.phb_heritage_trait(id) ON DELETE CASCADE,
  thread_slug TEXT NULL REFERENCES rpg.phb_character_thread(slug) ON DELETE CASCADE,
  min_level INTEGER NOT NULL DEFAULT 1 CHECK (min_level BETWEEN 1 AND 20),
  CONSTRAINT prd_scope_fk CHECK (
    (scope = 'species' AND species_id IS NOT NULL AND class_id IS NULL AND subclass_id IS NULL AND feat_id IS NULL AND item_id IS NULL AND heritage_trait_id IS NULL AND thread_slug IS NULL)
    OR (scope = 'class' AND class_id IS NOT NULL AND species_id IS NULL AND subclass_id IS NULL AND feat_id IS NULL AND item_id IS NULL AND heritage_trait_id IS NULL AND thread_slug IS NULL)
    OR (scope = 'subclass' AND subclass_id IS NOT NULL AND species_id IS NULL AND class_id IS NULL AND feat_id IS NULL AND item_id IS NULL AND heritage_trait_id IS NULL AND thread_slug IS NULL)
    OR (scope = 'feat' AND feat_id IS NOT NULL AND species_id IS NULL AND class_id IS NULL AND subclass_id IS NULL AND item_id IS NULL AND heritage_trait_id IS NULL AND thread_slug IS NULL)
    OR (scope = 'item' AND item_id IS NOT NULL AND species_id IS NULL AND class_id IS NULL AND subclass_id IS NULL AND feat_id IS NULL AND heritage_trait_id IS NULL AND thread_slug IS NULL)
    OR (scope = 'heritage' AND heritage_trait_id IS NOT NULL AND species_id IS NULL AND class_id IS NULL AND subclass_id IS NULL AND feat_id IS NULL AND item_id IS NULL AND thread_slug IS NULL)
    OR (scope = 'character_thread' AND thread_slug IS NOT NULL AND species_id IS NULL AND class_id IS NULL AND subclass_id IS NULL AND feat_id IS NULL AND item_id IS NULL AND heritage_trait_id IS NULL)
  )
);

-- owner_id = subclass_id | species_id | feat_id conforme scope (sem FK polimórfica)
