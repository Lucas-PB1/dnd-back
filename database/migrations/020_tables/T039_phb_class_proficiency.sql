-- Lote F: afinidades de classe unificadas (saving throw, primary ability, armor, weapon, fighting style)

CREATE TABLE rpg.phb_class_proficiency (
  class_id BIGINT NOT NULL REFERENCES rpg.phb_class(id) ON DELETE CASCADE,
  kind rpg.class_proficiency_kind NOT NULL,
  ref_id BIGINT,
  ref_slug TEXT,
  sort_order INTEGER NOT NULL DEFAULT 0,
  CONSTRAINT phb_class_proficiency_ref CHECK (
    (kind IN ('saving_throw'::rpg.class_proficiency_kind, 'primary_ability'::rpg.class_proficiency_kind)
      AND ref_id IS NOT NULL AND ref_slug IS NULL)
    OR (kind = 'armor_training'::rpg.class_proficiency_kind AND ref_id IS NOT NULL AND ref_slug IS NULL)
    OR (kind = 'weapon'::rpg.class_proficiency_kind AND ref_slug IS NOT NULL AND ref_id IS NULL)
    OR (kind = 'fighting_style'::rpg.class_proficiency_kind AND ref_id IS NOT NULL AND ref_slug IS NULL)
  )
);

CREATE UNIQUE INDEX uq_phb_class_prof_id
  ON rpg.phb_class_proficiency (class_id, kind, ref_id) WHERE ref_id IS NOT NULL;
CREATE UNIQUE INDEX uq_phb_class_prof_slug
  ON rpg.phb_class_proficiency (class_id, kind, ref_slug) WHERE ref_slug IS NOT NULL;
CREATE INDEX idx_phb_class_proficiency_class ON rpg.phb_class_proficiency(class_id, kind);
