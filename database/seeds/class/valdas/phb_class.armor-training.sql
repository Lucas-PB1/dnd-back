-- Seed Gunslinger armor training

INSERT INTO rpg.phb_class_proficiency (class_id, kind, ref_id)
VALUES (
  (SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'),
  'armor_training'::rpg.class_proficiency_kind,
  (SELECT id FROM rpg.phb_armor_category WHERE slug = 'light')
)
ON CONFLICT (class_id, kind, ref_id) WHERE ref_id IS NOT NULL DO NOTHING;
