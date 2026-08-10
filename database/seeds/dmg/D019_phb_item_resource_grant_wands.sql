-- DMG §0 #7: resources varinhas (pool + multi-magia)
-- Ver docs/source/dmg-item-mesa-taxonomy-wands.yaml

INSERT INTO rpg.phb_resource_definition (slug, name, scope, item_id, min_level)
VALUES
  (
    'varinhaImobilizadoraCharges',
    'Cargas — Varinha Imobilizadora',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'varinha-imobilizadora'),
    1
  ),
  (
    'varinhaMedoCharges',
    'Cargas — Varinha do Medo',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'varinha-do-medo'),
    1
  ),
  (
    'varinhaMisseisCharges',
    'Cargas — Varinha de Mísseis Mágicos',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'varinha-de-misseis-magicos'),
    1
  )
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
  ('varinha-imobilizadora', 'varinhaImobilizadoraCharges', 7),
  ('varinha-do-medo', 'varinhaMedoCharges', 7),
  ('varinha-de-misseis-magicos', 'varinhaMisseisCharges', 7)
) AS v(item_slug, resource_slug, fixed_max)
JOIN rpg.phb_item i ON i.slug = v.item_slug
JOIN rpg.phb_resource_definition rd
  ON rd.slug = v.resource_slug AND rd.item_id = i.id
ON CONFLICT DO NOTHING;
