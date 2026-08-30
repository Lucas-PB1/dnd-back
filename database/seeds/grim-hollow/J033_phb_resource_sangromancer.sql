-- Recursos — Sangromante (Grim Hollow Cap. 2)

INSERT INTO rpg.phb_resource_definition (slug, name, scope, class_id, subclass_id, min_level)
VALUES (
  'sangromancy-dice',
  'Dados de Sangromancia',
  'subclass'::rpg.resource_scope,
  NULL,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'sangromancer'),
  3
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  scope = EXCLUDED.scope,
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
  'level_plus_one'::rpg.resource_max_formula,
  NULL,
  sf.id,
  TRUE,
  FALSE,
  TRUE
FROM rpg.phb_subclass s
JOIN rpg.phb_resource_definition rd ON rd.slug = 'sangromancy-dice'
LEFT JOIN rpg.phb_subclass_feature sf
  ON sf.subclass_id = s.id AND sf.name = 'Sangue Pleno'
WHERE s.slug = 'sangromancer'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  feature_id = EXCLUDED.feature_id,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;
