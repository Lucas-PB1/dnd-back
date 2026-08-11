-- DMG §0 #9b: economy maravilhosos simples (lote 2)
-- Ver docs/source/dmg-wiring-status.md

INSERT INTO rpg.phb_class_economy_action (
  action_id, class_id, species_id, feat_id, item_id, subclass_id, name, economy, unlock_level,
  resource_slug, free_resource_slug, always_spends_resource,
  summary, description, table_action, spend_amount, sort_order,
  requires_option_key, requires_option_value
) VALUES
(
  'item-chapeu-dos-vermes-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'chapeu-dos-vermes'), NULL,
  'Chapéu · Invocar Bicho', 'action'::rpg.action_economy_bucket, 1,
  'chapeuVermesCharges', NULL, true,
  'Gastar 1 carga: Morcego, Rato ou Sapo (1 h)',
  'Usar Magia: gaste 1 carga → Morcego, Rato ou Sapo no chapéu (Indiferente, sem controle; some em 1 h ou a 0 PV). Cargas: 3; recupera todas ao amanhecer (MVP: Descanso Longo).',
  'spend-resource', 1, 780, NULL, NULL
),
(
  'item-tunica-das-cores-cintilantes-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'tunica-das-cores-cintilantes'), NULL,
  'Túnica · Cores Deslumbrantes', 'action'::rpg.action_economy_bucket, 1,
  'tunicaCoresCharges', NULL, true,
  'Gastar 1 carga: Luz 9 m; Desv. vs você; SAB CD 15 ou Atordoado',
  'Usar Magia: gaste 1 carga → padrão deslumbrante até fim do próximo turno; Luz Plena 9 m + Meia-luz 9 m; Desvantagem em ataques contra você; na Luz Plena SAB CD 15 ou Atordoado até o fim. Cargas: 3; recupera 1d3 ao amanhecer (MVP: Descanso Longo).',
  'spend-resource', 1, 781, NULL, NULL
),
(
  'item-instrumento-musical-de-escrita-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'instrumento-musical-de-escrita'), NULL,
  'Instrumento · Mensagem Mágica', 'action'::rpg.action_economy_bucket, 1,
  'instrumentoEscritaCharges', NULL, true,
  'Gastar 1 carga: escrever até 6 palavras (Bardo: +7 e brilho)',
  'Enquanto toca: Usar Magia, gaste 1 carga → mensagem ≤6 palavras (idioma conhecido) em superfície a até 9 m. Bardo: +7 palavras e brilho em Escuridão não mágica. Some em 24 h ou Dissipar Magia. Cargas: 3; recupera todas ao amanhecer (MVP: Descanso Longo).',
  'spend-resource', 1, 782, NULL, NULL
),
(
  'item-manto-do-morcego-passivo', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'manto-do-morcego'), NULL,
  'Manto · Furtividade / Voo', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Vantagem Furtividade; Voo 12 m em Meia-luz/Escuridão (segurar bordas)',
  'Enquanto veste: Vantagem em Furtividade. Em Meia-luz/Escuridão, segure as bordas → Voo 12 m; se soltar ou sair da área, perde o voo.',
  NULL, NULL, 783, NULL, NULL
),
(
  'item-manto-do-morcego-polimorfia', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'manto-do-morcego'), NULL,
  'Manto · Polimorfia (Morcego)', 'action'::rpg.action_economy_bucket, 1,
  'mantoMorcegoPolimorfiaUse', NULL, true,
  'Polimorfia em Morcego (1×/amanhecer)',
  'Em Meia-luz/Escuridão: Polimorfia em Morcego (mantém Int/Sab/Car). 1× até o próximo amanhecer (MVP: Descanso Longo).',
  'spend-resource', 1, 784, NULL, NULL
),
(
  'item-capa-aracnidea-passivo', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'capa-aracnidea'), NULL,
  'Capa · Benefícios de Aranha', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Sem aprisionamento em teias; Escalada = Desloc.; Resistência Venenoso',
  'Caminhada da Aranha, Escalada de Aranha e Resistência a Venenoso enquanto usa a capa.',
  NULL, NULL, 785, NULL, NULL
),
(
  'item-capa-aracnidea-teia', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'capa-aracnidea'), NULL,
  'Capa · Teia', 'action'::rpg.action_economy_bucket, 1,
  'capaAracnideaTeiaUse', NULL, true,
  'Teia CD 13 área dobrada (1×/amanhecer)',
  'Conjure Teia (CD 13); área dobrada. 1× até o próximo amanhecer (MVP: Descanso Longo).',
  'spend-resource', 1, 786, NULL, NULL
),
(
  'item-orbe-flutuante-luz', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'orbe-flutuante'), NULL,
  'Orbe · Luz', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'A até 18 m: ordenar Luz (à vontade)',
  'A até 18 m, ordene Luz. Usar Magia: pairar a ≤1,5 m; segue você se >18 m; se bloqueado, desce e apaga.',
  NULL, NULL, 787, NULL, NULL
),
(
  'item-orbe-flutuante-luz-do-dia', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'orbe-flutuante'), NULL,
  'Orbe · Luz do Dia', 'action'::rpg.action_economy_bucket, 1,
  'orbeFlutuanteLuzDiaUse', NULL, true,
  'Ordenar Luz do Dia (1×/amanhecer)',
  'A até 18 m, ordene Luz do Dia. 1× até o próximo amanhecer (MVP: Descanso Longo).',
  'spend-resource', 1, 788, NULL, NULL
),
(
  'item-cubo-de-invocacao-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'cubo-de-invocacao'), NULL,
  'Cubo · Invocar (1d6)', 'action'::rpg.action_economy_bucket, 1,
  'cuboInvocacaoUse', NULL, true,
  'Torce a manivela: invoca criatura 5º (1×/amanhecer)',
  'Usar Magia: 1d6 → Aberração/Fera/Constructo/Dragão/Elemental/Feérico (5º, CD 17, +9; sem Concentração; você é o conjurador). 1× até o próximo amanhecer (MVP: Descanso Longo).',
  'spend-resource', 1, 789, NULL, NULL
),
(
  'item-tabuleiro-espiritual-augurio', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'tabuleiro-espiritual'), NULL,
  'Tabuleiro · Augúrio', 'action'::rpg.action_economy_bucket, 1,
  'tabuleiroEspiritualCharges', NULL, true,
  'Gastar 1 carga: Augúrio (1 min)',
  'Com a prancheta no tabuleiro: 1 min → Augúrio. Cargas: 3; recupera 1 ao amanhecer (MVP: Descanso Longo).',
  'spend-resource', 1, 790, NULL, NULL
),
(
  'item-tabuleiro-espiritual-comunhao', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'tabuleiro-espiritual'), NULL,
  'Tabuleiro · Comunhão', 'action'::rpg.action_economy_bucket, 1,
  'tabuleiroEspiritualCharges', NULL, true,
  'Gastar 3 cargas: Comunhão (1 min)',
  'Com a prancheta no tabuleiro: 1 min → Comunhão. Cargas: 3; MVP recupera no Descanso Longo.',
  'spend-resource', 3, 791, NULL, NULL
),
(
  'item-bola-de-cristal-de-telepatia-videncia', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'bola-de-cristal-de-telepatia'), NULL,
  'Bola · Vidência', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Vidência CD 17 + telepatia 9 m no sensor',
  'Toque o orbe: Vidência (CD 17). Telepatia com criaturas à vista a até 9 m do sensor.',
  NULL, NULL, 792, NULL, NULL
),
(
  'item-bola-de-cristal-de-telepatia-sugestao', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'bola-de-cristal-de-telepatia'), NULL,
  'Bola · Sugestão (via sensor)', 'action'::rpg.action_economy_bucket, 1,
  'bolaCristalTelepatiaSugestaoUse', NULL, true,
  'Sugestão CD 17 pelo sensor (1×/amanhecer)',
  'Durante Vidência: Sugestão (CD 17) em criatura no alcance telepático; sem Concentração; encerra com a Vidência. 1× até o próximo amanhecer (MVP: Descanso Longo).',
  'spend-resource', 1, 793, NULL, NULL
),
(
  'item-jarro-alquimico-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'jarro-alquimico'), NULL,
  'Jarro · Produzir Líquido', 'action'::rpg.action_economy_bucket, 1,
  'jarroAlquimicoUse', NULL, true,
  'Nomear líquido da tabela (1×/amanhecer)',
  'Usar Magia: nomeie um líquido (ácido, veneno, cerveja, mel, maionese, óleo, vinagre, água, vinho — ver tabela do item). Derrame até 8 L/min. Não produz outro tipo/mais do limite até o próximo amanhecer (MVP: Descanso Longo).',
  'spend-resource', 1, 794, NULL, NULL
),
(
  'item-cinturao-do-povo-anao-passivo', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'cinturao-do-povo-anao'), NULL,
  'Cinturão · Benefícios Anões', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  '+2 Con; idioma Anão; Persuasão vs anões; extras se não-anão',
  'Constituição +2 (máx. 20). Amigo dos Anões, idioma Anão. Se não for anão/duergar: Resistência Venenoso, Vantagem vs Envenenado, Visão no Escuro 18 m. 50% ao amanhecer: barba cresce/engrossa (lembrete).',
  NULL, NULL, 795, NULL, NULL
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
