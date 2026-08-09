-- Talentos PHB: definições de recurso + grants (owner_kind = feat).
-- Talentos Valdas → valdas/V019_phb_feat_resource_grant.sql

INSERT INTO rpg.phb_resource_definition (slug, name, scope, feat_id, min_level)
VALUES
  ('luckPoints', 'Pontos de Sorte', 'feat'::rpg.resource_scope, (SELECT id FROM rpg.phb_feat WHERE slug = 'lucky'), 1),
  ('ritualQuick', 'Ritual Rápido', 'feat'::rpg.resource_scope, (SELECT id FROM rpg.phb_feat WHERE slug = 'ritual-caster'), 1),
  ('mageSlayerGuard', 'Resguardo Mental', 'feat'::rpg.resource_scope, (SELECT id FROM rpg.phb_feat WHERE slug = 'mage-slayer'), 1),
  ('boonVitalityDice', 'Recuperar Vitalidade', 'feat'::rpg.resource_scope, (SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-recovery'), 1),
  ('boonDeathWard', 'Até a Morte', 'feat'::rpg.resource_scope, (SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-recovery'), 1),
  ('boonFate', 'Aprimorar Destino', 'feat'::rpg.resource_scope, (SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-fate'), 1)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  scope = EXCLUDED.scope,
  feat_id = EXCLUDED.feat_id,
  min_level = EXCLUDED.min_level;

-- PB / LR
INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'feat'::rpg.resource_owner_kind,
  f.id,
  rd.id,
  1,
  'proficiency_bonus'::rpg.resource_max_formula,
  NULL,
  FALSE,
  FALSE,
  TRUE
FROM rpg.phb_feat f
JOIN rpg.phb_resource_definition rd ON rd.feat_id = f.id
WHERE (f.slug, rd.slug) IN (
  ('lucky', 'luckPoints')
)
ON CONFLICT DO NOTHING;

-- 1 / SR+LR (mage slayer)
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
  ON rd.feat_id = f.id AND rd.slug = 'mageSlayerGuard'
WHERE f.slug = 'mage-slayer'
ON CONFLICT DO NOTHING;

-- Fixed pools / LR
INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'feat'::rpg.resource_owner_kind,
  f.id,
  rd.id,
  1,
  v.max_formula::rpg.resource_max_formula,
  v.fixed_max,
  FALSE,
  v.recover_short,
  TRUE
FROM (VALUES
  ('ritual-caster', 'ritualQuick', 'fixed', 1, false),
  ('boon-of-recovery', 'boonDeathWard', 'fixed', 1, false),
  ('boon-of-recovery', 'boonVitalityDice', 'fixed', 10, false),
  ('boon-of-fate', 'boonFate', 'fixed', 1, true)
) AS v(feat_slug, resource_slug, max_formula, fixed_max, recover_short)
JOIN rpg.phb_feat f ON f.slug = v.feat_slug
JOIN rpg.phb_resource_definition rd
  ON rd.slug = v.resource_slug AND rd.feat_id = f.id
ON CONFLICT DO NOTHING;
