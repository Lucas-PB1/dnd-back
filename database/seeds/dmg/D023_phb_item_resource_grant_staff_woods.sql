-- DMG §0 #8d: Cajado das Matas (resource + permanentEffects arma +2)
-- Ver docs/source/extracts/dmg/wiring-status.md
-- +2 ataque mágico = passive-note (sem campo em permanentEffects)
-- Grants: SSOT em effects/E007 (species) / E012 (subclass) / E013 (item) / E00* feats

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



UPDATE rpg.phb_item
SET properties = COALESCE(properties, '{}'::jsonb) || '{
  "permanentEffects": {
    "attackBonus": 2,
    "damageBonus": 2
  }
}'::jsonb
WHERE slug = 'cajado-das-matas';
