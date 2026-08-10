-- Coberturas de arma com economy (ação / bônus / reação / free)
INSERT INTO rpg.phb_resource_definition (slug, name, scope, item_id, min_level)
VALUES
  (
    'marteloDoTrovaoCharges',
    'Cargas — Martelo do Trovão',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'martelo-do-trovao'),
    1
  ),
  (
    'garraSilvestreMensagemUse',
    'Mensagem — Garra Silvestre',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'garra-silvestre'),
    1
  ),
  (
    'escaraGelidaExtinguirUse',
    'Extinguir — Escara Gélida',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'escara-gelida'),
    1
  ),
  (
    'laminaDaSorteDesejoCharges',
    'Desejo — Lâmina da Sorte',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'lamina-da-sorte'),
    1
  ),
  (
    'laminaDaSorteSorteUse',
    'Sorte — Lâmina da Sorte',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'lamina-da-sorte'),
    1
  ),
  (
    'arcoDoJuramentoJurarUse',
    'Jurar — Arco do Juramento',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'arco-do-juramento'),
    1
  )
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  scope = EXCLUDED.scope,
  item_id = EXCLUDED.item_id,
  min_level = EXCLUDED.min_level;

INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
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
  v.recover_all_on_long,
  v.recover_on_long_dice
FROM (VALUES
  ('martelo-do-trovao', 'marteloDoTrovaoCharges', 5, FALSE, '1d4+1'),
  ('garra-silvestre', 'garraSilvestreMensagemUse', 1, TRUE, NULL),
  ('escara-gelida', 'escaraGelidaExtinguirUse', 1, TRUE, NULL),
  ('lamina-da-sorte', 'laminaDaSorteDesejoCharges', 3, FALSE, NULL),
  ('lamina-da-sorte', 'laminaDaSorteSorteUse', 1, TRUE, NULL),
  ('arco-do-juramento', 'arcoDoJuramentoJurarUse', 1, TRUE, NULL)
) AS v(item_slug, resource_slug, fixed_max, recover_all_on_long, recover_on_long_dice)
JOIN rpg.phb_item i ON i.slug = v.item_slug
JOIN rpg.phb_resource_definition rd
  ON rd.slug = v.resource_slug AND rd.item_id = i.id
ON CONFLICT DO NOTHING;
