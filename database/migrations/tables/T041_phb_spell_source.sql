-- Tabela rpg.phb_spell_source

CREATE TABLE rpg.phb_spell_source (
  id BIGSERIAL PRIMARY KEY,
  slug TEXT NOT NULL UNIQUE,
  label TEXT NOT NULL,
  origin_type rpg.spell_source_origin NOT NULL,
  class_id BIGINT REFERENCES rpg.phb_class(id),
  subclass_id BIGINT,
  species_id BIGINT REFERENCES rpg.phb_species(id),
  feat_id BIGINT REFERENCES rpg.phb_feat(id),
  CONSTRAINT spell_source_origin_fk CHECK (
    (origin_type = 'class_list' AND class_id IS NULL AND subclass_id IS NULL AND species_id IS NULL AND feat_id IS NULL)
    OR (origin_type = 'subclass' AND subclass_id IS NOT NULL AND class_id IS NOT NULL AND species_id IS NULL AND feat_id IS NULL)
    OR (origin_type = 'species' AND species_id IS NOT NULL AND class_id IS NULL AND subclass_id IS NULL AND feat_id IS NULL)
    OR (origin_type = 'feat' AND feat_id IS NOT NULL AND class_id IS NULL AND subclass_id IS NULL AND species_id IS NULL)
  ),
  CONSTRAINT spell_source_subclass_fk
    FOREIGN KEY (class_id, subclass_id) REFERENCES rpg.phb_subclass(class_id, id)
);
