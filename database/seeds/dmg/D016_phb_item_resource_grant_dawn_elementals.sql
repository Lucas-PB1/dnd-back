-- DMG lote §0 #4b: resources 1×/amanhecer (elementais)
-- Ver docs/source/extracts/dmg/wiring-status.md

INSERT INTO rpg.phb_resource_definition (slug, name, scope, item_id, min_level)
VALUES
  (
    'braseiroFogoUse',
    'Braseiro · Elemental do Fogo',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'braseiro-de-comandar-elementais-do-fogo'),
    1
  ),
  (
    'incensarioArUse',
    'Incensário · Elemental do Ar',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'incensario-de-controlar-elementais-do-ar'),
    1
  ),
  (
    'pedraTerraUse',
    'Pedra · Elemental da Terra',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'pedra-de-controlar-elementais-da-terra'),
    1
  ),
  (
    'tigelaAguaUse',
    'Tigela · Elemental da Água',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'tigela-de-comandar-elementais-da-agua'),
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
  ('braseiro-de-comandar-elementais-do-fogo', 'braseiroFogoUse', 1),
  ('incensario-de-controlar-elementais-do-ar', 'incensarioArUse', 1),
  ('pedra-de-controlar-elementais-da-terra', 'pedraTerraUse', 1),
  ('tigela-de-comandar-elementais-da-agua', 'tigelaAguaUse', 1)
) AS v(item_slug, resource_slug, fixed_max)
JOIN rpg.phb_item i ON i.slug = v.item_slug
JOIN rpg.phb_resource_definition rd
  ON rd.slug = v.resource_slug AND rd.item_id = i.id
ON CONFLICT DO NOTHING;
