-- Recursos de item — Steinhardt Eldritch Hunt (cargas / usos)
-- Grants: SSOT em effects/E007 (species) / E012 (subclass) / E013 (item) / E00* feats

INSERT INTO rpg.phb_resource_definition (slug, name, scope, item_id, min_level)
VALUES
  (
    'galvanizedClawCharges',
    'Cargas da Garra Galvanizada',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'galvanized-claw'),
    1
  ),
  (
    'shardOfMoonlightCharges',
    'Cargas do Estilhaço do Luar',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'shard-of-moonlight'),
    1
  ),
  (
    'orphansCradlePurify',
    'Miasma Purificador',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'orphans-cradle'),
    1
  ),
  (
    'dreamExecutionerSoul',
    'Alma Colhida',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'dream-executioner'),
    1
  )
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  scope = EXCLUDED.scope,
  item_id = EXCLUDED.item_id,
  min_level = EXCLUDED.min_level;


