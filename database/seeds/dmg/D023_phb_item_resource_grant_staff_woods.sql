-- DMG §0 #8d: Cajado das Matas (resource + permanentEffects arma +2)
-- Ver docs/source/dmg-item-mesa-taxonomy-staves.yaml
-- +2 ataque mágico = passive-note (sem campo em permanentEffects)

INSERT INTO rpg.phb_resource_definition (slug, name, scope, item_id, min_level)
VALUES
  (
    'cajadoMatasCharges',
    'Cargas — Cajado das Matas',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-das-matas'),
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
  6,
  FALSE,
  FALSE,
  TRUE
FROM rpg.phb_item i
JOIN rpg.phb_resource_definition rd
  ON rd.slug = 'cajadoMatasCharges' AND rd.item_id = i.id
WHERE i.slug = 'cajado-das-matas'
ON CONFLICT DO NOTHING;

UPDATE rpg.phb_item
SET properties = COALESCE(properties, '{}'::jsonb) || '{
  "permanentEffects": {
    "attackBonus": 2,
    "damageBonus": 2
  }
}'::jsonb
WHERE slug = 'cajado-das-matas';
