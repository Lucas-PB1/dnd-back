-- Grim Hollow — Caçador de Monstros proficiências

INSERT INTO rpg.phb_class_proficiency (class_id, kind, ref_id, sort_order)
VALUES
  ((SELECT id FROM rpg.phb_class WHERE slug = 'monster-hunter'), 'primary_ability'::rpg.class_proficiency_kind, (SELECT id FROM rpg.phb_ability WHERE slug = 'forca'), 1),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'monster-hunter'), 'primary_ability'::rpg.class_proficiency_kind, (SELECT id FROM rpg.phb_ability WHERE slug = 'destreza'), 2),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'monster-hunter'), 'primary_ability'::rpg.class_proficiency_kind, (SELECT id FROM rpg.phb_ability WHERE slug = 'inteligencia'), 3),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'monster-hunter'), 'saving_throw'::rpg.class_proficiency_kind, (SELECT id FROM rpg.phb_ability WHERE slug = 'destreza'), 0),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'monster-hunter'), 'saving_throw'::rpg.class_proficiency_kind, (SELECT id FROM rpg.phb_ability WHERE slug = 'inteligencia'), 0),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'monster-hunter'), 'armor_training'::rpg.class_proficiency_kind, (SELECT id FROM rpg.phb_armor_category WHERE slug = 'light'), 0),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'monster-hunter'), 'armor_training'::rpg.class_proficiency_kind, (SELECT id FROM rpg.phb_armor_category WHERE slug = 'medium'), 0),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'monster-hunter'), 'armor_training'::rpg.class_proficiency_kind, (SELECT id FROM rpg.phb_armor_category WHERE slug = 'shield'), 0)
ON CONFLICT (class_id, kind, ref_id) WHERE ref_id IS NOT NULL DO NOTHING;

INSERT INTO rpg.phb_class_proficiency (class_id, kind, ref_slug)
VALUES
  ((SELECT id FROM rpg.phb_class WHERE slug = 'monster-hunter'), 'weapon'::rpg.class_proficiency_kind, 'armas-simples'),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'monster-hunter'), 'weapon'::rpg.class_proficiency_kind, 'armas-marciais')
ON CONFLICT (class_id, kind, ref_slug) WHERE ref_slug IS NOT NULL DO NOTHING;

INSERT INTO rpg.phb_class_skill_pool (class_id, skill_id)
SELECT c.id, s.id FROM rpg.phb_class c, rpg.phb_skill s
WHERE c.slug = 'monster-hunter' AND s.slug = 'athletics'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_class_skill_pool (class_id, skill_id)
SELECT c.id, s.id FROM rpg.phb_class c, rpg.phb_skill s
WHERE c.slug = 'monster-hunter' AND s.slug = 'history'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_class_skill_pool (class_id, skill_id)
SELECT c.id, s.id FROM rpg.phb_class c, rpg.phb_skill s
WHERE c.slug = 'monster-hunter' AND s.slug = 'investigation'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_class_skill_pool (class_id, skill_id)
SELECT c.id, s.id FROM rpg.phb_class c, rpg.phb_skill s
WHERE c.slug = 'monster-hunter' AND s.slug = 'medicine'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_class_skill_pool (class_id, skill_id)
SELECT c.id, s.id FROM rpg.phb_class c, rpg.phb_skill s
WHERE c.slug = 'monster-hunter' AND s.slug = 'nature'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_class_skill_pool (class_id, skill_id)
SELECT c.id, s.id FROM rpg.phb_class c, rpg.phb_skill s
WHERE c.slug = 'monster-hunter' AND s.slug = 'perception'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_class_skill_pool (class_id, skill_id)
SELECT c.id, s.id FROM rpg.phb_class c, rpg.phb_skill s
WHERE c.slug = 'monster-hunter' AND s.slug = 'religion'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_class_skill_pool (class_id, skill_id)
SELECT c.id, s.id FROM rpg.phb_class c, rpg.phb_skill s
WHERE c.slug = 'monster-hunter' AND s.slug = 'survival'
ON CONFLICT DO NOTHING;

