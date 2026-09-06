-- DMG §0 #9k: economy armas únicas restantes
-- Cast/link magia = fase 6

INSERT INTO rpg.phb_class_economy_action (
  action_id, class_id, species_id, feat_id, item_id, subclass_id, name, economy, unlock_level,
  resource_slug, free_resource_slug, always_spends_resource,
  summary, description, table_action, spend_amount, sort_order,
  requires_option_key, requires_option_value
) VALUES
(
  'item-alaude-batidas-passivo', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'alaude-de-batidas-estrondosas'), NULL,
  'Alaúde · Clava +2d8 Trovejante', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Clava mágica: +2d8 Trovejante no acerto',
  'Empunhado como Clava. Sem sintonização.',
  NULL, NULL, 1070, NULL, NULL
),
(
  'item-alaude-batidas-bardo', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'alaude-de-batidas-estrondosas'), NULL,
  'Alaúde · Cante e Golpeie', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Bardo: ataque corpo a corpo com CAR (cantando)',
  'Use modificador de Carisma no lugar de Força se cantar/cantarolar no ataque.',
  NULL, NULL, 1071, NULL, NULL
),
(
  'item-espada-respostas-passivo', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'espada-das-respostas'), NULL,
  'Espada · +3 Ataque/Dano', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  '+3 ataque e dano (permanentEffects)',
  'Sintonização.',
  NULL, NULL, 1072, NULL, NULL
),
(
  'item-espada-respostas-reacao', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'espada-das-respostas'), NULL,
  'Espada · Contra-ataque', 'reaction'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Reação: ataque CA vs quem te causou dano (Vantagem; ignora Res/Imun)',
  'Alcance corpo a corpo. Dano ignora Resistência/Imunidade do alvo a esse dano.',
  NULL, NULL, 1073, NULL, NULL
),
(
  'item-espada-kas-passivo', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'espada-de-kas'), NULL,
  'Kas · +3 / Crítico 19–20 / +2d10 vs MV', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  '+3 ataque/dano; crítico 19–20; +2d10 Cortante vs Mortos-Vivos',
  'Artefato. PE = +3/+3; resto na mesa.',
  NULL, NULL, 1074, NULL, NULL
),
(
  'item-espada-kas-iniciativa', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'espada-de-kas'), NULL,
  'Kas · Fome de Batalha', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Na posse: +1d10 nas jogadas de Iniciativa',
  'Espírito de Kas.',
  NULL, NULL, 1075, NULL, NULL
),
(
  'item-espada-kas-defensiva', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'espada-de-kas'), NULL,
  'Kas · Lâmina Defensiva', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Na ação Atacar: transferir bônus de ataque → CA até seu próximo turno',
  'Parte ou todo o +3 de ataque para CA.',
  NULL, NULL, 1076, NULL, NULL
),
(
  'item-espada-kas-personalidade', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'espada-de-kas'), NULL,
  'Kas · Personalidade / Vecna', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Senciente: ruína a Vecna; conflito se ignorar',
  'Artefato — ver texto DMG (personalidade / destruição).',
  NULL, NULL, 1077, NULL, NULL
),
(
  'item-lamina-solar-passivo', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'lamina-solar'), NULL,
  'Lâmina Solar · +2 Radiante', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  '+2 ataque/dano; dano Radiante; +1d8 vs Morto-vivo; Acuidade',
  'Proficiência se Espada Longa ou Curta. PE = +2/+2.',
  NULL, NULL, 1078, NULL, NULL
),
(
  'item-lamina-solar-ativar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'lamina-solar'), NULL,
  'Lâmina Solar · Acender/Apagar', 'bonus'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Ação Bônus: criar/remover lâmina de luz',
  'Sem lâmina = só o cabo.',
  NULL, NULL, 1079, NULL, NULL
),
(
  'item-lamina-solar-luz', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'lamina-solar'), NULL,
  'Lâmina Solar · Ajustar Luz', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Usar Magia: ±1,5 m Luz Plena/Meia-luz (3–9 m); luz do sol',
  'Base: Luz Plena 4,5 m + Meia-luz 4,5 m enquanto a lâmina existir.',
  NULL, NULL, 1080, NULL, NULL
),
(
  'item-laminegra-passivo', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'laminegra'), NULL,
  'Laminegra · +3 Ataque/Dano', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  '+3 ataque/dano; vs MV: você 1d10 Necrótico / alvo cura 1d10',
  'Artefato. Se Necrótico zerar seus PV → Devorar Alma em você.',
  NULL, NULL, 1081, NULL, NULL
),
(
  'item-laminegra-sentidos', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'laminegra'), NULL,
  'Laminegra · Imunidades / Visão às Cegas', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Imunidade Amedrontado/Enfeitiçado; Visão às Cegas 9 m',
  'Enquanto empunha.',
  NULL, NULL, 1082, NULL, NULL
),
(
  'item-laminegra-devorar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'laminegra'), NULL,
  'Laminegra · Devorar Alma', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Ao zerar PV: mata e devora alma (PV temp = PV máx.); só Desejo revive',
  'Exceto Constructo/MV. Celeridade: a arma decide (sem Concentração, 1 min). Sede: 3 dias sem alma → conflito.',
  NULL, NULL, 1083, NULL, NULL
),
(
  'item-laminegra-personalidade', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'laminegra'), NULL,
  'Laminegra · Senciência', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Senciente CN INT 17 / SAB 10 / CAR 19; telepatia',
  'Afinidade com Onda/Opressor. Destruição: engrenagens de Mecânos / tons de Primus.',
  NULL, NULL, 1084, NULL, NULL
),
(
  'item-lunamina-passivo', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'lunamina'), NULL,
  'Lunâmina · +1 (1ª runa)', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  '+1 ataque/dano base; runas extras = tabela DMG (até +3)',
  'PE MVP = +1/+1. Outras props (dano, arremesso, crítico…) = mesa/Mestre.',
  NULL, NULL, 1085, NULL, NULL
),
(
  'item-lunamina-rejeicao', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'lunamina'), NULL,
  'Lunâmina · Rejeição / Maldição', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Se rejeitar: 24 h Testes D20 com Desvantagem (até Remover Maldição)',
  'Aceita → sintonização instantânea. Só o portador trata como mágica.',
  NULL, NULL, 1086, NULL, NULL
),
(
  'item-lunamina-brilho', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'lunamina'), NULL,
  'Lunâmina · Brilho (prop. 86–95)', 'bonus'::rpg.action_economy_bucket, 1,
  'lunaminaBrilhoUse', NULL, true,
  'Ação Bônus: CON CD 15 ou Cego 1 min (≤9 m) — se tiver a prop.',
  'Só se a Lunâmina tiver essa propriedade. Recupera no DC ou DL.',
  'spend-resource', 1, 1087, NULL, NULL
),
(
  'item-lunamina-sombra', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'lunamina'), NULL,
  'Lunâmina · Entidade / Tabela', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Props 00 / anel armazenador / etc. — ver tabela DMG',
  'Senciência INT 12/SAB 10/CAR 12. Prop. menor de artefato também.',
  NULL, NULL, 1088, NULL, NULL
),
(
  'item-maca-destruicao-passivo', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'maca-da-destruicao'), NULL,
  'Maça · +1 (+3 vs Constructo)', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  '+1 ataque/dano; +3 vs Constructo; 20 natural: +7 (+14 Constructo)',
  'Constructo ≤25 PV após o dano extra do 20 → destruído. PE = +1/+1.',
  NULL, NULL, 1089, NULL, NULL
),
(
  'item-maca-disrupcao-passivo', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'maca-da-disrupcao'), NULL,
  'Maça · +2d6 Radiante vs Ínfero/MV', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Acerto vs Ínfero/MV: +2d6 Radiante; ≤25 PV → SAB CD 15 ou destruído',
  'Sucesso na CD: Amedrontado até fim do seu próximo turno. Luz Plena/Meia 6 m.',
  NULL, NULL, 1090, NULL, NULL
),
(
  'item-maca-terror-onda', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'maca-do-terror'), NULL,
  'Maça · Onda de Terror', 'action'::rpg.action_economy_bucket, 1,
  'macaTerrorCharges', NULL, true,
  'Usar Magia: gastar 1 — SAB CD 15 Amedrontado 1 min (≤9 m)',
  'Cargas 3; recupera 1d3 ao amanhecer (MVP: DL). Fugir; sem Ataques de Oportunidade.',
  'spend-resource', 1, 1091, NULL, NULL
),
(
  'item-machado-senhores-passivo', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'machado-dos-senhores-anoes'), NULL,
  'Machado · +3 / Crítico / Arremesso', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  '+3; 20 natural +20 Cortante; arremesso 6/18 m +1d8 (+2d8 Gigante) e retorna',
  'Artefato. PE = +3/+3.',
  NULL, NULL, 1092, NULL, NULL
),
(
  'item-machado-senhores-bencaos', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'machado-dos-senhores-anoes'), NULL,
  'Machado · Bênçãos de Moradin', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'CON +2 (máx 20); Imun Veneno; Res Ígneo; Visão Escuro 18 m; tools; max dano em objetos',
  'PE inclui abilityBonuses.constituicao +2. Props aleatórias de artefato = mesa.',
  NULL, NULL, 1093, NULL, NULL
),
(
  'item-machado-senhores-elemental', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'machado-dos-senhores-anoes'), NULL,
  'Machado · Invocar Elemental da Terra', 'action'::rpg.action_economy_bucket, 1,
  'machadoElementalTerraUse', NULL, true,
  'Usar Magia: Elemental da Terra 24 h (1×/amanhecer)',
  '≤9 m; obedece; turno após o seu. Dispensar = Ação Bônus. MVP: DL.',
  'spend-resource', 1, 1094, NULL, NULL
),
(
  'item-machado-senhores-teleporte', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'machado-dos-senhores-anoes'), NULL,
  'Machado · Teleporte (obra anã)', 'action'::rpg.action_economy_bucket, 1,
  'machadoTeleporteUse', NULL, true,
  'Usar Magia em pedra anã fixa: Teleporte (subsolo sem acidente); 1×/3 dias',
  'Sem recover automático — Mestre restaura após 3 dias. Cast real = fase 6.',
  'spend-resource', 1, 1095, NULL, NULL
),
(
  'item-martelo-anoes-passivo', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'martelo-arremessavel-dos-anoes'), NULL,
  'Martelo · +3 Arremesso', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  '+3 ataque/dano; Arremesso 6/18 m; +1d8 Energético (+2d8 Gigante); retorna',
  'PE = +3/+3. Sintonização.',
  NULL, NULL, 1096, NULL, NULL
),
(
  'item-onda-passivo', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'onda'), NULL,
  'Onda · +3 / Crítico Necrótico', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  '+3 ataque/dano; 20 natural: +21 Necrótico',
  'Artefato. PE = +3/+3.',
  NULL, NULL, 1097, NULL, NULL
),
(
  'item-onda-passivos-agua', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'onda'), NULL,
  'Onda · Respirar / Iniciativa', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Bolha de ar sob água; Vantagem em Iniciativa',
  'Enquanto segura.',
  NULL, NULL, 1098, NULL, NULL
),
(
  'item-onda-comando', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'onda'), NULL,
  'Onda · Dominar Fera Aquática', 'action'::rpg.action_economy_bucket, 1,
  'ondaComandoAquaticoCharges', NULL, true,
  'Gastar 1 carga: Dominar Fera CD 20 (Fera com natação)',
  'Cargas 3; recupera 1d3 ao amanhecer (MVP: DL). Cast real = fase 6.',
  'spend-resource', 1, 1099, NULL, NULL
),
(
  'item-onda-globo', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'onda'), NULL,
  'Onda · Globo de Invulnerabilidade (9º)', 'action'::rpg.action_economy_bucket, 1,
  'ondaGloboUse', NULL, true,
  'Conjurar Globo 9º (1×/amanhecer)',
  'MVP: DL. Cast real = fase 6.',
  'spend-resource', 1, 1100, NULL, NULL
),
(
  'item-onda-personalidade', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'onda'), NULL,
  'Onda · Senciência', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Senciente Neutro INT 14/SAB 10/CAR 18; telepatia; Aquan',
  'Incentiva culto a deuses do mar. Destruição: Forja do Trovão.',
  NULL, NULL, 1101, NULL, NULL
),
(
  'item-opressor-passivo', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'opressor'), NULL,
  'Opressor · +3 / Arremesso', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  '+3; Arremesso 18/45 m; +1d8 Energético (+4d8 Constructo/Elemental/Gigante); retorna',
  'Artefato. PE = +3/+3. Alerta portas secretas a 9 m.',
  NULL, NULL, 1102, NULL, NULL
),
(
  'item-opressor-detectar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'opressor'), NULL,
  'Opressor · Detectar Bem e Mal', 'action'::rpg.action_economy_bucket, 1,
  'opressorDetectarBemMalUse', NULL, true,
  'Conjurar Detectar Bem e Mal (1×/amanhecer)',
  'MVP: DL. Cast real = fase 6.',
  'spend-resource', 1, 1103, NULL, NULL
),
(
  'item-opressor-localizar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'opressor'), NULL,
  'Opressor · Localizar Objeto', 'action'::rpg.action_economy_bucket, 1,
  'opressorLocalizarObjetoUse', NULL, true,
  'Conjurar Localizar Objeto (1×/amanhecer)',
  'MVP: DL. Cast real = fase 6.',
  'spend-resource', 1, 1104, NULL, NULL
),
(
  'item-opressor-choque', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'opressor'), NULL,
  'Opressor · Onda de Choque', 'action'::rpg.action_economy_bucket, 1,
  'opressorOndaChoqueUse', NULL, true,
  'Usar Magia: CON CD 20 Atordoado 1 min (chão ≤18 m) — 1×/amanhecer',
  'Criaturas à escolha no chão. MVP: DL.',
  'spend-resource', 1, 1105, NULL, NULL
),
(
  'item-opressor-personalidade', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'opressor'), NULL,
  'Opressor · Senciência', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Senciente ON INT 15/SAB 12/CAR 15; proteger anões / clã Dankil',
  'Destruição: bile de dragão negro ancião ou forja Martelo Soberano.',
  NULL, NULL, 1106, NULL, NULL
),
(
  'item-tacape-trovejante-forca', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'tacape-trovejante'), NULL,
  'Tacape · Força 20 / +1d8 Trovejante', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Força = 20 se menor; +1d8 Trovejante (+3d8 objetos não usados)',
  'Ajuste Força na ficha (como Cinturão). Sintonização.',
  NULL, NULL, 1107, NULL, NULL
),
(
  'item-tacape-trovejante-estrondo', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'tacape-trovejante'), NULL,
  'Tacape · Estrondo Trovejante', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Usar Magia: Cone 9 m — FOR CD 15 ou Caído; audível 90 m',
  'Objetos não mágicos no cone: 3d8 Trovejante. À vontade.',
  NULL, NULL, 1108, NULL, NULL
),
(
  'item-tacape-trovejante-terremoto', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'tacape-trovejante'), NULL,
  'Tacape · Terremoto', 'action'::rpg.action_economy_bucket, 1,
  'tacapeTerremotoUse', NULL, true,
  'Usar Magia: círculo 15 m — DEX CD 20 Caído; fissura opcional (1×/amanhecer)',
  'Estruturas 50 Contundente. Concentração: CON CD 20. MVP: DL.',
  'spend-resource', 1, 1109, NULL, NULL
),
(
  'item-tridente-comandar-peixes', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'tridente-de-comandar-peixes'), NULL,
  'Tridente · Dominar Fera Aquática', 'action'::rpg.action_economy_bucket, 1,
  'tridenteComandarPeixesCharges', NULL, true,
  'Gastar 1 carga: Dominar Fera CD 15 (Fera com natação)',
  'Cargas 3; recupera 1d3 ao amanhecer (MVP: DL). Cast real = fase 6.',
  'spend-resource', 1, 1110, NULL, NULL
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
