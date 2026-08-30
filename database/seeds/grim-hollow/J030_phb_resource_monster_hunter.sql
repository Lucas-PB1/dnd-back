-- Recursos de combate — Caçador de Monstros (guildas + classe)

INSERT INTO rpg.phb_resource_definition (slug, name, scope, class_id, subclass_id, min_level)
VALUES
  (
    'devourer-portion',
    'Porções de Monstro',
    'subclass'::rpg.resource_scope,
    NULL,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'devourer-guild'),
    3
  ),
  (
    'grave-strike',
    'Golpe Sepulcral',
    'class'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_class WHERE slug = 'monster-hunter'),
    NULL,
    20
  ),
  (
    'trapper-phase-leap',
    'Salto de Fase',
    'subclass'::rpg.resource_scope,
    NULL,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'trapper-guild'),
    15
  )
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  scope = EXCLUDED.scope,
  class_id = EXCLUDED.class_id,
  subclass_id = EXCLUDED.subclass_id,
  min_level = EXCLUDED.min_level;

INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max, feature_id,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'subclass'::rpg.resource_owner_kind,
  s.id,
  rd.id,
  3,
  'intelligence_mod'::rpg.resource_max_formula,
  NULL,
  sf.id,
  FALSE,
  FALSE,
  TRUE
FROM rpg.phb_subclass s
JOIN rpg.phb_resource_definition rd ON rd.slug = 'devourer-portion'
LEFT JOIN rpg.phb_subclass_feature sf
  ON sf.subclass_id = s.id AND sf.name = 'Transmuting Metabolism'
WHERE s.slug = 'devourer-guild'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  feature_id = EXCLUDED.feature_id,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'class'::rpg.resource_owner_kind,
  c.id,
  rd.id,
  20,
  'intelligence_mod'::rpg.resource_max_formula,
  NULL,
  FALSE,
  FALSE,
  TRUE
FROM rpg.phb_class c
JOIN rpg.phb_resource_definition rd ON rd.slug = 'grave-strike'
WHERE c.slug = 'monster-hunter'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max, feature_id,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'subclass'::rpg.resource_owner_kind,
  s.id,
  rd.id,
  15,
  'fixed'::rpg.resource_max_formula,
  3,
  sf.id,
  FALSE,
  FALSE,
  TRUE
FROM rpg.phb_subclass s
JOIN rpg.phb_resource_definition rd ON rd.slug = 'trapper-phase-leap'
LEFT JOIN rpg.phb_subclass_feature sf
  ON sf.subclass_id = s.id AND sf.name = 'Monster-Hide Armor'
WHERE s.slug = 'trapper-guild'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  fixed_max = EXCLUDED.fixed_max,
  feature_id = EXCLUDED.feature_id,
  recover_all_on_long = EXCLUDED.recover_all_on_long;
