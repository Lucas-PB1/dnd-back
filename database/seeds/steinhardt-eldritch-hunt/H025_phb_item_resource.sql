-- Recursos de item — Steinhardt Eldritch Hunt (cargas / usos)

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
  v.recover_short,
  TRUE
FROM (VALUES
  ('galvanized-claw', 'galvanizedClawCharges', 3, false),
  ('shard-of-moonlight', 'shardOfMoonlightCharges', 10, false),
  ('orphans-cradle', 'orphansCradlePurify', 1, true),
  ('dream-executioner', 'dreamExecutionerSoul', 1, false)
) AS v(item_slug, resource_slug, fixed_max, recover_short)
JOIN rpg.phb_item i ON i.slug = v.item_slug
JOIN rpg.phb_resource_definition rd
  ON rd.slug = v.resource_slug AND rd.item_id = i.id
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;
