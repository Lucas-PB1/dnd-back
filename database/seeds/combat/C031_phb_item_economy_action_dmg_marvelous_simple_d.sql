-- DMG §0 #9d: economy maravilhosos passivos/à vontade (lote 4)
-- Ver docs/source/dmg-wiring-status.md

INSERT INTO rpg.phb_class_economy_action (
  action_id, class_id, species_id, feat_id, item_id, subclass_id, name, economy, unlock_level,
  resource_slug, free_resource_slug, always_spends_resource,
  summary, description, table_action, spend_amount, sort_order,
  requires_option_key, requires_option_value
) VALUES
(
  'item-botas-despistadoras-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'botas-despistadoras'), NULL,
  'Botas · Pegadas Falsas', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Deixar pegadas de outro humanoide do seu tamanho',
  'Enquanto usa: faça as botas deixarem pegadas como as de qualquer tipo de humanoide do seu tamanho.',
  NULL, NULL, 830, NULL, NULL
),
(
  'item-braceletes-de-defesa-passivo', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'braceletes-de-defesa'), NULL,
  'Braceletes · +2 CA', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  '+2 CA se sem armadura e sem Escudo',
  'permanentEffects +2 CA. Só se aplica se não estiver vestindo armadura e não estiver usando Escudo — desligue mentalmente se armado.',
  NULL, NULL, 831, NULL, NULL
),
(
  'item-olhos-noturnos-passivo', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'olhos-noturnos'), NULL,
  'Olhos · Visão no Escuro', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Visão no Escuro 18 m (ou +18 m se já tiver)',
  'Ao usar as lentes: Visão no Escuro 18 m; se já tiver, alcance +18 m.',
  NULL, NULL, 832, NULL, NULL
),
(
  'item-roupas-autoconcertantes-passivo', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'roupas-autoconcertantes'), NULL,
  'Roupas · Autoconsertar', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Remenda desgaste diário (peças destruídas não)',
  'Remenda magicamente desgastes diários. Peças totalmente destruídas não são reparadas.',
  NULL, NULL, 833, NULL, NULL
),
(
  'item-colar-da-adaptabilidade-passivo', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'colar-da-adaptabilidade'), NULL,
  'Colar · Respirar / Antiveneno', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Respirar em qualquer ambiente; Vantagem vs Envenenado',
  'Ao usar: respira normalmente em qualquer ambiente; Vantagem em salvaguardas para evitar/encerrar Envenenado.',
  NULL, NULL, 834, NULL, NULL
),
(
  'item-periapto-de-protecao-contra-veneno-passivo', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'periapto-de-protecao-contra-veneno'), NULL,
  'Periapto · Imunidade a Veneno', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Imunidade a Envenenado e dano Venenoso',
  'Ao usar: Imunidade à condição Envenenado e ao dano Venenoso.',
  NULL, NULL, 835, NULL, NULL
),
(
  'item-capa-do-povo-elfico-passivo', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'capa-do-povo-elfico'), NULL,
  'Capa · Furtividade Élfica', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Desvantagem Percepção vs você; Vantagem Furtividade',
  'Enquanto usa: testes de Sabedoria (Percepção) para notá-lo têm Desvantagem; Vantagem em Furtividade.',
  NULL, NULL, 836, NULL, NULL
),
(
  'item-braceletes-de-arquearia-passivo', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'braceletes-de-arquearia'), NULL,
  'Braceletes · Arquearia', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Proficiência Arco Longo/Curto; +2 dano com eles',
  'Enquanto usa: proficiência com Arco Longo e Arco Curto; +2 nas jogadas de dano com essas armas.',
  NULL, NULL, 837, NULL, NULL
),
(
  'item-livro-de-magias-duravel-passivo', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'livro-de-magias-duravel'), NULL,
  'Livro · Imune Fogo/Água', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Livro e escrita: imunes a fogo/água; não deteriora',
  'Este livro de magias e o que está escrito nele não podem ser danificados por fogo ou água e não se deterioram com o tempo.',
  NULL, NULL, 838, NULL, NULL
),
(
  'item-amuleto-de-protecao-contra-deteccao-e-localizacao-passivo', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'amuleto-de-protecao-contra-deteccao-e-localizacao'), NULL,
  'Amuleto · Ocultar de Adivinhação', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Oculto a Adivinhação e sensores de vidência',
  'Enquanto usa: oculto a magias de Adivinhação; não pode ser alvo delas nem percebido por sensores de vidência.',
  NULL, NULL, 839, NULL, NULL
),
(
  'item-bola-de-cristal-de-visao-verdadeira-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'bola-de-cristal-de-visao-verdadeira'), NULL,
  'Bola · Vidência + Visão Verdadeira', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Vidência CD 17; Visão Verdadeira 36 m no sensor',
  'Toque o orbe: Vidência (CD 17). Além disso, Visão Verdadeira 36 m centrada no sensor mágico.',
  NULL, NULL, 840, NULL, NULL
),
(
  'item-bengala-de-veterano-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'bengala-de-veterano'), NULL,
  'Bengala · Espada Longa', 'bonus'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Ação Bônus: bengala ↔ Espada Longa comum',
  'Ação Bônus: transforme em Espada Longa comum ou reverta (deve estar segurando).',
  NULL, NULL, 841, NULL, NULL
),
(
  'item-chave-misteriosa-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'chave-misteriosa'), NULL,
  'Chave · Destrancar 5%', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  '5% de destrancar; some se abrir',
  '5% de chance de destrancar qualquer fechadura. Se destrancar, a chave desaparece (remova do inventário).',
  NULL, NULL, 842, NULL, NULL
),
(
  'item-botas-elficas-passivo', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'botas-elficas'), NULL,
  'Botas · Passos Silenciosos', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Passos sem barulho; Vantagem Furtividade',
  'Enquanto usa: passos não fazem barulho (qualquer superfície); Vantagem em Furtividade.',
  NULL, NULL, 843, NULL, NULL
),
(
  'item-esfera-do-tempo-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'esfera-do-tempo'), NULL,
  'Esfera · Hora do Dia', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Usar Magia: manhã/tarde/noite/madrugada (Plano Material)',
  'Foco Arcano. Usar Magia: descubra se é manhã, tarde, noite ou madrugada (só no Plano Material).',
  NULL, NULL, 844, NULL, NULL
),
(
  'item-luvas-de-natacao-e-escalada-passivo', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'luvas-de-natacao-e-escalada'), NULL,
  'Luvas · Nadar / Escalar', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Natação e Escalada = Desloc.; +5 Atletismo (escalar/nadar)',
  'Enquanto veste: Deslocamento de Escalada e Natação iguais ao seu Deslocamento; +5 em Força (Atletismo) para escalar ou nadar.',
  NULL, NULL, 845, NULL, NULL
),
(
  'item-conta-de-hidratacao-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'conta-de-hidratacao'), NULL,
  'Conta · Purificar Água', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Dissolver: até 0,5 L → água potável (consumir)',
  'Em líquido: dissolve e transforma até meio litro em água potável fresca. Não afeta líquidos mágicos/venenos. Remova 1 do inventário.',
  NULL, NULL, 846, NULL, NULL
),
(
  'item-cadeado-antiladinagem-passivo', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'cadeado-antiladinagem'), NULL,
  'Cadeado · Antiladinagem', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Abrir: Desvantagem em Destreza; vem com 1 chave',
  'Cadeado comum com 1 chave. Testes de Destreza para abri-lo têm Desvantagem.',
  NULL, NULL, 847, NULL, NULL
),
(
  'item-touca-de-respirar-na-agua-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'touca-de-respirar-na-agua'), NULL,
  'Touca · Bolha de Ar', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Debaixo d’água: Usar Magia → bolha de ar na cabeça',
  'Debaixo d’água: Usar Magia cria bolha de ar ao redor da cabeça até remover a touca ou sair da água.',
  NULL, NULL, 848, NULL, NULL
),
(
  'item-esfera-da-direcao-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'esfera-da-direcao'), NULL,
  'Esfera · Norte Magnético', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Usar Magia: apontar o norte magnético',
  'Foco Arcano. Usar Magia: determine o norte magnético (nada se não houver).',
  NULL, NULL, 849, NULL, NULL
),
(
  'item-caneca-da-sobriedade-passivo', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'caneca-da-sobriedade'), NULL,
  'Caneca · Sem Embriaguez', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Beber álcool não mágico sem embriagar',
  'Beba cerveja/vinho/álcool não mágico nela sem ficar embriagado. Não afeta líquidos mágicos/venenos.',
  NULL, NULL, 850, NULL, NULL
),
(
  'item-vara-de-pesca-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'vara-de-pesca'), NULL,
  'Vara · Haste ↔ Pesca', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Usar Magia: Haste ↔ vara de pescar',
  'Funciona como Haste. Usar Magia: transforme em vara de pescar (anzol, linha, carretilha) ou reverta.',
  NULL, NULL, 851, NULL, NULL
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
