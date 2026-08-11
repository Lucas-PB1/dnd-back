-- DMG §0 #8: resources cajados (pool + multi-magia)
-- Ver docs/source/dmg-wiring-status.md

INSERT INTO rpg.phb_resource_definition (slug, name, scope, item_id, min_level)
VALUES
  (
    'cajadoCuraCharges',
    'Cargas — Cajado da Cura',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-da-cura'),
    1
  ),
  (
    'cajadoFogoCharges',
    'Cargas — Cajado do Fogo',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-do-fogo'),
    1
  ),
  (
    'cajadoGeloCharges',
    'Cargas — Cajado do Gelo',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-do-gelo'),
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
  10,
  FALSE,
  FALSE,
  TRUE
FROM (VALUES
  ('cajado-da-cura', 'cajadoCuraCharges'),
  ('cajado-do-fogo', 'cajadoFogoCharges'),
  ('cajado-do-gelo', 'cajadoGeloCharges')
) AS v(item_slug, resource_slug)
JOIN rpg.phb_item i ON i.slug = v.item_slug
JOIN rpg.phb_resource_definition rd
  ON rd.slug = v.resource_slug AND rd.item_id = i.id
ON CONFLICT DO NOTHING;
