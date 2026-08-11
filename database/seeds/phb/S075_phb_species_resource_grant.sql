-- Grants de recursos de espécie PHB (defs em S046). Mandrake → valdas/V018.

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
  ('goliath', 'giantAncestry')
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
