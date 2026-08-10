-- DMG §0 #9i: economy utilitários densos leves + armas
-- Cast/link magia = fase 6 (só spend-resource + texto)

INSERT INTO rpg.phb_class_economy_action (
  action_id, class_id, species_id, feat_id, item_id, subclass_id, name, economy, unlock_level,
  resource_slug, free_resource_slug, always_spends_resource,
  summary, description, table_action, spend_amount, sort_order,
  requires_option_key, requires_option_value
) VALUES
(
  'item-bolsa-cabe-tudo-sacar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'bolsa-cabe-tudo'), NULL,
  'Bolsa · Sacar Item', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Usar Objeto: retirar um item (até 250 kg / 1,8 m³)',
  'Espaço extradimensional ~60 cm × 1,2 m; até 250 kg / 1,8 m³. Pesa 7,5 kg. Retirar = ação Usar Objeto. Sobrecarregar/furar/rasgar destrói e espalha no Astral.',
  NULL, NULL, 1010, NULL, NULL
),
(
  'item-buraco-portatil-abrir', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'buraco-portatil'), NULL,
  'Buraco · Abrir', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Usar Magia: desdobrar sobre superfície → buraco 3 m',
  'Tecido 1,8 m Ø. Abrir cria espaço extradimensional 3 m de profundidade (não abre passagem).',
  NULL, NULL, 1011, NULL, NULL
),
(
  'item-buraco-portatil-fechar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'buraco-portatil'), NULL,
  'Buraco · Fechar', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Usar Magia: dobrar bordas e fechar',
  'Fechar dobra o tecido. Criaturas/objetos dentro ficam no espaço extradimensional até reabrir.',
  NULL, NULL, 1012, NULL, NULL
),
(
  'item-barco-de-bolso-remo', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'barco-de-bolso'), NULL,
  'Barco · Remo', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Usar Magia (1ª palavra): desdobra Barco a Remo',
  'Caixa 30×15×15 cm, 2 kg, flutua. 1ª palavra de comando → Barco a Remo.',
  NULL, NULL, 1013, NULL, NULL
),
(
  'item-barco-de-bolso-quilha', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'barco-de-bolso'), NULL,
  'Barco · Quilha', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Usar Magia (2ª palavra): desdobra Barco de Quilha',
  '2ª palavra de comando → Barco de Quilha.',
  NULL, NULL, 1014, NULL, NULL
),
(
  'item-barco-de-bolso-dobrar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'barco-de-bolso'), NULL,
  'Barco · Dobrar', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Usar Magia (3ª palavra): volta à caixa (vazio de criaturas)',
  '3ª palavra: dobra se ninguém a bordo. Objetos que não cabem ficam fora.',
  NULL, NULL, 1015, NULL, NULL
),
(
  'item-tapete-voador-pairar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'tapete-voador'), NULL,
  'Tapete · Pairar/Voo', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Usar Magia + palavra: paira e voa (até 9 m de você)',
  'Move conforme instruções a ≤9 m. Tamanho/capacidade/velocidade: tabela DMG (ex. 100–400 kg, 9–24 m).',
  NULL, NULL, 1016, NULL, NULL
),
(
  'item-vassoura-voadora-pairar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'vassoura-voadora'), NULL,
  'Vassoura · Pairar', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Usar Magia montado: Deslocamento de Voo 15 m (≤200 kg)',
  'Sintonização. ≤100 kg: 15 m; 100–200 kg: 9 m. Para ao desmontar.',
  NULL, NULL, 1017, NULL, NULL
),
(
  'item-vassoura-voadora-enviar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'vassoura-voadora'), NULL,
  'Vassoura · Enviar/Chamar', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Usar Magia: enviar a local ≤1,5 km / chamar de volta',
  'Enviar a local familiar ≤1,5 km. Chamar com palavra se ainda a ≤1,5 km.',
  NULL, NULL, 1018, NULL, NULL
),
(
  'item-garrafa-agua-infinita-riacho', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'garrafa-da-agua-infinita'), NULL,
  'Garrafa · Riacho (4 L)', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Usar Magia: 4 litros (doce ou salgada)',
  'Palavra Riacho: produz 4 L até o início do seu próximo turno.',
  NULL, NULL, 1019, NULL, NULL
),
(
  'item-garrafa-agua-infinita-fonte', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'garrafa-da-agua-infinita'), NULL,
  'Garrafa · Fonte (20 L)', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Usar Magia: 20 litros',
  'Palavra Fonte: produz 20 L.',
  NULL, NULL, 1020, NULL, NULL
),
(
  'item-garrafa-agua-infinita-geiser', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'garrafa-da-agua-infinita'), NULL,
  'Garrafa · Gêiser (120 L)', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Usar Magia: jato 9 m / 120 L (pode derrubar)',
  'Palavra Gêiser: 120 L em linha 9 m × 30 cm. Pode derrubar criaturas (mesa).',
  NULL, NULL, 1021, NULL, NULL
),
(
  'item-ferraduras-de-zefiro-fixar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'ferraduras-de-zefiro'), NULL,
  'Ferraduras · Fixar/Remover', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Usar Magia: fixar/remover 1 ferradura no casco',
  '4 ferraduras. Com todas: flutua 10 cm, ignora terreno difícil, sem rastros, 12 h/dia sem exaustão de viagem.',
  NULL, NULL, 1022, NULL, NULL
),
(
  'item-grilhoes-dimensionais-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'grilhoes-dimensionais'), NULL,
  'Grilhões · Prender/Remover', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Usar Objeto: prender Incapacitado (P–G) / remover',
  'Bloqueia movimento extradimensional (não portais). Remoção: você ou escolhidos. Alvo: CD 30 Atletismo 1×/30 dias.',
  NULL, NULL, 1023, NULL, NULL
),
(
  'item-corda-encantada-comandar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'corda-encantada'), NULL,
  'Corda · Comandar', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Usar Magia: animar ponta / prender / nós / enrolar',
  '18 m; suporte 1.500 kg. Move 3 m/turno até o destino. Comandos: parar, prender, soltar, atar, desatar, enrolar.',
  NULL, NULL, 1024, NULL, NULL
),
(
  'item-corda-de-emaranhamento-enredar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'corda-de-emaranhamento'), NULL,
  'Corda · Enredar', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Usar Magia: Contido DEX CD 15 (alvo a 6 m)',
  '9 m. Soltar extremidade ou Ação Bônus re-comanda. Alvo Contido: Atletismo/Acrobacia CD 15 para sair.',
  NULL, NULL, 1025, NULL, NULL
),
(
  'item-mochila-heward-sacar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'mochila-prestativa-de-heward'), NULL,
  'Mochila · Sacar Item', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Usar Objeto ou Ação Bônus: item sempre no topo',
  '3 bolsos extradimensionais; pesa 2,5 kg. Laterais 100 kg; central 250 kg / 1,8 m³. Rasgar destrói.',
  NULL, NULL, 1026, NULL, NULL
),
(
  'item-amuleto-planar-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'amuleto-planar'), NULL,
  'Amuleto · Transição Planar', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Usar Magia: Arcanismo CD 15 → Transição Planar (ou destino aleatório)',
  'Nomeie local familiar noutro plano. Sucesso: Transição Planar. Falha: 1d100 destino aleatório (tabela DMG). Cast real = fase 6.',
  NULL, NULL, 1027, NULL, NULL
),
(
  'item-contas-energeticas-arremessar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'contas-energeticas'), NULL,
  'Conta · Explodir', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Usar Magia: arremessar ≤18 m — esfera 3 m, DEX CD 15 / 5d4 Energético (consome 1 conta)',
  'Normalmente 1d4+4 contas. Explode e é destruída. Esfera transparente 1 min; falha + totalmente dentro = preso. Quantidade manual.',
  NULL, NULL, 1028, NULL, NULL
),
(
  'item-po-da-seca-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'po-da-seca'), NULL,
  'Pó · Secar Água', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Usar Objeto: 1 pitada → Cubo 4,5 m de água vira esfera',
  'Pacote 1d6+4 pitadas. Esmagar esfera libera água. Também vs Elemental de água a 1,5 m. Quantidade manual.',
  NULL, NULL, 1029, NULL, NULL
),
(
  'item-po-de-espirro-engasgo-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'po-de-espirro-engasgo'), NULL,
  'Pó · Espirro/Engasgo', 'action'::rpg.action_economy_bucket, 1,
  'poEspirroEngasgoUse', NULL, true,
  'Usar Objeto: Emanação 9 m — CON CD 15 ou Incapacitado (1 uso)',
  'Você e criaturas na área. Constructos/Elementais/Gosmas/Plantas/MV auto-sucesso. Falha: espirro + Incapacitado + sufocando. Sem recover.',
  'spend-resource', 1, 1030, NULL, NULL
),
(
  'item-carrilhao-destrancador-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'carrilhao-destrancador'), NULL,
  'Carrilhão · Arrombar', 'action'::rpg.action_economy_bucket, 1,
  'carrilhaoDestrancadorCharges', NULL, true,
  'Usar Magia: Arrombar (audível 90 m); 10 usos totais',
  'Som do carrilhão substitui o bang. Após 10 usos racha e fica inútil. Sem recover. Cast real = fase 6.',
  'spend-resource', 1, 1031, NULL, NULL
),
(
  'item-flauta-dos-esgotos-passivo', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'flauta-dos-esgotos'), NULL,
  'Flauta · Ratos Indiferentes', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Ratos comuns/gigantes Indiferentes (enquanto na posse)',
  'Não atacam a menos que ameaçados. Sintonização.',
  NULL, NULL, 1032, NULL, NULL
),
(
  'item-flauta-dos-esgotos-1', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'flauta-dos-esgotos'), NULL,
  'Flauta · Enxame (1)', 'bonus'::rpg.action_economy_bucket, 1,
  'flautaEsgotosCharges', NULL, true,
  'Após tocar (ação): gastar 1 — 1 Enxame de Ratos',
  'Cargas 3; recupera 1d3 ao amanhecer (MVP: DL). Precisa de ratos a ≤750 m (Mestre).',
  'spend-resource', 1, 1033, NULL, NULL
),
(
  'item-flauta-dos-esgotos-2', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'flauta-dos-esgotos'), NULL,
  'Flauta · Enxames (2)', 'bonus'::rpg.action_economy_bucket, 1,
  'flautaEsgotosCharges', NULL, true,
  'Após tocar: gastar 2 — 2 Enxames de Ratos',
  'Gaste 2 cargas (1 enxame por carga).',
  'spend-resource', 2, 1034, NULL, NULL
),
(
  'item-flauta-dos-esgotos-3', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'flauta-dos-esgotos'), NULL,
  'Flauta · Enxames (3)', 'bonus'::rpg.action_economy_bucket, 1,
  'flautaEsgotosCharges', NULL, true,
  'Após tocar: gastar 3 — 3 Enxames de Ratos',
  'Gaste 3 cargas.',
  'spend-resource', 3, 1035, NULL, NULL
),
(
  'item-vassoura-dancante-animar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'vassoura-dancante-de-baba-yaga'), NULL,
  'Vassoura · Animar', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Usar Magia: vira Vassoura Agressora sob seu controle',
  'Age logo após você; controla mentalmente a ≤9 m. Estatísticas = monstro Vassoura Agressora (mesa).',
  NULL, NULL, 1036, NULL, NULL
),
(
  'item-vassoura-dancante-parar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'vassoura-dancante-de-baba-yaga'), NULL,
  'Vassoura · Parar', 'bonus'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Ação Bônus + palavra: torna inanimada',
  'Encerra a animação.',
  NULL, NULL, 1037, NULL, NULL
),
(
  'item-vela-de-invocacao-acender', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'vela-de-invocacao'), NULL,
  'Vela · Acender', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Usar Magia: Meia-luz 9 m; Vantagem em D20; Clér./Drui. 1º sem slot',
  'Queima 4 h total (pode apagar). Alternativa 1ª acesa: Portal (destrói) — tabela DMG. Tracking manual do tempo.',
  NULL, NULL, 1038, NULL, NULL
),
(
  'item-adaga-peconhenta-passivo', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'adaga-peconhenta'), NULL,
  'Adaga · +1 Ataque/Dano', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  '+1 ataque e dano (permanentEffects)',
  'Arma mágica +1.',
  NULL, NULL, 1039, NULL, NULL
),
(
  'item-adaga-peconhenta-veneno', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'adaga-peconhenta'), NULL,
  'Adaga · Revestir Veneno', 'bonus'::rpg.action_economy_bucket, 1,
  'adagaPeconhentaVenenoUse', NULL, true,
  'Ação Bônus: veneno 1 min / até acertar — CON CD 15 / 2d10 Ven. + Envenenado',
  '1×/amanhecer (MVP: DL).',
  'spend-resource', 1, 1040, NULL, NULL
),
(
  'item-azagaia-relampago-passivo', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'azagaia-relampago'), NULL,
  'Azagaia · Dano Elétrico', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Ao acertar: pode causar Elétrico em vez de Perfurante',
  'Escolha de tipo de dano no acerto.',
  NULL, NULL, 1041, NULL, NULL
),
(
  'item-azagaia-relampago-linha', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'azagaia-relampago'), NULL,
  'Azagaia · Relâmpago', 'action'::rpg.action_economy_bucket, 1,
  'azagaiaRelampagoUse', NULL, true,
  'Arremesso ≤36 m: linha 1,5 m — DEX CD 13 / 4d6 Elétrico; volta à mão',
  'Sem jogada de ataque. 1×/amanhecer (MVP: DL).',
  'spend-resource', 1, 1042, NULL, NULL
),
(
  'item-cimitarra-velocidade-passivo', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'cimitarra-da-velocidade'), NULL,
  'Cimitarra · +2 Ataque/Dano', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  '+2 ataque e dano (permanentEffects)',
  'Arma mágica +2. Sintonização.',
  NULL, NULL, 1043, NULL, NULL
),
(
  'item-cimitarra-velocidade-bonus', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'cimitarra-da-velocidade'), NULL,
  'Cimitarra · Ataque Extra', 'bonus'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Ação Bônus: 1 ataque com esta cimitarra (cada turno)',
  'Além da ação de Ataque normal.',
  NULL, NULL, 1044, NULL, NULL
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
