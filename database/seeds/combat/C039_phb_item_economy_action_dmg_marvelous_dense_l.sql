-- DMG §0 #9l: economy maravilhosos densos finais + Orcus/Maravilhas
-- Cast/link magia = fase 6 · tabelas = lembrete de mesa

INSERT INTO rpg.phb_class_economy_action (
  action_id, class_id, species_id, feat_id, item_id, subclass_id, name, economy, unlock_level,
  resource_slug, free_resource_slug, always_spends_resource,
  summary, description, table_action, spend_amount, sort_order,
  requires_option_key, requires_option_value
) VALUES
(
  'item-amuleto-estilha-foco', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'amuleto-da-estilha-negra'), NULL,
  'Estilha · Foco de Bruxo', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Foco de Conjuração para magias de Bruxo',
  'Enquanto usa (sintonização).',
  NULL, NULL, 1120, NULL, NULL
),
(
  'item-amuleto-estilha-truque', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'amuleto-da-estilha-negra'), NULL,
  'Estilha · Truque Desconhecido', 'action'::rpg.action_economy_bucket, 1,
  'amuletoEstilhaMagiaDesconhecidaUse', NULL, true,
  'Usar Magia: Arcanismo CD 10 → truque de Bruxo (ação) que não conhece',
  '1×/DL. Falha = ação desperdiçada. Cast real = fase 6.',
  'spend-resource', 1, 1121, NULL, NULL
),
(
  'item-baralho-ilusoes-tirar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'baralho-das-ilusoes'), NULL,
  'Ilusões · Tirar Carta', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Usar Magia: carta aleatória → ilusão a ≤9 m (tabela DMG)',
  'Não causa dano. Investigação CD 15 revela. Carta some ao dissipar.',
  NULL, NULL, 1122, NULL, NULL
),
(
  'item-baralho-ilusoes-mover', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'baralho-das-ilusoes'), NULL,
  'Ilusões · Mover Ilusão', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Usar Magia: mover ilusão ≤9 m da carta (você a ≤36 m e vê)',
  'Enquanto a carta estiver no chão.',
  NULL, NULL, 1123, NULL, NULL
),
(
  'item-baralho-muitas-coisas-puxar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'baralho-de-muitas-coisas'), NULL,
  'Muitas Coisas · Declarar e Puxar', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Declarar N cartas; puxar aleatoriamente (≤1 h entre cartas)',
  'Efeito imediato; tabela DMG (13 ou 22). Tolo/Bufão saem do baralho.',
  NULL, NULL, 1124, NULL, NULL
),
(
  'item-bolsa-tropelias-puxar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'bolsa-das-tropelias'), NULL,
  'Tropelias · Arremessar Objeto', 'action'::rpg.action_economy_bucket, 1,
  'bolsaTropeliasCharges', NULL, true,
  'Usar Magia: arremessar ≤6 m → criatura (tabela cor); máx. 3/amanhecer',
  'Amigável; age após você. Some no amanhecer ou a 0 PV. MVP: DL.',
  'spend-resource', 1, 1125, NULL, NULL
),
(
  'item-bolsa-tropelias-ordenar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'bolsa-das-tropelias'), NULL,
  'Tropelias · Ordenar Criatura', 'bonus'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Ação Bônus: comando movimento/ação da criatura',
  'Sem ordem: age conforme natureza.',
  NULL, NULL, 1126, NULL, NULL
),
(
  'item-bolsa-feijoes-plantar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'bolsa-de-feijoes'), NULL,
  'Feijões · Plantar', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Plantar + regar: efeito em 1 min (tabela 1d100 DMG); consome 1',
  'Quantidade inicial 3d4. Sem feijões = deixa de ser mágico.',
  NULL, NULL, 1127, NULL, NULL
),
(
  'item-bolsa-feijoes-despejar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'bolsa-de-feijoes'), NULL,
  'Feijões · Despejar (explosão)', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Despejar 1+: esfera 3 m — DEX CD 15 / 5d4 Energético; grãos destruídos',
  'Inclui você na área.',
  NULL, NULL, 1128, NULL, NULL
),
(
  'item-bolsa-devoradora-aviso', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'bolsa-devoradora'), NULL,
  'Devoradora · Orifício Extradimensional', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Devora matéria viva/vegetal; 1×/dia engole objetos → outro plano',
  'Parece Bolsa Cabe Tudo. Virar do avesso fecha. Rasgar → Astral.',
  NULL, NULL, 1129, NULL, NULL
),
(
  'item-chapeu-muitas-magias-foco', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'chapeu-das-muitas-magias'), NULL,
  'Chapéu · Foco de Mago', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Foco de Mago; somático = puxar magia do chapéu',
  'Sintonização.',
  NULL, NULL, 1130, NULL, NULL
),
(
  'item-chapeu-muitas-magias-desconhecida', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'chapeu-das-muitas-magias'), NULL,
  'Chapéu · Magia Desconhecida', 'action'::rpg.action_economy_bucket, 1,
  'chapeuMuitasMagiasUse', NULL, true,
  'Gastar espaço + Arcanismo CD 10+círculo; falha = tabela aleatória',
  'Lista do Mago; material ≤1000 PO. Sucesso: 1× até DC/DL. Cast = fase 6.',
  'spend-resource', 1, 1131, NULL, NULL
),
(
  'item-demonomico-conhecimento', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'demonomico-de-lggwilv'), NULL,
  'Demonômico · Conhecimento Abissal', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Vantagem em INT (demônios) / Sobrevivência (Abismo)',
  'Artefato. Consultar o tomo.',
  NULL, NULL, 1132, NULL, NULL
),
(
  'item-demonomico-contencao', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'demonomico-de-lggwilv'), NULL,
  'Demonômico · Contenção', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Usar Magia: Ínfero em Círculo Mágico — CAR CD 20 Desvant. ou prende em página',
  '10 páginas em branco. Ver texto para libertar/usar.',
  NULL, NULL, 1133, NULL, NULL
),
(
  'item-demonomico-cast-0', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'demonomico-de-lggwilv'), NULL,
  'Demonômico · Gargalhada Nefasta (0)', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Usar Magia: Gargalhada Nefasta de Tasha CD 20 (0 cargas)',
  'Cargas 8; recupera 1d8 amanhecer (MVP: DL). Cast = fase 6.',
  NULL, NULL, 1134, NULL, NULL
),
(
  'item-demonomico-cast-1', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'demonomico-de-lggwilv'), NULL,
  'Demonômico · Círculo Mágico (1)', 'action'::rpg.action_economy_bucket, 1,
  'demonomicoCharges', NULL, true,
  'Gastar 1: Círculo Mágico CD 20',
  'Cast real = fase 6.',
  'spend-resource', 1, 1135, NULL, NULL
),
(
  'item-demonomico-cast-2', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'demonomico-de-lggwilv'), NULL,
  'Demonômico · Âncora Planar (2)', 'action'::rpg.action_economy_bucket, 1,
  'demonomicoCharges', NULL, true,
  'Gastar 2: Âncora Planar CD 20',
  'Cast real = fase 6.',
  'spend-resource', 2, 1136, NULL, NULL
),
(
  'item-demonomico-cast-3', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'demonomico-de-lggwilv'), NULL,
  'Demonômico · Magia 3 cargas', 'action'::rpg.action_economy_bucket, 1,
  'demonomicoCharges', NULL, true,
  'Gastar 3: Aliado / Invocar Ínfero / Receptáculo / Transição (Abismo)',
  'Escolha na mesa. Cast = fase 6.',
  'spend-resource', 3, 1137, NULL, NULL
),
(
  'item-dispositivo-kwalish-pilotar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'dispositivo-de-kwalish'), NULL,
  'Kwalish · Acionar Alavancas', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Usar Magia: mover até 2 alavancas (veículo lagosta; tabela DMG)',
  'CA 20 / 200 PV; 2 Médias; ar 10 h. Investigação CD 20 acha trinco.',
  NULL, NULL, 1138, NULL, NULL
),
(
  'item-elmo-esplendor-passivo', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'elmo-do-esplendor'), NULL,
  'Elmo · Joias / Resistência / Luz', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Contar gemas; Res Ígneo (rubi); Luz Diamantina vs MV; risco 1 em d20',
  'Gemas destroem-se ao conjurar. Sem gemas = perde magia.',
  NULL, NULL, 1139, NULL, NULL
),
(
  'item-elmo-esplendor-chamas', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'elmo-do-esplendor'), NULL,
  'Elmo · Chamas (Opala de Fogo)', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Usar Magia: arma +1d6 Ígneo + luz 3/3 m (enquanto houver opala de fogo)',
  'Apagar = Ação Bônus ou guardar arma.',
  NULL, NULL, 1140, NULL, NULL
),
(
  'item-elmo-esplendor-magia', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'elmo-do-esplendor'), NULL,
  'Elmo · Conjurar (consome gema)', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Luz do Dia / Bola de Fogo / Muralha de Fogo / Rajada Prismática CD 18',
  'Consome 1 gema do tipo. Quantidade manual. Cast = fase 6.',
  NULL, NULL, 1141, NULL, NULL
),
(
  'item-esfera-aniquilacao-controlar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'esfera-da-aniquilacao'), NULL,
  'Esfera · Assumir Controle', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Usar Magia a ≤18 m: Arcanismo CD 25; falha: esfera avança 3 m em você',
  'Sucesso: controla até início do próximo turno.',
  NULL, NULL, 1142, NULL, NULL
),
(
  'item-esfera-aniquilacao-mover', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'esfera-da-aniquilacao'), NULL,
  'Esfera · Mover', 'bonus'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Ação Bônus (se controlando): mover 1,5 m × INT (mín. 1,5 m)',
  'DEX CD 19 ou 8d10 Energético ao tocar.',
  NULL, NULL, 1143, NULL, NULL
),
(
  'item-espelho-aprisionador-ativar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'espelho-aprisionador-de-vida'), NULL,
  'Espelho · Ativar/Desativar', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Usar Magia + palavra (pendurado; você a ≤1,5 m)',
  'Reflexo a ≤9 m: CAR CD 15 ou preso em cela (12 celas). Constructos auto-sucesso.',
  NULL, NULL, 1144, NULL, NULL
),
(
  'item-estatueta-poder-ativar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'estatueta-de-poder-maravilhoso'), NULL,
  'Estatueta · Animar', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Usar Magia: jogar ≤18 m → criatura (tipo/duração/cooldown = variante)',
  'Amigável; turno após você. Volta a 0 PV ou tocar + Usar Magia.',
  NULL, NULL, 1145, NULL, NULL
),
(
  'item-fortaleza-daern-crescer', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'fortaleza-instantanea-de-daern'), NULL,
  'Fortaleza · Crescer/Encolher', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Usar Magia + palavra: torre 6×6×9 m / volta a estatueta se vazia',
  'CA 20 / 100 PV; Imun B/C/P (exceto cerco). Sintonização.',
  NULL, NULL, 1146, NULL, NULL
),
(
  'item-fortaleza-daern-porta', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'fortaleza-instantanea-de-daern'), NULL,
  'Fortaleza · Abrir Porta', 'bonus'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Ação Bônus: comando da porta (imune a Arrombar)',
  'Só você comanda.',
  NULL, NULL, 1147, NULL, NULL
),
(
  'item-garrafa-ifriti-abrir', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'garrafa-ifriti'), NULL,
  'Garrafa · Abrir (Ifriti)', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Usar Magia: remover rolha — efeito 1d10 (ataque / servir 1 h / Desejo)',
  'Tracking de aberturas (máx. 4 no efeito 2–9). Mesa.',
  NULL, NULL, 1148, NULL, NULL
),
(
  'item-instrumento-bardos-conjurar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'instrumento-musical-dos-bardos'), NULL,
  'Instrumento · Conjurar Magia', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Tocar: magia da tabela (1×/amanhecer por magia); seu atributo/CD',
  'Comuns: Invisibilidade, Levitação, Proteção Bem/Mal, Voo + específicas do tipo. Sem sintonização: SAB CD 15 ou 2d4 Psíquico.',
  NULL, NULL, 1149, NULL, NULL
),
(
  'item-livro-trevas-sintonizar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'livro-das-trevas-profanas'), NULL,
  'Trevas · Sintonizar (risco Larva)', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Não Ínfero/MV: CAR CD 17 ou vira Larva (só Desejo reverte)',
  'Artefato. Natureza murcha perto. Ver texto para benefícios/leitura.',
  NULL, NULL, 1150, NULL, NULL
),
(
  'item-livro-feitos-estudar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'livro-dos-feitos-sublimes'), NULL,
  'Feitos · Estudar 80 h', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Só sintonizado abre; 80 h de estudo → benefícios; some depois',
  'Ínfero/MV/servo Inferior: 24d6 Radiante (ignora Res/Imun). Artefato.',
  NULL, NULL, 1151, NULL, NULL
),
(
  'item-manual-golens-criar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'manual-dos-golens'), NULL,
  'Manual · Criar Golem', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Conjurador 2× espaços 5º+; tempo/custo por tipo; livro é consumido',
  'Leitor inválido: 6d6 Psíquico. Tipo = tabela DMG.',
  NULL, NULL, 1152, NULL, NULL
),
(
  'item-vecna-olho-passivo', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'olho-e-mao-de-vecna'), NULL,
  'Vecna · Olho (Visão Verdadeira / risco)', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Visão Verdadeira 72 m; 5% alma ao conjurar do olho; órbita vazia',
  'Remover olho = morte. Props aleatórias de artefato.',
  NULL, NULL, 1153, NULL, NULL
),
(
  'item-vecna-olho-cast', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'olho-e-mao-de-vecna'), NULL,
  'Vecna · Magia do Olho (cargas)', 'action'::rpg.action_economy_bucket, 1,
  'olhoVecnaCharges', NULL, true,
  'Gastar 1–5: Coroa/Clarividência/Desintegrar/Mau Olhado/Dominar (tabela)',
  'Cargas 8; recupera 1d4+4 amanhecer (MVP: DL). CD 18. Cast = fase 6.',
  'spend-resource', 1, 1154, NULL, NULL
),
(
  'item-vecna-mao-passivo', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'olho-e-mao-de-vecna'), NULL,
  'Vecna · Mão (FOR 20 / Toque Gélido)', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Alinhamento NM; FOR 20 se menor; +2d8 Gélido em ataque CA da mão; Iniciativa+',
  'Remover mão = morte. Sugestão maligna ao conjurar.',
  NULL, NULL, 1155, NULL, NULL
),
(
  'item-vecna-mao-cast', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'olho-e-mao-de-vecna'), NULL,
  'Vecna · Magia da Mão (cargas)', 'action'::rpg.action_economy_bucket, 1,
  'maoVecnaCharges', NULL, true,
  'Gastar 1–5: Sono/Lentidão/Teleporte/Dedo da Morte (tabela)',
  'Cargas 8; MVP: DL. CD 18. Cast = fase 6.',
  'spend-resource', 1, 1156, NULL, NULL
),
(
  'item-vecna-juntos', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'olho-e-mao-de-vecna'), NULL,
  'Vecna · Olho+Mão (Imun / Regen / Redução)', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Imun Veneno; regen 1d10/turno; Redução Necrótica CON CD 18 / 7d6',
  'Desejo separado. Destruição: Espada de Kas na mesma criatura.',
  NULL, NULL, 1157, NULL, NULL
),
(
  'item-vecna-desejo', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'olho-e-mao-de-vecna'), NULL,
  'Vecna · Desejo', 'action'::rpg.action_economy_bucket, 1,
  'olhoMaoVecnaDesejoUse', NULL, true,
  'Conjurar Desejo (olho+mão); 1×/30 dias',
  'Sem recover automático — Mestre restaura após 30 dias. Cast = fase 6.',
  'spend-resource', 1, 1158, NULL, NULL
),
(
  'item-orbes-espiar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'orbes-draconicos'), NULL,
  'Orbe · Espiar (controle ou Enfeitiçado)', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Usar Magia: CAR CD 15 — sucesso controla; falha Enfeitiçado + Sugestão CD 18',
  'Artefato. Props aleatórias.',
  NULL, NULL, 1159, NULL, NULL
),
(
  'item-orbes-cast', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'orbes-draconicos'), NULL,
  'Orbe · Magia (se controla)', 'action'::rpg.action_economy_bucket, 1,
  'orbesDraconicosCharges', NULL, true,
  'Gastar 0–4: Detectar Magia / Luz do Dia / Proteção Morte / Vidência / Curar 9º',
  'Cargas 7; recupera 1d4+3 amanhecer (MVP: DL). Cast = fase 6.',
  'spend-resource', 1, 1160, NULL, NULL
),
(
  'item-orbes-chamar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'orbes-draconicos'), NULL,
  'Orbe · Chamar Dragões', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Usar Magia (se controla): chamado 60 km; cooldown 1 h',
  'Cromáticos compelidos; podem ficar hostis.',
  NULL, NULL, 1161, NULL, NULL
),
(
  'item-ioun-orbitar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'pedra-de-ioun'), NULL,
  'Ioun · Orbitar / Guardar', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Usar Magia: lançar para orbitar (máx. 3); Usar Objeto: guardar',
  'Efeito = tipo (Absorção, Proteção +1 CA, FOR +2, etc.). Mesa/Mestre.',
  NULL, NULL, 1162, NULL, NULL
),
(
  'item-pigmentos-nolzur-pintar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'pigmentos-maravilhosos-de-nolzur'), NULL,
  'Pigmentos · Pintar Cubo 6 m', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  '10 min Concentração: consome 1 pote → objetos/terreno reais (≤500 PO)',
  '1d4 potes. Interromper = perde pote.',
  NULL, NULL, 1163, NULL, NULL
),
(
  'item-pote-ferro-prender', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'pote-de-ferro'), NULL,
  'Pote · Aprisionar', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Usar Magia: alvo ≤18 m noutro plano — SAB CD 17 ou preso (1 criatura)',
  'Vantagem se já foi preso antes.',
  NULL, NULL, 1164, NULL, NULL
),
(
  'item-pote-ferro-liberar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'pote-de-ferro'), NULL,
  'Pote · Liberar', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Usar Magia: remove rolha — obedece 1 h; depois age livre',
  'Identificar revela se há criatura, não o tipo.',
  NULL, NULL, 1165, NULL, NULL
),
(
  'item-trombeta-valhalla-soprar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'trombeta-do-valhalla'), NULL,
  'Trombeta · Soprar', 'action'::rpg.action_economy_bucket, 1,
  'trombetaValhallaUse', NULL, true,
  'Usar Magia: Berserkers de Ysgard 1 h (2–5); 1×/7 dias',
  'Requisito por metal (tabela). Sem requisito: atacam você. Sem recover — Mestre após 7 dias.',
  'spend-resource', 1, 1166, NULL, NULL
),
(
  'item-tunica-estrelas-passivo', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'tunica-das-estrelas'), NULL,
  'Estrelas · +1 Salvaguardas', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  '+1 em todas as salvaguardas (permanentEffects)',
  'Sintonização.',
  NULL, NULL, 1167, NULL, NULL
),
(
  'item-tunica-estrelas-misseis', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'tunica-das-estrelas'), NULL,
  'Estrelas · Mísseis Mágicos (5º)', 'action'::rpg.action_economy_bucket, 1,
  'tunicaEstrelasCharges', NULL, true,
  'Usar Magia: gastar 1 estrela → Mísseis 5º',
  '6 estrelas; 1d6 reaparecem ao anoitecer (MVP: DL). Cast = fase 6.',
  'spend-resource', 1, 1168, NULL, NULL
),
(
  'item-tunica-estrelas-astral', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'tunica-das-estrelas'), NULL,
  'Estrelas · Plano Astral', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Usar Magia: entrar/sair do Astral com o que veste/carrega',
  'Retorna ao último espaço (ou adjacente).',
  NULL, NULL, 1169, NULL, NULL
),
(
  'item-tunica-quinquilharias-remendo', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'tunica-das-quinquilharias-uteis'), NULL,
  'Quinquilharias · Remover Remendo', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Usar Magia: remendo vira objeto/criatura (tabela); último = roupa comum',
  '2 de cada básico + 4d4 extras. Quantidade manual.',
  NULL, NULL, 1170, NULL, NULL
),
(
  'item-varinha-maravilhas-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'varinha-das-maravilhas'), NULL,
  'Maravilhas · Efeito Aleatório', 'action'::rpg.action_economy_bucket, 1,
  'varinhaMaravilhasCharges', NULL, true,
  'Usar Magia: gastar 1 — efeito 1d100 no ponto ≤36 m (tabela DMG)',
  'Cargas 7; recupera 1d6+1 amanhecer (MVP: DL). Última carga: 1d20, em 1 destrói. CD 15.',
  'spend-resource', 1, 1171, NULL, NULL
),
(
  'item-varinha-orcus-arma', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'varinha-de-orcus'), NULL,
  'Orcus · Maça +3 / +2d12 Necrótico / +3 CA', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Maça mágica; +3 CA ao segurar (PE); destrói Água Benta a 3 m',
  'Sintonizar: CON CD 17 — sucesso 10d6 Necrótico; falha morre (+Zumbi se Humanoide).',
  NULL, NULL, 1172, NULL, NULL
),
(
  'item-varinha-orcus-cast', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'varinha-de-orcus'), NULL,
  'Orcus · Magia (cargas)', 'action'::rpg.action_economy_bucket, 1,
  'varinhaOrcusCharges', NULL, true,
  'Gastar 1–4: Animar Mortos / Falar Mortos / Malogro / Círculo / Dedo / Palavra Matar',
  'Cargas 7; recupera 1d4+3 amanhecer (MVP: DL). CD 18. Cast = fase 6.',
  'spend-resource', 1, 1173, NULL, NULL
),
(
  'item-varinha-orcus-convocar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'varinha-de-orcus'), NULL,
  'Orcus · Convocar 15 Esqueletos + 15 Zumbis', 'action'::rpg.action_economy_bucket, 1,
  'varinhaOrcusConvocarUse', NULL, true,
  'Usar Magia: 15+15 MV ≤90 m até amanhecer (1×/amanhecer)',
  'MVP: DL. Senciência CM; personalidade niilista.',
  'spend-resource', 1, 1174, NULL, NULL
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
