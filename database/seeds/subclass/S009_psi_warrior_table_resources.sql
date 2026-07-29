-- Uso gratuito por descanso do Movimento Telecinético.
-- Repetições podem gastar um Dado de Energia Psiônica pela ação da ficha.

INSERT INTO rpg.phb_resource_definition (
  slug, name, scope, subclass_id, min_level
)
VALUES (
  'telekinetic-movement',
  'Movimento Telecinético',
  'subclass'::rpg.resource_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'psi-warrior'),
  3
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  scope = EXCLUDED.scope,
  subclass_id = EXCLUDED.subclass_id,
  min_level = EXCLUDED.min_level;

INSERT INTO rpg.phb_subclass_resource (
  subclass_id, resource_id, unlock_level, max_formula, fixed_max, feature_id,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  s.id,
  rd.id,
  3,
  'fixed'::rpg.resource_max_formula,
  1,
  sf.id,
  FALSE,
  TRUE,
  TRUE
FROM rpg.phb_subclass s
JOIN rpg.phb_resource_definition rd
  ON rd.slug = 'telekinetic-movement'
LEFT JOIN rpg.phb_subclass_feature sf
  ON sf.subclass_id = s.id AND sf.name = 'Poder Psiônico'
WHERE s.slug = 'psi-warrior'
ON CONFLICT (subclass_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  feature_id = EXCLUDED.feature_id,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;
