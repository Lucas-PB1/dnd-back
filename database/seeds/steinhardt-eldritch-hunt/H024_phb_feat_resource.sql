-- Recursos de talento — Steinhardt Eldritch Hunt

INSERT INTO rpg.phb_resource_definition (slug, name, scope, feat_id, min_level)
VALUES
  (
    'divineClarity',
    'Clareza Divina',
    'feat'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_feat WHERE slug = 'faithful'),
    1
  ),
  (
    'resistInspiration',
    'Resistir',
    'feat'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_feat WHERE slug = 'grizzled'),
    1
  )
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  scope = EXCLUDED.scope,
  feat_id = EXCLUDED.feat_id,
  min_level = EXCLUDED.min_level;

-- Fiel: Clareza Divina 1× / DL
INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'feat'::rpg.resource_owner_kind,
  f.id,
  rd.id,
  1,
  'fixed'::rpg.resource_max_formula,
  1,
  FALSE,
  FALSE,
  TRUE
FROM rpg.phb_feat f
JOIN rpg.phb_resource_definition rd
  ON rd.slug = 'divineClarity' AND rd.feat_id = f.id
WHERE f.slug = 'faithful'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

-- Curtido: Resistir 1× / DC ou DL (após Ensanguentado)
INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'feat'::rpg.resource_owner_kind,
  f.id,
  rd.id,
  1,
  'fixed'::rpg.resource_max_formula,
  1,
  FALSE,
  TRUE,
  TRUE
FROM rpg.phb_feat f
JOIN rpg.phb_resource_definition rd
  ON rd.slug = 'resistInspiration' AND rd.feat_id = f.id
WHERE f.slug = 'grizzled'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;
