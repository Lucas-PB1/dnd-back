-- Gunslinger P0: mastery eligibility/progression + Risk resource

UPDATE rpg.phb_class
SET weapon_mastery_eligibility = 'ranged'
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
  'Risco',
  'class'::rpg.resource_scope,
  NULL,
  (SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'),
  2
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  class_id = EXCLUDED.class_id,
  min_level = EXCLUDED.min_level;

-- Grants: effects/E009_class.sql
