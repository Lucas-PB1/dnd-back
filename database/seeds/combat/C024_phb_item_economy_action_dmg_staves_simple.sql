-- DMG §0 #8c: economy cajados simples + Sortilégios
-- Ver docs/source/extracts/dmg/wiring-status.md

INSERT INTO rpg.phb_class_economy_action (
  action_id, class_id, species_id, feat_id, item_id, subclass_id, name, economy, unlock_level,
  resource_slug, free_resource_slug, always_spends_resource,
  summary, description, table_action, spend_amount, sort_order,
  requires_option_key, requires_option_value
) VALUES
-- 1 botão
(
  'item-cajado-de-flores-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-de-flores'), NULL,
  'Cajado · Brotação de Flor', 'action'::rpg.action_economy_bucket, 1,
  'cajadoFloresCharges', NULL, true,
  'Gastar 1 carga: brotar uma flor (1,5 m)',
  'Ao empunhar o cajado, ação Usar Magia: gaste 1 carga para fazer uma flor brotar em terra/solo a até 1,5 m ou no próprio cajado (inofensiva). Cargas: 10; recupera 1d6+4 ao amanhecer (MVP: Descanso Longo). Última carga: 1d20, em 1 vira pétalas e se perde.',
  'spend-resource', 1, 680, NULL, NULL
),
(
  'item-cajado-avicular-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-avicular'), NULL,
  'Cajado · Som de Pássaro', 'action'::rpg.action_economy_bucket, 1,
  'cajadoAvicularCharges', NULL, true,
  'Gastar 1 carga: emitir som de pássaro (36 m)',
  'Ao segurar o cajado, ação Usar Magia: gaste 1 carga para produzir um som de pássaro audível a 36 m (tentilhão, corvo, galinha, pato, mergulhão, peru, gaivota, coruja ou águia). Cargas: 10; recupera 1d6+4 ao amanhecer (MVP: Descanso Longo). Última carga: 1d20, em 1 explode em penas e se perde.',
  'spend-resource', 1, 681, NULL, NULL
),
(
  'item-cajado-do-definhamento-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-do-definhamento'), NULL,
  'Cajado · Definhamento', 'free'::rpg.action_economy_bucket, 1,
  'cajadoDefinhamentoCharges', NULL, true,
  'No acerto: gastar 1 carga → +2d10 Necrótico + save CON CD 15',
  'Empunhado como Cajado mágico. Em um acerto, gaste 1 carga para causar +2d10 Necrótico e forçar salvaguarda de Constituição CD 15; se falhar, Desvantagem por 1 hora em testes/salvaguardas de Força ou Constituição. Cargas: 3; recupera 1d3 ao amanhecer (MVP: Descanso Longo).',
  'spend-resource', 1, 682, NULL, NULL
),
-- Sortilégios
(
  'item-cajado-dos-sortilegios-comando', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-dos-sortilegios'), NULL,
  'Cajado · Comando', 'action'::rpg.action_economy_bucket, 1,
  'cajadoSortilegiosCharges', NULL, true,
  'Gastar 1 carga: Comando',
  'Gaste 1 carga para conjurar Comando (sua CD). Cargas: 10; recupera 1d8+2 ao amanhecer (MVP: Descanso Longo). Última carga: 1d20, em 1 o cajado se desfaz em pó.',
  'spend-resource', 1, 683, NULL, NULL
),
(
  'item-cajado-dos-sortilegios-compreender', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-dos-sortilegios'), NULL,
  'Cajado · Compreender Idiomas', 'action'::rpg.action_economy_bucket, 1,
  'cajadoSortilegiosCharges', NULL, true,
  'Gastar 1 carga: Compreender Idiomas',
  'Gaste 1 carga para conjurar Compreender Idiomas. Cargas: 10; MVP recupera no Descanso Longo.',
  'spend-resource', 1, 684, NULL, NULL
),
(
  'item-cajado-dos-sortilegios-enfeiticar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-dos-sortilegios'), NULL,
  'Cajado · Enfeitiçar Pessoa', 'action'::rpg.action_economy_bucket, 1,
  'cajadoSortilegiosCharges', NULL, true,
  'Gastar 1 carga: Enfeitiçar Pessoa',
  'Gaste 1 carga para conjurar Enfeitiçar Pessoa (sua CD). Cargas: 10; MVP recupera no Descanso Longo.',
  'spend-resource', 1, 685, NULL, NULL
),
(
  'item-cajado-dos-sortilegios-refletir', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-dos-sortilegios'), NULL,
  'Cajado · Refletir Encantamento', 'reaction'::rpg.action_economy_bucket, 1,
  'cajadoSortilegiosCharges', NULL, true,
  'Reação ao sucesso vs Encantamento: gastar 1 carga → refletir',
  'Ao ser bem-sucedido em salvaguarda contra Encantamento que tem só você como alvo, Reação: gaste 1 carga para refletir a magia no conjurador. Cargas: 10; MVP recupera no Descanso Longo.',
  'spend-resource', 1, 686, NULL, NULL
),
(
  'item-cajado-dos-sortilegios-resistir', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-dos-sortilegios'), NULL,
  'Cajado · Resistir Encantamento', 'free'::rpg.action_economy_bucket, 1,
  'cajadoSortilegiosResistUse', NULL, true,
  'Ao falhar vs Encantamento: transformar em sucesso (1×/amanhecer)',
  'Ao falhar em salvaguarda contra Encantamento que tem só você como alvo, transforme a falha em sucesso. 1× até o próximo amanhecer (MVP: Descanso Longo).',
  'spend-resource', 1, 687, NULL, NULL
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
