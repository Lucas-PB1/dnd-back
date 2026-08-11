-- DMG §0 #8b: resource Cajado do Enxame de Insetos (pool simples)
-- Ver docs/source/dmg-wiring-status.md

INSERT INTO rpg.phb_resource_definition (slug, name, scope, item_id, min_level)
VALUES
  (
    'cajadoEnxameCharges',
    'Cargas — Cajado do Enxame de Insetos',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-do-enxame-de-insetos'),
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
FROM rpg.phb_item i
JOIN rpg.phb_resource_definition rd
  ON rd.slug = 'cajadoEnxameCharges' AND rd.item_id = i.id
WHERE i.slug = 'cajado-do-enxame-de-insetos'
ON CONFLICT DO NOTHING;
