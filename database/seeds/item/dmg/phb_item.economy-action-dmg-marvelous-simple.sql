-- DMG §0 #9a: economy maravilhosos simples
-- Ver docs/source/extracts/dmg/wiring-status.md

INSERT INTO rpg.phb_class_economy_action (
  action_id, class_id, species_id, feat_id, item_id, subclass_id, name, economy, unlock_level,
  resource_slug, free_resource_slug, always_spends_resource,
  summary, description, table_action, spend_amount, sort_order,
  requires_option_key, requires_option_value
) VALUES
(
  'item-elmo-de-telepatia-passivo', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'elmo-de-telepatia'), NULL,
  'Elmo · Telepatia 9 m', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Passivo: telepatia 9 m enquanto usa o elmo',
  'Enquanto estiver usando este elmo, você tem telepatia com alcance de 9 metros.',
  NULL, NULL, 760, NULL, NULL
),
(
  'item-elmo-de-telepatia-detectar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'elmo-de-telepatia'), NULL,
  'Elmo · Detectar Pensamentos', 'action'::rpg.action_economy_bucket, 1,
  'elmoTelepatiaDetectarUse', NULL, true,
  'Conjurar Detectar Pensamentos CD 13 (1×/amanhecer)',
  'Conjure Detectar Pensamentos a partir do elmo (CD 13). Essa magia não pode ser conjurada novamente até o próximo amanhecer (MVP: Descanso Longo).',
  'spend-resource', 1, 761, NULL, NULL
),
(
  'item-elmo-de-telepatia-sugestao', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'elmo-de-telepatia'), NULL,
  'Elmo · Sugestão', 'action'::rpg.action_economy_bucket, 1,
  'elmoTelepatiaSugestaoUse', NULL, true,
  'Conjurar Sugestão CD 13 (1×/amanhecer)',
  'Conjure Sugestão a partir do elmo (CD 13). Essa magia não pode ser conjurada novamente até o próximo amanhecer (MVP: Descanso Longo).',
  'spend-resource', 1, 762, NULL, NULL
),
(
  'item-chifre-do-alarme-silencioso-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'chifre-do-alarme-silencioso'), NULL,
  'Chifre · Alarme Silencioso', 'action'::rpg.action_economy_bucket, 1,
  'chifreAlarmeSilenciosoCharges', NULL, true,
  'Gastar 1 carga: 1 criatura a até 180 m ouve o chifre',
  'Usar Magia: gaste 1 carga; uma criatura à sua escolha a até 180 m ouve o estrondo — ninguém mais. Cargas: 4; recupera 1d4 ao amanhecer (MVP: Descanso Longo).',
  'spend-resource', 1, 763, NULL, NULL
),
(
  'item-botas-aladas-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'botas-aladas'), NULL,
  'Botas · Voo 9 m / 1 h', 'action'::rpg.action_economy_bucket, 1,
  'botasAladasCharges', NULL, true,
  'Gastar 1 carga: Deslocamento de Voo 9 m por 1 hora',
  'Usar Magia: gaste 1 carga → Voo 9 m por 1 h. Se voando ao acabar, desce 9 m/rodada. Cargas: 4; recupera 1d4 ao amanhecer (MVP: Descanso Longo).',
  'spend-resource', 1, 764, NULL, NULL
),
(
  'item-manto-de-invisibilidade-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'manto-de-invisibilidade'), NULL,
  'Manto · Invisível 1 h', 'action'::rpg.action_economy_bucket, 1,
  'mantoInvisibilidadeCharges', NULL, true,
  'Gastar 1 carga: capuz → Invisível por 1 hora',
  'Usar Magia: coloque o capuz e gaste 1 carga → Invisível 1 h. Encerra se retirar o capuz ou parar de usar o manto. Cargas: 3; recupera 1d3 ao amanhecer (MVP: Descanso Longo).',
  'spend-resource', 1, 765, NULL, NULL
),
(
  'item-capa-do-saltimbanco-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'capa-do-saltimbanco'), NULL,
  'Capa · Porta Dimensional', 'action'::rpg.action_economy_bucket, 1,
  'capaSaltimbancoUse', NULL, true,
  'Porta Dimensional + fumaça (1×/amanhecer)',
  'Usar Magia: conjure Porta Dimensional. Deixa fumaça (Parcialmente Obscurecido) no espaço de origem até o fim do seu próximo turno. 1× até o próximo amanhecer (MVP: Descanso Longo).',
  'spend-resource', 1, 766, NULL, NULL
),
(
  'item-olhos-de-enfeiticar-1', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'olhos-de-enfeiticar'), NULL,
  'Olhos · Enfeitiçar Pessoa (1º)', 'action'::rpg.action_economy_bucket, 1,
  'olhosEnfeiticarCharges', NULL, true,
  'Gastar 1 carga: Enfeitiçar Pessoa 1º (CD 13)',
  'Gaste 1 carga para conjurar Enfeitiçar Pessoa no 1º círculo (CD 13). Cargas: 3; recupera todas ao amanhecer (MVP: Descanso Longo).',
  'spend-resource', 1, 767, NULL, NULL
),
(
  'item-olhos-de-enfeiticar-2', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'olhos-de-enfeiticar'), NULL,
  'Olhos · Enfeitiçar Pessoa (2º)', 'action'::rpg.action_economy_bucket, 1,
  'olhosEnfeiticarCharges', NULL, true,
  'Gastar 2 cargas: Enfeitiçar Pessoa 2º (CD 13)',
  'Gaste 2 cargas para conjurar Enfeitiçar Pessoa no 2º círculo (CD 13). Cargas: 3; MVP recupera no Descanso Longo.',
  'spend-resource', 2, 768, NULL, NULL
),
(
  'item-olhos-de-enfeiticar-3', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'olhos-de-enfeiticar'), NULL,
  'Olhos · Enfeitiçar Pessoa (3º)', 'action'::rpg.action_economy_bucket, 1,
  'olhosEnfeiticarCharges', NULL, true,
  'Gastar 3 cargas: Enfeitiçar Pessoa 3º (CD 13)',
  'Gaste 3 cargas para conjurar Enfeitiçar Pessoa no 3º círculo (CD 13). Cargas: 3; MVP recupera no Descanso Longo.',
  'spend-resource', 3, 769, NULL, NULL
),
(
  'item-pedras-mensageiras-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'pedras-mensageiras'), NULL,
  'Pedras · Remeter', 'action'::rpg.action_economy_bucket, 1,
  'pedrasMensageirasUse', NULL, true,
  'Remeter ao portador da pedra par (1×/amanhecer)',
  'Ao tocar a pedra, conjure Remeter no portador da outra. Se ninguém porta a outra, você sabe e não conjura. 1× até o próximo amanhecer (MVP: Descanso Longo). Se uma pedra for destruída, a outra vira não mágica.',
  'spend-resource', 1, 770, NULL, NULL
),
(
  'item-flauta-atormentadora-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'flauta-atormentadora'), NULL,
  'Flauta · Melodia Amedrontadora', 'action'::rpg.action_economy_bucket, 1,
  'flautaAtormentadoraCharges', NULL, true,
  'Gastar 1 carga: SAB CD 15 ou Amedrontado (9 m)',
  'Usar Magia: gaste 1 carga; criaturas à escolha a até 9 m SAB CD 15 ou Amedrontado 1 min (repetir no fim do turno). Sucesso → imune 24 h. Cargas: 3; recupera 1d3 ao amanhecer (MVP: Descanso Longo).',
  'spend-resource', 1, 771, NULL, NULL
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
