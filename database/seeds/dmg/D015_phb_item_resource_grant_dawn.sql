-- DMG lote §0 #4: resources 1×/amanhecer (MVP: recover no Descanso Longo)
-- Ver docs/source/dmg-item-mesa-taxonomy-dawn.yaml

INSERT INTO rpg.phb_resource_definition (slug, name, scope, item_id, min_level)
VALUES
  (
    'amuletoMecanicoUse',
    'Amuleto Mecânico',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'amuleto-mecanico'),
    1
  ),
  (
    'diademaExplosaoUse',
    'Diadema da Explosão',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'diadema-da-explosao'),
    1
  ),
  (
    'periaptSaudeUse',
    'Periapto de Saúde',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'periapto-de-saude'),
    1
  ),
  (
    'perolaPoderUse',
    'Pérola de Poder',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'perola-de-poder'),
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
  ('amuleto-mecanico', 'amuletoMecanicoUse', 1),
  ('diadema-da-explosao', 'diademaExplosaoUse', 1),
  ('periapto-de-saude', 'periaptSaudeUse', 1),
  ('perola-de-poder', 'perolaPoderUse', 1)
) AS v(item_slug, resource_slug, fixed_max)
JOIN rpg.phb_item i ON i.slug = v.item_slug
JOIN rpg.phb_resource_definition rd
  ON rd.slug = v.resource_slug AND rd.item_id = i.id
ON CONFLICT DO NOTHING;
