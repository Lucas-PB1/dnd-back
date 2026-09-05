-- DMG §0 #7: resources varinhas (pool + multi-magia)
-- Ver docs/source/extracts/dmg/wiring-status.md
-- Grants: SSOT em effects/E007 (species) / E012 (subclass) / E013 (item) / E00* feats

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


