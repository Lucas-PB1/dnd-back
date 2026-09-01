-- Recursos de talento — Grim Hollow Cap. 4 (Fase C)
-- Gerado por scripts/generate-ghpg-cap4-economy-seeds.mjs

INSERT INTO rpg.phb_resource_definition (slug, name, scope, feat_id, min_level)
VALUES
(
  'fortunes-fortitude',
  'Fortitude da Fortuna',
  'feat'::rpg.resource_scope,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'fortuneofthe-thaumaturge'),
  1
),
(
  'lightning-immediate-response',
  'Resposta Imediata',
  'feat'::rpg.resource_scope,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'lightning-caster'),
  4
),
(
  'iron-gut-quick-recover',
  'Recuperação Rápida',
  'feat'::rpg.resource_scope,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'iron-gut'),
  4
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  scope = EXCLUDED.scope,
  feat_id = EXCLUDED.feat_id,
  min_level = EXCLUDED.min_level;

INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'feat'::rpg.resource_owner_kind, f.id, rd.id, 1,
  'proficiency_bonus'::rpg.resource_max_formula, NULL,
  FALSE, FALSE, TRUE
FROM rpg.phb_feat f
JOIN rpg.phb_resource_definition rd
  ON rd.slug = 'fortunes-fortitude' AND rd.feat_id = f.id
WHERE f.slug = 'fortuneofthe-thaumaturge'
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
  'feat'::rpg.resource_owner_kind, f.id, rd.id, 4,
  'fixed'::rpg.resource_max_formula, 1,
  FALSE, FALSE, TRUE
FROM rpg.phb_feat f
JOIN rpg.phb_resource_definition rd
  ON rd.slug = 'lightning-immediate-response' AND rd.feat_id = f.id
WHERE f.slug = 'lightning-caster'
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
  'feat'::rpg.resource_owner_kind, f.id, rd.id, 4,
  'fixed'::rpg.resource_max_formula, 1,
  FALSE, TRUE, TRUE
FROM rpg.phb_feat f
JOIN rpg.phb_resource_definition rd
  ON rd.slug = 'iron-gut-quick-recover' AND rd.feat_id = f.id
WHERE f.slug = 'iron-gut'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;
