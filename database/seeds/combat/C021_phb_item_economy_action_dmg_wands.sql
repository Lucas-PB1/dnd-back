-- DMG §0 #7: economy varinhas (pool compartilhado + N botões)
-- Ver docs/source/dmg-wiring-status.md
-- Nota: gastar última carga → 1d20 (1 = destrói) é lembrete no texto.

INSERT INTO rpg.phb_class_economy_action (
  action_id, class_id, species_id, feat_id, item_id, subclass_id, name, economy, unlock_level,
  resource_slug, free_resource_slug, always_spends_resource,
  summary, description, table_action, spend_amount, sort_order,
  requires_option_key, requires_option_value
) VALUES
(
  'item-varinha-imobilizadora-paralisar-pessoa', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'varinha-imobilizadora'), NULL,
  'Varinha · Paralisar Pessoa', 'action'::rpg.action_economy_bucket, 1,
  'varinhaImobilizadoraCharges', NULL, true,
  'Gastar 2 cargas: Paralisar Pessoa (CD 17)',
  'Enquanto segurar a varinha, gaste 2 cargas para conjurar Paralisar Pessoa (CD 17). Cargas: 7; recupera 1d6+1 ao amanhecer (MVP: Descanso Longo). Se gastar a última carga, jogue 1d20: em 1, a varinha se desfaz.',
  'spend-resource', 2, 640, NULL, NULL
),
(
  'item-varinha-imobilizadora-paralisar-monstro', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'varinha-imobilizadora'), NULL,
  'Varinha · Paralisar Monstro', 'action'::rpg.action_economy_bucket, 1,
  'varinhaImobilizadoraCharges', NULL, true,
  'Gastar 5 cargas: Paralisar Monstro (CD 17)',
  'Enquanto segurar a varinha, gaste 5 cargas para conjurar Paralisar Monstro (CD 17). Cargas: 7; recupera 1d6+1 ao amanhecer (MVP: Descanso Longo). Se gastar a última carga, jogue 1d20: em 1, a varinha se desfaz.',
  'spend-resource', 5, 641, NULL, NULL
),
(
  'item-varinha-do-medo-comando', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'varinha-do-medo'), NULL,
  'Varinha · Comando', 'action'::rpg.action_economy_bucket, 1,
  'varinhaMedoCharges', NULL, true,
  'Gastar 1 carga: Comando (“abaixar” ou “fugir”) (CD 15)',
  'Enquanto segurar a varinha, gaste 1 carga para conjurar Comando com as opções “abaixar” ou “fugir” apenas (CD 15). Cargas: 7; recupera 1d6+1 ao amanhecer (MVP: Descanso Longo). Se gastar a última carga, jogue 1d20: em 1, a varinha se desfaz.',
  'spend-resource', 1, 642, NULL, NULL
),
(
  'item-varinha-do-medo-medo', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'varinha-do-medo'), NULL,
  'Varinha · Medo', 'action'::rpg.action_economy_bucket, 1,
  'varinhaMedoCharges', NULL, true,
  'Gastar 3 cargas: Medo (Cone 18 m, CD 15)',
  'Enquanto segurar a varinha, gaste 3 cargas para conjurar Medo em Cone de 18 metros (CD 15). Cargas: 7; recupera 1d6+1 ao amanhecer (MVP: Descanso Longo). Se gastar a última carga, jogue 1d20: em 1, a varinha se desfaz.',
  'spend-resource', 3, 643, NULL, NULL
),
(
  'item-varinha-de-misseis-magicos-1', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'varinha-de-misseis-magicos'), NULL,
  'Varinha · Mísseis Mágicos (1º)', 'action'::rpg.action_economy_bucket, 1,
  'varinhaMisseisCharges', NULL, true,
  'Gastar 1 carga: Mísseis Mágicos 1º círculo',
  'Gaste 1 carga para conjurar Mísseis Mágicos no 1º círculo. Máximo 3 cargas por conjuração. Cargas: 7; recupera 1d6+1 ao amanhecer (MVP: Descanso Longo). Se gastar a última carga, jogue 1d20: em 1, a varinha se desfaz.',
  'spend-resource', 1, 644, NULL, NULL
),
(
  'item-varinha-de-misseis-magicos-2', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'varinha-de-misseis-magicos'), NULL,
  'Varinha · Mísseis Mágicos (2º)', 'action'::rpg.action_economy_bucket, 1,
  'varinhaMisseisCharges', NULL, true,
  'Gastar 2 cargas: Mísseis Mágicos 2º círculo',
  'Gaste 2 cargas para conjurar Mísseis Mágicos no 2º círculo. Máximo 3 cargas por conjuração. Cargas: 7; recupera 1d6+1 ao amanhecer (MVP: Descanso Longo). Se gastar a última carga, jogue 1d20: em 1, a varinha se desfaz.',
  'spend-resource', 2, 645, NULL, NULL
),
(
  'item-varinha-de-misseis-magicos-3', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'varinha-de-misseis-magicos'), NULL,
  'Varinha · Mísseis Mágicos (3º)', 'action'::rpg.action_economy_bucket, 1,
  'varinhaMisseisCharges', NULL, true,
  'Gastar 3 cargas: Mísseis Mágicos 3º círculo',
  'Gaste 3 cargas para conjurar Mísseis Mágicos no 3º círculo. Máximo 3 cargas por conjuração. Cargas: 7; recupera 1d6+1 ao amanhecer (MVP: Descanso Longo). Se gastar a última carga, jogue 1d20: em 1, a varinha se desfaz.',
  'spend-resource', 3, 646, NULL, NULL
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

-- Fase 6 piloto: cast real via spell_slug
UPDATE rpg.phb_class_economy_action
SET spell_slug = 'misseis-magicos'
WHERE action_id IN (
  'item-varinha-de-misseis-magicos-1',
  'item-varinha-de-misseis-magicos-2',
  'item-varinha-de-misseis-magicos-3'
);
