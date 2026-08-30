-- DMG §0 #8e: resources cajados restantes (Agravo/Magificado/Trovoada/Píton)
-- Ver docs/source/extracts/dmg/wiring-status.md

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
  ('cajado-do-agravo', 'cajadoAgravoCharges', 10),
  ('cajado-magificado', 'cajadoMagificadoCharges', 6),
  ('cajado-da-trovoada-relampejante', 'cajadoTrovoadaGolpeUse', 1),
  ('cajado-da-trovoada-relampejante', 'cajadoTrovoadaRelampagoUse', 1),
  ('cajado-da-trovoada-relampejante', 'cajadoTrovoadaTrovaoUse', 1),
  ('cajado-da-trovoada-relampejante', 'cajadoTrovoadaTrovoadaUse', 1),
  ('cajado-da-piton', 'cajadoPitonUse', 1)
) AS v(item_slug, resource_slug, fixed_max)
JOIN rpg.phb_item i ON i.slug = v.item_slug
JOIN rpg.phb_resource_definition rd
  ON rd.slug = v.resource_slug AND rd.item_id = i.id
ON CONFLICT DO NOTHING;

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
