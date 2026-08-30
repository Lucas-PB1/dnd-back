-- Caçador de Monstros — estilos de luta + maestria em armas

INSERT INTO rpg.phb_class_proficiency (class_id, kind, ref_id)
VALUES
  ((SELECT id FROM rpg.phb_class WHERE slug = 'monster-hunter'), 'fighting_style'::rpg.class_proficiency_kind, (SELECT id FROM rpg.phb_fighting_style WHERE slug = 'archery')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'monster-hunter'), 'fighting_style'::rpg.class_proficiency_kind, (SELECT id FROM rpg.phb_fighting_style WHERE slug = 'blind-fighting')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'monster-hunter'), 'fighting_style'::rpg.class_proficiency_kind, (SELECT id FROM rpg.phb_fighting_style WHERE slug = 'defense')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'monster-hunter'), 'fighting_style'::rpg.class_proficiency_kind, (SELECT id FROM rpg.phb_fighting_style WHERE slug = 'dueling')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'monster-hunter'), 'fighting_style'::rpg.class_proficiency_kind, (SELECT id FROM rpg.phb_fighting_style WHERE slug = 'great-weapon-fighting')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'monster-hunter'), 'fighting_style'::rpg.class_proficiency_kind, (SELECT id FROM rpg.phb_fighting_style WHERE slug = 'interception')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'monster-hunter'), 'fighting_style'::rpg.class_proficiency_kind, (SELECT id FROM rpg.phb_fighting_style WHERE slug = 'protection')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'monster-hunter'), 'fighting_style'::rpg.class_proficiency_kind, (SELECT id FROM rpg.phb_fighting_style WHERE slug = 'thrown-weapon-fighting')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'monster-hunter'), 'fighting_style'::rpg.class_proficiency_kind, (SELECT id FROM rpg.phb_fighting_style WHERE slug = 'two-weapon-fighting')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'monster-hunter'), 'fighting_style'::rpg.class_proficiency_kind, (SELECT id FROM rpg.phb_fighting_style WHERE slug = 'unarmed-fighting'))
ON CONFLICT (class_id, kind, ref_id) WHERE ref_id IS NOT NULL DO NOTHING;

UPDATE rpg.phb_class
SET weapon_mastery_eligibility = 'any'
WHERE slug = 'monster-hunter';
