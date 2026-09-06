-- Seed Gunslinger primary ability

INSERT INTO rpg.phb_class_proficiency (class_id, kind, ref_id, sort_order)
VALUES (
  (SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'),
  'primary_ability'::rpg.class_proficiency_kind,
  (SELECT id FROM rpg.phb_ability WHERE slug = 'destreza'),
  1
)
ON CONFLICT (class_id, kind, ref_id) WHERE ref_id IS NOT NULL
DO UPDATE SET sort_order = EXCLUDED.sort_order;
