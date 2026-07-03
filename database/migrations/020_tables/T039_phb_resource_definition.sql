-- Tabela rpg.phb_resource_definition

CREATE TABLE rpg.phb_resource_definition (
  id BIGSERIAL PRIMARY KEY,
  slug TEXT NOT NULL UNIQUE,
  name TEXT NOT NULL,
  scope rpg.resource_scope NOT NULL,
  species_id BIGINT REFERENCES rpg.phb_species(id),
  class_id BIGINT REFERENCES rpg.phb_class(id),
  subclass_id BIGINT REFERENCES rpg.phb_subclass(id) ON DELETE CASCADE,
  min_level INTEGER NOT NULL DEFAULT 1 CHECK (min_level BETWEEN 1 AND 20),
  CONSTRAINT prd_scope_fk CHECK (
    (scope = 'species' AND species_id IS NOT NULL AND class_id IS NULL AND subclass_id IS NULL) OR
    (scope = 'class' AND class_id IS NOT NULL AND species_id IS NULL AND subclass_id IS NULL) OR
    (scope = 'subclass' AND subclass_id IS NOT NULL AND species_id IS NULL AND class_id IS NULL)
  )
);
