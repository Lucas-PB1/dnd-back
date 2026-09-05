-- DMG §0 #9i: resources + permanentEffects (utilitários densos leves + armas)
-- Ver docs/source/extracts/dmg/wiring-status.md
-- Cast/link magia = fase 6
-- carrilhao / pó espirro: sem recover_all_on_long (consome)
-- Grants: SSOT em effects/E007 (species) / E012 (subclass) / E013 (item) / E00* feats

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
