-- DMG §0 #8e: resources cajados restantes (Agravo/Magificado/Trovoada/Píton)
-- Ver docs/source/extracts/dmg/wiring-status.md
-- Grants: SSOT em effects/E007 (species) / E012 (subclass) / E013 (item) / E00* feats

INSERT INTO rpg.phb_resource_definition (slug, name, scope, item_id, min_level)
VALUES
  (
    'cajadoAgravoCharges',
    'Cargas — Cajado do Agravo',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-do-agravo'),
    1
  ),
  (
    'cajadoMagificadoCharges',
    'Cargas — Cajado Magificado',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-magificado'),
    1
  ),
  (
    'cajadoTrovoadaGolpeUse',
    'Golpe de Relâmpago — Cajado da Trovoada',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-da-trovoada-relampejante'),
    1
  ),
  (
    'cajadoTrovoadaRelampagoUse',
    'Relâmpago — Cajado da Trovoada',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-da-trovoada-relampejante'),
    1
  ),
  (
    'cajadoTrovoadaTrovaoUse',
    'Trovão — Cajado da Trovoada',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-da-trovoada-relampejante'),
    1
  ),
  (
    'cajadoTrovoadaTrovoadaUse',
    'Trovoada — Cajado da Trovoada',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-da-trovoada-relampejante'),
    1
  ),
  (
    'cajadoPitonUse',
    'Cobra Constritora — Cajado da Píton',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-da-piton'),
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
    "attackBonus": 3,
    "damageBonus": 3
  }
}'::jsonb
WHERE slug = 'cajado-do-agravo';

UPDATE rpg.phb_item
SET properties = COALESCE(properties, '{}'::jsonb) || '{
  "permanentEffects": {
    "attackBonus": 2,
    "damageBonus": 2
  }
}'::jsonb
WHERE slug = 'cajado-da-trovoada-relampejante';
