-- DMG §0 #8c: resources cajados simples (1 botão + Sortilégios)
-- Ver docs/source/dmg-item-mesa-taxonomy-staves.yaml

INSERT INTO rpg.phb_resource_definition (slug, name, scope, item_id, min_level)
VALUES
  (
    'cajadoFloresCharges',
    'Cargas — Cajado de Flores',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-de-flores'),
    1
  ),
  (
    'cajadoAvicularCharges',
    'Cargas — Cajado Avicular',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-avicular'),
    1
  ),
  (
    'cajadoDefinhamentoCharges',
    'Cargas — Cajado do Definhamento',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-do-definhamento'),
    1
  ),
  (
    'cajadoSortilegiosCharges',
    'Cargas — Cajado dos Sortilégios',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-dos-sortilegios'),
    1
  ),
  (
    'cajadoSortilegiosResistUse',
    'Resistir Encantamento — Cajado dos Sortilégios',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-dos-sortilegios'),
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
  ('cajado-de-flores', 'cajadoFloresCharges', 10),
  ('cajado-avicular', 'cajadoAvicularCharges', 10),
  ('cajado-do-definhamento', 'cajadoDefinhamentoCharges', 3),
  ('cajado-dos-sortilegios', 'cajadoSortilegiosCharges', 10),
  ('cajado-dos-sortilegios', 'cajadoSortilegiosResistUse', 1)
) AS v(item_slug, resource_slug, fixed_max)
JOIN rpg.phb_item i ON i.slug = v.item_slug
JOIN rpg.phb_resource_definition rd
  ON rd.slug = v.resource_slug AND rd.item_id = i.id
ON CONFLICT DO NOTHING;
