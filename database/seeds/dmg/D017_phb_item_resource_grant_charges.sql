-- DMG lote §0 #5: resources pool de cargas (1 botão)
-- Ver docs/source/dmg-wiring-status.md

INSERT INTO rpg.phb_resource_definition (slug, name, scope, item_id, min_level)
VALUES
  (
    'anelEvasaoCharges',
    'Cargas — Anel de Evasão',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'anel-de-evasao'),
    1
  ),
  (
    'colarPensamentosCharges',
    'Cargas — Colar dos Pensamentos',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'colar-dos-pensamentos'),
    1
  ),
  (
    'elmoTeleporteCharges',
    'Cargas — Elmo de Teleporte',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'elmo-de-teleporte'),
    1
  ),
  (
    'gemaVisaoCharges',
    'Cargas — Gema da Visão',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'gema-da-visao'),
    1
  ),
  (
    'varinhaFarejadoraCharges',
    'Cargas — Varinha Farejadora de Magias',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'varinha-farejadora-de-magias'),
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
  ('anel-de-evasao', 'anelEvasaoCharges', 3),
  ('colar-dos-pensamentos', 'colarPensamentosCharges', 5),
  ('elmo-de-teleporte', 'elmoTeleporteCharges', 3),
  ('gema-da-visao', 'gemaVisaoCharges', 3),
  ('varinha-farejadora-de-magias', 'varinhaFarejadoraCharges', 3)
) AS v(item_slug, resource_slug, fixed_max)
JOIN rpg.phb_item i ON i.slug = v.item_slug
JOIN rpg.phb_resource_definition rd
  ON rd.slug = v.resource_slug AND rd.item_id = i.id
ON CONFLICT DO NOTHING;
