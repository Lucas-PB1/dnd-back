-- DMG §0 #9g: economy maravilhosos finais fáceis + anéis simples
-- Ver docs/source/dmg-item-mesa-taxonomy-marvelous-simple.yaml

INSERT INTO rpg.phb_class_economy_action (
  action_id, class_id, species_id, feat_id, item_id, subclass_id, name, economy, unlock_level,
  resource_slug, free_resource_slug, always_spends_resource,
  summary, description, table_action, spend_amount, sort_order,
  requires_option_key, requires_option_value
) VALUES
-- Maravilhosos
(
  'item-garrafa-do-fumace-eterno-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'garrafa-do-fumace-eterno'), NULL,
  'Garrafa · Abrir / Fechar Fumaça', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Abrir: Emanação fumaça 18→36 m; fechar: fixa 10 min',
  'Usar Magia: abrir/fechar. Aberta: fumaça Totalmente Obscurecida (18 m, +3 m/min até 36 m). Fechar: nuvem fixa 10 min (vento forte: 1 min).',
  NULL, NULL, 930, NULL, NULL
),
(
  'item-gema-elemental-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'gema-elemental'), NULL,
  'Gema · Invocar Elemental', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Quebrar: Elemental 1 h (consumir)',
  'Usar Objeto: quebre → Elemental (Fogo/Terra/Água/Ar conforme gema). Obedece; some em 1 h / 0 PV / dispensar (bônus). Remova o item.',
  NULL, NULL, 931, NULL, NULL
),
(
  'item-tunica-ocular-passivo', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'tunica-ocular'), NULL,
  'Túnica · Olhos', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Visão no Escuro + Verdadeira 36 m; Vantagem Percepção; cuidado com Luz',
  'Visão no Escuro e Visão Verdadeira 36 m; Vantagem Percepção (visão). Luz na túnica / Luz do Dia a 1,5 m → Cego 1 min (CON CD 11/15).',
  NULL, NULL, 932, NULL, NULL
),
(
  'item-trombeta-de-explosao-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'trombeta-de-explosao'), NULL,
  'Trombeta · Explosão', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Cone 9 m: CON CD 15 · 5d8 Trovejante (+20% explode)',
  'Usar Magia: Cone 9 m audível 180 m; CON CD 15; falha 5d8 Trovejante + Surdo 1 min / sucesso metade. Vidro/cristal 10d8. 20% explode: 10d6 Energético em você e destrói.',
  NULL, NULL, 933, NULL, NULL
),
(
  'item-cola-suprema-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'cola-suprema'), NULL,
  'Cola · Aplicar', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  '30 g: cola permanente 30×30 cm (1 min para fixar)',
  'Recipiente (1d6+1)×30 g. Usar Objeto: aplique 30 g; fixa em 1 min. Só Solvente Universal / Óleo Etéreo / Desejo desfaz. Rastreie gramas.',
  NULL, NULL, 934, NULL, NULL
),
(
  'item-chapeu-dos-magos-passivo', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'chapeu-dos-magos'), NULL,
  'Chapéu · Foco de Mago', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Foco de conjuração de Mago',
  'Enquanto usa: Foco de Conjuração para magias de Mago.',
  NULL, NULL, 935, NULL, NULL
),
(
  'item-chapeu-dos-magos-truque', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'chapeu-dos-magos'), NULL,
  'Chapéu · Truque Desconhecido', 'action'::rpg.action_economy_bucket, 1,
  'chapeuMagosTruqueUse', NULL, true,
  'Arcanismo CD 10: conjurar truque de Mago (1×/DL)',
  'Usar Magia: tente truque de Mago (ação) que não conhece; Int (Arcanismo) CD 10. Sucesso conjura; falha desperdiça a ação. 1×/Descanso Longo.',
  'spend-resource', 1, 936, NULL, NULL
),
(
  'item-poco-dos-mundos-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'poco-dos-mundos'), NULL,
  'Poço · Abrir Portal', 'action'::rpg.action_economy_bucket, 1,
  'pocoMundosUse', NULL, true,
  'Portal 1,8 m (destino do Mestre); MVP 1×/DL (texto 1d8 h)',
  'Usar Magia: desdobre em superfície → portal bidirecional 1,8 m (destino do Mestre). Fecha: criatura a 1,5 m Usar Magia dobrando. Texto: 1d8 h (MVP: Descanso Longo).',
  'spend-resource', 1, 937, NULL, NULL
),
(
  'item-colar-de-contas-de-oracao-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'colar-de-contas-de-oracao'), NULL,
  'Colar · Usar Conta', 'bonus'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Ação Bônus: magia da conta (1×/amanhecer por conta)',
  '1d4+2 contas mágicas (tipos na tabela). Ação Bônus: conjure a magia da conta (sua CD). Cada conta 1× até o amanhecer. Rastreie tipos/usos.',
  NULL, NULL, 938, NULL, NULL
),
(
  'item-gema-da-claridade-luz', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'gema-da-claridade'), NULL,
  'Gema · Luz (0 cargas)', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  '1ª palavra: Luz Plena 9 m (sem gastar carga)',
  'Usar Magia: Luz Plena 9 m + Meia-luz 9 m. Não gasta carga. Ação Bônus: mesma palavra para apagar; ou use outra função.',
  NULL, NULL, 939, NULL, NULL
),
(
  'item-gema-da-claridade-feixe', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'gema-da-claridade'), NULL,
  'Gema · Feixe Cegante', 'action'::rpg.action_economy_bucket, 1,
  'gemaClaridadeCharges', NULL, true,
  'Gastar 1 carga: CON CD 15 ou Cego 1 min',
  '2ª palavra: gaste 1 carga; alvo a 18 m CON CD 15 ou Cego 1 min (repetir no fim do turno). Cargas: 50; a 0 vira joia 50 PO.',
  'spend-resource', 1, 940, NULL, NULL
),
(
  'item-gema-da-claridade-cone', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'gema-da-claridade'), NULL,
  'Gema · Cone Cegante', 'action'::rpg.action_economy_bucket, 1,
  'gemaClaridadeCharges', NULL, true,
  'Gastar 5 cargas: Cone 9 m (mesmo save do feixe)',
  '3ª palavra: gaste 5 cargas; Cone 9 m — cada criatura faz o save do feixe. Cargas: 50.',
  'spend-resource', 5, 941, NULL, NULL
),
-- Anéis
(
  'item-anel-de-telecinese-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'anel-de-telecinese'), NULL,
  'Anel · Telecinese', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Conjurar Telecinese',
  'Enquanto usa: conjure Telecinese a partir do anel.',
  NULL, NULL, 942, NULL, NULL
),
(
  'item-anel-de-natacao-passivo', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'anel-de-natacao'), NULL,
  'Anel · Natação 12 m', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Deslocamento de Natação 12 m',
  'Enquanto usa: Deslocamento de Natação 12 m.',
  NULL, NULL, 943, NULL, NULL
),
(
  'item-anel-de-queda-suave-passivo', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'anel-de-queda-suave'), NULL,
  'Anel · Queda Suave', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Ao cair: 18 m/rodada; sem dano de queda',
  'Ao cair: desce 18 m por rodada e não sofre dano de queda.',
  NULL, NULL, 944, NULL, NULL
),
(
  'item-anel-de-andar-sobre-as-aguas-passivo', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'anel-de-andar-sobre-as-aguas'), NULL,
  'Anel · Caminhar Sobre as Águas', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Caminhar Sobre as Águas (só você)',
  'Enquanto usa: Caminhar Sobre as Águas tendo só você como alvo.',
  NULL, NULL, 945, NULL, NULL
),
(
  'item-anel-de-saltar-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'anel-de-saltar'), NULL,
  'Anel · Salto', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Conjurar Salto (só em si)',
  'Enquanto usa: conjure Salto só em si.',
  NULL, NULL, 946, NULL, NULL
),
(
  'item-anel-dos-tres-desejos-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'anel-dos-tres-desejos'), NULL,
  'Anel · Desejo', 'action'::rpg.action_economy_bucket, 1,
  'anelTresDesejosCharges', NULL, true,
  'Gastar 1 carga: Desejo (sem recuperar; última = não mágico)',
  'Gaste 1 de 3 cargas: conjure Desejo. Não recupera cargas. Última carga: anel vira não mágico.',
  'spend-resource', 1, 947, NULL, NULL
),
(
  'item-anel-da-livre-movimentacao-passivo', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'anel-da-livre-movimentacao'), NULL,
  'Anel · Livre Movimentação', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Ignora Terreno Difícil; imune redução de Desloc./Contido/Paralisado mágicos',
  'Terreno Difícil sem custo extra. Magia não reduz Deslocamentos nem impõe Contido/Paralisado.',
  NULL, NULL, 948, NULL, NULL
),
(
  'item-anel-de-invisibilidade-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'anel-de-invisibilidade'), NULL,
  'Anel · Invisível', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Usar Magia: Invisível até remover ou Ação Bônus',
  'Usar Magia: Invisível até remover o anel ou Ação Bônus para ficar visível.',
  NULL, NULL, 949, NULL, NULL
),
(
  'item-anel-de-aquecimento-passivo', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'anel-de-aquecimento'), NULL,
  'Anel · Aquecimento', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  '−2d8 dano Gélido; imune a frio ≤ −18 °C',
  'Dano Gélido reduzido em 2d8. Você e o que carrega/usa: sem prejuízo de ≤ −18 °C.',
  NULL, NULL, 950, NULL, NULL
),
(
  'item-anel-de-influenciar-animais-amizade', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'anel-de-influenciar-animais'), NULL,
  'Anel · Amizade Animal', 'action'::rpg.action_economy_bucket, 1,
  'anelInfluenciarAnimaisCharges', NULL, true,
  'Gastar 1 carga: Amizade Animal CD 13',
  'Gaste 1 carga: Amizade Animal (CD 13). Cargas: 3; recupera 1d3 ao amanhecer (MVP: DL).',
  'spend-resource', 1, 951, NULL, NULL
),
(
  'item-anel-de-influenciar-animais-falar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'anel-de-influenciar-animais'), NULL,
  'Anel · Falar com Animais', 'action'::rpg.action_economy_bucket, 1,
  'anelInfluenciarAnimaisCharges', NULL, true,
  'Gastar 1 carga: Falar com Animais',
  'Gaste 1 carga: Falar com Animais. Cargas: 3; MVP recupera no DL.',
  'spend-resource', 1, 952, NULL, NULL
),
(
  'item-anel-de-influenciar-animais-medo', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'anel-de-influenciar-animais'), NULL,
  'Anel · Medo (só Feras)', 'action'::rpg.action_economy_bucket, 1,
  'anelInfluenciarAnimaisCharges', NULL, true,
  'Gastar 1 carga: Medo (apenas Feras) CD 13',
  'Gaste 1 carga: Medo só em Feras (CD 13). Cargas: 3; MVP recupera no DL.',
  'spend-resource', 1, 953, NULL, NULL
),
(
  'item-anel-de-regeneracao-passivo', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'anel-de-regeneracao'), NULL,
  'Anel · Regeneração', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  '1d6 PV / 10 min (≥1 PV); regenera membro em 1d6+1 dias',
  'Com ≥1 PV: recupera 1d6 PV a cada 10 min. Membro perdido: 1d6+1 dias com ≥1 PV o tempo todo.',
  NULL, NULL, 954, NULL, NULL
),
(
  'item-anel-afastador-de-magias-passivo', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'anel-afastador-de-magias'), NULL,
  'Anel · Afastar Magias', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Vantagem vs magias; sucesso ≤7º sem efeito; Reação refletir',
  'Vantagem vs magias. Sucesso vs ≤7º: sem efeito em você. Se só você era alvo (sem área): Reação reflete no conjurador (ele faz o save na CD dele).',
  NULL, NULL, 955, NULL, NULL
),
(
  'item-anel-de-resistencia-passivo', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'anel-de-resistencia'), NULL,
  'Anel · Resistência (tipo da pedra)', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Resistência a 1 tipo (pedra do anel)',
  'Resistência ao tipo indicado pela pedra (tabela Ácido…Trovejante). Anote o tipo na mesa.',
  NULL, NULL, 956, NULL, NULL
),
(
  'item-anel-de-visao-de-raio-x-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'anel-de-visao-de-raio-x'), NULL,
  'Anel · Visão de Raio-X', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Usar Magia: raio-X 9 m / 1 min (risco Exaustão se repetir)',
  'Usar Magia: visão raio-X 9 m por 1 min (limites de material no texto). Antes do DL: cada uso extra → CON CD 15 ou +1 Exaustão.',
  NULL, NULL, 957, NULL, NULL
),
(
  'item-anel-de-escudo-mental-passivo', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'anel-de-escudo-mental'), NULL,
  'Anel · Escudo Mental', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Imune leitura de pensamentos/mentira/alinhamento/tipo; telepatia opt-in',
  'Imune a magias que leem pensamentos, detectam mentira, alinhamento ou tipo. Telepatia só se permitir. Usar Magia: tornar imperceptível/visível. Ao morrer: alma pode entrar no anel.',
  NULL, NULL, 958, NULL, NULL
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
