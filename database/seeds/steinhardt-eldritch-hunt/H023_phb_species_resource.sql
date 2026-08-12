-- Recursos de espécie — Manikin / Scourgeborne (Eldritch Hunt)

INSERT INTO rpg.phb_resource_definition (slug, name, scope, species_id, min_level)
VALUES
  (
    'manikin-custodian-intercept',
    'Intercepção do Custódio',
    'species'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_species WHERE slug = 'manikin'),
    1
  ),
  (
    'manikin-thespian-bond',
    'Conexão Teatral',
    'species'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_species WHERE slug = 'manikin'),
    1
  ),
  (
    'scourgeborne-lineage',
    'Linhagem Monstruosa',
    'species'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_species WHERE slug = 'scourgeborne'),
    3
  )
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  scope = EXCLUDED.scope,
  species_id = EXCLUDED.species_id,
  min_level = EXCLUDED.min_level;

-- Custódio: Reação PB / LR
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
  ON rd.slug = 'manikin-custodian-intercept' AND rd.species_id = sp.id
WHERE sp.slug = 'manikin'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

-- Teatral: 1 conexão / SR+LR
INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'species'::rpg.resource_owner_kind,
  sp.id,
  rd.id,
  1,
  'fixed'::rpg.resource_max_formula,
  1,
  FALSE,
  TRUE,
  TRUE
FROM rpg.phb_species sp
JOIN rpg.phb_resource_definition rd
  ON rd.slug = 'manikin-thespian-bond' AND rd.species_id = sp.id
WHERE sp.slug = 'manikin'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

-- Linhagem: L3 = 1/LR; L5 = PB/LR (Vespertilio também SR — MVP recupera em SR+LR)
INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'species'::rpg.resource_owner_kind,
  sp.id,
  rd.id,
  3,
  'fixed'::rpg.resource_max_formula,
  1,
  FALSE,
  FALSE,
  TRUE
FROM rpg.phb_species sp
JOIN rpg.phb_resource_definition rd
  ON rd.slug = 'scourgeborne-lineage' AND rd.species_id = sp.id
WHERE sp.slug = 'scourgeborne'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'species'::rpg.resource_owner_kind,
  sp.id,
  rd.id,
  5,
  'proficiency_bonus'::rpg.resource_max_formula,
  NULL,
  FALSE,
  TRUE,
  TRUE
FROM rpg.phb_species sp
JOIN rpg.phb_resource_definition rd
  ON rd.slug = 'scourgeborne-lineage' AND rd.species_id = sp.id
WHERE sp.slug = 'scourgeborne'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;
