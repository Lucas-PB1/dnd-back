-- Seed Gunslinger saving throws

INSERT INTO rpg.phb_class_proficiency (class_id, kind, ref_id)
VALUES
  ((SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'), 'saving_throw'::rpg.class_proficiency_kind, (SELECT id FROM rpg.phb_ability WHERE slug = 'destreza')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'), 'saving_throw'::rpg.class_proficiency_kind, (SELECT id FROM rpg.phb_ability WHERE slug = 'carisma'))
ON CONFLICT (class_id, kind, ref_id) WHERE ref_id IS NOT NULL DO NOTHING;
