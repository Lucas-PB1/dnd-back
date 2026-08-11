-- DMG §0 #8: economy cajados (pool + N magias)
-- Ver docs/source/dmg-wiring-status.md

INSERT INTO rpg.phb_class_economy_action (
  action_id, class_id, species_id, feat_id, item_id, subclass_id, name, economy, unlock_level,
  resource_slug, free_resource_slug, always_spends_resource,
  summary, description, table_action, spend_amount, sort_order,
  requires_option_key, requires_option_value
) VALUES
-- Cajado da Cura
(
  'item-cajado-da-cura-ferimentos-1', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-da-cura'), NULL,
  'Cajado · Curar Ferimentos (1º)', 'action'::rpg.action_economy_bucket, 1,
  'cajadoCuraCharges', NULL, true,
  'Gastar 1 carga: Curar Ferimentos 1º',
  'Ao empunhar o cajado, gaste 1 carga para conjurar Curar Ferimentos no 1º círculo (seu modificador de conjuração). Cargas: 10; recupera 1d6+4 ao amanhecer (MVP: Descanso Longo). Última carga: 1d20, em 1 o cajado se perde.',
  'spend-resource', 1, 650, NULL, NULL
),
(
  'item-cajado-da-cura-ferimentos-2', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-da-cura'), NULL,
  'Cajado · Curar Ferimentos (2º)', 'action'::rpg.action_economy_bucket, 1,
  'cajadoCuraCharges', NULL, true,
  'Gastar 2 cargas: Curar Ferimentos 2º',
  'Gaste 2 cargas para conjurar Curar Ferimentos no 2º círculo. Cargas: 10; MVP recupera no Descanso Longo.',
  'spend-resource', 2, 651, NULL, NULL
),
(
  'item-cajado-da-cura-ferimentos-3', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-da-cura'), NULL,
  'Cajado · Curar Ferimentos (3º)', 'action'::rpg.action_economy_bucket, 1,
  'cajadoCuraCharges', NULL, true,
  'Gastar 3 cargas: Curar Ferimentos 3º',
  'Gaste 3 cargas para conjurar Curar Ferimentos no 3º círculo. Cargas: 10; MVP recupera no Descanso Longo.',
  'spend-resource', 3, 652, NULL, NULL
),
(
  'item-cajado-da-cura-ferimentos-4', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-da-cura'), NULL,
  'Cajado · Curar Ferimentos (4º)', 'action'::rpg.action_economy_bucket, 1,
  'cajadoCuraCharges', NULL, true,
  'Gastar 4 cargas: Curar Ferimentos 4º',
  'Gaste 4 cargas para conjurar Curar Ferimentos no 4º círculo (máximo). Cargas: 10; MVP recupera no Descanso Longo.',
  'spend-resource', 4, 653, NULL, NULL
),
(
  'item-cajado-da-cura-restauracao-menor', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-da-cura'), NULL,
  'Cajado · Restauração Menor', 'action'::rpg.action_economy_bucket, 1,
  'cajadoCuraCharges', NULL, true,
  'Gastar 2 cargas: Restauração Menor',
  'Gaste 2 cargas para conjurar Restauração Menor. Cargas: 10; MVP recupera no Descanso Longo.',
  'spend-resource', 2, 654, NULL, NULL
),
(
  'item-cajado-da-cura-ferimentos-massa', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-da-cura'), NULL,
  'Cajado · Curar Ferimentos em Massa', 'action'::rpg.action_economy_bucket, 1,
  'cajadoCuraCharges', NULL, true,
  'Gastar 5 cargas: Curar Ferimentos em Massa',
  'Gaste 5 cargas para conjurar Curar Ferimentos em Massa. Cargas: 10; MVP recupera no Descanso Longo.',
  'spend-resource', 5, 655, NULL, NULL
),
-- Cajado do Fogo
(
  'item-cajado-do-fogo-maos-flamejantes', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-do-fogo'), NULL,
  'Cajado · Mãos Flamejantes', 'action'::rpg.action_economy_bucket, 1,
  'cajadoFogoCharges', NULL, true,
  'Gastar 1 carga: Mãos Flamejantes',
  'Resistência a Ígneo enquanto empunha. Gaste 1 carga para conjurar Mãos Flamejantes (sua CD). Cargas: 10; recupera 1d6+4 ao amanhecer (MVP: Descanso Longo). Última carga: 1d20, em 1 destrói.',
  'spend-resource', 1, 656, NULL, NULL
),
(
  'item-cajado-do-fogo-bola-de-fogo', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-do-fogo'), NULL,
  'Cajado · Bola de Fogo', 'action'::rpg.action_economy_bucket, 1,
  'cajadoFogoCharges', NULL, true,
  'Gastar 3 cargas: Bola de Fogo',
  'Gaste 3 cargas para conjurar Bola de Fogo (sua CD). Cargas: 10; MVP recupera no Descanso Longo.',
  'spend-resource', 3, 657, NULL, NULL
),
(
  'item-cajado-do-fogo-muralha-de-fogo', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-do-fogo'), NULL,
  'Cajado · Muralha de Fogo', 'action'::rpg.action_economy_bucket, 1,
  'cajadoFogoCharges', NULL, true,
  'Gastar 4 cargas: Muralha de Fogo',
  'Gaste 4 cargas para conjurar Muralha de Fogo (sua CD). Cargas: 10; MVP recupera no Descanso Longo.',
  'spend-resource', 4, 658, NULL, NULL
),
-- Cajado do Gelo
(
  'item-cajado-do-gelo-nevoa', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-do-gelo'), NULL,
  'Cajado · Névoa Obscurecente', 'action'::rpg.action_economy_bucket, 1,
  'cajadoGeloCharges', NULL, true,
  'Gastar 1 carga: Névoa Obscurecente',
  'Resistência a Gélido enquanto empunha. Gaste 1 carga para conjurar Névoa Obscurecente (sua CD). Cargas: 10; recupera 1d6+4 ao amanhecer (MVP: Descanso Longo). Última carga: 1d20, em 1 vira água e se destrói.',
  'spend-resource', 1, 659, NULL, NULL
),
(
  'item-cajado-do-gelo-muralha', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-do-gelo'), NULL,
  'Cajado · Muralha de Gelo', 'action'::rpg.action_economy_bucket, 1,
  'cajadoGeloCharges', NULL, true,
  'Gastar 4 cargas: Muralha de Gelo',
  'Gaste 4 cargas para conjurar Muralha de Gelo (sua CD). Cargas: 10; MVP recupera no Descanso Longo.',
  'spend-resource', 4, 660, NULL, NULL
),
(
  'item-cajado-do-gelo-tempestade', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-do-gelo'), NULL,
  'Cajado · Tempestade Glacial', 'action'::rpg.action_economy_bucket, 1,
  'cajadoGeloCharges', NULL, true,
  'Gastar 4 cargas: Tempestade Glacial',
  'Gaste 4 cargas para conjurar Tempestade Glacial (sua CD). Cargas: 10; MVP recupera no Descanso Longo.',
  'spend-resource', 4, 661, NULL, NULL
),
(
  'item-cajado-do-gelo-cone-frio', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-do-gelo'), NULL,
  'Cajado · Cone de Frio', 'action'::rpg.action_economy_bucket, 1,
  'cajadoGeloCharges', NULL, true,
  'Gastar 5 cargas: Cone de Frio',
  'Gaste 5 cargas para conjurar Cone de Frio (sua CD). Cargas: 10; MVP recupera no Descanso Longo.',
  'spend-resource', 5, 662, NULL, NULL
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
