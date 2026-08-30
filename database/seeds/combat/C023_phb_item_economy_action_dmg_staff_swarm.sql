-- DMG §0 #8b: economy Cajado do Enxame de Insetos (3 botões)
-- Ver docs/source/extracts/dmg/wiring-status.md

INSERT INTO rpg.phb_class_economy_action (
  action_id, class_id, species_id, feat_id, item_id, subclass_id, name, economy, unlock_level,
  resource_slug, free_resource_slug, always_spends_resource,
  summary, description, table_action, spend_amount, sort_order,
  requires_option_key, requires_option_value
) VALUES
(
  'item-cajado-do-enxame-nuvem', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-do-enxame-de-insetos'), NULL,
  'Cajado · Nuvem de Insetos', 'action'::rpg.action_economy_bucket, 1,
  'cajadoEnxameCharges', NULL, true,
  'Gastar 1 carga: Nuvem de Insetos (obscurecimento 9 m / 10 min)',
  'Ao empunhar o cajado, gaste 1 carga (ação Usar Magia) para preencher uma Emanação de 9 m com um enxame inofensivo por 10 minutos (Totalmente Obscurecida para outros). Vento forte encerra. Cargas: 10; recupera 1d6+4 ao amanhecer (MVP: Descanso Longo). Última carga: 1d20, em 1 o enxame consome o cajado.',
  'spend-resource', 1, 670, NULL, NULL
),
(
  'item-cajado-do-enxame-inseto-gigante', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-do-enxame-de-insetos'), NULL,
  'Cajado · Inseto Gigante', 'action'::rpg.action_economy_bucket, 1,
  'cajadoEnxameCharges', NULL, true,
  'Gastar 4 cargas: Inseto Gigante',
  'Gaste 4 cargas para conjurar Inseto Gigante (sua CD / ataque mágico). Cargas: 10; MVP recupera no Descanso Longo.',
  'spend-resource', 4, 671, NULL, NULL
),
(
  'item-cajado-do-enxame-praga', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-do-enxame-de-insetos'), NULL,
  'Cajado · Praga de Insetos', 'action'::rpg.action_economy_bucket, 1,
  'cajadoEnxameCharges', NULL, true,
  'Gastar 5 cargas: Praga de Insetos',
  'Gaste 5 cargas para conjurar Praga de Insetos (sua CD / ataque mágico). Cargas: 10; MVP recupera no Descanso Longo.',
  'spend-resource', 5, 672, NULL, NULL
)
ON CONFLICT (action_id) DO UPDATE SET
  class_id = EXCLUDED.class_id,
  species_id = EXCLUDED.species_id,
  feat_id = EXCLUDED.feat_id,
  item_id = EXCLUDED.item_id,
  subclass_id = EXCLUDED.subclass_id,
  name = EXCLUDED.name,
  economy = EXCLUDED.economy,
  unlock_level = EXCLUDED.unlock_level,
  resource_slug = EXCLUDED.resource_slug,
  free_resource_slug = EXCLUDED.free_resource_slug,
  always_spends_resource = EXCLUDED.always_spends_resource,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  table_action = EXCLUDED.table_action,
  spend_amount = EXCLUDED.spend_amount,
  sort_order = EXCLUDED.sort_order,
  requires_option_key = EXCLUDED.requires_option_key,
  requires_option_value = EXCLUDED.requires_option_value;
