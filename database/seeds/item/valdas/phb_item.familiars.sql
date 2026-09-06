-- Seed Valdas Player Pack 2 familiars (as magic items)

INSERT INTO rpg.phb_item (
  slug, item_type, name, cost, weight, description, properties
)
VALUES (
  'flying-book',
  'other'::rpg.item_type,
  'Livro Voador',
  NULL,
  NULL,
  'Pouco se pode dizer sobre o livro voador que não seja imediatamente aparente. Embora seja indistinguível de um grimório de arcanista enquanto imóvel, este tomo arcano animado pode bater asas pelo ar a qualquer momento, usando a capa como asas rudimentares. Livros voadores são brincalhões e apreciam a sensação de serem escritos.

Livro Voador

Construto Minúsculo, Sem Alinhamento

CA 13 Iniciativa +4 (14)

PV 5 (2d4)

Deslocamento 0 pés, Voo 30 pés (pairar)

Mod
Salv.

FOR
3
-4
-4

DES
15
+2
+2

CON
11
+0
+0

Mod
Salv.

INT
1
-5
-5

SAB
4
-3
-3

CAR
1
-5
-5

Vulnerabilidades Ígneo

Imunidades Veneno, Psíquico; Cego, Enfeitiçado, Surdo, Amedrontado, Paralisado, Petrificado, Envenenado

Sentidos Visão às Cegas 30 pés; Percepção Passiva 7

Idiomas Nenhum

ND 1/8 (XP 25; BP +2)

Ações

Pancada. Jogada de Ataque Corpo a Corpo: +4, alcance 5 pés. Acerto: 4 (1d4 + 2) de dano Contundente.',
  '{"magic":true,"category":"Familiar","rarity":null,"rarityLabel":null,"requiresAttunement":false,"source":"valdas-spire-player-pack-2","editionSlug":"valdas-spire-2024-en","citationSlug":"valdas-spire-2024-en:player-pack-2"}'::jsonb
)
ON CONFLICT (slug) DO UPDATE SET
  item_type = EXCLUDED.item_type,
  name = EXCLUDED.name,
  cost = EXCLUDED.cost,
  weight = EXCLUDED.weight,
  description = EXCLUDED.description,
  properties = EXCLUDED.properties;

INSERT INTO rpg.phb_item (
  slug, item_type, name, cost, weight, description, properties
)
VALUES (
  'fright',
  'other'::rpg.item_type,
  'Susto',
  NULL,
  NULL,
  'Assombrações geralmente podem ser atribuídas aos suspeitos espectrais de sempre: fantasmas, espectros, sombras e poltergeists. Mas assombrações benignas, em que o espírito inquieto apenas prega peças nos vivos, costumam ser causadas por um Susto. Esses espíritos normalmente são resquícios de crianças ou artistas, apegados à vida após a morte em busca de companhia e de uma aparência de afeição, e por isso estão obcecados com diversão. Nunca prejudicam outros de propósito ao assombrar uma casa, e servirão a qualquer mestre que os invoque, nem que seja só pelo sentimento de inclusão.

Susto

Morto-vivo Pequeno, Caótico Maligno

CA 14 Iniciativa +2 (12)

PV 21 (6d6)

Deslocamento 0 pés, Voo 30 pés (pairar)

Mod
Salv.

FOR
1
-5
-5

DES
14
+2
+2

CON
10
+0
+0

Mod
Salv.

INT
10
+0
+0

SAB
9
–1
–1

CAR
15
+2
+2

Resistências Ácido, Gélido, Ígneo, Elétrico, Necrótico, Trovejante

Imunidades Veneno; Enfeitiçado, Exaustão, Agarrado, Paralisado, Petrificado, Envenenado, Caído, Contido, Inconsciente

Sentidos Visão no Escuro 60 pés; Percepção Passiva 9

Idiomas Comum mais um outro idioma

ND 1/2 (XP 100; BP +2)

Traços

Movimento Incorpóreo. O Susto pode se mover através de outras criaturas e objetos como se fossem Terreno Difícil. Sofre 5 (1d10) de dano Energético se terminar o turno dentro de um objeto.

Ações

Drenar Vida. Jogada de Ataque Corpo a Corpo: +4, alcance 5 pés. Acerto: 9 (2d8) de dano Necrótico. Se o alvo for uma criatura, seu máximo de Pontos de Vida diminui em uma quantidade igual ao dano sofrido.',
  '{"magic":true,"category":"Familiar","rarity":null,"rarityLabel":null,"requiresAttunement":false,"source":"valdas-spire-player-pack-2","editionSlug":"valdas-spire-2024-en","citationSlug":"valdas-spire-2024-en:player-pack-2"}'::jsonb
)
ON CONFLICT (slug) DO UPDATE SET
  item_type = EXCLUDED.item_type,
  name = EXCLUDED.name,
  cost = EXCLUDED.cost,
  weight = EXCLUDED.weight,
  description = EXCLUDED.description,
  properties = EXCLUDED.properties;

INSERT INTO rpg.phb_item (
  slug, item_type, name, cost, weight, description, properties
)
VALUES (
  'grep',
  'other'::rpg.item_type,
  'Grep',
  NULL,
  NULL,
  'Um grep é um catador subterrâneo, conhecido por usar visão aguçada, audição aguda e voo silencioso para enganar e roubar viajantes, acumulando seus bens em esconderijos bem ocultos. Arcanistas usam greps como mensageiros e batedores, mas eles se destacam como recuperadores; um grep pode receber o nome de um objeto importante e ser enviado para encontrá-lo, voltando pouco depois com o prêmio.

Grep

Monstruosidade Minúscula, Neutro

CA 14 Iniciativa +4 (14)

PV 21 (6d4 + 6)

Deslocamento 15 pés, Voo 50 pés

Mod
Salv.

FOR
3
-4
-4

DES
18
+4
+4

CON
13
+1
+1

Mod
Salv.

INT
13
+1
+1

SAB
15
+2
+2

CAR
10
+0
+0

Perícias Percepção +4, Prestidigitação +6, Furtividade +6

Sentidos Visão no Escuro 60 pés; Percepção Passiva 14

Idiomas Compreende Comum, mas não pode falar

ND 1/2 (XP 100; BP +2)

Traços

Mimetismo. O grep pode imitar sons simples que tenha ouvido, como um sussurro ou um chilrear. Um ouvinte pode discernir que os sons são imitações com um teste bem-sucedido de Sabedoria (Intuição) CD 10.

Ações

Garra. Jogada de Ataque Corpo a Corpo: +6, alcance 5 pés. Acerto: 7 (1d6 + 4) de dano Cortante.',
  '{"magic":true,"category":"Familiar","rarity":null,"rarityLabel":null,"requiresAttunement":false,"source":"valdas-spire-player-pack-2","editionSlug":"valdas-spire-2024-en","citationSlug":"valdas-spire-2024-en:player-pack-2"}'::jsonb
)
ON CONFLICT (slug) DO UPDATE SET
  item_type = EXCLUDED.item_type,
  name = EXCLUDED.name,
  cost = EXCLUDED.cost,
  weight = EXCLUDED.weight,
  description = EXCLUDED.description,
  properties = EXCLUDED.properties;

INSERT INTO rpg.phb_item (
  slug, item_type, name, cost, weight, description, properties
)
VALUES (
  'mock',
  'other'::rpg.item_type,
  'Mofa',
  NULL,
  NULL,
  'O parente diminuto do mímico, a Mofa é um metamorfo minúsculo que replica objetos pequenos e valiosos para atrair suas vítimas. No deserto, uma Mofa pode assumir a forma de um cantil de água preciosa, e em uma masmorra pode replicar uma gema volumosa ou uma Peça de Ouro sobressalente. Se um aventureiro for pego de surpresa, uma Mofa é tão perigosa quanto seus parentes maiores, pois pode se esconder em lugares bem menos evidentes.

Mofa

Monstruosidade Minúscula, Neutro

CA 11 Iniciativa +3 (13)

PV (2d4 + 4)

Deslocamento 20 pés

Mod
Salv.

FOR
9
-1
-1

DES
12
+1
+1

CON
14
+2
+2

Mod
Salv.

INT
4
-3
-3

SAB
13
+1
+1

CAR
6
-2
-2

Perícias Furtividade +5

Imunidades Ácido; Caído

Sentidos Visão no Escuro 60 pés; Percepção Passiva 11

Idiomas Nenhum

ND 1/8 (XP 25; BP +2)

Traços

Adesivo (Apenas Forma de Objeto). A Mofa adere a qualquer coisa que a toque. A Mofa tem Vantagem nas jogadas de ataque contra qualquer criatura aderida a ela. O alvo ou uma criatura a até 5 pés dela pode destacar a Mofa como uma ação.

Ações

Mordida. Jogada de Ataque Corpo a Corpo: +3, alcance 5 pés. Acerto: 3 (1d4 + 1) de dano Perfurante mais 2 (1d4) de dano Ácido.

Ações Bônus

Mudar de Forma. A Mofa muda de forma para se assemelhar a um objeto Minúsculo, mantendo suas estatísticas de jogo, ou retorna à sua verdadeira forma de massa amorfa. Qualquer equipamento que estiver vestindo ou carregando não é transformado.',
  '{"magic":true,"category":"Familiar","rarity":null,"rarityLabel":null,"requiresAttunement":false,"source":"valdas-spire-player-pack-2","editionSlug":"valdas-spire-2024-en","citationSlug":"valdas-spire-2024-en:player-pack-2"}'::jsonb
)
ON CONFLICT (slug) DO UPDATE SET
  item_type = EXCLUDED.item_type,
  name = EXCLUDED.name,
  cost = EXCLUDED.cost,
  weight = EXCLUDED.weight,
  description = EXCLUDED.description,
  properties = EXCLUDED.properties;

INSERT INTO rpg.phb_item (
  slug, item_type, name, cost, weight, description, properties
)
VALUES (
  'pet-rock',
  'other'::rpg.item_type,
  'Pedra de Estimação',
  NULL,
  NULL,
  'Amplamente considerada o familiar perfeito, não exigindo comida nem água e possuindo defesas naturais extremamente altas, uma pedra de estimação pode ser invocada pela maioria dos conjuradores. Embora não aja com nenhuma agilidade (de fato, não se move de forma alguma), pode ser uma arma formidável quando arremessada.

Pedra de Estimação

Elemental Minúsculo, Sem Alinhamento

CA 15 Iniciativa −5 (5)

PV 5 (1d4 + 3)

Deslocamento 0 pés

Mod
Salv.

FOR
1
-5
-5

DES
1
-5
-5

CON
16
+3
+3

Mod
Salv.

INT
1
-5
-5

SAB
5
-3
-3

CAR
1
-5
-5

Resistências Contundente, Ígneo, Elétrico, Perfurante, Radiante, Cortante

Imunidades Veneno, Psíquico; Enfeitiçado, Exaustão, Amedrontado, Paralisado, Envenenado, Caído, Inconsciente

Sentidos Percepção Passiva 7

Idiomas Compreende todos, mas não pode falar

ND 0 (XP 0; BP +2)

Traços

Apenas uma Pedra. A pedra conta como um objeto. Além disso, não pode realizar ações e seu Deslocamento não pode ser aumentado.',
  '{"magic":true,"category":"Familiar","rarity":null,"rarityLabel":null,"requiresAttunement":false,"source":"valdas-spire-player-pack-2","editionSlug":"valdas-spire-2024-en","citationSlug":"valdas-spire-2024-en:player-pack-2"}'::jsonb
)
ON CONFLICT (slug) DO UPDATE SET
  item_type = EXCLUDED.item_type,
  name = EXCLUDED.name,
  cost = EXCLUDED.cost,
  weight = EXCLUDED.weight,
  description = EXCLUDED.description,
  properties = EXCLUDED.properties;

INSERT INTO rpg.phb_item (
  slug, item_type, name, cost, weight, description, properties
)
VALUES (
  'winter-wolf-pup',
  'other'::rpg.item_type,
  'Filhote de Lobo Invernal',
  NULL,
  NULL,
  'Quando adulto, um lobo invernal é um predador de ápice da neve, um terror de dentes e pelagem, espreitando a tundra em matilhas. Mas antes de desenvolverem seu temível sopro congelante, os filhotes de lobo invernal são bem mais amigáveis (talvez porque ainda não tenham percebido a extensão do próprio poder) e seguirão fielmente um mestre que os alimente bem e os trate com respeito.

Filhote de Lobo Invernal

Monstruosidade Pequena, Neutro Maligno

CA 13 Iniciativa +1 (11)

PV 10 (3d6)

Deslocamento 30 pés

Mod
Salv.

FOR
9
-1
-1

DES
12
+1
+1

CON
11
+0
+0

Mod
Salv.

INT
6
-2
-2

SAB
12
+1
+1

CAR
7
-2
-2

Perícias Percepção +3, Furtividade +3

Resistências Gélido

Sentidos Percepção Passiva 13

Idiomas Comum, Gigante

ND 1/8 (XP 25; BP +2)

Traços

Táticas de Bando. O filhote tem Vantagem nas jogadas de ataque contra uma criatura se pelo menos um aliado do filhote estiver a até 5 pés da criatura e o aliado não tiver a condição Incapacitado.

Ações

Mordida. Jogada de Ataque Corpo a Corpo: +3, alcance 5 pés. Acerto: 3 (1d4 + 1) de dano Perfurante mais 2 (1d4) de dano Gélido.',
  '{"magic":true,"category":"Familiar","rarity":null,"rarityLabel":null,"requiresAttunement":false,"source":"valdas-spire-player-pack-2","editionSlug":"valdas-spire-2024-en","citationSlug":"valdas-spire-2024-en:player-pack-2"}'::jsonb
)
ON CONFLICT (slug) DO UPDATE SET
  item_type = EXCLUDED.item_type,
  name = EXCLUDED.name,
  cost = EXCLUDED.cost,
  weight = EXCLUDED.weight,
  description = EXCLUDED.description,
  properties = EXCLUDED.properties;

INSERT INTO rpg.phb_item (
  slug, item_type, name, cost, weight, description, properties
)
VALUES (
  'yarn-golem',
  'other'::rpg.item_type,
  'Golem de Fio',
  NULL,
  NULL,
  'Os maiores golems são formados de ferro, pedra e argila, mas os menores são construídos de fio. Enrolados e costurados em uma forma vagamente Humanoide, golems de fio estão entre os primeiros objetos animados que arcanistas aprendem a criar, praticando obsessivamente com eles até dominarem o básico e partirem para materiais mais rígidos. Golems de fio são amigáveis e brincalhões, mas correm o risco de se desenrolarem tolamente se se prenderem em objetos afiados.

Golem de Fio

Construto Minúsculo, Caótico Neutro

CA 13 Iniciativa +5 (15)

PV 21 (6d4 + 6)

Deslocamento 30 pés

Mod
Salv.

FOR
8
-1
-1

DES
16
+3
+3

CON
13
+1
+1

Mod
Salv.

INT
1
-5
-5

SAB
10
+0
+0

CAR
8
-1
-1

Resistências Perfurante

Imunidades Veneno, Psíquico; Envenenado

Sentidos Percepção Passiva 10

Idiomas Compreende Comum mais um outro idioma, mas não pode falar

ND 1/2 (XP 100; BP +2)

Ações

Cutucada. Jogada de Ataque Corpo a Corpo: +5, alcance 5 pés. Acerto: 8 (2d4 + 3) de dano Perfurante.

Emaranhar (Recarga 6). Salvaguarda de Destreza: CD 12, uma criatura que o golem possa ver a até 5 pés. Falha: Se o alvo for Médio ou menor, ele tem a condição Agarrado (CD de escape 12). Enquanto Agarrado, o alvo tem a condição Contido.',
  '{"magic":true,"category":"Familiar","rarity":null,"rarityLabel":null,"requiresAttunement":false,"source":"valdas-spire-player-pack-2","editionSlug":"valdas-spire-2024-en","citationSlug":"valdas-spire-2024-en:player-pack-2"}'::jsonb
)
ON CONFLICT (slug) DO UPDATE SET
  item_type = EXCLUDED.item_type,
  name = EXCLUDED.name,
  cost = EXCLUDED.cost,
  weight = EXCLUDED.weight,
  description = EXCLUDED.description,
  properties = EXCLUDED.properties;
