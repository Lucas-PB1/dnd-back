-- Recursos de espécie — Northlands Heroes of the Sagas

INSERT INTO rpg.phb_resource_definition (slug, name, scope, species_id, min_level)
VALUES
  (
    'bearfolk-apex-predator',
    'Predador de Ápice',
    'species'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_species WHERE slug = 'bearfolk'),
    1
  ),
  (
    'bearfolk-bear-hug',
    'Abraço do Urso',
    'species'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_species WHERE slug = 'bearfolk'),
    1
  ),
  (
    'giantkin-burning-blood',
    'Sangue Ardente',
    'species'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_species WHERE slug = 'giantkin'),
    1
  ),
  (
    'trollkin-fey-charm',
    'Dado Fey',
    'species'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_species WHERE slug = 'trollkin'),
    1
  ),
  (
    'werekin-shift-aspect',
    'Mudar Aspecto',
    'species'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_species WHERE slug = 'werekin'),
    1
  ),
  (
    'baugsmidr-sense-magic',
    'Sentir Magia',
    'species'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_species WHERE slug = 'baugsmidr-dwarf'),
    1
  )
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  scope = EXCLUDED.scope,
  species_id = EXCLUDED.species_id,
  min_level = EXCLUDED.min_level;

-- Predador de Ápice: PB / LR
INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'species'::rpg.resource_owner_kind, sp.id, rd.id, 1,
  'proficiency_bonus'::rpg.resource_max_formula, NULL,
  FALSE, FALSE, TRUE
FROM rpg.phb_species sp
JOIN rpg.phb_resource_definition rd ON rd.slug = 'bearfolk-apex-predator' AND rd.species_id = sp.id
WHERE sp.slug = 'bearfolk'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

-- Abraço do Urso: CON mod / LR (Garhamr)
INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'species'::rpg.resource_owner_kind, sp.id, rd.id, 1,
  'constitution_mod'::rpg.resource_max_formula, NULL,
  FALSE, FALSE, TRUE
FROM rpg.phb_species sp
JOIN rpg.phb_resource_definition rd ON rd.slug = 'bearfolk-bear-hug' AND rd.species_id = sp.id
WHERE sp.slug = 'bearfolk'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

-- Sangue Ardente: PB / LR
INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'species'::rpg.resource_owner_kind, sp.id, rd.id, 1,
  'proficiency_bonus'::rpg.resource_max_formula, NULL,
  FALSE, FALSE, TRUE
FROM rpg.phb_species sp
JOIN rpg.phb_resource_definition rd ON rd.slug = 'giantkin-burning-blood' AND rd.species_id = sp.id
WHERE sp.slug = 'giantkin'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

-- Dado Fey: CHA mod / LR
INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'species'::rpg.resource_owner_kind, sp.id, rd.id, 1,
  'charisma_mod'::rpg.resource_max_formula, NULL,
  FALSE, FALSE, TRUE
FROM rpg.phb_species sp
JOIN rpg.phb_resource_definition rd ON rd.slug = 'trollkin-fey-charm' AND rd.species_id = sp.id
WHERE sp.slug = 'trollkin'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

-- Mudar Aspecto: 1 / LR
INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'species'::rpg.resource_owner_kind, sp.id, rd.id, 1,
  'fixed'::rpg.resource_max_formula, 1,
  FALSE, FALSE, TRUE
FROM rpg.phb_species sp
JOIN rpg.phb_resource_definition rd ON rd.slug = 'werekin-shift-aspect' AND rd.species_id = sp.id
WHERE sp.slug = 'werekin'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

-- Sentir Magia: PB / LR
INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'species'::rpg.resource_owner_kind, sp.id, rd.id, 1,
  'proficiency_bonus'::rpg.resource_max_formula, NULL,
  FALSE, FALSE, TRUE
FROM rpg.phb_species sp
JOIN rpg.phb_resource_definition rd ON rd.slug = 'baugsmidr-sense-magic' AND rd.species_id = sp.id
WHERE sp.slug = 'baugsmidr-dwarf'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;
