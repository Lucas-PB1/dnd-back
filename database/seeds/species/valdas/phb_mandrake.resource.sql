-- Mandrake (Valdas): recurso Vinhas Enredantes — após V004 (espécie).
-- Grants: SSOT em effects/E007 (species) / E012 (subclass) / E013 (item) / E00* feats

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


