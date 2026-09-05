-- Coberturas de arma com economy (ação / bônus / reação / free)
-- Grants: SSOT em effects/E007 (species) / E012 (subclass) / E013 (item) / E00* feats
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


