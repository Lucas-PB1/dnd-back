-- DMG §0 #9g: resources maravilhosos finais fáceis + anéis
-- Ver docs/source/extracts/dmg/wiring-status.md
-- anelTresDesejosCharges: sem recuperação (consome o anel)

INSERT INTO rpg.phb_resource_definition (slug, name, scope, item_id, min_level)
VALUES
  (
    'chapeuMagosTruqueUse',
    'Truque Desconhecido — Chapéu dos Magos',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'chapeu-dos-magos'),
    1
  ),
  (
    'pocoMundosUse',
    'Portal — Poço dos Mundos',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'poco-dos-mundos'),
    1
  ),
  (
    'gemaClaridadeCharges',
    'Cargas — Gema da Claridade',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'gema-da-claridade'),
    1
  ),
  (
    'anelTresDesejosCharges',
    'Cargas — Anel dos Três Desejos',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'anel-dos-tres-desejos'),
    1
  ),
  (
    'anelInfluenciarAnimaisCharges',
    'Cargas — Anel de Influenciar Animais',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'anel-de-influenciar-animais'),
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
  ('chapeu-dos-magos', 'chapeuMagosTruqueUse', 1, TRUE),
  ('poco-dos-mundos', 'pocoMundosUse', 1, TRUE),
  ('gema-da-claridade', 'gemaClaridadeCharges', 50, TRUE),
  ('anel-dos-tres-desejos', 'anelTresDesejosCharges', 3, FALSE),
  ('anel-de-influenciar-animais', 'anelInfluenciarAnimaisCharges', 3, TRUE)
) AS v(item_slug, resource_slug, fixed_max, recover_long)
JOIN rpg.phb_item i ON i.slug = v.item_slug
JOIN rpg.phb_resource_definition rd
  ON rd.slug = v.resource_slug AND rd.item_id = i.id
ON CONFLICT DO NOTHING;
