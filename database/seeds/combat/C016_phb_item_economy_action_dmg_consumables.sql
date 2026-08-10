-- DMG lote §0 #1: economy lembrete (Beber / Aplicar / Ler)
-- Gerado por docs/source/generate-dmg-consumable-lote.mjs
-- Sem resource regenerável — consumir = reduzir quantity no inventário.

INSERT INTO rpg.phb_class_economy_action (
  action_id, class_id, species_id, feat_id, item_id, subclass_id, name, economy, unlock_level,
  resource_slug, free_resource_slug, always_spends_resource,
  summary, description, table_action, spend_amount, sort_order,
  requires_option_key, requires_option_value
) VALUES
(
  'item-oleo-de-forma-eterea-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'oleo-de-forma-eterea'), NULL,
  'Aplicar · Óleo de Forma Etérea', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Aplicar: Um frasco deste óleo pode cobrir uma criatura Média ou menor, juntamente com o equipamento que ela …',
  'Um frasco deste óleo pode cobrir uma criatura Média ou menor, juntamente com o equipamento que ela está usando e carregando (um frasco adicional é necessário para cada categoria de tamanho acima de Médio). A aplicação do óleo leva 10 minutos. A criatura afetada então recebe o efeito da magia Forma Etérea por 1 hora. Bolhas deste óleo cinza turvo se formam do lado de fora de seu recipiente e evaporam rapidamente.',
  NULL, NULL, 500, NULL, NULL
),
(
  'item-oleo-de-precisao-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'oleo-de-precisao'), NULL,
  'Aplicar · Óleo de Precisão', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Aplicar: Um frasco deste óleo pode revestir uma arma Corpo a Corpo ou até vinte peças de munição, mas apenas…',
  'Um frasco deste óleo pode revestir uma arma Corpo a Corpo ou até vinte peças de munição, mas apenas armas e munições não mágicas que causem dano Cortante ou Perfurante são afetadas. Aplicar o óleo leva 1 minuto, após o qual ele se impregna magicamente no item coberto, transformando a arma em uma Arma +3 ou a munição em Munição +3. Este óleo transparente e gelatinoso brilha com pequenos fragmentos de prata ultrafinos.',
  NULL, NULL, 501, NULL, NULL
),
(
  'item-oleo-escorregadio-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'oleo-escorregadio'), NULL,
  'Aplicar · Óleo Escorregadio', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Aplicar: Um frasco deste óleo pode cobrir uma criatura Média ou menor, juntamente com o equipamento que ela …',
  'Um frasco deste óleo pode cobrir uma criatura Média ou menor, juntamente com o equipamento que ela está usando e carregando (um frasco adicional é necessário para cada categoria de tamanho acima de Médio). A aplicação do óleo leva 10 minutos. A criatura afetada então recebe o efeito da magia Movimentação Livre por 8 horas. Alternativamente, o óleo pode ser derramado no chão como uma ação Usar Magia, onde cobre um quadrado de 3 metros de lado, duplicando o efeito da magia Graxa nessa área por 8 horas. Este unguento preto e pegajoso é espesso e denso, mas flui rapidamente ao ser derramado.',
  NULL, NULL, 502, NULL, NULL
),
(
  'item-pergaminho-da-invocacao-de-tita-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'pergaminho-da-invocacao-de-tita'), NULL,
  'Ler · Pergaminho da Invocação de Titã', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Ler: Ao executar uma ação Usar Magia para ler este pergaminho, um titã em particular cujo nome consta no…',
  'Ao executar uma ação Usar Magia para ler este pergaminho, um titã em particular cujo nome consta no pergaminho aparece em um espaço desocupado no chão ou na água à sua vista a até 1,5 km de distância. O Mestre escolhe um titã adequado ou o determina aleatoriamente jogando na tabela abaixo (veja o Livro dos Monstros para o bloco de estatísticas da criatura). O titã é Hostil em relação a todas as outras criaturas e desaparece ao ser reduzido a 0 Pontos de Vida. Se o titã for invocado para um espaço que não seja grande o suficiente para contê-lo, a invocação falha e o pergaminho é desperdiçado. …',
  NULL, NULL, 503, NULL, NULL
),
(
  'item-pergaminho-de-circulo-da-protecao-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'pergaminho-de-circulo-da-protecao'), NULL,
  'Ler · Pergaminho de Círculo da Proteção', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Ler: Cada Pergaminho de Círculo da Proteção funciona contra criaturas de um tipo de criatura escolhido p…',
  'Cada Pergaminho de Círculo da Proteção funciona contra criaturas de um tipo de criatura escolhido pelo Mestre ou determinado jogando na tabela a seguir. 1d100 Tipo de Criatura 01–10 Aberrações 11–15 Feras 16–20 Celestiais 21–25 Constructos 26–35 Dragões 36–45 Elementais 46–50 Humanoides 51–60 Feéricos 61–70 Ínferos 71–75 Gigantes 76–80 Monstruosidades 81–85 Gosmas 86–90 Plantas 91–00 Mortos-vivos Executar uma ação Usar Magia para ler o pergaminho cria uma Emanação de 1,5 metro originada a partir de você. Por 5 minutos, criaturas do tipo especificado não podem entrar ou afetar algo na área. No…',
  NULL, NULL, 504, NULL, NULL
),
(
  'item-pocao-bafo-de-fogo-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'pocao-bafo-de-fogo'), NULL,
  'Beber · Poção Bafo de Fogo', 'bonus'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Beber: Após beber esta poção, você pode executar uma Ação Bônus para exalar fogo em um alvo a até 9 metros…',
  'Após beber esta poção, você pode executar uma Ação Bônus para exalar fogo em um alvo a até 9 metros de distância. O alvo deve realizar uma salvaguarda de Destreza CD 13 ou sofre 4d6 pontos de dano Ígneo se falhar e metade desse dano em caso de sucesso. O efeito termina depois que você exala o fogo três vezes ou quando 1 hora tenha se passado. O líquido laranja desta poção pisca e fumaça preenche a parte superior do recipiente e se espalha sempre que é aberta.',
  NULL, NULL, 505, NULL, NULL
),
(
  'item-pocao-da-saude-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'pocao-da-saude'), NULL,
  'Beber · Poção da Saúde', 'bonus'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Beber: O líquido claro e vermelho contém pequenas bolhas de luz. Quando você bebe esta poção, todos os con…',
  'O líquido claro e vermelho contém pequenas bolhas de luz. Quando você bebe esta poção, todos os contágios mágicos em você são curados. Além disso, as seguintes condições encerram em você: Cego, Envenenado, Paralisado e Surdo.',
  NULL, NULL, 506, NULL, NULL
),
(
  'item-pocao-das-formas-gasosas-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'pocao-das-formas-gasosas'), NULL,
  'Beber · Poção das Formas Gasosas', 'bonus'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Beber: Ao beber esta poção, você adquire o efeito da magia Forma Gasosa por 1 hora (sem necessidade de Con…',
  'Ao beber esta poção, você adquire o efeito da magia Forma Gasosa por 1 hora (sem necessidade de Concentração) ou até encerrar o efeito como uma Ação Bônus. O recipiente desta poção parece conter névoa que se move e derrama como água.',
  NULL, NULL, 507, NULL, NULL
),
(
  'item-pocao-de-amizade-animal-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'pocao-de-amizade-animal'), NULL,
  'Beber · Poção de Amizade Animal', 'bonus'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Beber: Ao beber esta poção, você pode conjurar a magia Amizade Animal como 3º círculo (CD 13 para evitar).…',
  'Ao beber esta poção, você pode conjurar a magia Amizade Animal como 3º círculo (CD 13 para evitar). Agitar o líquido turvo desta poção revela pequenos fragmentos: uma escama de peixe, uma pena de beija-flor, uma garra de gato ou um pelo de esquilo.',
  NULL, NULL, 508, NULL, NULL
),
(
  'item-pocao-de-clarividencia-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'pocao-de-clarividencia'), NULL,
  'Beber · Poção de Clarividência', 'bonus'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Beber: Ao beber esta poção, você recebe o efeito da magia Clarividência (sem necessidade de Concentração).…',
  'Ao beber esta poção, você recebe o efeito da magia Clarividência (sem necessidade de Concentração). Um globo ocular flutua no líquido amarelado desta poção, mas desaparece quando a poção é aberta.',
  NULL, NULL, 509, NULL, NULL
),
(
  'item-pocao-de-compreensao-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'pocao-de-compreensao'), NULL,
  'Beber · Poção de Compreensão', 'bonus'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Beber: Ao beber esta poção, você recebe o efeito da magia Compreender Idiomas por 1 hora. O líquido desta …',
  'Ao beber esta poção, você recebe o efeito da magia Compreender Idiomas por 1 hora. O líquido desta poção é uma mistura translúcida com fragmentos de sal e fuligem que giram nela.',
  NULL, NULL, 510, NULL, NULL
),
(
  'item-pocao-de-cura-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'pocao-de-cura'), NULL,
  'Beber · Poção de Cura', 'bonus'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Beber: Você recupera 2d4 + 2 Pontos de Vida ao beber esta poção. Qualquer que seja sua potência, o líquido…',
  'Você recupera 2d4 + 2 Pontos de Vida ao beber esta poção. Qualquer que seja sua potência, o líquido vermelho da poção brilha quando agitada. Poção PV Recuperado Raridade Poção de Cura 2d4 + 2 Comum Poção de Cura (maior) 4d4 + 4 Incomum Poção de Cura (superior) 8d4 + 8 Raro Poção de Cura (suprema) 10d4 + 20 Muito Raro',
  NULL, NULL, 511, NULL, NULL
),
(
  'item-pocao-de-escalada-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'pocao-de-escalada'), NULL,
  'Beber · Poção de Escalada', 'bonus'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Beber: Ao beber esta poção, você adquire um Deslocamento de Escalada igual ao seu Deslocamento por 1 hora.…',
  'Ao beber esta poção, você adquire um Deslocamento de Escalada igual ao seu Deslocamento por 1 hora. Durante esse período, você tem Vantagem em testes de Força (Atletismo) para escalar. Esta poção é composta por camadas marrons, prateadas e cinzentas que se assemelham a faixas de pedra. Agitar a garrafa não consegue misturar as cores.',
  NULL, NULL, 512, NULL, NULL
),
(
  'item-pocao-de-forca-de-gigante-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'pocao-de-forca-de-gigante'), NULL,
  'Beber · Poção de Força de Gigante', 'bonus'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Beber: Ao beber esta poção, seu valor de Força muda por 1 hora. O tipo de gigante determina o valor (veja …',
  'Ao beber esta poção, seu valor de Força muda por 1 hora. O tipo de gigante determina o valor (veja a tabela abaixo). A poção não afeta você se sua Força for igual ou maior do que esse valor. O líquido transparente desta poção contém um fragmento de luz flutuante que se assemelha à unha de um gigante. Poção For. Raridade Poção de Força de Gigante (da colina) 21 Incomum Poção de Força de Gigante (de pedra/gelo) 23 Raro Poção de Força de Gigante (de fogo) 25 Raro Poção de Força de Gigante (das nuvens) 27 Muito Raro Poção de Força de Gigante (da tempestade) 29 Lendário',
  NULL, NULL, 513, NULL, NULL
),
(
  'item-pocao-de-heroismo-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'pocao-de-heroismo'), NULL,
  'Beber · Poção de Heroísmo', 'bonus'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Beber: Ao beber esta poção, você adquire 10 Pontos de Vida Temporários que duram 1 hora. Pela mesma duraçã…',
  'Ao beber esta poção, você adquire 10 Pontos de Vida Temporários que duram 1 hora. Pela mesma duração, você está sob o efeito da magia Bênção (sem necessidade de Concentração). O líquido azul desta poção borbulha e solta vapor, como se estivesse fervendo.',
  NULL, NULL, 514, NULL, NULL
),
(
  'item-pocao-de-invisibilidade-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'pocao-de-invisibilidade'), NULL,
  'Beber · Poção de Invisibilidade', 'bonus'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Beber: O recipiente desta poção parece vazio, mas aparenta conter líquido. Ao beber a poção, você tem a co…',
  'O recipiente desta poção parece vazio, mas aparenta conter líquido. Ao beber a poção, você tem a condição Invisível por 1 hora. O efeito termina se você realizar uma jogada de ataque, causar dano ou conjurar uma magia.',
  NULL, NULL, 515, NULL, NULL
),
(
  'item-pocao-de-invisibilidade-maior-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'pocao-de-invisibilidade-maior'), NULL,
  'Beber · Poção de Invisibilidade Maior', 'bonus'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Beber: O recipiente desta poção parece vazio, mas aparenta conter líquido. Ao beber a poção, você tem a co…',
  'O recipiente desta poção parece vazio, mas aparenta conter líquido. Ao beber a poção, você tem a condição Invisível por 1 hora.',
  NULL, NULL, 516, NULL, NULL
),
(
  'item-pocao-de-invulnerabilidade-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'pocao-de-invulnerabilidade'), NULL,
  'Beber · Poção de Invulnerabilidade', 'bonus'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Beber: Por 1 minuto após beber esta poção, você tem Resistência a todos os tipos de dano. O líquido xaropo…',
  'Por 1 minuto após beber esta poção, você tem Resistência a todos os tipos de dano. O líquido xaroposo desta poção parece ferro liquefeito.',
  NULL, NULL, 517, NULL, NULL
),
(
  'item-pocao-de-ler-mentes-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'pocao-de-ler-mentes'), NULL,
  'Beber · Poção de Ler Mentes', 'bonus'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Beber: Ao beber esta poção, você recebe o efeito da magia Detectar Pensamentos (sem necessidade de Concent…',
  'Ao beber esta poção, você recebe o efeito da magia Detectar Pensamentos (sem necessidade de Concentração). O líquido denso e roxo desta poção contém uma nuvem rosa de formato oval flutuando em seu interior.',
  NULL, NULL, 518, NULL, NULL
),
(
  'item-pocao-de-longevidade-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'pocao-de-longevidade'), NULL,
  'Beber · Poção de Longevidade', 'bonus'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Beber: Ao beber esta poção, sua idade física é reduzida em 1d6 + 6 anos, para um mínimo de 13 anos. Cada v…',
  'Ao beber esta poção, sua idade física é reduzida em 1d6 + 6 anos, para um mínimo de 13 anos. Cada vez que você subsequentemente bebe uma Poção de Longevidade, há 10% de chance cumulativa de que você, em vez de rejuvenescer, envelheça 1d6 + 6 anos. Suspenso neste líquido âmbar está um pequeno coração que, contra toda lógica, ainda está batendo. Esse ingrediente desaparece ao abrir a poção.',
  NULL, NULL, 519, NULL, NULL
),
(
  'item-pocao-de-pugilismo-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'pocao-de-pugilismo'), NULL,
  'Beber · Poção de Pugilismo', 'bonus'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Beber: Após beber esta poção, cada Ataque Desarmado que você realizar causa 1d6 pontos de dano Energético …',
  'Após beber esta poção, cada Ataque Desarmado que você realizar causa 1d6 pontos de dano Energético adicionais em caso de acerto. Este efeito dura 10 minutos. Esta poção é um líquido verde espesso que tem gosto de espinafre.',
  NULL, NULL, 520, NULL, NULL
),
(
  'item-pocao-de-resistencia-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'pocao-de-resistencia'), NULL,
  'Beber · Poção de Resistência', 'bonus'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Beber: Ao beber esta poção, você tem Resistência a um tipo de dano por 1 hora. O Mestre escolhe o tipo ou …',
  'Ao beber esta poção, você tem Resistência a um tipo de dano por 1 hora. O Mestre escolhe o tipo ou o determina aleatoriamente jogando na tabela a seguir. 1d10 Tipo de Dano 1 Ácido 2 Gélido 3 Ígneo 4 Energético 5 Elétrico 6 Necrótico 7 Venenoso 8 Psíquico 9 Radiante 10 Trovejante',
  NULL, NULL, 521, NULL, NULL
),
(
  'item-pocao-de-respirar-na-agua-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'pocao-de-respirar-na-agua'), NULL,
  'Beber · Poção de Respirar na Água', 'bonus'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Beber: Você pode respirar debaixo d’água por 24 horas após beber esta poção. O fluido verde turvo desta po…',
  'Você pode respirar debaixo d’água por 24 horas após beber esta poção. O fluido verde turvo desta poção tem cheiro de maresia e possui uma bolha no formato de água-viva flutuando em seu meio.',
  NULL, NULL, 522, NULL, NULL
),
(
  'item-pocao-de-velocidade-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'pocao-de-velocidade'), NULL,
  'Beber · Poção de Velocidade', 'bonus'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Beber: Ao beber esta poção, você adquire o efeito da magia Celeridade por 1 minuto (sem necessidade de Con…',
  'Ao beber esta poção, você adquire o efeito da magia Celeridade por 1 minuto (sem necessidade de Concentração) e sem sofrer a onda de letargia que normalmente ocorre quando o efeito termina. O fluido amarelo desta poção é manchado de preto e gira por conta própria.',
  NULL, NULL, 523, NULL, NULL
),
(
  'item-pocao-de-vitalidade-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'pocao-de-vitalidade'), NULL,
  'Beber · Poção de Vitalidade', 'bonus'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Beber: Ao beber esta poção, ela remove quaisquer níveis de Exaustão que você tenha e encerra a condição En…',
  'Ao beber esta poção, ela remove quaisquer níveis de Exaustão que você tenha e encerra a condição Envenenado em você. Pelas próximas 24 horas, você recupera o número máximo de Pontos de Vida para qualquer Dado de Ponto de Vida que gastar. O líquido carmesim desta poção pulsa regularmente com uma luz opaca, lembrando o ritmo do batimento cardíaco.',
  NULL, NULL, 524, NULL, NULL
),
(
  'item-pocao-de-voo-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'pocao-de-voo'), NULL,
  'Beber · Poção de Voo', 'bonus'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Beber: Ao beber esta poção, você adquire um Deslocamento de Voo igual ao seu Deslocamento por 1 hora e pod…',
  'Ao beber esta poção, você adquire um Deslocamento de Voo igual ao seu Deslocamento por 1 hora e pode pairar. Se você estiver no ar quando a poção terminar o efeito, você cai, a menos que tenha algum outro meio de permanecer no ar. O líquido transparente desta poção flutua no topo de seu recipiente e tem impurezas brancas turvas flutuando.',
  NULL, NULL, 525, NULL, NULL
),
(
  'item-pocao-do-amor-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'pocao-do-amor'), NULL,
  'Beber · Poção do Amor', 'bonus'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Beber: Da próxima vez que avistar uma criatura nos 10 minutos seguintes após beber esta poção, você fica e…',
  'Da próxima vez que avistar uma criatura nos 10 minutos seguintes após beber esta poção, você fica enfeitiçado por ela e tem a condição Enfeitiçado por 1 hora. Este líquido efervescente em tons de rosa possui bolhas quase imperceptíveis em forma de coração.',
  NULL, NULL, 526, NULL, NULL
),
(
  'item-pocao-do-crescimento-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'pocao-do-crescimento'), NULL,
  'Beber · Poção do Crescimento', 'bonus'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Beber: Ao beber esta poção, você recebe o efeito “aumentar” da magia Aumentar/Reduzir por 10 minutos (sem …',
  'Ao beber esta poção, você recebe o efeito “aumentar” da magia Aumentar/Reduzir por 10 minutos (sem necessidade de Concentração). O vermelho no líquido da poção se expande continuamente a partir de uma pequena gota para colorir o líquido claro ao seu redor e depois se contrai. Agitar a garrafa não interrompe esse processo.',
  NULL, NULL, 527, NULL, NULL
),
(
  'item-pocao-do-encolhimento-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'pocao-do-encolhimento'), NULL,
  'Beber · Poção do Encolhimento', 'bonus'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Beber: Ao beber esta poção, você recebe o efeito “reduzir” da magia Aumentar/Reduzir por 1d4 horas (sem ne…',
  'Ao beber esta poção, você recebe o efeito “reduzir” da magia Aumentar/Reduzir por 1d4 horas (sem necessidade de Concentração). O vermelho no líquido da poção se contrai continuamente em uma pequena gota e depois se expande para colorir o líquido claro ao seu redor. Agitar a garrafa não interrompe esse processo.',
  NULL, NULL, 528, NULL, NULL
),
(
  'item-pocao-falsa-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'pocao-falsa'), NULL,
  'Beber · Poção Falsa', 'bonus'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Beber: Esta mistura parece, cheira e tem o gosto de uma Poção de Cura ou outra poção benéfica. No entanto,…',
  'Esta mistura parece, cheira e tem o gosto de uma Poção de Cura ou outra poção benéfica. No entanto, na verdade, é veneno mascarado por magia de ilusão. A magia Identificar revela sua verdadeira natureza. Se você beber esta poção, sofre 4d6 pontos de dano Venenoso e deve ser bem-sucedido em uma salvaguarda de Constituição CD 13 ou tem a condição Envenenado por 1 hora.',
  NULL, NULL, 529, NULL, NULL
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
