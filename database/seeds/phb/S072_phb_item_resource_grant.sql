-- Itens mágicos: definições de recurso + grants (owner_kind = item).

INSERT INTO rpg.phb_resource_definition (slug, name, scope, item_id, min_level)
VALUES
  ('ringBarrelCharges', 'Cargas do Anel dos Barris', 'item'::rpg.resource_scope, (SELECT id FROM rpg.phb_item WHERE slug = 'ring-of-barrels'), 1),
  ('gamblerCoinCharges', 'Cargas da Moeda do Apostador', 'item'::rpg.resource_scope, (SELECT id FROM rpg.phb_item WHERE slug = 'gambler-s-coin'), 1),
  ('bagOfCheerGifts', 'Presentes da Bolsa da Alegria', 'item'::rpg.resource_scope, (SELECT id FROM rpg.phb_item WHERE slug = 'bag-of-cheer'), 1),
  ('frogPrinceUse', 'Estatueta do Príncipe Sapo', 'item'::rpg.resource_scope, (SELECT id FROM rpg.phb_item WHERE slug = 'frog-prince-statuette'), 1),
  ('throneFeast', 'Banquete do Trono', 'item'::rpg.resource_scope, (SELECT id FROM rpg.phb_item WHERE slug = 'leonora-s-throne-of-indolence'), 1),
  ('soulFigurineWard', 'Figurinha da Alma', 'item'::rpg.resource_scope, (SELECT id FROM rpg.phb_item WHERE slug = 'soul-figurine'), 1)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  scope = EXCLUDED.scope,
  item_id = EXCLUDED.item_id,
  min_level = EXCLUDED.min_level;

-- Fixed pools / LR (amanhecer ≈ LR no MVP)
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
  ('ring-of-barrels', 'ringBarrelCharges', 6),
  ('gambler-s-coin', 'gamblerCoinCharges', 3),
  ('bag-of-cheer', 'bagOfCheerGifts', 3),
  ('frog-prince-statuette', 'frogPrinceUse', 1),
  ('leonora-s-throne-of-indolence', 'throneFeast', 1)
) AS v(item_slug, resource_slug, fixed_max)
JOIN rpg.phb_item i ON i.slug = v.item_slug
JOIN rpg.phb_resource_definition rd
  ON rd.slug = v.resource_slug AND rd.item_id = i.id
ON CONFLICT DO NOTHING;

-- Soul figurine: one-shot (não recupera)
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
