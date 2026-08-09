-- Mandrake (Valdas): recurso Vinhas Enredantes — após V004 (espécie).

INSERT INTO rpg.phb_resource_definition (slug, name, scope, species_id, class_id, min_level)
VALUES (
  'entanglingVines',
  'Vinhas Enredantes',
  'species'::rpg.resource_scope,
  (SELECT id FROM rpg.phb_species WHERE slug = 'mandrake'),
  NULL,
  1
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  scope = EXCLUDED.scope,
  species_id = EXCLUDED.species_id,
  min_level = EXCLUDED.min_level;

INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'species'::rpg.resource_owner_kind,
  sp.id,
  rd.id,
  1,
  'proficiency_bonus'::rpg.resource_max_formula,
  NULL,
  FALSE,
  FALSE,
  TRUE
FROM rpg.phb_species sp
JOIN rpg.phb_resource_definition rd
  ON rd.species_id = sp.id AND rd.slug = 'entanglingVines'
WHERE sp.slug = 'mandrake'
ON CONFLICT DO NOTHING;
