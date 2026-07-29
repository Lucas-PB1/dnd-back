-- Seed Valda subclass features
-- Conteúdo canônico Valda: Spire of Secrets

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'path-of-the-muscle-wizard'),
  3,
  'Magia indiscutível',
  'Sua legitimidade inquestionável (e imensos músculos peitorais) lhe dão Vantagem em testes de Carisma (Intimidação) feitos para convencer os outros de que você é, de fato, um mago.

Além disso, se alguém questionar sua legítima habilidade mágica, você pode realizar uma Reação para entrar em sua Fúria até o final do seu próximo turno. Esta Fúria não pode ser estendida e não gasta um uso de sua Fúria.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'path-of-the-muscle-wizard'),
  3,
  '“Truques”',
  'Você pode invocar sua “magia” para lançar “Truques” em combate. Uma vez em cada um de seus turnos, ao atingir um alvo com um ataque baseado em Força, você pode usar um dos seguintes “Truques” de sua escolha.

Mãos Mágicas. Você pode empurrar o alvo até 1,5 metro de distância de você, se ele for grande ou menor. Enquanto sua Fúria estiver ativa, você pode empurrar o alvo até 3 metros.

Toque Chocante. A força do seu ataque é bastante chocante. O alvo não pode fazer Ataques de Oportunidade até o final do turno atual. Enquanto sua Fúria estiver ativa, ela não poderá atingir Ataques de Oportunidade até o início do seu próximo turno.

Ataque Certeiro. Você realmente ataca, causando 1d6 de dano extra ao alvo. O dano é do mesmo tipo da arma ou Ataque Desarmado usada para o ataque. Enquanto sua Fúria estiver ativa, você adiciona metade do seu nível de Bárbaro (arredondado para baixo) ao dano extra.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'path-of-the-muscle-wizard'),
  6,
  '“Magias”',
  'Sua “magia” é poderosa o suficiente para lançar todos os “magias” que existem (e ninguém pode provar o contrário sem costelas quebradas). No entanto, você só preparou os seguintes “magias” hoje. Enquanto sua Fúria estiver ativa, você pode usar cada um dos seguintes “Magias” uma vez. Ao fazer isso, você não poderá usar aquele “Magia” novamente até terminar um Descanso Longo.

Mãos Flamejantes. Seu tapa de backhand é lendário. Com uma ação, você pode realizar um Ataque Desarmado contra cada criatura ao seu alcance. Se acertar, este golpe causa Contundente de dano igual a 1d8 mais seu modificador de Força e o alvo tem Desvantagem no próximo ataque que realizar antes do início do seu próximo turno.

Mísseis Mágicos. Como uma ação, você pode fazer três ataques à distância usando Dardos, Adagas ou outras armas com a propriedade Arremesso que usem Força para as jogadas de ataque e dano. Como Mísseis Mágicos nunca erra, você tem Vantagem nessas jogadas de ataque.

Escudo. Quando você é atingido por uma jogada de ataque, você pode realizar uma Reação para vestir rapidamente um Escudo para se defender. Você ganha o bônus de CA do Escudo contra o ataque desencadeador, potencialmente fazendo com que ele erre. Se o ataque acertar, o dano causado a você será reduzido em uma quantidade igual ao seu nível de Bárbaro.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'path-of-the-muscle-wizard'),
  10,
  'Resistência Mágica',
  'Você é um bruxo tão incrível que outros bruxos nem conseguem tocar em você. Enquanto sua Fúria estiver ativa, você terá Vantagem em salvaguardas contra magias e outros efeitos mágicos.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'path-of-the-muscle-wizard'),
  14,
  'Eu lancei o punho',
  'Você pode esmagar seus inimigos com seu “magia” definitivo: Punho. Ao usar a ação Atacar enquanto sua Fúria está ativa, você pode substituir um de seus ataques por um soco realmente forte. Faça um Ataque Desarmado com Vantagem. Se acertar, o alvo sofre dano Contundente igual a 6d6 mais seu modificador de Força e tem a condição Caído se for Enorme ou menor. Você pode usar esse recurso uma vez por Fúria ativa.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'dungeoneer'),
  3,
  'Chute na porta',
  'Você tem Vantagem nas jogadas de ataque que faz durante a primeira rodada de combate.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'dungeoneer'),
  3,
  'Superstição Heroica',
  'Você ganha Inspiração Heroica ao realizar qualquer uma das ações a seguir.

Vulnerabilidade a danos. Causa um tipo de dano ao qual uma criatura tem Vulnerabilidade.

Encontre fraqueza. Aciona a fraqueza específica de uma criatura, como a Fraqueza à Luz Solar de Shadow ou causa dano que impede a Regeneração de uma criatura.

Adivinhe o monstro. Adivinhe o tipo específico de uma criatura (como mímico ou lich) antes de vê-la. O Mestre confirma se você está correto quando a criatura é revelada. Você não consegue adivinhar a identidade dos Humanoides.

Portas Secretas. Descubra uma porta secreta.

Localizador de armadilhas. Detecte ou desarme uma armadilha.

Tesouro. Encontre um item mágico ou tesouro incomum, raro, muito raro ou lendário no valor de 100 PO+.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'dungeoneer'),
  7,
  'Precauções na masmorra',
  'Você pode lançar qualquer uma das seguintes magias sem espaço de magia: Alarme, Compreender Idiomas, Detectar Magia, Detectar Veneno e Doença, Encontrar Armadilhas, Identificação e Purificar Alimentos e Bebidas. Inteligência, Sabedoria ou Carisma é seu atributo de conjuração para as magias que você conjura com este recurso (escolha o atributo ao conjurar a magia).

Você pode usar esse recurso cinco vezes e recuperar todos os usos gastos ao terminar um Descanso Longo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'dungeoneer'),
  10,
  'Matar Monstro',
  'Uma vez por turno, quando você atinge um Aberração, Dragão, Feérico, Corruptor, Monstruosidade, Gosma ou Morto-vivo com um ataque com uma arma, você pode causar 1d10 de dano extra ao alvo. Este dano é do mesmo tipo causado pela arma.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'dungeoneer'),
  15,
  'Evitar',
  'Quando você está sujeito a um efeito que permite que você faça uma salvaguarda de Força, Destreza ou Constituição para sofrer apenas metade do dano, você não sofre nenhum dano se tiver sucesso na salvaguarda e apenas metade do dano se falhar. Você não pode usar esse recurso se tiver a condição Incapacitado.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'dungeoneer'),
  18,
  'Herói Veterano',
  'Sua experiência em masmorras oferece os seguintes benefícios.

Heroísmo incomparável. Uma vez por turno, ao fazer um Teste de D20, você pode gastar Inspiração Heroica para transformar o lançamento em 20, em vez de rolar novamente o d20.

Dupla inspiração. Você pode ter duas instâncias de Inspiração Heroica ao mesmo tempo. Você pode usar apenas um Inspiração Heroica por rolo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'warrior-of-the-street'),
  3,
  'Combinação',
  'Ao atingir uma criatura com Ataque Desarmado e causar dano, você pode gastar 1 Ponto de Foco para iniciar um combo. Até o final do turno atual, você ganha +2 de bônus nas jogadas de ataque de seus Ataque Desarmados. Este bônus aumenta em 2, até um máximo de +6, para cada acerto sucessivo no turno atual. Este bônus é redefinido para +2 se você sofrer dano ou errar uma jogada de ataque.

Lucas Ferreira CM'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'warrior-of-the-street'),
  3,
  'Punho de Ferro',
  'Sempre que você atinge um objeto com um Ataque Desarmado, o acerto é um Acerto Crítico.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'warrior-of-the-street'),
  6,
  'Movimentos Especiais',
  'Você memorizou padrões de movimentos discretos que lhe permitem usar os seguintes movimentos especiais.

Explosão de Energia. Ao usar a ação Atacar no seu turno, você pode gastar 1 Ponto de Foco para substituir um de seus ataques por uma explosão de energia. Uma criatura de sua escolha que você possa ver a até 60 pés faz uma salvaguarda de Destreza, sofrendo Energético de dano igual a duas jogadas de seu dado de Artes Marciais, ou metade do dano em um teste bem-sucedido.

Quebrador de guarda. Se você fizer uma jogada de ataque com seu Ataque Desarmado e errar o alvo, você pode gastar 1 Focus Point para realizar um Guard Breaker. Este Ataque Desarmado causa dano igual ao seu modificador de Destreza ao alvo. Esta falha não redefine seu bônus de Combo nas jogadas de ataque.

Corte superior. Ao acertar uma criatura com um Ataque Desarmado e causar dano, você pode gastar 1 ponto de foco para dar um soco. Você pode empurrar o alvo até 5 pés de distância de você e dar ao alvo a condição Caído se ele for Grande ou menor.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'warrior-of-the-street'),
  11,
  'Traço aéreo',
  'No seu turno, você pode gastar 1 Ponto de Foco para ganhar Deslocamento de Voo igual à sua Velocidade até o final do seu próximo turno (nenhuma ação é necessária). Você tem Vantagem no próximo ataque corpo a corpo que fizer antes do final do turno atual.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'warrior-of-the-street'),
  17,
  'K.O.',
  'Uma vez por turno, ao atingir uma criatura com um Ataque Desarmado, você pode tentar nocautear o alvo. O alvo sofre dano Energético extra igual a três jogadas de seu dado de Artes Marciais. Se o alvo tiver 100 Pontos de Vida ou menos após você causar dano com o Ataque Desarmado, ele terá a condição Inconsciente por 10 minutos.

Depois de usar esse recurso, você não poderá usá-lo novamente até terminar um Descanso Curto ou Longo. Você também pode restaurar seu uso gastando 5 Pontos de Foco (nenhuma ação necessária).'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'oath-of-revelry'),
  3,
  'Magias de Juramento de Folia',
  'A magia do seu juramento garante que você sempre tenha certas magias prontas; quando você atinge um nível de Paladino especificado na tabela Magias de Juramento de Folia, você sempre terá as magias listadas preparados. Novas magias são marcados com um asterisco (*).

Magias de Juramento de Folia

Nível Paladino
Magias

3
Pessoa encantadora, risada horrível

5
Melhorar a capacidade, ressaca *

9
Crie comida e água, padrão hipnótico

13
Monstro Charmoso, Liberdade de Movimento

17
Missão, Ligação Telepática'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'oath-of-revelry'),
  3,
  'Conjurar bebida',
  'Como Ação Mágica, você pode gastar um uso de seu Canalizar Divindade para conjurar um número de canecas cheias de cerveja espumosa até seu modificador de Carisma (mínimo de um), que aparecem em espaços a até 30 pés de você. Uma criatura que bebe a cerveja como Ação Bônus ganha Pontos de Vida Temporáriossss igual ao seu modificador de Carisma e tem Vantagem em salvaguardas por 1 minuto. Quando você termina um Descanso Longo, as canecas e a cerveja restante desaparecem.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'oath-of-revelry'),
  7,
  'Aura de Fraternidade',
  'Você e seus aliados causam 1d4 de dano extra em ataques usando armas corpo a corpo ou Ataque Desarmados enquanto estiverem em sua Aura de Proteção. Este dano é do mesmo tipo causado pela arma ou Ataque Desarmado.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'oath-of-revelry'),
  15,
  'Folião',
  'Quando você ou um aliado a até 30 pés de você que pode ver ou ouvir você faz um Teste de D20, você pode realizar uma Reação para dar Vantagem àquela criatura no teste.

Você pode usar esse recurso um número de vezes igual ao seu modificador de Carisma (no mínimo uma vez) e recuperar todos os usos gastos ao terminar um Descanso Longo. Se a criatura ainda falhar no Teste de D20, este uso do Folião não será gasto.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'oath-of-revelry'),
  20,
  'Animal de festa',
  'Como Ação Bônus, você pode imbuir sua Aura de Proteção com a magia multicolorida da folia, concedendo os benefícios abaixo por 10 minutos ou até terminá-los (nenhuma ação necessária). Depois de usar esse recurso, você não poderá usá-lo novamente até terminar um Descanso Longo. Você também pode restaurar seu uso gastando um espaço de magia de nível 5 (nenhuma ação necessária).

Dano Extra. O dano extra da sua Aura de Fraternidade aumenta para 1d8.

Inspiração Heroica. No início de cada um dos seus turnos, você pode dar Inspiração Heroica a um aliado dentro da aura.

Imunidades. Você e seus aliados têm imunidade às condições Cego, Surdo, Exaustão e Envenenado enquanto estiverem na aura.

Martin Kirby-Jackson'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'arachnoid-stalker'),
  3,
  'Correia',
  'Você pode produzir magicamente teias de aranha pegajosas e sedosas com suas mãos como uma Ação Bônus. Esta teia se dissolve após 1 minuto. Ao criar as teias, você pode usá-las para executar uma das ações a seguir.

Puxe-se. Você projeta uma linha de teia em um ponto que pode ver a até 30 pés, puxando-se até esse ponto em linha reta sem provocar Ataques de Oportunidade. Você pode usar esse benefício como uma reação ao cair para se elevar até 10 pés em qualquer direção.

Manipular objetos. Você pode usar uma linha de teia para manipular um objeto que não esteja sendo usado ou carregado em um raio de 30 pés. Por exemplo, você pode puxar um objeto para sua mão, fechar uma porta ou pegar um objeto pequeno ou menor que pese menos de 10 libras.

Crie uma corda. Você cria uma corda de teia de 60 pés de comprimento e a ancora em um ponto de sua escolha.

Magia Teia. Você conjura Teia sem espaço de magia como parte da Ação Bônus usada para esse recurso (a CD é igual a 8 mais seu modificador de Destreza e seu Bônus de Proficiência). Quando você a conjura usando esse recurso, as teias preenchem um cubo de 5 pés e a duração da magia passa a ser de 1 minuto. Você pode conjurar esta magia usando este recurso duas vezes. Você recupera um uso gasto ao terminar um Descanso Curto e recupera todos os usos gastos ao terminar um Descanso Longo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'arachnoid-stalker'),
  3,
  'Golpe Venenoso',
  'Quando você causa dano Ataque Furtivo a uma criatura, você pode escolher que Ataque Furtivo cause d8s de dano Venenoso em vez de d6s do mesmo tipo causados ​​pela arma.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'arachnoid-stalker'),
  9,
  'Rastejando na parede',
  'Você se acostumou a se mover como uma aranha, o que lhe concede os seguintes benefícios.
Alpinista. Você ganha uma Velocidade de Escalada igual à sua Velocidade.

Escondendo-se nos tetos. Se você estiver no teto e levemente obscurecido, você pode realizar a ação Esconder-se enquanto qualquer inimigo que possa vê-lo estiver abaixo de você.

Escalada de aranha. Você pode mover-se para cima, para baixo e através de superfícies verticais e ao longo de tetos, deixando as mãos livres.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'arachnoid-stalker'),
  13,
  'Sentido de Aranha',
  'Quando você faz uma salvaguarda e sofre dano, você pode realizar uma Reação para usar sua Esquiva Sobrenatural, reduzindo pela metade o dano sofrido (arredondado para baixo).'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'arachnoid-stalker'),
  17,
  'Veneno Paralítico',
  'Você ganha a seguinte opção Ataque Astuto.

Paralisar (Custo: 4d6). Quando você causa dano Venenoso com seu Golpe Venenoso, o alvo deve ser bem sucedido em uma salvaguarda de Constituição ou ter a condição Paralisado até o final do seu próximo turno.

Lucas Ferreira CM'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'future-you-patron'),
  3,
  'Magias do futuro para você',
  'A magia do seu patrono garante que você sempre tenha certas magias prontas; quando você atinge um nível de Bruxo especificado na tabela Magias do Eu do Futuro, você sempre terá as magias listadas preparados. Novas magias são marcados com um asterisco (*).

Magias do futuro para você

Nível de Bruxo
Magias

3
Acelerar/Desacelerar,* Atrasar,* Aumentar a capacidade, Momento para pensar,* Relembrar

5
Proteção contra energia, lenta

7
Proteção da Morte, Aviso Terrível *

9
Conhecimento Lendário, Ligação Telepática

Além disso, efeitos estranhos persistem após a comunicação com o seu eu futuro. Você ganha uma das características da tabela Peculiaridades do Eu do Futuro.

Futuro, suas peculiaridades

d6
Peculiaridades

1
Muitas vezes você fala no tempo errado ou se refere a si mesmo no plural.

2
Às vezes você se refere a uma pessoa pelo nome antes dela se apresentar.

3
Você fica excessivamente calmo em circunstâncias terríveis.

4
Sob certas condições de iluminação, você parece muito mais velho do que é.

5
Ver certas pessoas vivas leva você instantaneamente às lágrimas.

6
Seu senso de moda futuro entra em conflito completamente com o de hoje.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'future-you-patron'),
  3,
  'Aconteceu assim',
  'Suas discussões sobre o futuro consigo mesmo lhe deram um conhecimento periférico sobre como os eventos acontecerão. Sempre que você termina um Descanso Curto ou Longo, o Mestre rola um d20 e um d4 em segredo e registra o número obtido no d20. O Mestre conta a você o lançamento do d20 registrado, a menos que ele tire um 4 no d4; nesse caso, eles mentem sobre o lançamento d20 registrado.

Lucas Ferreira CM

Você pode substituir qualquer Teste de D20 feito por você ou por uma criatura que você possa ver pela jogada d20 registrada (nenhuma ação é necessária). Você deve optar por fazer isso antes do lançamento. Se o Mestre mentiu sobre o teste, ele informará você sobre o teste real registrado do d20 somente depois que você substituir o teste por ele.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'future-you-patron'),
  6,
  'Eu poderia fazer com menos cicatrizes',
  'Seu eu futuro avisa sobre ataques específicos aos quais você deve estar atento. Quando uma criatura que você pode ver atinge você com uma jogada de ataque, você pode realizar uma Reação para ganhar um bônus de +10 em sua CA contra esse ataque, potencialmente fazendo com que ele erre.

Você pode usar esse recurso duas vezes. Você recupera um uso gasto ao terminar um Descanso Curto e recupera todos os usos gastos ao terminar um Descanso Longo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'future-you-patron'),
  10,
  'Espere uma emboscada',
  'Você tem Vantagem nas jogadas de Iniciativa e Resistência a todos os danos na primeira rodada de combate.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'future-you-patron'),
  14,
  'Paradoxo do Avô',
  'Como Ação Mágica, você pode incitar uma criatura a até 60 pés de você que possa ver ou ouvir você a causar um paradoxo. A criatura deve fazer uma salvaguarda de Inteligência contra sua CD de resistência de magia. Se falhar, a criatura sofre 10d6 de dano Psíquico e fica com a condição Atordoado por 1 minuto, pois está bloqueada entre linhas de tempo opostas. Em um teste bem-sucedido, o alvo sofre apenas metade do dano. A criatura Atordoado repete a salvaguarda no final de cada um de seus turnos, encerrando a condição em caso de sucesso.

Depois de usar esse recurso, você não poderá usá-lo novamente até terminar um Descanso Longo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;
