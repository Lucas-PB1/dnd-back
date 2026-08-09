-- Player Pack 2: recursos de talento e item (após P004 / P008).

INSERT INTO rpg.phb_resource_definition (slug, name, scope, feat_id, min_level)
VALUES
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
  ('familiar-keeper', 'familiarDistraction'),
  ('showman', 'showmanTaunt'),
  ('spellblade', 'spellbladeChannel')
)
ON CONFLICT DO NOTHING;

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
FROM (VALUES
  ('magitechnician', 'magitechRecharge'),
  ('metabolistic-magic', 'metabolisticFuel')
) AS v(feat_slug, resource_slug)
JOIN rpg.phb_feat f ON f.slug = v.feat_slug
JOIN rpg.phb_resource_definition rd
  ON rd.slug = v.resource_slug AND rd.feat_id = f.id
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_resource_definition (slug, name, scope, item_id, min_level)
VALUES
  ('gamblerCoinCharges', 'Cargas da Moeda do Apostador', 'item'::rpg.resource_scope, (SELECT id FROM rpg.phb_item WHERE slug = 'gambler-s-coin'), 1),
  ('bagOfCheerGifts', 'Presentes da Bolsa da Alegria', 'item'::rpg.resource_scope, (SELECT id FROM rpg.phb_item WHERE slug = 'bag-of-cheer'), 1),
  ('soulFigurineWard', 'Figurinha da Alma', 'item'::rpg.resource_scope, (SELECT id FROM rpg.phb_item WHERE slug = 'soul-figurine'), 1)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  scope = EXCLUDED.scope,
  item_id = EXCLUDED.item_id,
  min_level = EXCLUDED.min_level;

INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'item'::rpg.resource_owner_kind,
  i.id,
  rd.id,
  1,
  'fixed'::rpg.resource_max_formula,
  v.fixed_max,
  FALSE,
  FALSE,
  TRUE
FROM (VALUES
  ('gambler-s-coin', 'gamblerCoinCharges', 3),
  ('bag-of-cheer', 'bagOfCheerGifts', 3)
) AS v(item_slug, resource_slug, fixed_max)
JOIN rpg.phb_item i ON i.slug = v.item_slug
JOIN rpg.phb_resource_definition rd
  ON rd.slug = v.resource_slug AND rd.item_id = i.id
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'item'::rpg.resource_owner_kind,
  i.id,
  rd.id,
  1,
  'fixed'::rpg.resource_max_formula,
  1,
  FALSE,
  FALSE,
  FALSE
FROM rpg.phb_item i
JOIN rpg.phb_resource_definition rd
  ON rd.item_id = i.id AND rd.slug = 'soulFigurineWard'
WHERE i.slug = 'soul-figurine'
ON CONFLICT DO NOTHING;
