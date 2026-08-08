-- Talentos: definições de recurso + grants (owner_kind = feat).

INSERT INTO rpg.phb_resource_definition (slug, name, scope, feat_id, min_level)
VALUES
  ('luckPoints', 'Pontos de Sorte', 'feat'::rpg.resource_scope, (SELECT id FROM rpg.phb_feat WHERE slug = 'lucky'), 1),
  ('ritualQuick', 'Ritual Rápido', 'feat'::rpg.resource_scope, (SELECT id FROM rpg.phb_feat WHERE slug = 'ritual-caster'), 1),
  ('mageSlayerGuard', 'Resguardo Mental', 'feat'::rpg.resource_scope, (SELECT id FROM rpg.phb_feat WHERE slug = 'mage-slayer'), 1),
  ('boonVitalityDice', 'Recuperar Vitalidade', 'feat'::rpg.resource_scope, (SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-recovery'), 1),
  ('boonDeathWard', 'Até a Morte', 'feat'::rpg.resource_scope, (SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-recovery'), 1),
  ('boonFate', 'Aprimorar Destino', 'feat'::rpg.resource_scope, (SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-fate'), 1),
  ('ironHeroIntervention', 'Intervenção Heroica', 'feat'::rpg.resource_scope, (SELECT id FROM rpg.phb_feat WHERE slug = 'iron-hero'), 1),
  ('familiarDistraction', 'Distração do Familiar', 'feat'::rpg.resource_scope, (SELECT id FROM rpg.phb_feat WHERE slug = 'familiar-keeper'), 1),
  ('showmanTaunt', 'Provocação', 'feat'::rpg.resource_scope, (SELECT id FROM rpg.phb_feat WHERE slug = 'showman'), 1),
  ('spellbladeChannel', 'Ataque Canalizado', 'feat'::rpg.resource_scope, (SELECT id FROM rpg.phb_feat WHERE slug = 'spellblade'), 1),
  ('magitechRecharge', 'Recarga de Item Mágico', 'feat'::rpg.resource_scope, (SELECT id FROM rpg.phb_feat WHERE slug = 'magitechnician'), 1),
  ('metabolisticFuel', 'Combustível Vital', 'feat'::rpg.resource_scope, (SELECT id FROM rpg.phb_feat WHERE slug = 'metabolistic-magic'), 1)
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
  ('lucky', 'luckPoints'),
  ('iron-hero', 'ironHeroIntervention'),
  ('familiar-keeper', 'familiarDistraction'),
  ('showman', 'showmanTaunt'),
  ('spellblade', 'spellbladeChannel')
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
  ('boon-of-fate', 'boonFate', 'fixed', 1, true),
  ('magitechnician', 'magitechRecharge', 'fixed', 1, false),
  ('metabolistic-magic', 'metabolisticFuel', 'fixed', 1, false)
) AS v(feat_slug, resource_slug, max_formula, fixed_max, recover_short)
JOIN rpg.phb_feat f ON f.slug = v.feat_slug
JOIN rpg.phb_resource_definition rd
  ON rd.slug = v.resource_slug AND rd.feat_id = f.id
ON CONFLICT DO NOTHING;
