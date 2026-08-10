-- DMG §0 #9c: economy maravilhosos passivos/à vontade + cubos/bolsa
-- Ver docs/source/dmg-item-mesa-taxonomy-marvelous-simple.yaml

INSERT INTO rpg.phb_class_economy_action (
  action_id, class_id, species_id, feat_id, item_id, subclass_id, name, economy, unlock_level,
  resource_slug, free_resource_slug, always_spends_resource,
  summary, description, table_action, spend_amount, sort_order,
  requires_option_key, requires_option_value
) VALUES
-- Passivos / à vontade
(
  'item-botas-de-levitacao-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'botas-de-levitacao'), NULL,
  'Botas · Levitação', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Conjurar Levitação em si (à vontade)',
  'Enquanto usa as botas, conjure Levitação em si mesmo.',
  NULL, NULL, 800, NULL, NULL
),
(
  'item-manto-de-resistencia-a-magia-passivo', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'manto-de-resistencia-a-magia'), NULL,
  'Manto · Resistência a Magia', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Vantagem em salvaguardas contra magias',
  'Enquanto veste este manto, Vantagem em salvaguardas contra magias.',
  NULL, NULL, 801, NULL, NULL
),
(
  'item-bola-de-cristal-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'bola-de-cristal'), NULL,
  'Bola · Vidência', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Conjurar Vidência CD 17',
  'Ao tocar o orbe, conjure Vidência (CD 17).',
  NULL, NULL, 802, NULL, NULL
),
(
  'item-elmo-da-compreensao-de-idiomas-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'elmo-da-compreensao-de-idiomas'), NULL,
  'Elmo · Compreender Idiomas', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Conjurar Compreender Idiomas',
  'Enquanto veste o elmo, conjure Compreender Idiomas a partir dele.',
  NULL, NULL, 803, NULL, NULL
),
(
  'item-amuleto-da-saude-passivo', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'amuleto-da-saude'), NULL,
  'Amuleto · Constituição 19', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Constituição torna-se 19 (se menor)',
  'Sua Constituição é 19 enquanto usa o amuleto; se já for ≥19, sem efeito. Ajuste manual na ficha (schema não fixa atributo).',
  NULL, NULL, 804, NULL, NULL
),
(
  'item-dado-do-charlatao-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'dado-do-charlatao'), NULL,
  'Dado · Resultado Escolhido', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Ao jogar este d6, escolha o resultado',
  'Sempre que jogar este dado de seis lados, controle qual número sai.',
  NULL, NULL, 805, NULL, NULL
),
(
  'item-chifre-de-escutar-passivo', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'chifre-de-escutar'), NULL,
  'Chifre · Suprimir Surdo', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Segurar na orelha: suprime Surdo',
  'Enquanto segurar este chifre contra a orelha, suprime os efeitos da condição Surdo.',
  NULL, NULL, 806, NULL, NULL
),
(
  'item-vela-das-profundezas-passivo', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'vela-das-profundezas'), NULL,
  'Vela · Não Apaga na Água', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Chama não se apaga na água; luz/calor normal',
  'A chama não se apaga quando mergulhada em água. Emite luz e calor como vela normal.',
  NULL, NULL, 807, NULL, NULL
),
(
  'item-pedra-da-boa-sorte-passivo', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'pedra-da-boa-sorte-pedra-da-sorte'), NULL,
  'Pedra · +1 Testes e Salvaguardas', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  '+1 salvaguardas (wired); +1 testes de atributo (lembrete)',
  'Em posse: +1 em testes de atributo e salvaguardas. Salvaguardas via permanentEffects; testes de atributo = lembrete na mesa.',
  NULL, NULL, 808, NULL, NULL
),
(
  'item-conta-de-nutricao-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'conta-de-nutricao'), NULL,
  'Conta · Nutrição (1 dia)', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Dissolver na língua = 1 dia de Rações (consumir)',
  'Esfera gelatinosa: dissolve na língua e nutre como 1 dia de Rações. Remova 1 do inventário ao usar.',
  NULL, NULL, 809, NULL, NULL
),
(
  'item-manto-da-arraia-passivo', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'manto-da-arraia'), NULL,
  'Manto · Respirar / Nadar 18 m', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Respirar na água; Deslocamento de Natação 18 m',
  'Enquanto veste: respira debaixo d’água e tem Natação 18 m.',
  NULL, NULL, 810, NULL, NULL
),
(
  'item-broche-escudarcano-passivo', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'broche-escudarcano'), NULL,
  'Broche · Escudo Arcano', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Resistência Energético; Imunidade a Míssil Mágico',
  'Enquanto usa: Resistência a Energético e Imunidade ao dano de Míssil Mágico.',
  NULL, NULL, 811, NULL, NULL
),
(
  'item-capa-esvoacante-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'capa-esvoacante'), NULL,
  'Capa · Ondular', 'bonus'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Ação Bônus: capa ondula dramaticamente por 1 min',
  'Enquanto veste: Ação Bônus para fazê-la ondular dramaticamente por 1 minuto.',
  NULL, NULL, 812, NULL, NULL
),
(
  'item-luvas-da-ladinagem-passivo', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'luvas-da-ladinagem'), NULL,
  'Luvas · +5 Prestidigitação', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  '+5 em Destreza (Prestidigitação); imperceptíveis',
  'Ao usá-las: +5 em testes de Destreza (Prestidigitação). Imperceptíveis durante o uso.',
  NULL, NULL, 813, NULL, NULL
),
(
  'item-manoplas-de-poder-do-ogro-passivo', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'manoplas-de-poder-do-ogro'), NULL,
  'Manoplas · Força 19', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Força torna-se 19 (se menor)',
  'Força é 19 enquanto usa; se já ≥19, sem efeito. Ajuste manual na ficha.',
  NULL, NULL, 814, NULL, NULL
),
(
  'item-chapeu-do-embuco-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'chapeu-do-embuco'), NULL,
  'Chapéu · Disfarçar-se', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Conjurar Disfarçar-se (encerra se remover o chapéu)',
  'Enquanto veste: conjure Disfarçar-se. A magia encerra se o chapéu for removido.',
  NULL, NULL, 815, NULL, NULL
),
(
  'item-tiara-do-intelecto-passivo', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'tiara-do-intelecto'), NULL,
  'Tiara · Inteligência 19', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Inteligência torna-se 19 (se menor)',
  'Inteligência é 19 enquanto veste; se já ≥19, sem efeito. Ajuste manual na ficha.',
  NULL, NULL, 816, NULL, NULL
),
(
  'item-elmo-do-medo-passivo', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'elmo-do-medo'), NULL,
  'Elmo · Aparência Temível', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Olhos vermelhos; rosto na sombra (cosmético)',
  'Enquanto usa: olhos brilham em vermelho e o resto do rosto fica escondido na sombra.',
  NULL, NULL, 817, NULL, NULL
),
(
  'item-leque-do-vento-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'leque-do-vento'), NULL,
  'Leque · Lufada de Vento', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Lufada de Vento CD 13 (+20% falha cumulativa/dia)',
  'Conjure Lufada de Vento (CD 13). Cada uso antes do próximo amanhecer: +20% chance cumulativa de falhar e rasgar (não mágico). Rastreie % na mesa.',
  NULL, NULL, 818, NULL, NULL
),
-- Cubo Energético
(
  'item-cubo-energetico-armadura-arcana', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'cubo-energetico'), NULL,
  'Cubo · Armadura Arcana', 'action'::rpg.action_economy_bucket, 1,
  'cuboEnergeticoCharges', NULL, true,
  'Gastar 1 carga: Armadura Arcana',
  'Pressione a face: Armadura Arcana (CD 17). Cargas: 10; recupera 1d6 ao amanhecer (MVP: Descanso Longo).',
  'spend-resource', 1, 819, NULL, NULL
),
(
  'item-cubo-energetico-escudo-arcano', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'cubo-energetico'), NULL,
  'Cubo · Escudo Arcano', 'action'::rpg.action_economy_bucket, 1,
  'cuboEnergeticoCharges', NULL, true,
  'Gastar 1 carga: Escudo Arcano',
  'Pressione a face: Escudo Arcano (CD 17). Cargas: 10; MVP recupera no Descanso Longo.',
  'spend-resource', 1, 820, NULL, NULL
),
(
  'item-cubo-energetico-pequeno-refugio', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'cubo-energetico'), NULL,
  'Cubo · Pequeno Refúgio de Leomund', 'action'::rpg.action_economy_bucket, 1,
  'cuboEnergeticoCharges', NULL, true,
  'Gastar 3 cargas: Pequeno Refúgio de Leomund',
  'Pressione a face: Pequeno Refúgio de Leomund. Cargas: 10; MVP recupera no Descanso Longo.',
  'spend-resource', 3, 821, NULL, NULL
),
(
  'item-cubo-energetico-esfera-resiliente', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'cubo-energetico'), NULL,
  'Cubo · Esfera Resiliente de Otiluke', 'action'::rpg.action_economy_bucket, 1,
  'cuboEnergeticoCharges', NULL, true,
  'Gastar 4 cargas: Esfera Resiliente de Otiluke',
  'Pressione a face: Esfera Resiliente de Otiluke (CD 17). Cargas: 10; MVP recupera no Descanso Longo.',
  'spend-resource', 4, 822, NULL, NULL
),
(
  'item-cubo-energetico-santuario', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'cubo-energetico'), NULL,
  'Cubo · Santuário Particular de Mordenkainen', 'action'::rpg.action_economy_bucket, 1,
  'cuboEnergeticoCharges', NULL, true,
  'Gastar 4 cargas: Santuário Particular de Mordenkainen',
  'Pressione a face: Santuário Particular de Mordenkainen. Cargas: 10; MVP recupera no Descanso Longo.',
  'spend-resource', 4, 823, NULL, NULL
),
(
  'item-cubo-energetico-muralha-energia', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'cubo-energetico'), NULL,
  'Cubo · Muralha de Energia', 'action'::rpg.action_economy_bucket, 1,
  'cuboEnergeticoCharges', NULL, true,
  'Gastar 5 cargas: Muralha de Energia',
  'Pressione a face: Muralha de Energia (CD 17). Cargas: 10; MVP recupera no Descanso Longo.',
  'spend-resource', 5, 824, NULL, NULL
),
-- Cubo Portal
(
  'item-cubo-portal-portal', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'cubo-portal'), NULL,
  'Cubo · Portal', 'action'::rpg.action_economy_bucket, 1,
  'cuboPortalCharges', NULL, true,
  'Gastar 1 carga: Portal (lado do plano)',
  'Usar Magia: pressione 1× um lado → Portal para o plano ligado. Cargas: 3; recupera 1d3 ao amanhecer (MVP: Descanso Longo).',
  'spend-resource', 1, 825, NULL, NULL
),
(
  'item-cubo-portal-transicao', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'cubo-portal'), NULL,
  'Cubo · Transição Planar', 'action'::rpg.action_economy_bucket, 1,
  'cuboPortalCharges', NULL, true,
  'Gastar 1 carga: Transição Planar (lado 2×)',
  'Usar Magia: pressione 2× um lado → Transição Planar para o plano ligado. Cargas: 3; MVP recupera no Descanso Longo.',
  'spend-resource', 1, 826, NULL, NULL
),
(
  'item-bolsa-de-temperos-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'bolsa-de-temperos-prestativa-de-howard'), NULL,
  'Bolsa · Pitada de Tempero', 'action'::rpg.action_economy_bucket, 1,
  'bolsaTemperosCharges', NULL, true,
  'Gastar 1 carga: pitada do tempero nomeado',
  'Usar Magia: gaste 1 carga, diga um tempero não mágico e retire uma pitada (1 refeição). Cargas: 10; recupera 1d6+4 ao amanhecer (MVP: Descanso Longo).',
  'spend-resource', 1, 827, NULL, NULL
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
