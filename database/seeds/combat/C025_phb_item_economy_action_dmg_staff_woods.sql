-- DMG §0 #8d: economy Cajado das Matas (Forma Arbórea + 8 magias)
-- Ver docs/source/dmg-wiring-status.md

INSERT INTO rpg.phb_class_economy_action (
  action_id, class_id, species_id, feat_id, item_id, subclass_id, name, economy, unlock_level,
  resource_slug, free_resource_slug, always_spends_resource,
  summary, description, table_action, spend_amount, sort_order,
  requires_option_key, requires_option_value
) VALUES
(
  'item-cajado-das-matas-forma-arborea', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-das-matas'), NULL,
  'Cajado · Forma Arbórea', 'action'::rpg.action_economy_bucket, 1,
  'cajadoMatasCharges', NULL, true,
  'Gastar 1 carga: transformar o cajado em árvore',
  'Cajado mágico +2 ataque/dano; +2 ataque mágico enquanto empunha (lembrete). Ação Usar Magia: fincar no chão e gastar 1 carga → árvore 18 m (tronco 1,5 m, copa raio 6 m). Tocar + Usar Magia reverte. Cargas: 6; recupera 1d6 ao amanhecer (MVP: Descanso Longo). Última carga: 1d20, em 1 vira Cajado não mágico.',
  'spend-resource', 1, 690, NULL, NULL
),
(
  'item-cajado-das-matas-amizade-animal', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-das-matas'), NULL,
  'Cajado · Amizade Animal', 'action'::rpg.action_economy_bucket, 1,
  'cajadoMatasCharges', NULL, true,
  'Gastar 1 carga: Amizade Animal',
  'Gaste 1 carga para conjurar Amizade Animal (sua CD). Cargas: 6; MVP recupera no Descanso Longo.',
  'spend-resource', 1, 691, NULL, NULL
),
(
  'item-cajado-das-matas-falar-animais', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-das-matas'), NULL,
  'Cajado · Falar com Animais', 'action'::rpg.action_economy_bucket, 1,
  'cajadoMatasCharges', NULL, true,
  'Gastar 1 carga: Falar com Animais',
  'Gaste 1 carga para conjurar Falar com Animais. Cargas: 6; MVP recupera no Descanso Longo.',
  'spend-resource', 1, 692, NULL, NULL
),
(
  'item-cajado-das-matas-localizar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-das-matas'), NULL,
  'Cajado · Localizar Animais ou Plantas', 'action'::rpg.action_economy_bucket, 1,
  'cajadoMatasCharges', NULL, true,
  'Gastar 2 cargas: Localizar Animais ou Plantas',
  'Gaste 2 cargas para conjurar Localizar Animais ou Plantas. Cargas: 6; MVP recupera no Descanso Longo.',
  'spend-resource', 2, 693, NULL, NULL
),
(
  'item-cajado-das-matas-passo-sem-rastro', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-das-matas'), NULL,
  'Cajado · Passo Sem Rastro', 'action'::rpg.action_economy_bucket, 1,
  'cajadoMatasCharges', NULL, true,
  'Gastar 2 cargas: Passo Sem Rastro',
  'Gaste 2 cargas para conjurar Passo Sem Rastro. Cargas: 6; MVP recupera no Descanso Longo.',
  'spend-resource', 2, 694, NULL, NULL
),
(
  'item-cajado-das-matas-pele-casca', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-das-matas'), NULL,
  'Cajado · Pele-casca', 'action'::rpg.action_economy_bucket, 1,
  'cajadoMatasCharges', NULL, true,
  'Gastar 2 cargas: Pele-casca',
  'Gaste 2 cargas para conjurar Pele-casca. Cargas: 6; MVP recupera no Descanso Longo.',
  'spend-resource', 2, 695, NULL, NULL
),
(
  'item-cajado-das-matas-falar-plantas', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-das-matas'), NULL,
  'Cajado · Falar com Plantas', 'action'::rpg.action_economy_bucket, 1,
  'cajadoMatasCharges', NULL, true,
  'Gastar 3 cargas: Falar com Plantas',
  'Gaste 3 cargas para conjurar Falar com Plantas. Cargas: 6; MVP recupera no Descanso Longo.',
  'spend-resource', 3, 696, NULL, NULL
),
(
  'item-cajado-das-matas-despertar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-das-matas'), NULL,
  'Cajado · Despertar', 'action'::rpg.action_economy_bucket, 1,
  'cajadoMatasCharges', NULL, true,
  'Gastar 5 cargas: Despertar',
  'Gaste 5 cargas para conjurar Despertar (sua CD). Cargas: 6; MVP recupera no Descanso Longo.',
  'spend-resource', 5, 697, NULL, NULL
),
(
  'item-cajado-das-matas-muralha-espinhos', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-das-matas'), NULL,
  'Cajado · Muralha de Espinhos', 'action'::rpg.action_economy_bucket, 1,
  'cajadoMatasCharges', NULL, true,
  'Gastar 6 cargas: Muralha de Espinhos',
  'Gaste 6 cargas para conjurar Muralha de Espinhos (sua CD). Cargas: 6; MVP recupera no Descanso Longo.',
  'spend-resource', 6, 698, NULL, NULL
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
