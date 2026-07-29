-- Gunslinger P0: mastery eligibility/progression + Risk resource

UPDATE rpg.phb_class
SET weapon_mastery_eligibility = 'any'
WHERE slug = 'gunslinger';

UPDATE rpg.phb_class_progression cp
SET weapon_mastery = CASE
  WHEN cp.level BETWEEN 1 AND 3 THEN 2
  WHEN cp.level BETWEEN 4 AND 9 THEN 3
  WHEN cp.level BETWEEN 10 AND 20 THEN 4
  ELSE cp.weapon_mastery
END
FROM rpg.phb_class c
WHERE cp.class_id = c.id AND c.slug = 'gunslinger';

INSERT INTO rpg.phb_resource_definition (slug, name, scope, species_id, class_id, min_level)
VALUES (
  'risk',
  'Risk',
  'class'::rpg.resource_scope,
  NULL,
  (SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'),
  2
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  class_id = EXCLUDED.class_id,
  min_level = EXCLUDED.min_level;

INSERT INTO rpg.phb_class_resource (
  class_id, resource_id, unlock_level, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT c.id, rd.id, v.unlock_level, 'fixed'::rpg.resource_max_formula, v.fixed_max,
       FALSE, TRUE, TRUE
FROM rpg.phb_class c
JOIN rpg.phb_resource_definition rd ON rd.slug = 'risk' AND rd.class_id = c.id
CROSS JOIN (VALUES
  (2, 4),
  (6, 5),
  (14, 6)
) AS v(unlock_level, fixed_max)
WHERE c.slug = 'gunslinger'
ON CONFLICT DO NOTHING;
