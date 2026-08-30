-- DMG §0 #9i: resources + permanentEffects (utilitários densos leves + armas)
-- Ver docs/source/extracts/dmg/wiring-status.md
-- Cast/link magia = fase 6
-- carrilhao / pó espirro: sem recover_all_on_long (consome)

INSERT INTO rpg.phb_resource_definition (slug, name, scope, item_id, min_level)
VALUES
  (
    'adagaPeconhentaVenenoUse',
    'Veneno — Adaga Peçonhenta',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'adaga-peconhenta'),
    1
  ),
  (
    'azagaiaRelampagoUse',
    'Relâmpago — Azagaia Relâmpago',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'azagaia-relampago'),
    1
  ),
  (
    'flautaEsgotosCharges',
    'Cargas — Flauta dos Esgotos',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'flauta-dos-esgotos'),
    1
  ),
  (
    'carrilhaoDestrancadorCharges',
    'Usos — Carrilhão Destrancador',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'carrilhao-destrancador'),
    1
  ),
  (
    'poEspirroEngasgoUse',
    'Uso — Pó de Espirro e Engasgo',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'po-de-espirro-engasgo'),
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
  v.recover_long
FROM (VALUES
  ('adaga-peconhenta', 'adagaPeconhentaVenenoUse', 1, TRUE),
  ('azagaia-relampago', 'azagaiaRelampagoUse', 1, TRUE),
  ('flauta-dos-esgotos', 'flautaEsgotosCharges', 3, TRUE),
  ('carrilhao-destrancador', 'carrilhaoDestrancadorCharges', 10, FALSE),
  ('po-de-espirro-engasgo', 'poEspirroEngasgoUse', 1, FALSE)
) AS v(item_slug, resource_slug, fixed_max, recover_long)
JOIN rpg.phb_item i ON i.slug = v.item_slug
JOIN rpg.phb_resource_definition rd
  ON rd.slug = v.resource_slug AND rd.item_id = i.id
ON CONFLICT DO NOTHING;

UPDATE rpg.phb_item
SET properties = COALESCE(properties, '{}'::jsonb) || '{
  "permanentEffects": {
    "attackBonus": 1,
    "damageBonus": 1
  }
}'::jsonb
WHERE slug = 'adaga-peconhenta';

UPDATE rpg.phb_item
SET properties = COALESCE(properties, '{}'::jsonb) || '{
  "permanentEffects": {
    "attackBonus": 2,
    "damageBonus": 2
  }
}'::jsonb
WHERE slug = 'cimitarra-da-velocidade';
