-- DMG lote §0 #5: economy 1 pool + 1 botão (spend 1 carga)
-- Ver docs/source/extracts/dmg/wiring-status.md

INSERT INTO rpg.phb_class_economy_action (
  action_id, class_id, species_id, feat_id, item_id, subclass_id, name, economy, unlock_level,
  resource_slug, free_resource_slug, always_spends_resource,
  summary, description, table_action, spend_amount, sort_order,
  requires_option_key, requires_option_value
) VALUES
(
  'item-anel-de-evasao-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'anel-de-evasao'), NULL,
  'Anel de Evasão · Sucesso', 'reaction'::rpg.action_economy_bucket, 1,
  'anelEvasaoCharges', NULL, true,
  'Reação ao falhar DES: gastar 1 carga → sucesso',
  'Este anel tem 3 cargas e recupera 1d3 cargas gastas diariamente ao amanhecer (MVP: recupera no Descanso Longo). Ao falhar em uma salvaguarda de Destreza enquanto estiver usando o anel, você pode executar uma Reação para gastar 1 carga para ser bem-sucedido nessa salvaguarda.',
  'spend-resource', 1, 620, NULL, NULL
),
(
  'item-colar-dos-pensamentos-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'colar-dos-pensamentos'), NULL,
  'Colar · Detectar Pensamentos', 'action'::rpg.action_economy_bucket, 1,
  'colarPensamentosCharges', NULL, true,
  'Gastar 1 carga: Detectar Pensamentos (CD 13)',
  'O colar tem 5 cargas. Enquanto o estiver usando, você pode gastar 1 carga para conjurar Detectar Pensamentos (CD 13 para evitar) a partir dele. O colar recupera 1d4 cargas gastas diariamente ao amanhecer (MVP: recupera no Descanso Longo).',
  'spend-resource', 1, 621, NULL, NULL
),
(
  'item-elmo-de-teleporte-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'elmo-de-teleporte'), NULL,
  'Elmo · Teleporte', 'action'::rpg.action_economy_bucket, 1,
  'elmoTeleporteCharges', NULL, true,
  'Gastar 1 carga: conjurar Teleporte',
  'Este elmo tem 3 cargas. Enquanto o estiver usando, você pode gastar 1 carga para conjurar Teleporte a partir dele. O elmo recupera 1d3 cargas gastas diariamente ao amanhecer (MVP: recupera no Descanso Longo).',
  'spend-resource', 1, 622, NULL, NULL
),
(
  'item-gema-da-visao-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'gema-da-visao'), NULL,
  'Gema · Visão Verdadeira', 'action'::rpg.action_economy_bucket, 1,
  'gemaVisaoCharges', NULL, true,
  'Usar Magia: 1 carga → Visão Verdadeira 36 m / 10 min',
  'Esta gema tem 3 cargas. Como uma ação Usar Magia, você pode consumir 1 carga. Nos próximos 10 minutos, você tem Visão Verdadeira a 36 metros quando olha através da gema. A gema recupera 1d3 cargas gastas diariamente ao amanhecer (MVP: recupera no Descanso Longo).',
  'spend-resource', 1, 623, NULL, NULL
),
(
  'item-varinha-farejadora-de-magias-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'varinha-farejadora-de-magias'), NULL,
  'Varinha · Detectar Magia', 'action'::rpg.action_economy_bucket, 1,
  'varinhaFarejadoraCharges', NULL, true,
  'Gastar 1 carga: Detectar Magia',
  'Esta varinha tem 3 cargas. Enquanto a segurar, você pode gastar 1 carga para conjurar Detectar Magia a partir dela. A varinha recupera 1d3 cargas gastas diariamente ao amanhecer (MVP: recupera no Descanso Longo).',
  'spend-resource', 1, 624, NULL, NULL
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
