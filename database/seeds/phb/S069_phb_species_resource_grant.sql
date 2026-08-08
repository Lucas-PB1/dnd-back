-- Espécie: def Mandrágora + grants para todos os recursos de espécie (S046).

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

-- PB / LR
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
JOIN rpg.phb_resource_definition rd ON rd.species_id = sp.id
WHERE (sp.slug, rd.slug) IN (
  ('dwarf', 'stonecunning'),
  ('dragonborn', 'breathWeapon'),
  ('goliath', 'giantAncestry'),
  ('mandrake', 'entanglingVines')
)
ON CONFLICT DO NOTHING;

-- Orc adrenalina: PB / SR+LR
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
  TRUE,
  TRUE
FROM rpg.phb_species sp
JOIN rpg.phb_resource_definition rd
  ON rd.species_id = sp.id AND rd.slug = 'adrenalineSurge'
WHERE sp.slug = 'orc'
ON CONFLICT DO NOTHING;

-- Fixed 1 / LR
INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'species'::rpg.resource_owner_kind,
  sp.id,
  rd.id,
  v.unlock_level,
  'fixed'::rpg.resource_max_formula,
  1,
  FALSE,
  FALSE,
  TRUE
FROM (VALUES
  ('aasimar', 'healingHands', 1),
  ('aasimar', 'celestialRevelation', 3),
  ('dragonborn', 'dragonFlight', 5),
  ('goliath', 'largeForm', 5),
  ('orc', 'relentlessEndurance', 1)
) AS v(species_slug, resource_slug, unlock_level)
JOIN rpg.phb_species sp ON sp.slug = v.species_slug
JOIN rpg.phb_resource_definition rd
  ON rd.slug = v.resource_slug AND rd.species_id = sp.id
ON CONFLICT DO NOTHING;
