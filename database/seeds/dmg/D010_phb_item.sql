-- Seed DMG 2024 — Itens Mágicos A–Z (Cap. 7)
-- Gerado por docs/source/generate-dmg-item-seeds.mjs — não editar à mão
-- Fonte: comunidade DMG 2024 PT; 338 itens

INSERT INTO rpg.phb_item (
  slug, item_type, name, cost, weight, description, properties
)
VALUES (
  'adaga-peconhenta',
  'weapon'::rpg.item_type,
  'Adaga Peçonhenta',
  NULL,
  NULL,
  'Você adquire um bônus de +1 em jogadas de ataque e dano realizadas com esta arma mágica.
Você pode executar uma Ação Bônus para revestir magicamente a lâmina com veneno. O veneno permanece por 1 minuto ou até que um ataque usando esta arma atinja uma criatura. Essa criatura deve ser bem-sucedida em uma salvaguarda de Constituição CD 15 ou sofre 2d10 pontos de dano Venenoso e tem a condição Envenenado por 1 minuto. A arma não pode ser usada deste modo novamente até o próximo amanhecer.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Arma (Adaga)","rarity":"rare","rarityLabel":"Raro","requiresAttunement":false,"header":"Arma (Adaga), Raro","weaponSubtype":"Adaga"}'::jsonb
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
  'alaude-de-batidas-estrondosas',
  'weapon'::rpg.item_type,
  'Alaúde de Batidas Estrondosas',
  NULL,
  NULL,
  'Este alaúde reforçado pode ser empunhado como uma Clava mágica que causa 2d8 pontos de dano Trovejante adicionais ao acertar.
Cante e Golpeie. Se você for um Bardo, pode usar seu modificador de Carisma em vez do modificador de Força ao realizar uma jogada de ataque corpo a corpo com o alaúde, desde que esteja cantando ou cantarolando durante o ataque.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Arma (Clava)","rarity":"very-rare","rarityLabel":"Muito Raro","requiresAttunement":false,"header":"Arma (Clava), Muito Raro","weaponSubtype":"Clava"}'::jsonb
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
  'aljava-de-ehlonna',
  'other'::rpg.item_type,
  'Aljava de Ehlonna',
  NULL,
  NULL,
  'Cada um dos três compartimentos dessa aljava conecta-se a um espaço extradimensional que permite armazenar inúmeros itens sem pesar mais de 1 quilo. O compartimento mais curto pode conter até 60 Flechas, Virotes ou objetos similares. O compartimento médio comporta até 18 Azagaias ou objetos similares. O compartimento mais longo pode armazenar até 6 objetos longos, como arcos, Cajados ou Lanças.
Você pode sacar qualquer item da aljava como se estivesse pegando de uma aljava ou bainha comum.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"uncommon","rarityLabel":"Incomum","requiresAttunement":false,"header":"Item Maravilhoso, Incomum"}'::jsonb
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
  'amuleto-da-estilha-negra',
  'other'::rpg.item_type,
  'Amuleto da Estilha Negra',
  NULL,
  NULL,
  'Este amuleto é formado a partir de um fragmento de material resiliente originário de um reino de outro mundo. Enquanto estiver usando-o, você adquire os seguintes benefícios.
Foco de Conjuração. Você pode usar o amuleto como um Foco de Conjuração para suas magias de Bruxo.
Magia Desconhecida. Como uma ação Usar Magia, você pode tentar conjurar um truque que não conhece. O truque deve estar na lista de magias do Bruxo e ter um tempo de conjuração de uma ação e você realiza um teste de Inteligência (Arcanismo) CD 10. Em caso de sucesso, você conjura a magia. Se falhar, a magia falha e a ação usada para conjurá-la é desperdiçada. Em ambos os casos, você não pode usar esta propriedade novamente até completar um Descanso Longo.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"common","rarityLabel":"Comum","requiresAttunement":true,"header":"Item Maravilhoso, Comum (Requer Sintonização por um Bruxo)","attunement":"Requer Sintonização por um Bruxo"}'::jsonb
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
  'amuleto-da-saude',
  'other'::rpg.item_type,
  'Amuleto da Saúde',
  NULL,
  NULL,
  'Sua Constituição é 19 enquanto usar este amuleto; se já for 19 ou superior, ele não tem efeito.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"rare","rarityLabel":"Raro","requiresAttunement":true,"header":"Item Maravilhoso, Raro (Requer Sintonização)","attunement":"Requer Sintonização"}'::jsonb
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
  'amuleto-de-protecao-contra-deteccao-e-localizacao',
  'other'::rpg.item_type,
  'Amuleto de Proteção Contra Detecção e Localização',
  NULL,
  NULL,
  'Enquanto estiver usando este amuleto, você fica oculto aos efeitos de magias de Adivinhação. Você não pode ser alvo de tais magias ou ser percebido por sensores mágicos de vidência.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"uncommon","rarityLabel":"Incomum","requiresAttunement":true,"header":"Item Maravilhoso, Incomum (Requer Sintonização)","attunement":"Requer Sintonização"}'::jsonb
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
  'amuleto-mecanico',
  'other'::rpg.item_type,
  'Amuleto Mecânico',
  NULL,
  NULL,
  'Este amuleto de cobre contém pequenas engrenagens interligadas e funciona com a magia de Mecânos, um plano de precisão mecânica. Ruídos fracos de tique-taque e zumbidos emanam vindos de dentro.
Ao realizar uma jogada de ataque enquanto utiliza o amuleto, você pode usar um 10 em vez de jogar um d20. Uma vez usada, esta propriedade não pode ser usada novamente até o próximo amanhecer.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"common","rarityLabel":"Comum","requiresAttunement":false,"header":"Item Maravilhoso, Comum"}'::jsonb
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
  'amuleto-planar',
  'other'::rpg.item_type,
  'Amuleto Planar',
  NULL,
  NULL,
  'Enquanto estiver usando este amuleto, você pode executar uma ação Usar Magia para nomear um local em outro plano de existência com o qual esteja familiarizado. Em seguida, realize um teste de Inteligência (Arcanismo) CD 15. Em caso de sucesso, você conjura Transição Planar. Se falhar, você e cada criatura e objeto em um raio de 4,5 metros viajam para um destino aleatório determinado ao jogar 1d100, conforme a tabela a seguir.
1d100
	Destino
	01-60
	Local aleatório no plano nomeado
	61-70
	Localização aleatória em um Plano Interno determinada pela jogada de 1d6: em um 1, o Plano do Ar; em um 2, o Plano da Terra; em um 3, o Plano do Fogo; em um 4, o Plano da Água; em um 5, Faéria; em um 6, o Sombral
	71-80
	Localização aleatória em um Plano Externo determinada pela jogada de 1d8: em um 1, Arbórea; em um 2, Arcádia; em um 3, as Terras Ferais; em um 4, Bitopia; em um 5, Elísio; em um 6, Mecânos; em um 7, Monte Celéstia; em um 8, Ysgard
	81-90
	Localização aleatória em um Plano Externo determinada pela jogada de 1d8: em um 1, o Abismo; em um 2, Aqueronte; em um 3, Cárceri; em um 4, Gehenna; em um 5, Hades; em um 6, Limbo; em um 7, os Nove Infernos; em um 8, Pandemônio
	91-100
	Local aleatório no Plano Astral',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"very-rare","rarityLabel":"Muito Raro","requiresAttunement":true,"header":"Item Maravilhoso, Muito Raro (Requer Sintonização)","attunement":"Requer Sintonização"}'::jsonb
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
  'anel-afastador-de-magias',
  'other'::rpg.item_type,
  'Anel Afastador de Magias',
  NULL,
  NULL,
  'Enquanto estiver usando este anel, você tem Vantagem em salvaguardas contra magias. Se você for bem-sucedido na salvaguarda contra uma magia de 7º círculo ou inferior, a magia não tem efeito sobre você. Se essa magia teve apenas você como alvo e não cria uma área de efeito, você pode executar uma Reação para desviar a magia de volta para o conjurador; o conjurador deve realizar uma salvaguarda contra a magia usando sua própria CD para evitar magia.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Anel","rarity":"legendary","rarityLabel":"Lendário","requiresAttunement":true,"header":"Anel, Lendário (Requer Sintonização)","attunement":"Requer Sintonização"}'::jsonb
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
  'anel-armazenador-de-magias',
  'other'::rpg.item_type,
  'Anel Armazenador de Magias',
  NULL,
  NULL,
  'Este anel armazena magias conjuradas nele, contendo-as até que o usuário sintonizado as use. O anel pode armazenar até 5 círculos de magias de cada vez. Quando encontrado, o anel contém 1d6 -1 círculos de magias armazenadas escolhidas pelo Mestre.
Qualquer criatura pode conjurar uma magia de 1º a 5º círculo no anel ao tocá-lo no momento em que a magia é conjurada. A magia não tem efeito, exceto por ser armazenada no anel. Se o anel não puder conter a magia, esta é gasta sem efeito. O círculo de espaço utilizado para conjurar a magia determina quanto espaço ela ocupa.
Enquanto está usando o anel, você pode conjurar qualquer magia que esteja armazenada nele. A magia utiliza o círculo de espaço, CD para evitar, bônus de ataque mágico e atributo de conjuração do conjurador original, mas é considerada como se você a estivesse conjurando. A magia conjurada do anel não está mais armazenada nele, liberando espaço.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Anel","rarity":"rare","rarityLabel":"Raro","requiresAttunement":true,"header":"Anel, Raro (Requer Sintonização)","attunement":"Requer Sintonização"}'::jsonb
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
  'anel-da-livre-movimentacao',
  'other'::rpg.item_type,
  'Anel da Livre Movimentação',
  NULL,
  NULL,
  'Enquanto estiver usando este anel, Terreno Difícil não custa movimento adicional a você. Além disso, a magia não pode reduzir nenhum de seus Deslocamentos nem impor a condição Contido ou Paralisado a você.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Anel","rarity":"rare","rarityLabel":"Raro","requiresAttunement":true,"header":"Anel, Raro (Requer Sintonização)","attunement":"Requer Sintonização"}'::jsonb
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
  'anel-das-estrelas-cadentes',
  'other'::rpg.item_type,
  'Anel das Estrelas Cadentes',
  NULL,
  NULL,
  'Você pode conjurar Luzes Dançantes ou Luz a partir do anel.
O anel tem 6 cargas e recupera 1d6 cargas gastas diariamente ao amanhecer. Você pode gastar as cargas do anel para usar as propriedades abaixo.
Esferas de Relâmpago. Você pode gastar 2 cargas como uma ação Usar Magia para criar até quatro esferas de relâmpago de 90 centímetros de diâmetro.
Cada esfera aparece em um espaço desocupado à sua vista a até 36 metros de distância. As esferas permanecem enquanto você mantiver a Concentração, até 1 minuto. Cada esfera projeta Meia-luz em um raio de 9 metros.
Com uma Ação Bônus, você pode mover cada esfera até 9 metros a até 36 metros de si. Na primeira vez que a esfera chegar a 1,5 metro de uma criatura diferente de você que não esteja atrás de uma Cobertura Total, a esfera descarrega um raio naquela criatura e desaparece. Essa criatura realiza uma salvaguarda de Destreza CD 15. Se falhar, a criatura sofre dano Elétrico com base no número de esferas que você criou, conforme mostrado na tabela a seguir. Em caso de sucesso, a criatura sofre metade do dano.
Número de Esferas
	Dano Elétrico
	1
	4d12
	2
	5d4
	3
	2d6
	4
	2d4
	Estrelas Cadentes. Você pode gastar de 1 a 3 cargas como uma ação Usar Magia. Para cada carga gasta, você lança uma partícula brilhante de luz a partir do anel em um ponto à sua vista a até 18 metros de distância. Cada criatura em um Cubo de 4,5 metros de lado originado desse ponto recebe uma chuva de faíscas e realiza uma salvaguarda de Destreza CD 15, sofrendo 5d4 pontos de dano Radiante se falhar, ou metade desse dano em caso de sucesso.
Fogo das Fadas. Você pode gastar 1 carga para conjurar Fogo das Fadas a partir do anel.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Anel","rarity":"very-rare","rarityLabel":"Muito Raro","requiresAttunement":true,"header":"Anel, Muito Raro (Requer Sintonização)","attunement":"Requer Sintonização"}'::jsonb
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
  'anel-de-andar-sobre-as-aguas',
  'other'::rpg.item_type,
  'Anel de Andar Sobre as Águas',
  NULL,
  NULL,
  'Enquanto estiver usando este anel, você conjura Caminhar Sobre as Águas a partir dele, tendo apenas você como alvo.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Anel","rarity":"uncommon","rarityLabel":"Incomum","requiresAttunement":false,"header":"Anel, Incomum"}'::jsonb
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
  'anel-de-aquecimento',
  'other'::rpg.item_type,
  'Anel de Aquecimento',
  NULL,
  NULL,
  'Se você sofrer dano Gélido enquanto estiver usando este anel, o anel reduz o dano sofrido em 2d8.
Além disso, enquanto estiver usando este anel, você e tudo o que você usa e carrega não serão prejudicados por temperaturas de -18 graus Celsius ou menos.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Anel","rarity":"uncommon","rarityLabel":"Incomum","requiresAttunement":true,"header":"Anel, Incomum (Requer Sintonização)","attunement":"Requer Sintonização"}'::jsonb
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
  'anel-de-ariete',
  'other'::rpg.item_type,
  'Anel de Aríete',
  NULL,
  NULL,
  'Este anel tem 3 cargas e recupera 1d3 cargas gastas diariamente ao amanhecer. Enquanto estiver usando o anel, você pode executar uma ação Usar Magia para gastar de 1 a 3 cargas para fazer um ataque mágico à distância contra uma criatura à sua vista a até 18 metros de distância. O anel produz a cabeça de um carneiro espectral e realiza sua jogada de ataque com um bônus de +7. Em um acerto, para cada carga que você gasta, o alvo sofre 2d10 pontos de dano Energético e é empurrado 1,5 metro para longe de você.
Como alternativa, você pode gastar de 1 a 3 das cargas do anel como uma ação Usar Magia para tentar quebrar um objeto não mágico à sua vista a até 18 metros de distância e que não esteja sendo usado ou carregado. O anel realiza um teste de Força com um bônus de +5 para cada carga gasta.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Anel","rarity":"rare","rarityLabel":"Raro","requiresAttunement":true,"header":"Anel, Raro (Requer Sintonização)","attunement":"Requer Sintonização"}'::jsonb
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
  'anel-de-comando-elemental',
  'other'::rpg.item_type,
  'Anel de Comando Elemental',
  NULL,
  NULL,
  'Cada Anel de Comando Elemental está ligado a um dos quatro Planos Elementais. O Mestre escolhe ou determina aleatoriamente o plano ao qual o anel está ligado. Por exemplo, um Anel de Comando Elemental (ar) está ligado ao Plano Elemental do Ar.
Cada Anel de Comando Elemental tem as duas propriedades a seguir:
Compulsão Elemental. Enquanto estiver usando o anel, você pode executar uma ação Usar Magia para tentar obrigar um Elemental à sua vista a até 18 metros de distância. O Elemental realiza uma salvaguarda de Sabedoria CD 18. Se falhar, o Elemental tem a condição Encantado até o início do seu próximo turno, e você determina o que ele executa com o movimento e ação dele no próximo turno dele.
Destruição Elemental. Enquanto estiver usando o anel, você tem Vantagem em jogadas de ataque contra Elementais e eles têm Desvantagem em jogadas de ataque contra você.
Foco Elemental. Enquanto estiver usando o anel, você se beneficia de propriedades adicionais correspondentes ao Plano Elemental ligado ao anel:
Água. Você conhece o idioma Aquan, adquire Deslocamento de Natação de 18 metros e pode respirar debaixo d’água.
Ar. Você conhece o idioma Auran, tem Resistência a dano Elétrico, Deslocamento de Voo igual ao seu Deslocamento e pode pairar.
Fogo. Você conhece o idioma Ignan e tem Imunidade a dano Ígneo.
Terra. Você conhece o idioma Terran e tem Resistência a dano Ácido. Terrenos compostos por escombros, pedras ou terra não são Terreno Difícil para você. Além disso, você pode se mover pela terra sólida ou rocha como se essas áreas fossem Terreno Difícil sem perturbar a matéria pela qual você passa. Ao terminar seu turno em terra sólida ou rocha, você é desviado para o espaço desocupado mais próximo que ocupou pela última vez.
Conjuração. O anel possui 5 cargas e recupera 1d4 + 1 cargas gastas diariamente ao amanhecer. Enquanto estiver usando o anel, você pode conjurar uma magia a partir dele. Escolha a magia da lista de magias disponíveis com base no Plano Elemental ao qual o anel está vinculado, conforme mostrado na tabela a seguir. A tabela indica quantas cargas você deve gastar para conjurar a magia, que possui CD 18 para evitar.
Plano
	Magias (Cargas)
	Água
	Caminhar Sobre as Águas (2 cargas), Criar ou Destruir Água (1 carga), Muralha de Gelo (3 cargas), Tempestade Glacial (2 cargas), Tsunami (5 cargas)
	Ar
	Corrente de Relâmpagos (3 cargas), Lufada de Vento (2 cargas), Muralha de Vento (1 carga), Queda Suave (0 cargas)
	Fogo
	Bola de Fogo (2 cargas), Mãos Flamejantes (1 carga), Muralha de Fogo (3 cargas), Tempestade de Fogo (4 cargas)
	Terra
	Moldar Rochas (2 cargas), Muralha de Pedra (3 cargas), Pele-Rocha (3 cargas), Terremoto (5 cargas)',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Anel","rarity":"legendary","rarityLabel":"Lendário","requiresAttunement":true,"header":"Anel, Lendário (Requer Sintonização)","attunement":"Requer Sintonização"}'::jsonb
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
  'anel-de-escudo-mental',
  'other'::rpg.item_type,
  'Anel de Escudo Mental',
  NULL,
  NULL,
  'Enquanto estiver usando este anel, você é imune à magia que permite que outras criaturas leiam seus pensamentos, determinem se você está mentindo, conheçam seu alinhamento ou conheçam seu tipo de criatura. As criaturas só podem se comunicar telepaticamente com você se você permitir.
Você pode executar uma ação Usar Magia para fazer com que o anel se torne imperceptível até executar outra ação Usar Magia para torná-lo perceptível, até remover o anel ou até você morrer.
Se você morrer enquanto estiver usando o anel, sua alma entra nele, a menos que ele já abrigue uma alma. Você pode permanecer no anel ou partir para a pós-vida. Enquanto sua alma estiver no anel, você pode se comunicar telepaticamente com qualquer criatura que o use. Um usuário não pode impedir essa comunicação telepática.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Anel","rarity":"uncommon","rarityLabel":"Incomum","requiresAttunement":true,"header":"Anel, Incomum (Requer Sintonização)","attunement":"Requer Sintonização"}'::jsonb
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
  'anel-de-evasao',
  'other'::rpg.item_type,
  'Anel de Evasão',
  NULL,
  NULL,
  'Este anel tem 3 cargas e recupera 1d3 cargas gastas diariamente ao amanhecer. Ao falhar em uma salvaguarda de Destreza enquanto estiver usando o anel, você pode executar uma Reação para gastar 1 carga para ser bem-sucedido nessa salvaguarda.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Anel","rarity":"rare","rarityLabel":"Raro","requiresAttunement":true,"header":"Anel, Raro (Requer Sintonização)","attunement":"Requer Sintonização"}'::jsonb
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
  'anel-de-influenciar-animais',
  'other'::rpg.item_type,
  'Anel de Influenciar Animais',
  NULL,
  NULL,
  'Este anel possui 3 cargas e recupera 1d3 cargas gastas diariamente ao amanhecer. Enquanto estiver usando o anel, você pode gastar 1 carga para conjurar uma das seguintes magias (CD 13 para evitar):
● Amizade Animal
● Falar com Animais
● Medo (afeta apenas Feras)',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Anel","rarity":"rare","rarityLabel":"Raro","requiresAttunement":false,"header":"Anel, Raro"}'::jsonb
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
  'anel-de-invisibilidade',
  'other'::rpg.item_type,
  'Anel de Invisibilidade',
  NULL,
  NULL,
  'Enquanto estiver usando este anel, você pode executar uma ação Usar Magia para adquirir a condição Invisível. Você permanece Invisível até que o anel seja removido ou até que você execute uma Ação Bônus para se tornar visível novamente.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Anel","rarity":"legendary","rarityLabel":"Lendário","requiresAttunement":true,"header":"Anel, Lendário (Requer Sintonização)","attunement":"Requer Sintonização"}'::jsonb
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
  'anel-de-invocar-djinni',
  'other'::rpg.item_type,
  'Anel de Invocar Djinni',
  NULL,
  NULL,
  'Enquanto estiver usando este anel, você pode executar uma ação Usar Magia para invocar um determinado Djinni do Plano Elemental do Ar. O djinni aparece em um espaço desocupado à sua escolha a até 36 metros de você. Ele permanece enquanto você mantiver a Concentração, até um máximo de 1 hora, ou até que você tenha seus Pontos de Vida reduzidos a 0.
Enquanto estiver invocado, o djinni é Amigável a você e seus aliados, obedecendo aos seus comandos. Se você não der comandos, o djinni se defende contra quem o atacar, mas não executa nenhuma outra ação.
Após o djinni partir, ele não pode ser invocado novamente por 24 horas, e o anel deixa de ser mágico se o djinni morrer.
Anéis de Invocar Djinni são frequentemente fabricados pelos próprios djinn invocados e dados a mortais como presentes de amizade ou símbolos de apreço.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Anel","rarity":"legendary","rarityLabel":"Lendário","requiresAttunement":true,"header":"Anel, Lendário (Requer Sintonização)","attunement":"Requer Sintonização"}'::jsonb
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
  'anel-de-natacao',
  'other'::rpg.item_type,
  'Anel de Natação',
  NULL,
  NULL,
  'Você tem um Deslocamento de Natação de 12 metros enquanto estiver usando este anel.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Anel","rarity":"uncommon","rarityLabel":"Incomum","requiresAttunement":false,"header":"Anel, Incomum"}'::jsonb
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
  'anel-de-protecao',
  'other'::rpg.item_type,
  'Anel de Proteção',
  NULL,
  NULL,
  'Você recebe um bônus de +1 na Classe de Armadura e em salvaguardas enquanto estiver usando este anel.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Anel","rarity":"rare","rarityLabel":"Raro","requiresAttunement":true,"header":"Anel, Raro (Requer Sintonização)","attunement":"Requer Sintonização"}'::jsonb
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
  'anel-de-queda-suave',
  'other'::rpg.item_type,
  'Anel de Queda Suave',
  NULL,
  NULL,
  'Ao cair enquanto usa este anel, você desce 18 metros por rodada e não sofre dano devido à queda.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Anel","rarity":"rare","rarityLabel":"Raro","requiresAttunement":true,"header":"Anel, Raro (Requer Sintonização)","attunement":"Requer Sintonização"}'::jsonb
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
  'anel-de-regeneracao',
  'other'::rpg.item_type,
  'Anel de Regeneração',
  NULL,
  NULL,
  'Enquanto estiver usando este anel, você recupera 1d6 Pontos de Vida a cada 10 minutos se tiver pelo menos 1 Ponto de Vida. Se você perder uma parte do corpo, o anel faz com que a parte perdida volte a crescer e retorne à funcionalidade total após 1d6 + 1 dias se você tiver pelo menos 1 Ponto de Vida durante todo esse tempo.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Anel","rarity":"very-rare","rarityLabel":"Muito Raro","requiresAttunement":true,"header":"Anel, Muito Raro (Requer Sintonização)","attunement":"Requer Sintonização"}'::jsonb
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
  'anel-de-resistencia',
  'other'::rpg.item_type,
  'Anel de Resistência',
  NULL,
  NULL,
  'Você tem Resistência a um tipo de dano ao usar este anel. A pedra preciosa no anel indica o tipo de dano, que o Mestre escolhe ou determina aleatoriamente ao jogar na tabela a seguir.
1d10
	Tipo de Dano
	Pedra Preciosa
	1
	Ácido
	Pérola
	2
	Gélido
	Turmalina
	3
	Ígneo
	Granada
	4
	Energético
	Safira
	5
	Elétrico
	Citrino
	6
	Necrótico
	Azeviche
	7
	Venenoso
	Ametista
	8
	Psíquico
	Jade
	9
	Radiante
	Topázio
	10
	Trovejante
	Espinela
	Anel de Resistência: Tipo de Dano e Pedra Preciosa',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Anel","rarity":"rare","rarityLabel":"Raro","requiresAttunement":false,"header":"Anel, Raro"}'::jsonb
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
  'anel-de-saltar',
  'other'::rpg.item_type,
  'Anel de Saltar',
  NULL,
  NULL,
  'Enquanto estiver usando este anel, você pode conjurar Salto a partir dele, mas só pode escolher a si mesmo como alvo quando o fizer.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Anel","rarity":"uncommon","rarityLabel":"Incomum","requiresAttunement":true,"header":"Anel, Incomum (Requer Sintonização)","attunement":"Requer Sintonização"}'::jsonb
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
  'anel-de-telecinese',
  'other'::rpg.item_type,
  'Anel de Telecinese',
  NULL,
  NULL,
  'Enquanto estiver usando este anel, você pode conjurar Telecinese a partir dele.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Anel","rarity":"very-rare","rarityLabel":"Muito Raro","requiresAttunement":true,"header":"Anel, Muito Raro (Requer Sintonização)","attunement":"Requer Sintonização"}'::jsonb
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
  'anel-de-visao-de-raio-x',
  'other'::rpg.item_type,
  'Anel de Visão de Raio-X',
  NULL,
  NULL,
  'Enquanto estiver usando este anel, você pode executar uma ação Usar Magia para adquirir visão de raio-X com alcance de 9 metros por 1 minuto. Para você, objetos sólidos dentro desse raio aparecem transparentes e não impedem que a luz passe por eles. A visão pode penetrar 30 centímetros de pedra, 2,5 centímetros de metal comum ou até 90 centímetros de madeira ou terra. Substâncias mais espessas ou uma fina camada de chumbo bloqueiam a visão.
Sempre que usar o anel novamente antes de fazer um Descanso Longo, você deve ser bem-sucedido em uma salvaguarda de Constituição CD 15 ou adquire 1 nível de Exaustão.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Anel","rarity":"rare","rarityLabel":"Raro","requiresAttunement":true,"header":"Anel, Raro (Requer Sintonização)","attunement":"Requer Sintonização"}'::jsonb
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
  'anel-dos-tres-desejos',
  'other'::rpg.item_type,
  'Anel dos Três Desejos',
  NULL,
  NULL,
  'Enquanto estiver usando este anel, você pode gastar 1 de suas 3 cargas para conjurar Desejo a partir dele. O anel se torna não mágico quando você usa a última carga.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Anel","rarity":"legendary","rarityLabel":"Lendário","requiresAttunement":false,"header":"Anel, Lendário"}'::jsonb
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
  'arco-de-energia',
  'weapon'::rpg.item_type,
  'Arco de Energia',
  NULL,
  NULL,
  'Você adquire um bônus de +1 nas jogadas de ataque e dano realizadas com esta arma mágica, que não possui corda. Sempre que você faz o movimento de disparar puxando o braço para trás, uma flecha mágica feita de energia dourada aparece encaixada e pronta para ser disparada. Uma flecha criada por esta arma causa dano Energético em vez de dano Perfurante ao acertar, e desaparece após acertar ou errar o alvo. Até desaparecer, a flecha emite Luz Plena em um raio de 6 metros e Meia-luz por mais 6 metros.
Esta arma tem as seguintes propriedades adicionais.
Flecha de Contenção. Sempre que você usar esta arma para realizar um ataque à distância contra uma criatura, você pode tentar conter o alvo em vez de causar dano a ele. Se a flecha acertar, o alvo deve ser bem-sucedido em uma salvaguarda de Força CD 15 ou tem a condição Contido por 1 minuto. Como uma ação, uma criatura Contida por uma flecha pode realizar um teste de Força (Atletismo) CD 20 para tentar se livrar da condição Contido, encerrando o efeito em si em caso de sucesso.
Flecha de Transporte. Como uma ação Usar Magia, você pode disparar uma flecha de energia desta arma em um alvo à sua vista a até 18 metros. O alvo pode ser uma criatura voluntária Média ou menor, ou um objeto que não esteja sendo usado ou carregado, desde que o objeto seja pequeno o suficiente para caber em um Cubo de 1,5 metro de lados. A flecha teleporta o alvo para um espaço desocupado à sua vista a até 3 metros de você.
Escada de Energia. Como uma ação Usar Magia, você pode liberar uma torrente de flechas de energia desta arma em uma parede a até 18 metros de distância de você. As flechas se transformam em degraus brilhantes que se projetam para fora da parede, formando uma escada mágica de até 18 metros de comprimento na parede. Esta escada permanece por 1 minuto antes de desaparecer.
Hank Prepara Seu Arco de Energia',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Arma (Arco Curto ou Arco Longo)","rarity":"very-rare","rarityLabel":"Muito Raro","requiresAttunement":true,"header":"Arma (Arco Curto ou Arco Longo), Muito Raro (Requer Sintonização)","attunement":"Requer Sintonização","weaponSubtype":"Arco Curto ou Arco Longo"}'::jsonb
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
  'arco-do-juramento',
  'weapon'::rpg.item_type,
  'Arco do Juramento',
  NULL,
  NULL,
  'Ao colocar uma flecha neste arco, ele sussurra em Élfico: “Célere derrota aos meus inimigos”. Ao usar esta arma para um ataque à distância, você pode proferir ou designar as seguintes palavras de comando: “Morte rápida àquele que me feriu”. O alvo do seu ataque se torna seu inimigo jurado até morrer ou até o amanhecer 7 dias depois. Você pode ter apenas um desses inimigos jurados por vez. Quando seu inimigo jurado morre, você pode escolher um novo após o próximo amanhecer.
Ao realizar uma jogada de ataque à distância com esta arma contra seu inimigo jurado, você tem Vantagem na jogada. Além disso, seu alvo não recebe nenhum benefício de Cobertura Parcial ou Cobertura de Três Quartos, e você não sofre Desvantagem devido ao alcance máximo. Se o ataque acertar, seu inimigo jurado sofre 3d6 pontos de dano Perfurante adicionais.
Enquanto seu inimigo jurado viver, você tem Desvantagem em jogadas de ataque com todas as outras armas.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Arma (Arco Curto ou Arco Longo)","rarity":"very-rare","rarityLabel":"Muito Raro","requiresAttunement":true,"header":"Arma (Arco Curto ou Arco Longo), Muito Raro (Requer Sintonização)","attunement":"Requer Sintonização","weaponSubtype":"Arco Curto ou Arco Longo"}'::jsonb
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
  'arma-de-adamantina',
  'weapon'::rpg.item_type,
  'Arma de Adamantina',
  NULL,
  NULL,
  'Esta arma ou munição, feita de adamantina, uma das substâncias mais duras existentes, causa um Acerto Crítico ao atingir um objeto.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Arma (Qualquer Munição ou Arma Corpo a Corpo)","rarity":"uncommon","rarityLabel":"Incomum","requiresAttunement":false,"header":"Arma (Qualquer Munição ou Arma Corpo a Corpo), Incomum","weaponSubtype":"Qualquer Munição ou Arma Corpo a Corpo"}'::jsonb
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
  'arma-de-prata',
  'weapon'::rpg.item_type,
  'Arma de Prata',
  NULL,
  NULL,
  'Um processo alquímico uniu prata a esta arma mágica. Ao obter um Acerto Crítico com ela contra uma criatura que está multimorfada, a arma causa um dado adicional de dano.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Arma (Qualquer Simples ou Marcial)","rarity":"common","rarityLabel":"Comum","requiresAttunement":false,"header":"Arma (Qualquer Simples ou Marcial), Comum","weaponSubtype":"Qualquer Simples ou Marcial"}'::jsonb
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
  'arma-implacavel',
  'weapon'::rpg.item_type,
  'Arma Implacável',
  NULL,
  NULL,
  'Esta arma mágica causa 2d6 pontos de dano adicionais a qualquer criatura atingida. Este dano adicional é do mesmo tipo do dano normal da arma.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Arma (Qualquer Simples ou Marcial)","rarity":"rare","rarityLabel":"Raro","requiresAttunement":false,"header":"Arma (Qualquer Simples ou Marcial), Raro","weaponSubtype":"Qualquer Simples ou Marcial"}'::jsonb
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
  'arma-magificada',
  'weapon'::rpg.item_type,
  'Arma Magificada',
  NULL,
  NULL,
  'Esta arma contém uma magia de 8º círculo ou inferior vinculada a ela. A magia é determinada no momento em que a arma é criada e deve pertencer a uma escola de magia entre Adivinhação, Evocação, Invocação, Necromancia ou Transmutação. A arma possui 6 cargas e recupera 1d6 cargas gastas diariamente ao amanhecer. Enquanto estiver segurando a arma, você pode gastar 1 carga para conjurar a magia vinculada a ela.
O círculo da magia vinculada à arma determina a CD da salvaguarda da magia, o bônus de ataque e a raridade da arma, conforme mostrado na tabela a seguir.
Círculo de Magia
	Raridade
	CD da Salvaguarda
	Bônus de Ataque
	Truque
	Incomum
	13
	+5
	1
	Incomum
	13
	+5
	2
	Raro
	13
	+5
	3
	Raro
	15
	+7
	4
	Muito Raro
	15
	+7
	5
	Muito Raro
	17
	+9
	6
	Lendário
	17
	+9
	7
	Lendário
	18
	+10
	8
	Lendário
	18
	+10',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Arma (Qualquer Simples ou Marcial)","rarity":"varies","rarityLabel":"Raridade Variável","requiresAttunement":true,"header":"Arma (Qualquer Simples ou Marcial), Raridade Varia (Requer Sintonização)","attunement":"Requer Sintonização","weaponSubtype":"Qualquer Simples ou Marcial"}'::jsonb
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
  'arma-sempre-alerta',
  'weapon'::rpg.item_type,
  'Arma Sempre Alerta',
  NULL,
  NULL,
  'Contanto que esta arma esteja ao seu alcance e você esteja sintonizado com ela, você e seus aliados a até 9 metros de distância adquirem os seguintes benefícios.
Alarme. A arma desperta magicamente cada sujeito que está dormindo naturalmente quando um combate se inicia. Esse benefício não acorda quem está em sono induzido magicamente.
Prontidão Sobrenatural. Cada sujeito tem Vantagem em jogadas de Iniciativa.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Arma (Qualquer Simples ou Marcial)","rarity":"uncommon","rarityLabel":"Incomum","requiresAttunement":true,"header":"Arma (Qualquer Simples ou Marcial), Incomum (Requer Sintonização)","attunement":"Requer Sintonização","weaponSubtype":"Qualquer Simples ou Marcial"}'::jsonb
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
  'arma-1-2-ou-3',
  'weapon'::rpg.item_type,
  'Arma, +1, +2 ou +3',
  NULL,
  NULL,
  'Você adquire um bônus em jogadas de ataque e dano realizadas com esta arma mágica. O bônus é determinado pela raridade da arma.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Arma (Qualquer Simples ou Marcial)","rarity":"uncommon","rarityLabel":"Incomum","requiresAttunement":false,"header":"Arma (Qualquer Simples ou Marcial), Incomum (+1), Raro (+2) ou Muito Raro (+3)","weaponSubtype":"Qualquer Simples ou Marcial"}'::jsonb
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
  'armadura-adamantina',
  'armor'::rpg.item_type,
  'Armadura Adamantina',
  NULL,
  NULL,
  'Esta armadura é reforçada com adamantina, uma das substâncias mais duras existentes. Enquanto estiver usando, qualquer Acerto Crítico contra você se torna um acerto normal.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Armadura (Qualquer Média ou Pesada, Exceto Gibão de Peles)","rarity":"uncommon","rarityLabel":"Incomum","requiresAttunement":false,"header":"Armadura (Qualquer Média ou Pesada, Exceto Gibão de Peles), Incomum","armorSubtype":"Qualquer Média ou Pesada, Exceto Gibão de Peles"}'::jsonb
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
  'armadura-de-invulnerabilidade',
  'armor'::rpg.item_type,
  'Armadura de Invulnerabilidade',
  NULL,
  NULL,
  'Você tem Resistência a dano Contundente, Cortante e Perfurante enquanto usa esta armadura.
Carapaça Metálica. Você pode executar uma ação Usar Magia para obter Imunidade a dano Contundente, Cortante e Perfurante por 10 minutos ou até não usar mais a armadura. Você restaura o uso desta propriedade após o amanhecer.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Armadura (Armadura de Placas)","rarity":"legendary","rarityLabel":"Lendário","requiresAttunement":true,"header":"Armadura (Armadura de Placas), Lendário (Requer Sintonização)","attunement":"Requer Sintonização","armorSubtype":"Armadura de Placas"}'::jsonb
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
  'armadura-de-mitral',
  'armor'::rpg.item_type,
  'Armadura de Mitral',
  NULL,
  NULL,
  'O mitral é um metal leve e flexível. Armaduras feitas dessa substância podem ser usadas sob roupas normais. Caso a armadura imponha Desvantagem em testes de Destreza (Furtividade) ou possua exigência de Força, a versão em mitral ignora essas limitações.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Armadura (Qualquer Média ou Pesada, Exceto Gibão de Peles)","rarity":"uncommon","rarityLabel":"Incomum","requiresAttunement":false,"header":"Armadura (Qualquer Média ou Pesada, Exceto Gibão de Peles), Incomum","armorSubtype":"Qualquer Média ou Pesada, Exceto Gibão de Peles"}'::jsonb
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
  'armadura-de-placas-das-formas-etereas',
  'armor'::rpg.item_type,
  'Armadura de Placas das Formas Etéreas',
  NULL,
  NULL,
  'Enquanto estiver vestindo esta armadura, você pode executar uma ação Usar Magia e usar uma palavra de comando para obter o efeito da magia Forma Etérea. A magia encerra imediatamente se você remover a armadura ou executar uma ação Usar Magia para repetir a palavra de comando. Esta propriedade da armadura não pode ser usada novamente até o próximo amanhecer.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Armadura (Armadura de Placas Parcial ou Armadura de Placas)","rarity":"legendary","rarityLabel":"Lendário","requiresAttunement":true,"header":"Armadura (Armadura de Placas Parcial ou Armadura de Placas), Lendário (Requer Sintonização)","attunement":"Requer Sintonização","armorSubtype":"Armadura de Placas Parcial ou Armadura de Placas"}'::jsonb
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
  'armadura-de-placas-do-povo-anao',
  'armor'::rpg.item_type,
  'Armadura de Placas do Povo Anão',
  NULL,
  NULL,
  'Enquanto estiver vestindo esta armadura, você adquire um bônus de +2 na Classe de Armadura. Além disso, se um efeito mover você contra sua vontade pelo chão, você pode executar uma Reação para reduzir a distância em até 3 metros.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Armadura (Armadura de Placas ou Placas Parcial)","rarity":"very-rare","rarityLabel":"Muito Raro","requiresAttunement":false,"header":"Armadura (Armadura de Placas ou Placas Parcial), Muito Raro","armorSubtype":"Armadura de Placas ou Placas Parcial"}'::jsonb
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
  'armadura-de-resistencia',
  'armor'::rpg.item_type,
  'Armadura de Resistência',
  NULL,
  NULL,
  'Você tem Resistência a um tipo de dano enquanto usa esta armadura. O Mestre escolhe o tipo ou o determina aleatoriamente jogando na tabela a seguir.
1d10
	Tipo de Dano
	1
	Ácido
	2
	Gélido
	3
	Ígneo
	4
	Energético
	5
	Elétrico
	6
	Necrótico
	7
	Venenoso
	8
	Psíquico
	9
	Radiante
	10
	Trovejante',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Armadura (Qualquer Leve, Média ou Pesada)","rarity":"rare","rarityLabel":"Raro","requiresAttunement":true,"header":"Armadura (Qualquer Leve, Média ou Pesada), Raro (Requer Sintonização)","attunement":"Requer Sintonização","armorSubtype":"Qualquer Leve, Média ou Pesada"}'::jsonb
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
  'armadura-de-vulnerabilidade',
  'armor'::rpg.item_type,
  'Armadura de Vulnerabilidade',
  NULL,
  NULL,
  'Enquanto estiver usando esta armadura, você tem Resistência a um dos seguintes tipos de dano: Contundente, Cortante ou Perfurante. O Mestre escolhe o tipo ou o determina aleatoriamente.
Maldição. Esta armadura é amaldiçoada, um fato revelado apenas quando a magia Identificar é conjurada na armadura ou você se sintonizar a ela. Sintonizar a armadura o amaldiçoa até que você seja alvo da magia Remover Maldição ou efeito mágico semelhante; remover a armadura não encerra a maldição. Enquanto amaldiçoado, você tem Vulnerabilidade a dois dos três tipos de dano associados à armadura (não aquele ao qual ela concede Resistência).',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Armadura (Qualquer Leve, Média ou Pesada)","rarity":"rare","rarityLabel":"Raro","requiresAttunement":true,"header":"Armadura (Qualquer Leve, Média ou Pesada), Raro (Requer Sintonização)","attunement":"Requer Sintonização","armorSubtype":"Qualquer Leve, Média ou Pesada"}'::jsonb
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
  'armadura-demoniaca',
  'armor'::rpg.item_type,
  'Armadura Demoníaca',
  NULL,
  NULL,
  'Enquanto estiver vestindo esta armadura, você adquire um bônus de +1 na Classe de Armadura e conhece o idioma Abissal. Além disso, as manoplas com garras da armadura permitem que seus Ataques Desarmados causem 1d8 pontos de dano Cortante em vez do dano normal Contundente, e você adquire um bônus de +1 nas jogadas de ataque e dano de seus Ataques Desarmados.
Maldição. Após vestir esta armadura amaldiçoada, você não pode removê-la a menos que seja alvo de uma magia Remover Maldição ou efeito mágico semelhante. Enquanto veste a armadura, você tem Desvantagem em jogadas de ataque contra demônios e em salvaguardas contra magias e habilidades especiais desses ínferos.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Armadura (Qualquer Leve, Média ou Pesada)","rarity":"very-rare","rarityLabel":"Muito Raro","requiresAttunement":true,"header":"Armadura (Qualquer Leve, Média ou Pesada), Muito Raro (Requer Sintonização)","attunement":"Requer Sintonização","armorSubtype":"Qualquer Leve, Média ou Pesada"}'::jsonb
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
  'armadura-do-marinheiro',
  'armor'::rpg.item_type,
  'Armadura do Marinheiro',
  NULL,
  NULL,
  'Enquanto estiver vestindo esta armadura, você tem um Deslocamento de Natação igual ao seu Deslocamento. Além disso, se começar seu turno debaixo d''água com 0 Pontos de Vida, você recupera imediatamente 1d4 Pontos de Vida. A armadura não pode curar ninguém novamente até o próximo amanhecer.
A armadura é decorada com representações de peixes e conchas.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Armadura (Qualquer Leve, Média ou Pesada)","rarity":"uncommon","rarityLabel":"Incomum","requiresAttunement":false,"header":"Armadura (Qualquer Leve, Média ou Pesada), Incomum","armorSubtype":"Qualquer Leve, Média ou Pesada"}'::jsonb
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
  'armadura-facil-de-tirar',
  'armor'::rpg.item_type,
  'Armadura Fácil de Tirar',
  NULL,
  NULL,
  'Você pode despir esta armadura como uma ação Usar Magia.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Armadura (Qualquer Leve, Média ou Pesada)","rarity":"common","rarityLabel":"Comum","requiresAttunement":false,"header":"Armadura (Qualquer Leve, Média ou Pesada), Comum","armorSubtype":"Qualquer Leve, Média ou Pesada"}'::jsonb
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
  'armadura-fumegante',
  'armor'::rpg.item_type,
  'Armadura Fumegante',
  NULL,
  NULL,
  'Fumos tênues, inofensivos e sem odor se elevam desta armadura enquanto ela está sendo vestida.
Armadura Magificada
Armadura, (Qualquer Leve, Média ou Pesada), Raridade Variável (Requer Sintonização)
Esta armadura contém uma magia de 8º círculo ou inferior vinculada a ela. A magia é determinada no momento em que a armadura é fabricada e deve pertencer às escolas de magia de Abjuração ou Ilusão. A armadura possui 6 cargas e recupera 1d6 cargas gastas diariamente ao amanhecer. Enquanto estiver vestindo a armadura, você pode gastar 1 carga para conjurar a magia vinculada a ela.
O círculo da magia vinculada à armadura determina a CD da salvaguarda da magia, o bônus de ataque e a raridade da armadura, conforme mostrado na tabela a seguir.
Círculo de Magia
	Raridade
	CD da Salvaguarda
	Bônus de Ataque
	Truque
	Incomum
	13
	+5
	1
	Incomum
	13
	+5
	2
	Raro
	13
	+5
	3
	Raro
	15
	+7
	4
	Muito Raro
	15
	+7
	5
	Muito Raro
	17
	+9
	6
	Lendário
	17
	+9
	7
	Lendário
	18
	+10
	8
	Lendário
	18
	+10',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Armadura (Qualquer Pesada, Média ou Leve)","rarity":"common","rarityLabel":"Comum","requiresAttunement":false,"header":"Armadura (Qualquer Pesada, Média ou Leve), Comum","armorSubtype":"Qualquer Pesada, Média ou Leve"}'::jsonb
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
  'armadura-reluzente',
  'armor'::rpg.item_type,
  'Armadura Reluzente',
  NULL,
  NULL,
  'Esta armadura nunca fica suja.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Armadura (Qualquer Leve, Média ou Pesada)","rarity":"common","rarityLabel":"Comum","requiresAttunement":false,"header":"Armadura (Qualquer Leve, Média ou Pesada), Comum","armorSubtype":"Qualquer Leve, Média ou Pesada"}'::jsonb
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
  'armadura-1-2-ou-3',
  'armor'::rpg.item_type,
  'Armadura, +1, +2 ou +3',
  NULL,
  NULL,
  'Você tem um bônus na Classe de Armadura enquanto estiver usando esta armadura. O bônus é determinado pela raridade da armadura.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Armadura (Qualquer Leve, Média ou Pesada)","rarity":"rare","rarityLabel":"Raro","requiresAttunement":false,"header":"Armadura (Qualquer Leve, Média ou Pesada), Raro (+1), Muito Raro (+2) ou Lendário (+3)","armorSubtype":"Qualquer Leve, Média ou Pesada"}'::jsonb
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
  'ataduras-do-poder-desarmado',
  'other'::rpg.item_type,
  'Ataduras do Poder Desarmado',
  NULL,
  NULL,
  'Enquanto estiver vestindo estas ataduras, você tem um bônus em jogadas de ataque e dano realizadas com seus Ataques Desarmados. O bônus é determinado pela raridade das ataduras, e esses golpes causam, à sua escolha, dano Energético ou o tipo de dano normal.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"uncommon","rarityLabel":"Incomum","requiresAttunement":false,"header":"Item Maravilhoso, Incomum (+1), Raro (+2) ou Muito Raro (+3)"}'::jsonb
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
  'azagaia-relampago',
  'weapon'::rpg.item_type,
  'Azagaia Relâmpago',
  NULL,
  NULL,
  'Toda vez que realizar uma jogada de ataque com esta arma mágica e acertar, você pode causar dano Elétrico em vez de dano Perfurante.
Relâmpago. Ao arremessar esta arma em um alvo a até 36 metros, você pode escolher não fazer uma jogada de ataque à distância e, em vez disso, transformá-la em um relâmpago. Esse relâmpago forma uma Linha de 1,5 metro de largura entre você e o alvo. O alvo e cada criatura na linha (exceto você) fazem uma salvaguarda de Destreza CD 13, sofrendo 4d6 de dano Elétrico em caso de falha, ou metade do dano se tiver sucesso. Após causar o dano, a arma reaparece em sua mão. Essa propriedade pode ser utilizada novamente apenas no próximo amanhecer.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Arma (Azagaia)","rarity":"uncommon","rarityLabel":"Incomum","requiresAttunement":false,"header":"Arma (Azagaia), Incomum","weaponSubtype":"Azagaia"}'::jsonb
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
  'baralho-das-ilusoes',
  'other'::rpg.item_type,
  'Baralho das Ilusões',
  NULL,
  NULL,
  'Esta caixa contém um conjunto de cartas. Um baralho completo tem 34 cartas: 32 representando criaturas específicas e duas com uma superfície espelhada. Um baralho encontrado como tesouro costuma ter 1d20 - 1 cartas a menos.
A magia do baralho funciona apenas se as cartas forem tiradas aleatoriamente. Você pode executar uma ação Usar Magia para tirar uma carta aleatoriamente do baralho e jogá-la no chão em um ponto a até 9 metros de você. Uma ilusão de uma criatura, determinada ao jogar na tabela Baralho das Ilusões, forma-se sobre a carta jogada e permanece até ser dissipada. A criatura ilusória criada pela carta parece e se comporta como uma criatura real de sua espécie, exceto que não pode causar dano. Enquanto você estiver a até 36 metros da criatura ilusória e puder vê-la, você pode executar uma ação Usar Magia para movê-la para qualquer lugar a até 9 metros de sua carta.
Qualquer interação física com a criatura ilusória revela que ela é falsa, uma vez que os objetos passam por ela. Uma criatura que executar uma ação Analisar para inspecionar visualmente a criatura ilusória a identifica como uma ilusão com um teste bem-sucedido de Inteligência (Investigação) CD 15. A ilusão permanece até que sua carta seja movida ou a ilusão seja dissipada (usando uma magia Dissipar Magia ou um efeito mágico semelhante). Quando a ilusão termina, a imagem em sua carta desaparece e essa carta não pode ser usada novamente.
1d100
	Ilusão*
	01-03
	Dragão Vermelho Adulto
	04-06
	Arquimago
	07-09
	Assassino
	10-12
	Capitão Bandido
	13-15
	Observador
	16-18
	Berserker
	19-21
	Bruturso Combatente
	22-24
	Gigante das Nuvens
	25-27
	Druida
	28-30
	Erínia
	31-33
	Ettin
	34-36
	Gigante de Fogo
	37-39
	Gigante do Gelo
	40-42
	Gnoll Combatente
	43-45
	Goblin Combatente
	46-48
	Naga Anciã
	49-51
	Gigante da Colina
	52-54
	Hobgoblin Combatente
	55-57
	Íncubo
	58-60
	Golem de Ferro
	61-63
	Cavaleiro
	64-66
	Kobold Warrior
	67-69
	Lich
	70-72
	Medusa
	73-75
	Megera da Noite
	76-78
	Ogro
	79-81
	Oni
	82-84
	Sacerdote
	85-87
	Súcubo
	88-90
	Troll
	91-93
	Veterano Combatente
	94-96
	Serpe
	97-00
	Coringa
	*Os Blocos de Estatísticas para essas criaturas (exceto o Coringa) aparecem no Livro dos Monstros.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"uncommon","rarityLabel":"Incomum","requiresAttunement":false,"header":"Item Maravilhoso, Incomum"}'::jsonb
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
  'baralho-de-muitas-coisas',
  'other'::rpg.item_type,
  'Baralho de Muitas Coisas',
  NULL,
  NULL,
  'Geralmente encontrado em uma caixa ou bolsa, este baralho contém uma quantidade de cartas feitas de marfim ou de velino. A maioria (75%) desses baralhos tem treze cartas, mas alguns têm vinte e duas. Use a coluna apropriada da tabela Baralho de Muitas Coisas ao determinar aleatoriamente as cartas retiradas do baralho.
Antes de puxar uma carta, você deve declarar quantas cartas pretende puxar e, em seguida, puxá-las aleatoriamente. Qualquer carta puxada além desse número não tem efeito. Caso contrário, assim que você puxar uma carta do baralho, a magia do baralho entra em efeito. Você deve puxar cada carta em um intervalo de, no máximo, 1 hora após a anterior. Se você não puxar o número declarado de cartas, as cartas restantes saem do baralho por conta própria e entram em efeito simultaneamente.
Assim que uma carta é puxada, ela desaparece. A menos que a carta seja o Tolo ou o Bufão, ela reaparece no baralho, tornando possível puxar a mesma carta mais de uma vez. Uma vez que o Tolo ou o Bufão tenha deixado o baralho, jogue novamente na tabela caso essa carta apareça novamente.
Cartas do Baralho de Muitas Coisas
1d100 (baralho de 13 cartas)
	1d100 (baralho de 22 cartas)
	Carta
	—
	01–05
	Equilíbrio
	—
	06–10
	Cometa
	—
	11–14
	Calabouço
	1–8
	15–18
	Euríale
	—
	19–23
	Parcas
	9–16
	24–27
	Labaredas
	—
	28–31
	Tolo
	—
	32–36
	Gema
	17–24
	37–41
	Bufão
	25–32
	42–46
	Chave
	33–40
	47–51
	Cavaleiro
	41–48
	52–56
	Lua
	—
	57–60
	Enigma
	49–56
	61–64
	Ladino
	57–64
	65–68
	Ruína
	—
	69–73
	Sábio
	65–72
	74–77
	Crânio
	73–80
	78–82
	Estrela
	81–88
	83–87
	Sol
	—
	88–91
	Garras
	89–96
	92–96
	Trono
	97–00
	97–00
	Vazio
	O efeito de cada carta é descrito abaixo.
 
Bufão. Você tem Vantagem em Testes de D20 pelas próximas 72 horas ou pode puxar duas cartas adicionais além das declaradas.
Calabouço. Você desaparece e fica preso em um estado de animação suspensa em uma esfera extradimensional. Tudo o que você estiver vestindo e carregando desaparece com você, exceto Artefatos, que permanecem no espaço que você ocupava. Você permanece aprisionado até ser encontrado e retirado da esfera. Você não pode ser localizado por magia de Adivinhação, mas uma magia Desejo pode revelar a localização de sua prisão. Você não pode puxar mais cartas.
Cavaleiro. Você obtém o serviço de um Cavaleiro, que aparece magicamente em um espaço desocupado à sua escolha a até 9 metros de você. O Cavaleiro tem o mesmo alinhamento que você e o serve lealmente até a morte, acreditando que vocês foram unidos pelo destino. Trabalhe com o Mestre para criar um nome e um histórico para este PNJ. O Mestre pode usar um bloco de estatísticas diferente para representar o Cavaleiro, conforme desejar.
Chave. Uma arma mágica rara ou superior com a qual você é proficiente aparece em suas mãos. O Mestre escolhe a arma.
Cometa. Na próxima vez que entrar em combate contra uma ou mais criaturas Hostis, você pode escolher uma delas como seu inimigo ao jogar a Iniciativa. Ao reduzir esse inimigo a 0 Pontos de Vida durante o combate, você tem Vantagem em Salvaguardas contra Morte por 1 ano. Se outra pessoa reduzir o inimigo escolhido a 0 Pontos de Vida ou se você não escolher um inimigo, esta carta não tem efeito.
Crânio. Um Avatar da Morte (veja o bloco de estatísticas correspondente) aparece em um espaço desocupado o mais próximo possível de você. O avatar ataca somente você, aparecendo como um esqueleto fantasmagórico envolto em uma túnica preta esfarrapada e empunhando uma foice espectral. O avatar desaparece quando é reduzido a 0 Pontos de Vida ou se você morrer. Se um de seus aliados causar dano ao avatar, esse aliado invoca outro Avatar da Morte. O novo avatar aparece em um espaço desocupado o mais próximo possível desse aliado e o ataca exclusivamente. Você e seus aliados podem invocar apenas um avatar cada como consequência deste saque. Uma criatura morta por um avatar não pode ser restaurada à vida.
Avatar da Morte
Morto-vivo Médio, Neutro e Mau
CA 20          Iniciativa +3 (13)
PV Metade do PV máximo de seu invocador
 Deslocamento 18 m, Voo 18 m (pairar)
 
	 
	Mod
	SG
	For
	16
	+3
	+3
	Des
	16
	+3
	+3
	Con
	16
	+3
	+3
	Int
	16
	+3
	+3
	Con
	16
	+3
	+3
	Car
	16
	+3
	+3
	Imunidades Necrótico, Venenoso; Amedrontado, Enfeitiçado, Envenenado, Exaustão, Inconsciente, Paralisado, Petrificado
Sentidos Visão Verdadeira 18 m, Percepção Passiva 13
Idiomas Todos os idiomas conhecidos por seu invocador
ND Nenhum (XP 0; BP é igual ao de seu invocador)
Traços
Movimento Incorpóreo. O avatar pode mover-se através de outras criaturas e objetos como se fossem Terreno Difícil. Ele sofre 5 (1d10) pontos de dano Energético se terminar o turno dentro de um objeto.
Ações
Ataques Múltiplos. O avatar realiza um número de ataques de Foice Ceifadora igual à metade do Bônus de Proficiência do invocador (arredondado para cima).
Foice Ceifadora. Jogada de Ataque Corpo a Corpo: Acerto automático, alcance 1,5 m. Dano: 7 (1d8 + 3) Cortante mais 4 (1d8) Necrótico.
Enigma. Reduza permanentemente seu valor de Inteligência ou Sabedoria em 1d4 + 1 (com um valor mínimo de 1). Você pode sacar uma carta adicional além das declaradas.
Equilíbrio. Você pode aumentar um de seus valores de atributo em 2, até um máximo de 22, desde que reduza outro valor de atributo em 2. Você não pode diminuir um atributo que tenha valor 5 ou menor. Como alternativa, você pode optar por não ajustar seus valores de atributo; nesse caso, esta carta não terá efeito sobre você.
Estrela. Aumente um de seus valores de atributo em 2, até um máximo de 24.
Euríale. A carta da medusa o amaldiçoa. Ao estar amaldiçoado deste modo, você sofre uma penalidade de −2 nas salvaguardas. Apenas um deus ou a magia da carta Parcas pode remover essa maldição.
Garras. Todo item mágico que você veste ou carrega se desintegra. Artefatos em sua posse não são destruídos, mas desaparecem.
Gema. Vinte e cinco joias no valor de 2.000 PO cada ou cinquenta gemas avaliadas em 1.000 PO cada, aparecem aos seus pés.
Labaredas. Um diabo poderoso se torna seu inimigo. O diabo busca sua ruína e o atormenta, saboreando seu sofrimento antes de tentar matá-lo. Essa inimizade dura até que você ou o diabo morra.
Uma Questão de Inimizade
Duas das cartas do Baralho de Muitas Coisas podem conceder a um personagem a inimizade de outro ser. Com a carta Labaredas, a inimizade é evidente. O personagem provavelmente vivenciará os esforços malévolos do diabo em várias ocasiões. Encontrar o diabo não deve ser uma tarefa simples, e o aventureiro deve enfrentar os aliados e seguidores do diabo algumas vezes antes de poder confrontá-lo diretamente.
No caso da carta Ladino, a inimizade é secreta e deve vir de alguém que o personagem considera um amigo ou aliado. Como Mestre, você deve aguardar um momento dramaticamente apropriado para revelar essa inimizade, mantendo o aventureiro em dúvida sobre quem provavelmente será o traidor.
Ladino. Um PNJ à escolha do Mestre torna-se Hostil a você. Você não sabe a identidade desse PNJ até que ele ou outra pessoa revele isso. Nada menos que uma magia Desejo ou intervenção divina pode encerrar a hostilidade desse PNJ.
Lua. Você adquire a capacidade de conjurar a magia Desejo 1d3 vezes.
Parcas. A realidade se desfaz e é tecida novamente, permitindo que você evite ou apague um evento como se nunca tivesse acontecido. Você pode usar a magia desta carta assim que a puxar ou a qualquer momento antes da sua morte.
Ruína. Todas as formas de riqueza que você carrega ou possui, exceto itens mágicos, são perdidas. Propriedades portáteis desaparecem. Negócios, edifícios e terras que você possui são perdidos de uma forma que altera a realidade o mínimo possível. Se você possui um Bastião (veja o capítulo 8), ele é destruído por alguma calamidade fora de seu controle. Qualquer documentação que prove sua posse de algo perdido por esta carta também desaparece.
Sábio. A qualquer momento dentro de um ano após comprar esta carta, você pode fazer uma pergunta em meditação e receber mentalmente uma resposta verdadeira para essa pergunta.
Sol. Um item mágico (escolhido pelo Mestre) aparece em sua posse. Além disso, você adquire 10 Pontos de Vida Temporários diariamente ao amanhecer até sua morte.
Tolo. Você tem Desvantagem em Testes de D20 pelas próximas 72 horas. Compre outra carta; este saque não conta como um dos saques declarados.
Trono. Você adquire proficiência e Especialização à sua escolha na perícia História, Intuição, Intimidação ou Persuasão. Além disso, você obtém o direito legítimo de posse de uma pequena fortaleza em algum lugar do mundo. No entanto, a fortaleza está atualmente habitada por um ou mais monstros, que devem ser eliminados antes que você possa reivindicá-la como sua.
Vazio. Sua alma é retirada do corpo e presa em um objeto em um local à escolha do Mestre. Um ou mais seres poderosos guardam o local. Enquanto sua alma estiver aprisionada deste modo, seu corpo fica inerte, para de envelhecer e não necessita de comida, ar ou água. Uma magia Desejo não pode devolver sua alma ao seu corpo, mas a magia revela a localização do objeto que a contém. Você não pode sacar mais cartas.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"legendary","rarityLabel":"Lendário","requiresAttunement":false,"header":"Item Maravilhoso, Lendário"}'::jsonb
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
  'barco-de-bolso',
  'other'::rpg.item_type,
  'Barco de Bolso',
  NULL,
  NULL,
  'Este objeto parece uma caixa de madeira medindo 30 centímetros de comprimento, 15 centímetros de largura e 15 centímetros de profundidade. Ele pesa 2 quilos e flutua. Pode ser aberto para armazenar itens em seu interior. Este item também possui três palavras de comando, cada uma exigindo uma ação Usar Magia para ser utilizado:
Primeira Palavra de Comando. A caixa se desdobra em um Barco a Remo.
Segunda Palavra de Comando. A caixa se desdobra em um Barco de Quilha.
Terceira Palavra de Comando. O Barco de Bolso se dobra de volta em uma caixa se nenhuma criatura estiver a bordo. Quaisquer objetos no recipiente que não couberem na caixa permanecem fora dela enquanto se dobra. Quaisquer objetos no recipiente que couberem na caixa permanecem lá.
Quando a caixa se torna uma embarcação, seu peso se torna o de uma embarcação comum daquele tamanho, e qualquer coisa armazenada na caixa permanece no barco.
As estatísticas para o Barco a Remo e para o Barco de Quilha aparecem no Livro do Jogador. Se qualquer embarcação for reduzida a 0 Pontos de Vida, o Barco de Bolso é destruído.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"rare","rarityLabel":"Raro","requiresAttunement":false,"header":"Item Maravilhoso, Raro"}'::jsonb
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
  'batuta-da-regencia',
  'other'::rpg.item_type,
  'Batuta da Regência',
  NULL,
  NULL,
  'Esta varinha tem 3 cargas. Enquanto a segura, você pode executar uma ação Usar Magia para gastar 1 carga e criar música orquestral agitando-a. A música pode ser ouvida a até 36 metros e termina quando você para de balançar a varinha.
Recuperando Cargas. A varinha recupera todas as cargas gastas diariamente ao amanhecer. Se você gastar a última carga da varinha, jogue 1d20. Em um 1, um som triste de tuba toca enquanto a varinha se desfaz em cinzas e é destruída.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Varinha","rarity":"common","rarityLabel":"Comum","requiresAttunement":false,"header":"Varinha, Comum"}'::jsonb
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
  'bengala-de-veterano',
  'other'::rpg.item_type,
  'Bengala de Veterano',
  NULL,
  NULL,
  'Como uma Ação Bônus, você pode transformar esta bengala em uma Espada Longa comum ou transformar a Espada Longa de volta em uma bengala. Em ambos os casos, você deve estar segurando o item.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"common","rarityLabel":"Comum","requiresAttunement":false,"header":"Item Maravilhoso, Comum"}'::jsonb
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
  'bola-de-cristal',
  'other'::rpg.item_type,
  'Bola de Cristal',
  NULL,
  NULL,
  'Ao tocar neste orbe de cristal, você pode conjurar Vidência (CD 17 para evitar) com ele.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"very-rare","rarityLabel":"Muito Raro","requiresAttunement":true,"header":"Item Maravilhoso, Muito Raro (Requer Sintonização)","attunement":"Requer Sintonização"}'::jsonb
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
  'bola-de-cristal-da-leitura-de-mentes',
  'other'::rpg.item_type,
  'Bola de Cristal da Leitura de Mentes',
  NULL,
  NULL,
  'Ao tocar neste orbe de cristal, você pode conjurar Vidência (CD 17 para evitar) com ele. Além disso, você pode conjurar Detectar Pensamentos (CD 17 para evitar) determinando como alvos criaturas à sua vista a até 9 metros do sensor mágico. Você não precisa se concentrar na magia Detectar Pensamentos para mantê-la pela duração, mas ela encerra quando a magia Vidência termina.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"legendary","rarityLabel":"Lendário","requiresAttunement":true,"header":"Item Maravilhoso, Lendário (Requer Sintonização)","attunement":"Requer Sintonização"}'::jsonb
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
  'bola-de-cristal-de-telepatia',
  'other'::rpg.item_type,
  'Bola de Cristal de Telepatia',
  NULL,
  NULL,
  'Ao tocar neste orbe de cristal, você pode conjurar Vidência (CD 17 para evitar) com ele. Além disso, você pode se comunicar telepaticamente com criaturas à sua vista a até 9 metros do sensor mágico. Você também pode conjurar Sugestão (CD 17 para evitar) através do sensor em uma dessas criaturas. Você não precisa se concentrar na magia Sugestão para mantê-la pela duração, mas ela encerra quando a magia Vidência termina. Você não pode conjurar Sugestão deste modo novamente até o próximo amanhecer.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"legendary","rarityLabel":"Lendário","requiresAttunement":true,"header":"Item Maravilhoso, Lendário (Requer Sintonização)","attunement":"Requer Sintonização"}'::jsonb
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
  'bola-de-cristal-de-visao-verdadeira',
  'other'::rpg.item_type,
  'Bola de Cristal de Visão Verdadeira',
  NULL,
  NULL,
  'Ao tocar neste orbe de cristal, você pode conjurar Vidência (CD 17 para evitar) com ele. Além disso, você tem Visão Verdadeira com um alcance de 36 metros centrado no sensor mágico.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"legendary","rarityLabel":"Lendário","requiresAttunement":true,"header":"Item Maravilhoso, Lendário (Requer Sintonização)","attunement":"Requer Sintonização"}'::jsonb
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
  'bolsa-cabe-tudo',
  'other'::rpg.item_type,
  'Bolsa Cabe Tudo',
  NULL,
  NULL,
  'Esta bolsa tem um espaço interno consideravelmente maior do que suas dimensões externas — aproximadamente 60 centímetros de diâmetro e 1,2 metro de profundidade. A bolsa pode conter até 250 quilos, não excedendo um volume de 1,8 metro cúbico. A bolsa pesa 7,5 quilos, independentemente do seu conteúdo. Retirar um item da bolsa requer uma ação Usar Objeto.
Se a bolsa estiver sobrecarregada, furada ou rasgada, ela é destruída e seu conteúdo é espalhado no Plano Astral. Se for virada do avesso, seu conteúdo é despejado ileso, mas a bolsa deve ser colocada no lugar antes que possa ser usada novamente. A bolsa contém ar suficiente para 10 minutos de respiração, dividido pelo número de criaturas que respiram lá dentro.
Colocar uma Bolsa Cabe Tudo dentro de um espaço extradimensional criado por um Buraco Portátil, Mochila Prestativa de Heward ou item semelhante destrói instantaneamente ambos os itens e abre um portal para o Plano Astral. O portal se forma quando um item é inserido em outro. Qualquer criatura em um raio de 3 metros do portal é sugada para um local aleatório no Plano Astral, onde o portal se fecha, tem mão única e não pode ser reaberto.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"uncommon","rarityLabel":"Incomum","requiresAttunement":false,"header":"Item Maravilhoso, Incomum"}'::jsonb
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
  'bolsa-das-tropelias',
  'other'::rpg.item_type,
  'Bolsa das Tropelias',
  NULL,
  NULL,
  'Esta bolsa comum, feita em tecido nas cores cinza, ferrugem ou bronze, parece vazia. No entanto, ao tatear seu interior, revela-se um objeto pequeno e disforme.
Como uma ação Usar Magia, você pode puxar o objeto disforme da bolsa e arremessá-lo até 6 metros. Quando o objeto cai no chão, ele se transforma em uma criatura que você determina jogando na tabela que corresponde à cor da bolsa. Veja o Livro dos Monstros para o bloco de estatísticas da criatura. A criatura desaparece no próximo amanhecer ou quando é reduzida a 0 Pontos de Vida.
A criatura é Amigável a você e a seus aliados e age imediatamente após você na contagem de Iniciativa. Você pode executar uma Ação Bônus para ordenar como a criatura se move e qual ação ela executa no próximo turno dela, como atacar um inimigo. Na ausência de tais ordens, a criatura age apropriadamente à natureza dela.
Uma vez que três objetos disformes tenham sido retirados da bolsa, ela não pode ser usada novamente até o próximo amanhecer.
Bolsa das Tropelias Bronze
1d8
	Criatura
	1
	Chacal
	2
	Gorila
	3
	Babuíno
	4
	Bico-de-Machado
	5
	Urso Negro
	6
	Doninha Gigante
	7
	Hiena Gigante
	8
	Tigre
	 
Bolsa das Tropelias Cinza
1d8
	Criatura
	1
	Doninha
	2
	Rato Gigante
	3
	Texugo
	4
	Javali
	5
	Pantera
	6
	Texugo Gigante
	7
	Lobo Atroz
	8
	Alce Gigante
	Bolsa das Tropelias Ferrugem
1d8
	Criatura
	1
	Rato
	2
	Coruja
	3
	Mastim
	4
	Cabra
	5
	Cabra Gigante
	6
	Javali Gigante
	7
	Leão
	8
	Urso Pardo',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"uncommon","rarityLabel":"Incomum","requiresAttunement":false,"header":"Item Maravilhoso, Incomum"}'::jsonb
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
  'bolsa-de-feijoes',
  'other'::rpg.item_type,
  'Bolsa de Feijões',
  NULL,
  NULL,
  'Esta bolsa pesada de pano contém 3d4 feijões secos e pesa 250 gramas, independente de quantos grãos tenha. Se não houver mais feijões, a bolsa deixa de ser um item mágico.
Se você despejar um ou mais grãos da bolsa, eles explodem em uma Esfera de 3 metros de raio centrada neles. Todos os grãos descartados são destruídos na explosão e cada criatura na Esfera, incluindo você, realiza uma salvaguarda de Destreza CD 15, sofrendo 5d4 pontos de dano Energético se falhar, ou metade desse dano em caso de sucesso.
Ao retirar um grão da bolsa, plantá-lo no solo ou na areia e regá-lo, o grão desaparece um minuto depois, gerando um efeito no local de plantio. O Mestre pode escolher um efeito da tabela abaixo ou determiná-lo aleatoriamente.
1d100
	Efeito
	01
	5d4 cogumelos brotam. Se uma criatura comer um deles, jogue qualquer dado. Caso o resultado seja ímpar, a criatura deve ser bem-sucedida em uma salvaguarda de Constituição CD 15 ou sofre 5d6 pontos de dano Venenoso e tem a condição Envenenado por 1 hora. Caso o resultado seja par, a criatura recebe 5d6 de Pontos de Vida temporários por 1 hora.
	02–10
	Um gêiser entra em erupção e jorra água, cerveja, maionese, chá, vinagre, vinho ou óleo (à escolha do Mestre) a 9 metros no ar por 1d4 minutos.
	11–20
	Um Ent brota. Jogue qualquer dado. Em um resultado ímpar ele é Caótico e Mau; em um resultado par, é Caótico e Bom.
	21–30
	Uma estátua de pedra animada semelhante a você, mas imóvel, ergue-se e faz ameaças verbais a você. Se você se afastar e outros se aproximarem, ela o descreve como o vilão mais hediondo e incita os recém-chegados a encontrá-lo atacá-lo. A estátua detecta sua localização se estiver no mesmo plano de existência e se torna inanimada após 24 horas.
	31–40
	Uma fogueira de chamas verdes queima por 24 horas ou até ser apagada.
	41–50
	Três Cogumelos Guinchadores brotam.
	51–60
	1d4 + 4 sapos rosa-claros aparecem rastejando. Ao tocar um sapo, ele se transforma em um monstro Grande ou menor, escolhido pelo Mestre, que age conforme o alinhamento e natureza dele. O monstro permanece por 1 minuto antes de desaparecer em fumaça rosa-brilhante.
	61–70
	Um Bulete faminto se desenterra e ataca.
	71–80
	Uma árvore frutífera cresce, produzindo 1d10 + 20 frutas, sendo 1d8 delas poções aleatórias. A árvore desaparece após 1 hora, mas as frutas coletadas mantêm a magia por 30 dias.
	81–90
	Um ninho com 1d4 + 3 ovos coloridos surge. Qualquer criatura que comer um ovo deve realizar uma salvaguarda de Constituição CD 20. Em caso de sucesso, uma criatura aumenta permanentemente o menor atributo em 1, escolhendo aleatoriamente entre os valores mais baixos. Se falhar, sofre 10d6 pontos de dano Energético devido a uma explosão interna.
	91–95
	Uma pirâmide com uma base quadrada de 18 metros irrompe para cima. Dentro dela há um sarcófago contendo uma Múmia, uma Múmia Real ou algum outro Morto-vivo à escolha do Mestre. O sarcófago contém um tesouro à escolha do Mestre.
	96–00
	Um pé de feijão gigante brota, crescendo a uma altura à escolha do Mestre. O topo leva para onde o Mestre escolher, como uma ótima vista, o castelo de um gigante das nuvens ou outro plano de existência.
	Bolsa de Feijões',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"rare","rarityLabel":"Raro","requiresAttunement":false,"header":"Item Maravilhoso, Raro"}'::jsonb
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
  'bolsa-de-temperos-prestativa-de-howard',
  'other'::rpg.item_type,
  'Bolsa de Temperos Prestativa de Howard',
  NULL,
  NULL,
  'Esta pochete parece vazia e tem 10 cargas. Enquanto segura a bolsa, você pode executar uma ação Usar Magia para gastar 1 carga, falar o nome de qualquer tempero alimentício não mágico (como sal, pimenta, açafrão ou coentro) e remover uma pitada do tempero desejado da bolsa. Uma pitada é suficiente para temperar uma única refeição. A bolsa recupera 1d6 + 4 cargas gastas diariamente ao amanhecer.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"common","rarityLabel":"Comum","requiresAttunement":false,"header":"Item Maravilhoso, Comum"}'::jsonb
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
  'bolsa-devoradora',
  'other'::rpg.item_type,
  'Bolsa Devoradora',
  NULL,
  NULL,
  'Esta bolsa se assemelha a uma Bolsa Cabe Tudo, mas é um orifício de alimentação para uma gigantesca criatura extradimensional. Virar a bolsa do avesso fecha o orifício.
A criatura extradimensional na bolsa sente tudo o que é colocado dentro dela. Qualquer matéria animal ou vegetal totalmente inserida é devorada e perdida para sempre. Se parte de uma criatura viva, como uma pessoa, entrar na bolsa, há 50% de chance de ser puxada para dentro. A criatura na bolsa pode tentar escapar com um teste bem-sucedido de Força (Atletismo) CD 15. Outra criatura pode tentar puxar alguém para fora da bolsa com um teste de Força (Atletismo) CD 20, desde que não seja puxada primeiro. Qualquer criatura que inicie seu turno dentro da bolsa é devorada e seu corpo destruído.
Objetos inanimados podem ser armazenados na bolsa, cuja capacidade máxima é de 30 litros (ou 0,3 metro cúbico de material). No entanto, uma vez por dia, a bolsa engole quaisquer objetos dentro dela e os regurgita para outro plano de existência. O Mestre determina o momento e o plano.
Se a bolsa for perfurada ou rasgada, ela é destruída, e qualquer coisa contida nela é transportada para um local aleatório no Plano Astral.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"very-rare","rarityLabel":"Muito Raro","requiresAttunement":false,"header":"Item Maravilhoso, Muito Raro"}'::jsonb
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
  'boneca-conversadora',
  'other'::rpg.item_type,
  'Boneca Conversadora',
  NULL,
  NULL,
  'Durante um Descanso Curto, enquanto a boneca estiver a até 1,5 metro de você, você pode falar a ela até seis frases de no máximo seis palavras cada, e definir uma condição para cada frase. As condições devem ocorrer a até 1,5 metro da boneca para as frases serem ativadas. Você pode substituir frases antigas a qualquer momento. Por exemplo, ao ser erguida, ela pode dizer: “Eu quero um doce.” As frases programadas desaparecem quando sua Sintonização com a boneca termina.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"common","rarityLabel":"Comum","requiresAttunement":true,"header":"Item Maravilhoso, Comum (Requer Sintonização)","attunement":"Requer Sintonização"}'::jsonb
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
  'botas-aladas',
  'other'::rpg.item_type,
  'Botas Aladas',
  NULL,
  NULL,
  'Estas botas têm 4 cargas e recuperam 1d4 cargas gastas diariamente ao amanhecer. Enquanto estiver usando as botas, você pode executar uma ação Usar Magia para gastar 1 carga, recebendo um Deslocamento de Voo de 9 metros por 1 hora. Se estiver voando quando a duração encerrar, você desce a uma taxa de 9 metros por rodada até pousar.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"uncommon","rarityLabel":"Incomum","requiresAttunement":true,"header":"Item Maravilhoso, Incomum (Requer Sintonização)","attunement":"Requer Sintonização"}'::jsonb
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
  'botas-das-terras-glaciais',
  'other'::rpg.item_type,
  'Botas das Terras Glaciais',
  NULL,
  NULL,
  'Estas botas de pele são confortáveis e quentes. Ao usá-las, você adquire os seguintes benefícios.
Caminhante Invernal. Você ignora Terreno Difícil gerado por gelo ou neve.
Resistência ao Frio. Você tem Resistência a dano Gélido e pode tolerar temperaturas de -18 graus Celsius ou menos sem qualquer proteção adicional.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"uncommon","rarityLabel":"Incomum","requiresAttunement":true,"header":"Item Maravilhoso, Incomum (Requer Sintonização)","attunement":"Requer Sintonização"}'::jsonb
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
  'botas-de-caminhar-e-saltar',
  'other'::rpg.item_type,
  'Botas de Caminhar e Saltar',
  NULL,
  NULL,
  'Enquanto estiver usando estas botas, seu Deslocamento se torna 9 metros, a menos que seu Deslocamento seja maior, e seu Deslocamento não é reduzido se você carregar um peso superior à sua capacidade de carga ou usar Armadura Pesada.
Uma vez em cada um de seus turnos, você pode saltar até 9 metros gastando apenas 3 metros de movimento.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"uncommon","rarityLabel":"Incomum","requiresAttunement":true,"header":"Item Maravilhoso, Incomum (Requer Sintonização)","attunement":"Requer Sintonização"}'::jsonb
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
  'botas-de-levitacao',
  'other'::rpg.item_type,
  'Botas de Levitação',
  NULL,
  NULL,
  'Enquanto estiver usando estas botas, você pode conjurar Levitação em si mesmo.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"rare","rarityLabel":"Raro","requiresAttunement":true,"header":"Item Maravilhoso, Raro (Requer Sintonização)","attunement":"Requer Sintonização"}'::jsonb
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
  'botas-de-velocidade',
  'other'::rpg.item_type,
  'Botas de Velocidade',
  NULL,
  NULL,
  'Enquanto estiver usando estas botas, você pode executar uma Ação Bônus para bater os calcanhares. Ao fazer isso, as botas dobram seu Deslocamento, e qualquer criatura que realizar um Ataque de Oportunidade contra você tem Desvantagem na jogada de ataque. Se você bater os calcanhares novamente, o efeito encerra.
Ao usar a propriedade das botas por um total de 10 minutos, a magia deixa de funcionar até que você complete um Descanso Longo.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"rare","rarityLabel":"Raro","requiresAttunement":true,"header":"Item Maravilhoso, Raro (Requer Sintonização)","attunement":"Requer Sintonização"}'::jsonb
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
  'botas-despistadoras',
  'other'::rpg.item_type,
  'Botas Despistadoras',
  NULL,
  NULL,
  'Enquanto estiver usando essas botas, você pode fazer com que elas deixem pegadas como as de qualquer tipo de humanoide do seu tamanho.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"common","rarityLabel":"Comum","requiresAttunement":true,"header":"Item Maravilhoso, Comum (Requer Sintonização)","attunement":"Requer Sintonização"}'::jsonb
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
  'botas-elficas',
  'other'::rpg.item_type,
  'Botas Élficas',
  NULL,
  NULL,
  'Enquanto estiver usando essas botas, seus passos não fazem barulho, independentemente da superfície em que você está se movendo. Você também tem Vantagem em testes de Destreza (Furtividade).',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"uncommon","rarityLabel":"Incomum","requiresAttunement":false,"header":"Item Maravilhoso, Incomum"}'::jsonb
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
  'braceletes-de-arquearia',
  'other'::rpg.item_type,
  'Braceletes de Arquearia',
  NULL,
  NULL,
  'Enquanto estiver usando estes braceletes, você tem proficiência com o Arco Longo e o Arco Curto, e recebe um bônus de +2 nas jogadas de dano realizadas com essas armas.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"uncommon","rarityLabel":"Incomum","requiresAttunement":true,"header":"Item Maravilhoso, Incomum (Requer Sintonização)","attunement":"Requer Sintonização"}'::jsonb
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
  'braceletes-de-defesa',
  'other'::rpg.item_type,
  'Braceletes de Defesa',
  NULL,
  NULL,
  'Enquanto estiver usando estes braceletes, você recebe um bônus de +2 na Classe de Armadura se não estiver vestindo armadura e não estiver usando Escudo.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"rare","rarityLabel":"Raro","requiresAttunement":true,"header":"Item Maravilhoso, Raro (Requer Sintonização)","attunement":"Requer Sintonização"}'::jsonb
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
  'braseiro-de-comandar-elementais-do-fogo',
  'other'::rpg.item_type,
  'Braseiro de Comandar Elementais do Fogo',
  NULL,
  NULL,
  'Enquanto estiver a até 1,5 metro deste braseiro, você pode executar uma ação Usar Magia para invocar um Elemental do Fogo. O elemental aparece em um espaço desocupado próximo ao braseiro, entende seus idiomas, obedece aos seus comandos e age imediatamente após sua contagem de iniciativa. Ele desaparece após 1 hora, quando morre ou quando você o dispensa como uma Ação Bônus. O braseiro não pode ser utilizado novamente desse modo até o próximo amanhecer.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"rare","rarityLabel":"Raro","requiresAttunement":false,"header":"Item Maravilhoso, Raro"}'::jsonb
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
  'broche-escudarcano',
  'other'::rpg.item_type,
  'Broche Escudarcano',
  NULL,
  NULL,
  'Enquanto estiver usando este broche, você tem Resistência a dano Energético e Imunidade ao dano da magia Míssil Mágico.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"uncommon","rarityLabel":"Incomum","requiresAttunement":true,"header":"Item Maravilhoso, Incomum (Requer Sintonização)","attunement":"Requer Sintonização"}'::jsonb
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
  'buraco-portatil',
  'other'::rpg.item_type,
  'Buraco Portátil',
  NULL,
  NULL,
  'Este fino tecido preto, macio como seda, é dobrado até as dimensões de um lenço. Ele se desdobra em uma folha circular de 1,8 metro de diâmetro.
Você pode executar uma ação Usar Magia para desdobrar um Buraco Portátil e posicioná-lo sobre ou contra uma superfície sólida. Após isso, o Buraco Portátil cria um buraco extradimensional com 3 metros de profundidade. O espaço cilíndrico dentro do buraco existe em um plano de existência diferente, portanto, não pode ser utilizado para criar passagens abertas. Qualquer criatura dentro de um Buraco Portátil aberto pode sair dele.
Você pode executar uma ação Usar Magia para fechar um Buraco Portátil segurando as bordas do tecido e dobrando-o. Dobrar o tecido fecha o buraco, e quaisquer criaturas ou objetos dentro dele permanecem no espaço extradimensional. Não importa o que esteja nele, o buraco pesa quase nada.
Se o buraco estiver dobrado, uma criatura dentro do espaço extradimensional do buraco pode executar uma ação para realizar um teste de Força (Atletismo) CD 10. Em caso de sucesso, a criatura consegue forçar sua saída e aparece a até 1,5 metro do Buraco Portátil. Um Buraco Portátil fechado contém ar suficiente para 1 hora de respiração, dividido pelo número de criaturas que respiram lá dentro.
Colocar o Buraco Portátil dentro de um espaço extradimensional criado por uma Bolsa Cabe Tudo, Mochila Prestativa de Heward ou item semelhante destrói instantaneamente ambos os itens e abre um portal para o Plano Astral. O portal tem origem onde um item foi colocado dentro do outro. Qualquer criatura a até 3 metros do portal e que não esteja atrás de uma Cobertura Total é sugada por ele e depositada em um local aleatório no Plano Astral. O portal então se fecha. O portal é unidirecional e não pode ser reaberto.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"rare","rarityLabel":"Raro","requiresAttunement":false,"header":"Item Maravilhoso, Raro"}'::jsonb
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
  'cachimbo-teratologico',
  'other'::rpg.item_type,
  'Cachimbo Teratológico',
  NULL,
  NULL,
  'Ao fumar este cachimbo, você pode executar uma ação Usar Magia para exalar uma nuvem de fumaça que assume a forma de uma criatura, como um dragão, um flunf ou um slaad. A forma deve ser pequena o suficiente para caber em um cubo de 30 centímetros de lados e perde sua forma após alguns segundos, tornando-se uma nuvem comum de fumaça.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"common","rarityLabel":"Comum","requiresAttunement":false,"header":"Item Maravilhoso, Comum"}'::jsonb
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
  'cadeado-antiladinagem',
  'other'::rpg.item_type,
  'Cadeado Antiladinagem',
  NULL,
  NULL,
  'Este cadeado parece ser comum (do tipo descrito no capítulo 6 do Livro do Jogador) e vem com uma única chave. Os pinos neste cadeado se ajustam magicamente para frustrar ladrões. Testes de Destreza realizados para abrir o cadeado têm Desvantagem.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"common","rarityLabel":"Comum","requiresAttunement":false,"header":"Item Maravilhoso, Comum"}'::jsonb
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
  'cajado-avicular',
  'other'::rpg.item_type,
  'Cajado Avicular',
  NULL,
  NULL,
  'Este cajado de madeira é decorado com entalhes de pássaros. Ele possui 10 cargas. Ao segurar o cajado, você pode executar uma ação Usar Magia para gastar 1 carga do cajado e fazer com que ele produza um dos seguintes sons, que podem ser ouvidos a até 36 metros: o chilrear de um tentilhão, o crocitar de um corvo, o cacarejar de uma galinha, o grasnar de um pato, o chamado de um mergulhão, o grugulejar de um peru, o chamado de uma gaivota, o crocitar de uma coruja ou o gritapoar de uma águia.
Recuperando Cargas. O cajado recupera 1d6 + 4 cargas gastas diariamente ao amanhecer. Se você gastar a última carga, jogue 1d20. Em um 1, o cajado explode em uma nuvem inofensiva de penas de pássaro e se perde para sempre.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Cajado","rarity":"common","rarityLabel":"Comum","requiresAttunement":false,"header":"Cajado, Comum"}'::jsonb
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
  'cajado-da-cura',
  'other'::rpg.item_type,
  'Cajado da Cura',
  NULL,
  NULL,
  'Este cajado possui 10 cargas. Ao empunhar o cajado, você pode conjurar uma das magias na tabela a seguir a partir dele, usando o modificador do seu atributo de conjuração. A tabela indica quantas cargas você deve gastar para conjurar a magia.
 
Magia
	Carga Usada
	Curar Ferimentos
	1 carga por círculo de magia (máximo de 4 para uma magia de 4º círculo)
	Curar Ferimentos em Massa
	5
	Restauração Menor
	2
	Recuperando Cargas. O cajado recupera 1d6 + 4 cargas gastas diariamente ao amanhecer. Ao gastar a última carga, jogue 1d20. Em um resultado 1, o cajado desaparece em um clarão de luz e é perdido para sempre.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Cajado","rarity":"rare","rarityLabel":"Raro","requiresAttunement":true,"header":"Cajado, Raro (Requer Sintonização por um Bardo, Clérigo ou Druida)","attunement":"Requer Sintonização por um Bardo, Clérigo ou Druida"}'::jsonb
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
  'cajado-da-piton',
  'other'::rpg.item_type,
  'Cajado da Píton',
  NULL,
  NULL,
  'Como uma ação Usar Magia, você pode arremessar este cajado de modo que ele caia em um espaço desocupado a até 3 metros de você, fazendo com que o cajado se transforme em uma Cobra Constritora Gigante nesse espaço. A cobra está sob seu controle e compartilha sua contagem de Iniciativa, tendo o turno imediatamente o seu.
No seu turno, você pode controlar mentalmente a cobra (nenhuma ação é necessária) se ela estiver a até 18 metros de você e você não estiver sob a condição Incapacitado. Você decide a ação que a cobra executa e para onde ela se move durante o turno dela, ou pode dar um comando geral, como atacar inimigos ou proteger um local. Na ausência de comandos seus, a cobra se defende sozinha.
Como uma Ação Bônus, você pode comandar a cobra a reverter para a forma de cajado no espaço em que estiver, e você não pode usar essa propriedade do cajado novamente por 1 hora. Se a cobra for reduzida a 0 Pontos de Vida, ela morre e reverte para sua forma de cajado; o cajado então se parte e é destruído. Se a cobra reverter para a forma de cajado antes de perder todos os seus Pontos de Vida, ela restaura todos eles.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Cajado","rarity":"uncommon","rarityLabel":"Incomum","requiresAttunement":true,"header":"Cajado, Incomum (Requer Sintonização)","attunement":"Requer Sintonização"}'::jsonb
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
  'cajado-da-trovoada-relampejante',
  'other'::rpg.item_type,
  'Cajado da Trovoada Relampejante',
  NULL,
  NULL,
  'Este cajado pode ser empunhado como um Cajado mágico que concede um bônus de +2 para jogadas de ataque e dano realizadas com ele. Ele também possui as seguintes propriedades adicionais. Uma vez que uma dessas propriedades é usada, ela não pode ser usada novamente até o próximo amanhecer.
Golpe de Relâmpago. Você pode executar uma ação Usar Magia para fazer com que um relâmpago salte da ponta do cajado em uma Linha com 1,5 metro de largura e 36 metros de comprimento. Cada criatura nessa Linha realiza uma salvaguarda de Destreza CD 17, sofrendo 9d6 pontos de dano Elétrico se falhar ou metade desse dano em caso de sucesso.
Relâmpago. Ao atingir com uma jogada de ataque corpo a corpo usando o cajado, você pode causar ao alvo 2d6 pontos de dano Elétrico adicionais (nenhuma ação é necessária).
Trovão e Relâmpago. Imediatamente após atingir com uma jogada de ataque corpo a corpo usando o cajado, você pode executar uma Ação Bônus para usar as propriedades Relâmpago e Trovão (veja acima) ao mesmo tempo. Ao fazer isso, você não gasta o uso diário dessas propriedades, apenas o uso desta.
Trovão. Ao atingir com uma jogada de ataque corpo a corpo usando o cajado, você pode fazer com que o cajado emita um estrondo de trovão audível a até 90 metros (nenhuma ação é necessária). O alvo atingido deve ser bem-sucedido em uma salvaguarda de Constituição CD 17 ou tem a condição Atordoado até o final do seu próximo turno.
Trovoada. Você pode executar uma ação Usar Magia para fazer o cajado produzir um estrondo audível a até 180 metros. Cada criatura dentro de uma Emanação de 18 metros originada de você realiza uma salvaguarda de Constituição CD 17. Se falhar, uma criatura sofre 2d6 pontos de dano Trovejante e tem a condição Surdo por 1 minuto. Em caso de sucesso, uma criatura sofre apenas metade desse dano.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Cajado","rarity":"very-rare","rarityLabel":"Muito Raro","requiresAttunement":true,"header":"Cajado, Muito Raro (Requer Sintonização)","attunement":"Requer Sintonização"}'::jsonb
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
  'cajado-da-vibora',
  'other'::rpg.item_type,
  'Cajado da Víbora',
  NULL,
  NULL,
  'Como uma Ação Bônus, você pode transformar a cabeça deste cajado em uma Cobra Peçonhenta animada por 1 minuto ou reverter o cajado para sua forma inanimada.
Ao executar a ação Atacar, você pode realizar uma das jogadas de ataque usando a cabeça da cobra animada, que possui um alcance de 1,5 metro. Aplique seu Bônus de Proficiência e modificador de Sabedoria à jogada de ataque. Em caso de acerto, o alvo sofre 1d6 pontos de dano Perfurante e 3d6 pontos de dano Venenoso.
A cabeça da cobra pode ser atacada enquanto estiver animada. Ela tem CA 15, 20 PV e Imunidade a Dano Psíquico e Venenoso. Se a cabeça for reduzida a 0 Pontos de Vida, o cajado é destruído. Enquanto não for destruído, o cajado recupera todos os Pontos de Vida perdidos quando reverte à sua forma inanimada.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Cajado","rarity":"uncommon","rarityLabel":"Incomum","requiresAttunement":true,"header":"Cajado, Incomum (Requer Sintonização)","attunement":"Requer Sintonização"}'::jsonb
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
  'cajado-das-matas',
  'other'::rpg.item_type,
  'Cajado das Matas',
  NULL,
  NULL,
  'Este cajado possui 6 cargas e pode ser empunhado como um Cajado mágico que concede um bônus de +2 para jogadas de ataque e dano realizadas com ele. Ao empunhar o cajado, você adquire um bônus de +2 nas jogadas de ataque mágico.
Forma Arbórea. Você pode executar uma ação Usar Magia para fincar uma das extremidades do cajado na terra em um espaço desocupado e gastar 1 carga para transformar o cajado em uma árvore saudável. A árvore possui 18 metros de altura e um tronco com 1,5 metro de diâmetro, e seus galhos da copa se espalham em um raio de 6 metros. A árvore parece comum, comum, mas emite uma aura tênue de magia de Transmutação que pode ser percebida com a magia Detectar Magia. Ao tocar a árvore e executar uma ação Usar Magia, você retorna o cajado à sua forma normal. Qualquer criatura que estiver na árvore cai quando a árvore reverte à forma de cajado.
Magias. Enquanto segurar o cajado, você pode conjurar uma das magias na tabela a seguir a partir dele, usando a CD para evitar sua magia. A tabela indica quantas cargas você deve gastar para conjurar a magia.
Magia
	Carga Usada
	Amizade Animal
	1
	Despertar
	5
	Falar com Animais
	1
	Falar com Plantas
	3
	Localizar Animais ou Plantas
	2
	Muralha de Espinhos
	6
	Passo Sem Rastro
	2
	Pele-casca
	2
	Recuperando Cargas. O cajado recupera 1d6 cargas gastas diariamente ao amanhecer. Ao gastar a última carga, jogue 1d20. Em um resultado 1, o cajado perde suas propriedades e se torna um Cajado não mágico.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Cajado","rarity":"rare","rarityLabel":"Raro","requiresAttunement":true,"header":"Cajado, Raro (Requer Sintonização por um Druida)","attunement":"Requer Sintonização por um Druida"}'::jsonb
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
  'cajado-de-flores',
  'other'::rpg.item_type,
  'Cajado de Flores',
  NULL,
  NULL,
  'Este cajado de madeira possui 10 cargas. Ao empunhar o cajado, você pode executar uma ação Usar Magia para gastar 1 carga do cajado e fazer com que uma flor brote de um pedaço de terra ou solo a até 1,5 metro de você, ou do próprio cajado. A menos que você escolha um tipo específico de flor, o cajado cria uma margarida de aroma suave. A flor é inofensiva e não mágica, e cresce ou murcha como uma flor normal.
Recuperando Cargas. O cajado recupera 1d6 + 4 cargas gastas diariamente ao amanhecer. Ao gastar a última carga, jogue 1d20. Em um resultado 1, o cajado se transforma em pétalas de flores e é perdido para sempre.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Cajado","rarity":"common","rarityLabel":"Comum","requiresAttunement":false,"header":"Cajado, Comum"}'::jsonb
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
  'cajado-do-acrobata',
  'weapon'::rpg.item_type,
  'Cajado do Acrobata',
  NULL,
  NULL,
  'Você adquire um bônus de +2 em jogadas de ataque e dano realizadas com esta arma mágica.
Enquanto estiver segurando esta arma, você pode fazê-la emitir Meia-luz verde em um raio de 3 metros como uma Ação Bônus ou após jogar a Iniciativa, ou apagar a luz como uma Ação Bônus.
Enquanto estiver segurando esta arma, você pode executar uma Ação Bônus para alterar sua forma, transformando-a em um cetro de 15 centímetros (para facilitar o armazenamento) ou uma haste de 3 metros, ou revertendo-a para um Cajado; a arma se alongará apenas até onde o espaço circundante permitir.
Em certas formas, a arma possui as seguintes propriedades adicionais.
Arma à Distância (Apenas na Forma Cajado). Esta arma possui a propriedade Arremesso com alcance normal de 9 metros e máximo de 36 metros. Imediatamente após realizar um ataque à distância com a arma, ela voa de volta para a sua mão.
Assistência Acrobática (Apenas nas Formas de Cajado e Haste de 3 Metros). Enquanto estiver segurando esta arma, você tem Vantagem em testes de Destreza (Acrobacia).
Deflexão de Ataque (Apenas na Forma de Cajado). Ao ser atingido por um ataque enquanto segura a arma, você pode executar uma Reação para girá-la ao seu redor, recebendo um bônus de +5 na sua Classe de Armadura contra o ataque desencadeante, o que pode fazê-lo errar. Você não pode usar esta propriedade novamente até completar um Descanso Curto ou Longo.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Arma (Cajado)","rarity":"very-rare","rarityLabel":"Muito Raro","requiresAttunement":true,"header":"Arma (Cajado), Muito Raro (Requer Sintonização)","attunement":"Requer Sintonização","weaponSubtype":"Cajado"}'::jsonb
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
  'cajado-do-agravo',
  'other'::rpg.item_type,
  'Cajado do Agravo',
  NULL,
  NULL,
  'Este cajado pode ser empunhado como um Cajado mágico que concede um bônus de +3 para jogadas de ataque e dano realizadas com ele.
O cajado possui 10 cargas. Ao atingir com uma jogada de ataque corpo a corpo usando ele, você pode gastar até 3 cargas. Para cada carga que você gastar, o alvo sofre 1d6 pontos de dano Energético adicionais.
Recuperando Cargas. O cajado recupera 1d6 + 4 cargas gastas diariamente ao amanhecer. Ao gastar a última carga, jogue 1d20. Em um resultado 1, o cajado se torna um Cajado não mágico.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Cajado","rarity":"very-rare","rarityLabel":"Muito Raro","requiresAttunement":true,"header":"Cajado, Muito Raro (Requer Sintonização)","attunement":"Requer Sintonização"}'::jsonb
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
  'cajado-do-definhamento',
  'other'::rpg.item_type,
  'Cajado do Definhamento',
  NULL,
  NULL,
  'Este cajado tem 3 cargas e recupera 1d3 cargas gastas diariamente ao amanhecer.
O cajado pode ser empunhado como um Cajado mágico. Em um acerto, ele causa dano como um Cajado normal, e você pode gastar 1 carga para causar ao alvo 2d10 pontos de dano Necrótico adicionais e forçá-lo a realizar uma salvaguarda de Constituição CD 15. Se falhar, o alvo tem Desvantagem por 1 hora em qualquer teste de atributo ou salvaguarda que use Força ou Constituição.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Cajado","rarity":"rare","rarityLabel":"Raro","requiresAttunement":true,"header":"Cajado, Raro (Requer Sintonização)","attunement":"Requer Sintonização"}'::jsonb
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
  'cajado-do-enxame-de-insetos',
  'other'::rpg.item_type,
  'Cajado do Enxame de Insetos',
  NULL,
  NULL,
  'Este cajado possui 10 cargas.
Magias. Ao empunhar o cajado, você pode conjurar uma das magias na tabela a seguir a partir dele, usando a CD para evitar sua magia e seu modificador de ataque mágico. A tabela indica quantas cargas você deve gastar para conjurar a magia.
Magia
	Carga Usada
	Inseto Gigante
	4
	Praga de Insetos
	5
	Nuvem de Insetos. Ao empunhar o cajado, você pode executar uma ação Usar Magia e gastar 1 carga para fazer com que um Enxame de insetos voadores inofensivos preencha uma Emanação de 9 metros originada em você. Os insetos permanecem por 10 minutos, tornando a área Totalmente Obscurecida para criaturas além de você. Um vento forte (como o criado por Lufada de Vento) dissipa o enxame e encerra o efeito.
Recuperando Cargas. O cajado recupera 1d6 + 4 cargas gastas diariamente ao amanhecer. Ao gastar a última carga, jogue 1d20. Em um resultado 1, um Enxame de insetos consome e destrói o cajado, depois se dispersa.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Cajado","rarity":"rare","rarityLabel":"Raro","requiresAttunement":true,"header":"Cajado, Raro (Requer Sintonização por um Bardo, Bruxo, Clérigo, Druida, Feiticeiro ou Mago)","attunement":"Requer Sintonização por um Bardo, Bruxo, Clérigo, Druida, Feiticeiro ou Mago"}'::jsonb
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
  'cajado-do-fogo',
  'other'::rpg.item_type,
  'Cajado do Fogo',
  NULL,
  NULL,
  'Você tem Resistência a dano Ígneo enquanto empunha este cajado.
Magias. O cajado possui 10 cargas. Ao empunhar o cajado, você pode conjurar uma das magias na tabela a seguir a partir dele, usando a CD para evitar sua magia. A tabela indica quantas cargas você deve gastar para conjurar a magia.
Magia
	Carga Usada
	Bola de Fogo
	3
	Mãos Flamejantes
	1
	Muralha de Fogo
	4
	Recuperando Cargas. O cajado recupera 1d6 + 4 cargas gastas diariamente ao amanhecer. Ao gastar a última carga, jogue 1d20. Em um resultado 1, o cajado se desfaz em cinzas e é destruído.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Cajado","rarity":"very-rare","rarityLabel":"Muito Raro","requiresAttunement":true,"header":"Cajado, Muito Raro (Requer Sintonização por um Bruxo, Druida, Feiticeiro ou Mago)","attunement":"Requer Sintonização por um Bruxo, Druida, Feiticeiro ou Mago"}'::jsonb
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
  'cajado-do-gelo',
  'other'::rpg.item_type,
  'Cajado do Gelo',
  NULL,
  NULL,
  'Você tem Resistência a dano Gélido enquanto empunhar este cajado.
Magias. O cajado possui 10 cargas. Ao empunhar o cajado, você pode conjurar uma das magias na tabela a seguir a partir dele, usando a CD para evitar sua magia. A tabela indica quantas cargas você deve gastar para conjurar a magia.
Magia
	Carga Usada
	Cone de Frio
	5
	Muralha de Gelo
	4
	Névoa Obscurecente
	1
	Tempestade Glacial
	4
	Recuperando Cargas. O cajado recupera 1d6 + 4 cargas gastas diariamente ao amanhecer. Ao gastar a última carga, jogue 1d20. Em um resultado 1, o cajado se transforma em água e é destruído.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Cajado","rarity":"very-rare","rarityLabel":"Muito Raro","requiresAttunement":true,"header":"Cajado, Muito Raro (Requer Sintonização por um Bruxo, Druida, Feiticeiro ou Mago)","attunement":"Requer Sintonização por um Bruxo, Druida, Feiticeiro ou Mago"}'::jsonb
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
  'cajado-do-poder',
  'other'::rpg.item_type,
  'Cajado do Poder',
  NULL,
  NULL,
  'Este cajado possui 20 cargas e pode ser empunhado como um Cajado mágico que concede um bônus de +2 para jogadas de ataque e dano realizadas com ele. Ao empunhar o cajado, você adquire um bônus de +2 na Classe de Armadura, salvaguardas e jogada de ataque mágico.
Golpe Retributivo. Você pode executar uma ação Usar Magia para quebrar o cajado sobre o joelho ou contra uma superfície sólida. O cajado é destruído e libera sua magia em uma explosão que preenche uma Emanação de 9 metros originada dele. Você tem 50% de chance de se teleportar instantaneamente para um plano de existência aleatório, evitando a explosão. Se falhar em evitar o efeito, você sofre dano Energético igual a 16 vezes o número de cargas no cajado. Cada outra criatura na área realiza uma salvaguarda de Destreza CD 17. Se falhar, uma criatura sofre dano Energético igual a 4 vezes o número de cargas no cajado. Em caso de sucesso, uma criatura sofre metade desse dano.
Magias. Enquanto segurar o cajado, você pode conjurar uma das magias na tabela a seguir a partir dele, usando a CD para evitar sua magia. A tabela indica quantas cargas você deve gastar para conjurar a magia.
Magia
	Carga Usada
	Bola de Fogo (de 5º círculo)
	5
	Cone de Frio
	5
	Globo de Invulnerabilidade
	6
	Levitação
	2
	Mísseis Mágicos
	1
	Muralha de Energia
	5
	Paralisar Monstro
	5
	Raio do Enfraquecimento
	1
	Relâmpago (de 5º círculo)
	5
	Recuperando Cargas. O cajado recupera 2d8 + 4 cargas gastas diariamente ao amanhecer. Ao gastar a última carga, jogue 1d20. Em um resultado 1, o cajado mantém seu bônus de +2 em jogadas de ataque e dano, mas perde todas as outras propriedades. Em um resultado 20, o cajado recupera 1d8 + 2 cargas.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Cajado","rarity":"very-rare","rarityLabel":"Muito Raro","requiresAttunement":true,"header":"Cajado, Muito Raro (Requer Sintonização por um Bruxo, Feiticeiro ou Mago)","attunement":"Requer Sintonização por um Bruxo, Feiticeiro ou Mago"}'::jsonb
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
  'cajado-dos-magi',
  'other'::rpg.item_type,
  'Cajado dos Magi',
  NULL,
  NULL,
  'Este cajado possui 50 cargas e pode ser empunhado como um Cajado mágico que concede um bônus de +2 para jogadas de ataque e dano realizadas com ele. Ao empunhá-lo, você adquire um bônus de +2 nas jogadas de ataque mágico.
Absorção de Magia. Ao empunhar o cajado, você tem Vantagem em salvaguardas contra magias. Além disso, você pode executar uma Reação quando outra criatura conjurar uma magia que tenha como alvo apenas você. Ao fazer isso, o cajado absorve a energia da magia, cancelando seu efeito e adquirindo um número de cargas igual ao círculo da magia absorvida. No entanto, se isso fizer com que o número total de cargas do cajado ultrapasse 50, o cajado explode como se você tivesse ativado seu Golpe Retributivo (veja abaixo).
Golpe Retributivo. Você pode executar uma ação Usar Magia para quebrar o cajado sobre o joelho ou contra uma superfície sólida. O cajado é destruído e libera sua magia em uma explosão que preenche uma Emanação de 9 metros originada dele. Você tem 50% de chance de se teleportar instantaneamente para um plano de existência aleatório, evitando a explosão (1d2, teleportado com um 1). Se falhar em evitar o efeito, você sofre dano Energético igual a 16 vezes o número de cargas no cajado. Cada outra criatura na área realiza uma salvaguarda de Destreza CD 17. Se falhar, uma criatura sofre dano Energético igual a 6 vezes o número de cargas no cajado. Em caso de sucesso, uma criatura sofre metade desse dano.
Magias. Enquanto segurar o cajado, você pode conjurar uma das magias na tabela a seguir a partir dele, usando a CD para evitar sua magia. A tabela indica quantas cargas você deve gastar para conjurar a magia.
 
Magia
	Carga Usada
	Arrombar
	2
	Aumentar/Reduzir
	0
	Bola de Fogo (de 7º círculo)
	7
	Criar Passagem
	5
	Detectar Magia
	0
	Dissipar Magia
	3
	Esfera Flamejante
	2
	Invisibilidade
	2
	Invocar Elemental
	7
	Luz
	0
	Mãos Mágicas
	0
	Muralha de Fogo
	4
	Proteção Contra o Bem e o Mal
	0
	Relâmpago (de 7º círculo)
	7
	Teia
	2
	Telecinese
	5
	Tempestade Glacial
	4
	Tranca Arcana
	0
	Transição Planar
	7
	Recuperando Cargas. O cajado recupera 4d6 + 2 cargas gastas diariamente ao amanhecer. Ao gastar a última carga, jogue 1d20. Em um resultado 20, o cajado recupera 1d12 + 1 cargas.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Cajado","rarity":"legendary","rarityLabel":"Lendário","requiresAttunement":true,"header":"Cajado, Lendário (Requer Sintonização por um Bruxo, Feiticeiro ou Mago)","attunement":"Requer Sintonização por um Bruxo, Feiticeiro ou Mago"}'::jsonb
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
  'cajado-dos-sortilegios',
  'other'::rpg.item_type,
  'Cajado dos Sortilégios',
  NULL,
  NULL,
  'Este cajado possui 10 cargas. Enquanto segura o cajado, você pode usar qualquer uma de suas propriedades:
Conjurar Magia. Você pode gastar 1 das cargas do cajado para conjurar Comando, Compreender Idiomas ou Enfeitiçar Pessoa, usando a CD para evitar sua magia.
Recuperando Cargas. O cajado recupera 1d8 + 2 cargas gastas diariamente ao amanhecer. Ao gastar a última carga, jogue 1d20. Em um resultado 1, o cajado se desfaz em pó e é destruído.
Refletir Encantamento. Ao ser bem-sucedido em uma salvaguarda contra uma magia de Encantamento que tem como alvo apenas você, pode executar uma Reação para gastar 1 carga do cajado e refletir a magia contra o conjurador, como se você mesmo a tivesse conjurado.
Resistir a Encantamento. Ao falhar em uma salvaguarda contra uma magia de Encantamento que tem como alvo apenas você, pode transformar sua falha em um sucesso. Você não pode usar esta propriedade do cajado novamente até o próximo amanhecer.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Cajado","rarity":"rare","rarityLabel":"Raro","requiresAttunement":true,"header":"Cajado, Raro (Requer Sintonização por um Bardo, Bruxo, Clérigo, Druida, Feiticeiro ou Mago)","attunement":"Requer Sintonização por um Bardo, Bruxo, Clérigo, Druida, Feiticeiro ou Mago"}'::jsonb
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
  'cajado-magificado',
  'other'::rpg.item_type,
  'Cajado Magificado',
  NULL,
  NULL,
  'Este cajado contém uma magia de 8º círculo ou inferior vinculada a ele. A magia é determinada no momento em que o cajado é criado e pode pertencer a qualquer escola de magia. O cajado possui 6 cargas e recupera 1d6 cargas gastas diariamente ao amanhecer. Enquanto estiver segurando o cajado, você pode gastar 1 carga para conjurar a magia vinculada a ele. Se você gastar a última carga do cajado, jogue 1d20. Com um resultado de 1, o cajado perde suas propriedades e se torna um Cajado não mágico.
O círculo da magia vinculada ao cajado determina a CD da salvaguarda da magia, o bônus de ataque e a raridade do cajado, conforme mostrado na tabela a seguir.
Círculo de Magia
	Raridade
	CD da Salvaguarda
	Bônus de Ataque
	Truque
	Incomum
	13
	+5
	1
	Incomum
	13
	+5
	2
	Raro
	13
	+5
	3
	Raro
	15
	+7
	4
	Muito Raro
	15
	+7
	5
	Muito Raro
	 17
	+9
	6
	Lendário
	17
	+9
	7
	Lendário
	18
	+10
	8
	Lendário
	18
	+10',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Cajado","rarity":"varies","rarityLabel":"Raridade Variável","requiresAttunement":true,"header":"Cajado, Raridade Varia (Requer Sintonização por um Conjurador)","attunement":"Requer Sintonização por um Conjurador"}'::jsonb
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
  'cajado-ornamental',
  'other'::rpg.item_type,
  'Cajado Ornamental',
  NULL,
  NULL,
  'Se você posicionar um objeto Minúsculo pesando no máximo 0,5 quilo (como um fragmento de cristal, um ovo ou uma pedra) acima da ponta deste cajado enquanto o segura, o objeto flutua a 2,5 cm da ponta do cajado e permanece lá até ser removido ou até que o cajado deixar de estar em sua posse. O cajado pode ter até três desses objetos flutuando sobre sua ponta ao mesmo tempo. Ao segurar o cajado, você pode fazer um ou mais desses objetos girarem, ou se moverem lentamente no lugar.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Cajado","rarity":"common","rarityLabel":"Comum","requiresAttunement":false,"header":"Cajado, Comum"}'::jsonb
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
  'caldeirao-do-renascimento',
  'other'::rpg.item_type,
  'Caldeirão do Renascimento',
  NULL,
  NULL,
  'Este pote Minúsculo traz cenas em relevo de heróis em suas laterais de ferro fundido.
Você pode usar o caldeirão como Foco de Conjuração para suas magias, e ele funciona como um componente adequado para a magia Vidência.
Preparar Poção. Ao completar um Descanso Longo, você pode usar o caldeirão para preparar uma Poção de Cura (maior), o que leva 1 minuto. A poção dura 24 horas, e então perde a magia se não for consumida.
Reviver os Mortos. Com uma ação Usar Magia, você pode fazer com que o caldeirão cresça o suficiente para que uma criatura Média se agache dentro dele. Você pode reverter o caldeirão para o tamanho normal como uma ação Usar Magia, realocando inofensivamente qualquer coisa que não caiba dentro dele para o espaço desocupado mais próximo.
Se você colocar o cadáver de um Humanoide no caldeirão e cobri-lo com 90 quilos de sal (que custa 10 PO) por pelo menos 8 horas, o sal é consumido e a criatura retorna à vida como na magia Reviver os Mortos, no próximo amanhecer. Uma vez usada, esta propriedade não pode ser usada novamente por 7 dias.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"very-rare","rarityLabel":"Muito Raro","requiresAttunement":true,"header":"Item Maravilhoso, Muito Raro (Requer Sintonização por um Bruxo ou Druida)","attunement":"Requer Sintonização por um Bruxo ou Druida"}'::jsonb
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
  'caneca-da-sobriedade',
  'other'::rpg.item_type,
  'Caneca da Sobriedade',
  NULL,
  NULL,
  'Esta caneca possui um rosto sério esculpido em um dos lados. Você pode beber cerveja, vinho ou qualquer outra bebida alcoólica não mágica colocada nela sem ficar embriagado. A caneca não afeta líquidos mágicos ou substâncias perigosas, como venenos.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"common","rarityLabel":"Comum","requiresAttunement":false,"header":"Item Maravilhoso, Comum"}'::jsonb
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
  'capa-aracnidea',
  'other'::rpg.item_type,
  'Capa Aracnídea',
  NULL,
  NULL,
  'Esta bela peça de roupa é feita de seda preta, entrelaçada com finos fios prateados. Ao usá-la, você adquire os seguintes benefícios.
Caminhada da Aranha. Você não pode ser aprisionado em teias de qualquer tipo e pode se mover através delas como se estivesse em Terreno Difícil.
Escalada de Aranha. Você tem um Deslocamento de Escalada igual ao seu Deslocamento e pode se mover por superfícies verticais e ao longo de tetos, deixando as mãos livres.
Resistência a Veneno. Você tem Resistência a dano Venenoso.
Teia. Você pode conjurar Teia (CD 13 para evitar). A teia criada pela magia preenche o dobro da área normal. Uma vez usada, esta propriedade não pode ser usada novamente até o próximo amanhecer.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"very-rare","rarityLabel":"Muito Raro","requiresAttunement":true,"header":"Item Maravilhoso, Muito Raro (Requer Sintonização)","attunement":"Requer Sintonização"}'::jsonb
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
  'capa-de-muitas-modas',
  'other'::rpg.item_type,
  'Capa de Muitas Modas',
  NULL,
  NULL,
  'Enquanto estiver vestindo esta capa, você pode executar uma Ação Bônus para alterar o estilo, a cor e a qualidade aparente dela O peso da capa não muda. Independentemente da aparência da capa, ela não pode ser nada além de uma capa. Embora duplique a aparência de outras capas e mantos mágicos, não obtém as propriedades mágicas delas.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"common","rarityLabel":"Comum","requiresAttunement":false,"header":"Item Maravilhoso, Comum"}'::jsonb
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
  'capa-deslocadora',
  'other'::rpg.item_type,
  'Capa Deslocadora',
  NULL,
  NULL,
  'Enquanto estiver usando esta capa, ela magicamente projeta uma ilusão que faz você parecer estar em um local perto de sua localização real, impondo Desvantagem em qualquer jogada de ataque que criaturas realizarem contra você. Se você sofrer dano, a propriedade deixa de funcionar até o início do seu próximo turno. Esta propriedade é suprimida enquanto seu Deslocamento for 0.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"rare","rarityLabel":"Raro","requiresAttunement":true,"header":"Item Maravilhoso, Raro (Requer Sintonização)","attunement":"Requer Sintonização"}'::jsonb
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
  'capa-do-povo-elfico',
  'other'::rpg.item_type,
  'Capa do Povo Élfico',
  NULL,
  NULL,
  'Enquanto estiver usando esta capa, testes de Sabedoria (Percepção) realizados para notá-lo têm Desvantagem e você tem Vantagem em testes de Destreza (Furtividade).',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"uncommon","rarityLabel":"Incomum","requiresAttunement":true,"header":"Item Maravilhoso, Incomum (Requer Sintonização)","attunement":"Requer Sintonização"}'::jsonb
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
  'capa-do-saltimbanco',
  'other'::rpg.item_type,
  'Capa do Saltimbanco',
  NULL,
  NULL,
  'Esta capa exala um leve odor de enxofre. Ao usá-la, você pode conjurar Porta Dimensional como uma ação Usar Magia. Essa propriedade só pode ser utilizada novamente após o próximo amanhecer.
Ao se teleportar com esta magia, você deixa uma nuvem de fumaça para trás. O espaço que você deixou fica Parcialmente Obscurecido por essa fumaça até o final do seu próximo turno.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"rare","rarityLabel":"Raro","requiresAttunement":false,"header":"Item Maravilhoso, Raro"}'::jsonb
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
  'capa-esvoacante',
  'other'::rpg.item_type,
  'Capa Esvoaçante',
  NULL,
  NULL,
  'Enquanto estiver vestindo esta capa, você pode executar uma Ação Bônus para fazê-la ondular dramaticamente por 1 minuto.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"common","rarityLabel":"Comum","requiresAttunement":false,"header":"Item Maravilhoso, Comum"}'::jsonb
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
  'carrilhao-destrancador',
  'other'::rpg.item_type,
  'Carrilhão Destrancador',
  NULL,
  NULL,
  'Este tubo de metal oco mede cerca de 30 centímetros de comprimento e pesa 0,5 quilo. Como uma ação Usar Magia, você pode tocar o carrilhão para conjurar Arrombar. O som de batida habitual da magia é substituído pelo tom claro e retumbante do carrilhão, que é audível a 90 metros.
O carrilhão pode ser usado 10 vezes. Após a décima vez, ele racha e se torna inútil.
Cetro da Absorção
Cetro, Muito Raro (Requer Sintonização)
Enquanto segura este cetro, você pode executar uma Reação para absorver uma magia que tem como alvo apenas você e não cria uma área de efeito. O efeito da magia absorvida é cancelado, e a energia da magia — não a própria magia — é armazenada no cetro. A energia tem o mesmo círculo da magia quando foi conjurada. Uma magia cancelada se dissipa sem efeito, e quaisquer recursos usados para conjurá-la são desperdiçados. O cetro pode absorver e armazenar até 50 círculos de energia ao longo de sua existência. Uma vez que o cetro absorve 50 círculos de energia, ele não pode absorver mais. Se você for alvo de uma magia que o cetro não pode armazenar, o cetro não tem efeito sobre essa magia.
Ao sintonizar com o cetro, você sabe quantos círculos de energia o cetro absorveu ao longo de sua existência e quantos círculos de energia mágica ele tem atualmente armazenado.
Se você é um conjurador segurando o cetro, pode converter energia armazenada nele em espaços de magia para conjurar magias que você preparou ou conhece. Você pode criar espaços de magia apenas de um círculo igual ou inferior aos seus próprios espaços de magia, até um máximo de 5º círculo. Você usa os círculos armazenados no lugar de seus espaços, mas conjura a magia normalmente. Por exemplo, você pode usar 3 círculos armazenados no cetro como um espaço de magia de 3º círculo.
Um cetro recém-descoberto normalmente tem 1d10 círculos de energia mágica armazenados. Um cetro que não pode mais absorver energia mágica e não tem energia restante torna-se não mágico.
Disponível: Você pode acompanhar a quantidade de energia disponível aqui.
Cetro da Prontidão
Cetro, Muito Raro (Requer Sintonização)
Este cetro tem as seguintes propriedades.
Prontidão. Enquanto segura o cetro, você tem Vantagem em testes de Sabedoria (Percepção) e em jogadas de Iniciativa.
Magias. Enquanto segura o cetro, você pode conjurar as seguintes magias a partir dele:
● Detectar Magia
● Detectar o Bem e o Mal
● Detectar Veneno e Doença
● Ver o Invisível
Aura Protetora. Como uma ação Usar Magia, você pode plantar a extremidade do cetro no chão, após o que a extremidade do cetro emite Luz Plena em um raio de 18 metros e Meia-luz por mais 18 metros. Enquanto estiver nessa Luz Plena, você e seus aliados ganham um bônus de +1 na Classe de Armadura e nas salvaguardas, e podem sentir a localização de qualquer criatura Invisível que também esteja na Luz Plena.
A extremidade do cetro para de brilhar e o efeito termina após 10 minutos ou quando uma criatura executa uma ação Usar Magia para puxar o cetro do chão. Uma vez usada, esta propriedade não pode ser usada novamente até o próximo amanhecer.
Cetro da Regência
Cetro, Raro (Requer Sintonização)
Você pode executar uma ação Usar Magia para apresentar o cetro e ordenar obediência a cada criatura à sua escolha, à sua vista e a até 36 metros de você. Cada alvo deve ser bem-sucedido em uma salvaguarda de Sabedoria CD 15 ou tem a condição Enfeitiçado por 8 horas. Embora Enfeitiçada deste modo, a criatura considera você como líder confiável. Se for ferido por você ou seus aliados, ou ordenado a fazer algo contrário à sua natureza, um alvo deixa de estar Enfeitiçado deste modo. Uma vez usada, esta propriedade não pode ser usada novamente até o próximo amanhecer.
Cetro da Segurança
Cetro, Muito Raro
Enquanto segura este cetro, você pode executar uma ação Usar Magia para ativá-lo. O cetro então transporta instantaneamente você e até 199 outras criaturas voluntárias à sua vista para um semiplano. Você escolhe a forma que o semiplano assume. Pode ser um jardim tranquilo, uma taverna alegre, um palácio imenso, uma ilha tropical, um parque de diversões fantástico ou qualquer outra coisa que você possa imaginar. Independentemente da sua natureza, o semiplano contém água e comida suficientes para sustentar seus visitantes, e o ambiente do semiplano não pode prejudicar seus ocupantes. Tudo o mais que pode ser interagido lá só pode existir lá. Por exemplo, uma flor colhida de um jardim ali desaparece se for levada para fora do semiplano.
Para cada hora gasta no semiplano, um visitante recupera Pontos de Vida como se tivesse gasto 1 Dado de Ponto de Vida. Além disso, as criaturas não envelhecem enquanto estão lá, embora o tempo passe normalmente. Os visitantes podem permanecer lá por até 200 dias divididos pelo número de criaturas presentes (arredondado para baixo).
Quando o tempo se esgota ou você executa uma ação Usar Magia para encerrar o efeito, todos os visitantes reaparecem no local que ocupavam quando você ativou o cetro ou um espaço desocupado mais próximo desse local. Uma vez usada, esta propriedade não pode ser usada novamente até passarem 10 dias.
Cetro de Poder Magistral
Cetro, Lendário (Requer Sintonização)
Este cetro tem uma extremidade com flanges e funciona como uma Maça mágica que concede um bônus de +3 para jogadas de ataque e dano realizadas com ela. O cetro tem propriedades associadas a seis diferentes botões que são dispostos em uma linha ao longo do eixo. Também possui outras três propriedades, detalhadas abaixo.
Botões. Você pode pressionar um dos seguintes botões como uma Ação Bônus; o efeito de um botão dura até você apertar um botão diferente ou até você apertar o mesmo botão novamente, o que faz com que o cetro volte à sua forma normal:
Cetro da Regência, Cetro de Poder Magistral, Cetro de Ressurreição, Corda de Emaranhamento
Botão 1. Uma lâmina flamejante brota da extremidade oposta à extremidade com flanges do cetro. As chamas emitem Luz Plena em um raio de 12 metros e Meia-luz por mais 12 metros, e a lâmina funciona como uma Espada Longa ou Espada Curta mágica (à sua escolha) que causa 2d6 pontos de dano Ígneo adicionais em um acerto.
Botão 2. A extremidade com flanges do cetro se dobra e duas lâminas em forma de crescente saltam para fora, transformando o cetro em um Machado de Batalha mágico que concede um bônus de +3 para jogadas de ataque e dano realizadas com ele.
Botão 3. A extremidade com flanges do cetro se dobra, uma ponta de lança salta da extremidade do cetro e o cabo do cetro se alonga em uma haste de 1,8 metro, transformando o cetro em uma Lança mágica que concede um bônus de +3 para jogadas de ataque e dano realizadas com ela.
Botão 4. O cetro se transforma em uma baliza de escalada de até 15 metros de comprimento (você especifica o comprimento), embora os botões do cetro permaneçam ao seu alcance. Em superfícies tão duras quanto o granito, um espigão na parte inferior e três ganchos na parte superior ancoram a baliza. Barras horizontais de 7,5 centímetros de comprimento se dobram ao longo das laterais, separadas por 30 centímetros, formando uma escada. A baliza pode suportar até 2.000 quilos. Mais peso ou falta de ancoragem sólida faz com que o cetro volte à sua forma normal.
Botão 5. O cetro se transforma em um aríete de mão e concede ao usuário um bônus de +10 nos testes de Força (Atletismo) realizados para romper portas, barricadas e outras barreiras.
Botão 6. O cetro assume ou permanece em sua forma normal e indica o norte magnético (nada acontece se essa função do cetro for usada em um local que não tenha norte magnético). O cetro também lhe dá conhecimento da profundidade aproximada abaixo do solo ou a altura acima dele.
Drenar Vida. Ao acertar uma criatura com um ataque corpo a corpo usando o cetro, você pode forçar o alvo a realizar uma salvaguarda de Constituição CD 17. Se falhar, o alvo sofre 4d6 pontos de dano Necrótico adicionais e você recupera um número de Pontos de Vida igual à metade desse dano. Uma vez usada, esta propriedade não pode ser usada novamente até o próximo amanhecer.
Paralisar. Ao acertar uma criatura com um ataque corpo a corpo usando o cetro, você pode forçar o alvo a realizar uma salvaguarda de Constituição CD 17. Se falhar, o alvo tem a condição Paralisado por 1 minuto. O alvo repete a salvaguarda no final de cada um dos turnos dele, encerrando o efeito em caso de sucesso. Uma vez usada, esta propriedade não pode ser usada novamente até o próximo amanhecer.
Aterrorizar. Enquanto segura o cetro, você pode executar uma ação Usar Magia para forçar cada criatura à sua vista a até 9 metros de distância a realizar uma salvaguarda de Sabedoria CD 17. Se falhar, o alvo tem a condição Amedrontado por 1 minuto. Um alvo Amedrontado repete a salvaguarda no final de cada um dos turnos dele, encerrando o efeito em caso de sucesso. Uma vez usada, esta propriedade não pode ser usada novamente até o próximo amanhecer.
Cetro de Ressurreição
Cetro, Lendário (Requer Sintonização)
O cetro tem 5 cargas. Enquanto o segura, você pode conjurar uma das seguintes magias: Cura Completa (gasta 1 carga) ou Ressurreição (gasta 5 cargas).
O Cetro recupera 1 carga gasta diariamente ao amanhecer. Se você gastar a última carga, jogue 1d20. Em um 1, o cetro desaparece em uma inofensiva explosão brilhante.
Cetro do Protetor do Pacto
Cetro, Incomum (+1), Raro (+2) ou Muito Raro (+3) (Requer Sintonização por um Bruxo)
Enquanto estiver segurando este cetro, você adquire um bônus em jogadas de ataque mágico e nas CDs de salvaguarda de suas magias de Bruxo. O bônus é determinado pela raridade do cetro.
Além disso, você pode recuperar um espaço de magia como uma ação Usar Magia enquanto segura o cetro. Você não pode usar esta propriedade novamente até completar um Descanso Longo.
Cetro Imóvel
Cetro, Incomum
Este cetro de ferro tem um botão em uma extremidade. Ao pressioná-lo como uma ação Usar Objeto, o cetro se fixa magicamente no lugar, desafiando a gravidade, até que você ou outra criatura pressione o botão novamente como uma ação Usar Objeto. Ele suporta até 4 toneladas; um peso maior desativa o cetro, fazendo-o cair. Uma criatura pode tentar mover o cetro fixo até 3 metros com um teste de Força (Atletismo) CD 30 como uma ação Usar Objeto, em caso de sucesso.
Cetro Tentacular
Cetro, Raro (Requer Sintonização)
Este cetro termina em três tentáculos maleáveis. Enquanto segurar o cetro, você pode executar uma ação Usar Magia para direcionar os tentáculos a se estendam e cada um ataque uma criatura à sua vista no alcance de até 4,5 metros. Para cada tentáculo, realize uma jogada de ataque corpo a corpo com um bônus de +9. Um tentáculo causa 1d6 pontos de dano Psíquico em um acerto. Se os três tentáculos atingirem o mesmo alvo, ele deve ser bem-sucedido em uma salvaguarda de Destreza CD 15 ou tem a condição Contido até que você tenha a condição Incapacitado, até que você execute uma Ação Bônus para liberar o alvo ou até que o alvo não esteja mais a até 4,5 metros de você. Enquanto Contido dessa maneira, o alvo sofre 3d6 pontos de dano Psíquico no início de cada um dos turnos dele. No final de cada um dos turnos dele, o alvo repete a salvaguarda, encerrando o efeito em caso de sucesso.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"rare","rarityLabel":"Raro","requiresAttunement":false,"header":"Item Maravilhoso, Raro"}'::jsonb
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
  'chapeu-das-muitas-magias',
  'other'::rpg.item_type,
  'Chapéu das Muitas Magias',
  NULL,
  NULL,
  'Este chapéu pontudo tem as seguintes propriedades.
Presto Conjura um Relâmpago Usando Seu Chapéu das Muitas Magias
Foco de Conjuração. Enquanto segura o chapéu, você pode usá-lo como um Foco de Conjuração para suas magias de Mago. Qualquer magia que você conjurar usando o chapéu tem um componente Somático especial: você deve colocar a mão no chapéu e "puxar" a magia para fora dele.
Magia Desconhecida. Ao segurar o chapéu, você pode tentar conjurar uma magia de 1º círculo ou superior que não conhece. A magia deve estar na lista de magias do Mago, ser de um círculo que você pode conjurar e não ter componentes Materiais que custem mais de 1.000 PO. Após escolher a magia, gaste um espaço de magia correspondente ao seu círculo. Para determinar se você conjura a magia, realize um teste de Inteligência (Arcanismo) CD 10 mais o círculo da magia. Em caso de sucesso, você conjura a magia normalmente e não pode usar esta propriedade novamente até completar um Descanso Curto ou Longo. Se falhar, a magia não é conjurada, e um efeito aleatório ocorre, determinado pela jogada na tabela a seguir.
Qualquer magia que você conjurar do chapéu usa a CD para evitar sua magia e seu modificador de ataque mágico.
1d100 Efeito
01–50
	Você conjura uma magia aleatória determinada pela jogada de 1d10: em um 1, Aumentar/Reduzir (efeito de aumentar); em um 2, Aumentar/Reduzir (efeito de reduzir); em um 3, Fogo das Fadas; em um 4, Bola de Fogo; em um 5, Lufada de Vento; em um 6, Invisibilidade (conjurada em você mesmo); em um 7, Relâmpago; em um 8, Força Espectral; em um 9, Polimorfia; em um 10, Nuvem Fétida.
	51–55
	Você tem a condição Atordoado até o final do seu próximo turno, acreditando que algo incrível acabou de acontecer.
	56–60
	Um enxame inofensivo de borboletas preenche um Cubo de 3 metros a até 9 metros de você. O enxame se dispersa após 1 minuto.
	61–65
	Você retira um objeto não mágico do chapéu. Jogue 1d4 para determinar o objeto: em um 1, um frasco de Ácido; em um 2, um pote de Fogo Alquímico; em um 3, um Pé de Cabra; em um 4, uma Tocha acesa.
	66–70
	Você sofre um ataque de “doença mágica” e tem a condição Envenenado por 1 hora.
	71–75
	Você tem a condição Petrificado até o final do seu próximo turno.
	76–80
	Você retira um objeto não mágico do chapéu. Jogue 1d4 para determinar o objeto: em um 1, uma Adaga; em um 2, uma Corda com um Arpéu amarrado a uma das extremidades; em um 3, um saco de Estrepes; em um 4, uma gema no valor de 50 PO.
	81–85
	Uma criatura aparece em um espaço desocupado o mais próximo possível de você. A criatura não está sob seu controle e age como normalmente faria, e desaparece após 1 hora ou quando alcança 0 Pontos de Vida. Jogue 1d4 para determinar a criatura: em um 1, um Camelo; em um 2, uma Cobra Constritora; em um 3, um Elefante; em um 4, uma Mula.
	86–90
	Um Enxame de Morcegos Hostil voa para fora do chapéu, ocupa seu espaço e ataca você.
	91–95
	Um portal bidirecional vertical, com 3 metros de diâmetro, se abre para outro plano de existência em um espaço desocupado a até 9 metros de você e permanece aberto até o final do seu próximo turno. O Mestre decide o destino do portal.
	96–00
	Você tira um item mágico do chapéu. Jogue 1d6 para determinar a raridade do item: em um 1–3, Comum; em um 4–5, Incomum; em um 6, Raro. O Mestre escolhe o item, que desaparece após 1 hora se não for consumido ou destruído antes disso.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"very-rare","rarityLabel":"Muito Raro","requiresAttunement":true,"header":"Item Maravilhoso, Muito Raro (Requer Sintonização por um Mago)","attunement":"Requer Sintonização por um Mago"}'::jsonb
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
  'chapeu-do-embuco',
  'other'::rpg.item_type,
  'Chapéu do Embuço',
  NULL,
  NULL,
  'Enquanto estiver vestindo este Chapéu, você pode conjurar a magia Disfarçar-se. A magia se encerra se o chapéu for removido.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"uncommon","rarityLabel":"Incomum","requiresAttunement":true,"header":"Item Maravilhoso, Incomum (Requer Sintonização)","attunement":"Requer Sintonização"}'::jsonb
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
  'chapeu-dos-magos',
  'other'::rpg.item_type,
  'Chapéu dos Magos',
  NULL,
  NULL,
  'Este chapéu em forma de cone é adornado com luas e estrelas. Enquanto o estiver usando, você adquire os seguintes benefícios.
Foco de Conjuração. Você pode usar o chapéu como um Foco de Conjuração para suas magias de Mago.
Magia Desconhecida. Como uma ação Usar Magia, você pode tentar conjurar um truque que não conhece. O truque deve estar na lista de magias do Mago e ter um tempo de conjuração de uma ação, e você realiza um teste de Inteligência (Arcanismo) CD 10. Em caso de sucesso, você conjura a magia. Se falhar, a magia falha e a ação usada para conjurá-la é desperdiçada. Em ambos os casos, você não pode usar esta propriedade novamente até completar um Descanso Longo.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"common","rarityLabel":"Comum","requiresAttunement":true,"header":"Item Maravilhoso, Comum (Requer Sintonização por um Mago)","attunement":"Requer Sintonização por um Mago"}'::jsonb
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
  'chapeu-dos-vermes',
  'other'::rpg.item_type,
  'Chapéu dos Vermes',
  NULL,
  NULL,
  'Este chapéu tem 3 cargas. Enquanto o segura, você pode executar uma ação Usar Magia para gastar 1 carga e invocar, à sua escolha, um Morcego, um Rato ou um Sapo. A criatura invocada aparece magicamente no chapéu e tenta se afastar de você o mais rápido possível. A criatura é Indiferente em relação a você e a outras criaturas, e não está sob seu controle. Ele se comporta como uma criatura comum de seu tipo e desaparece após 1 hora ou quando alcança 0 Pontos de Vida. O chapéu recupera todas as cargas gastas diariamente ao amanhecer.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"common","rarityLabel":"Comum","requiresAttunement":false,"header":"Item Maravilhoso, Comum"}'::jsonb
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
  'chave-misteriosa',
  'other'::rpg.item_type,
  'Chave Misteriosa',
  NULL,
  NULL,
  'Um ponto de interrogação é moldado na cabeça desta chave. A chave possui 5% de chance de destrancar qualquer fechadura na qual esteja inserida. Assim que destranca algo, a chave desaparece.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"common","rarityLabel":"Comum","requiresAttunement":false,"header":"Item Maravilhoso, Comum"}'::jsonb
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
  'chifre-de-escutar',
  'other'::rpg.item_type,
  'Chifre de Escutar',
  NULL,
  NULL,
  'Enquanto segurar este chifre contra sua orelha, ele suprime os efeitos da condição Surdo em você.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"common","rarityLabel":"Comum","requiresAttunement":false,"header":"Item Maravilhoso, Comum"}'::jsonb
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
  'chifre-do-alarme-silencioso',
  'other'::rpg.item_type,
  'Chifre do Alarme Silencioso',
  NULL,
  NULL,
  'Este chifre tem 4 cargas e recupera 1d4 cargas gastas diariamente ao amanhecer. Como uma ação Usar Magia, você pode soprar o chifre enquanto gasta 1 carga. Uma criatura à sua escolha escuta o estrondar do chifre, desde que a criatura esteja a até 180 metros do item. Nenhuma outra criatura ouve a trombeta.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"common","rarityLabel":"Comum","requiresAttunement":false,"header":"Item Maravilhoso, Comum"}'::jsonb
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
  'cimitarra-da-velocidade',
  'weapon'::rpg.item_type,
  'Cimitarra da Velocidade',
  NULL,
  NULL,
  'Você adquire um bônus de +2 em jogadas de ataque e dano realizadas com esta arma mágica. Além disso, você pode realizar um ataque com ela como uma Ação Bônus em cada um dos seus turnos.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Arma (Cimitarra)","rarity":"very-rare","rarityLabel":"Muito Raro","requiresAttunement":true,"header":"Arma (Cimitarra), Muito Rara (Requer Sintonização)","attunement":"Requer Sintonização","weaponSubtype":"Cimitarra"}'::jsonb
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
  'cinturao-de-forca-de-gigante',
  'other'::rpg.item_type,
  'Cinturão de Força de Gigante',
  NULL,
  NULL,
  'Ao usar este cinturão, seu valor de Força muda para o fornecido pelo item, que varia conforme o tipo de gigante (veja a tabela abaixo). O item não afeta você se sua Força sem o cinturão for igual ou maior do que a do cinturão.
Cinturão
	For.
	Raridade
	Cinturão de Força de Gigante (da colina)
	21
	Raro
	Cinturão de Força de Gigante (da pedra/do gelo)
	23
	Muito Raro
	Cinturão de Força de Gigante (do fogo)
	25
	Muito Raro
	Cinturão de Força de Gigante (das nuvens)
	27
	Lendário
	Cinturão de Força de Gigante (da tempestade)
	29
	Lendário',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"varies","rarityLabel":"Raridade Variável","requiresAttunement":true,"header":"Item Maravilhoso, Raridade Variável (Requer Sintonização)","attunement":"Requer Sintonização"}'::jsonb
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
  'cinturao-do-povo-anao',
  'other'::rpg.item_type,
  'Cinturão do Povo Anão',
  NULL,
  NULL,
  'Ao usar este cinturão, você adquire os seguintes benefícios:
Amigo dos Anões. Você tem Vantagem em testes de Carisma (Persuasão) realizados para interagir com anões e duergar.
Anão. Você conhece o idioma Anão.
Resistência. Seu valor de Constituição aumenta em 2, até no máximo 20.
Além disso, enquanto estiver sintonizado com o cinturão, você tem 50% de chance a cada dia, ao amanhecer, de que uma barba completa cresça em você ou sua barba fique mais grossa, se já tiver uma.
Se você não for um anão ou duergar, adquire os seguintes benefícios adicionais ao usar o cinturão:
Resistência a Toxinas. Você tem Resistência a Dano Venenoso. Você também tem Vantagem nas salvaguardas que realizar para evitar ou encerrar a condição Envenenado.
Visão no Escuro. Você tem Visão no Escuro com um alcance de 18 metros.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"rare","rarityLabel":"Raro","requiresAttunement":true,"header":"Item Maravilhoso, Raro (Requer Sintonização)","attunement":"Requer Sintonização"}'::jsonb
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
  'cola-suprema',
  'other'::rpg.item_type,
  'Cola Suprema',
  NULL,
  NULL,
  'Essa substância viscosa, de coloração branco-leitosa, pode formar uma ligação adesiva permanente entre quaisquer dois objetos. Ela deve ser armazenada em uma ampola ou pote cujo interior tenha sido revestido com Óleo Escorregadio. Quando encontrado, um recipiente contém (1d6 + 1) x 30 gramas de cola.
Trinta gramas de cola podem cobrir uma superfície quadrada de 30 centímetros de lado. Aplicar 30 gramas de Cola Suprema requer uma ação Usar Objeto, e a cola aplicada leva 1 minuto para se fixar completamente. Após esse tempo, o vínculo formado só pode ser desfeito com a aplicação de Solvente Universal ou Óleo de Forma Etérea, ou com uma magia Desejo.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"legendary","rarityLabel":"Lendário","requiresAttunement":false,"header":"Item Maravilhoso, Lendário"}'::jsonb
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
  'colar-da-adaptabilidade',
  'other'::rpg.item_type,
  'Colar da Adaptabilidade',
  NULL,
  NULL,
  'Ao usar este colar, você pode respirar normalmente em qualquer ambiente e tem Vantagem em salvaguardas realizadas para evitar ou encerrar a condição Envenenado.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"uncommon","rarityLabel":"Incomum","requiresAttunement":true,"header":"Item Maravilhoso, Incomum (Requer Sintonização)","attunement":"Requer Sintonização"}'::jsonb
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
  'colar-de-bolas-de-fogo',
  'other'::rpg.item_type,
  'Colar de Bolas de Fogo',
  NULL,
  NULL,
  'Este colar tem 1d6 + 3 contas penduradas nele. Você pode executar uma ação Usar Magia para soltar uma conta e arremessá-la a até 18 metros de distância. Ao atingir o final de sua trajetória, a conta detona como uma magia Bola de Fogo de 3º círculo (CD 15 para evitar).
Você pode arremessar várias contas, ou até mesmo o colar inteiro, de uma só vez. Ao fazer isso, aumente o dano da Bola de Fogo em 1d6 para cada conta após a primeira (máximo 12d6).',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"rare","rarityLabel":"Raro","requiresAttunement":false,"header":"Item Maravilhoso, Raro"}'::jsonb
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
  'colar-de-contas-de-oracao',
  'other'::rpg.item_type,
  'Colar de Contas de Oração',
  NULL,
  NULL,
  'Este colar tem 1d4 + 2 contas mágicas produzidas de água-marinha, pérola negra ou topázio. Ele também tem muitas contas não mágicas produzidas de pedras como âmbar, hematita, citrino, coral, jade, pérola ou quartzo. Se uma conta mágica for removida do colar, essa conta perde sua magia.
Existem seis tipos de contas mágicas. O Mestre decide o tipo de cada conta no colar ou a determina aleatoriamente jogando na tabela abaixo. Um colar pode ter mais de uma conta do mesmo tipo. Para usar uma conta, você deve estar usando o colar. Cada conta contém uma magia que você pode conjurar como uma Ação Bônus (usando a CD para evitar sua magia se uma salvaguarda for necessária). Uma vez que a magia de uma conta mágica é conjurada, essa conta não pode ser usada novamente até o próximo amanhecer.
1d20
	Conta
	Magia
	1–6
	Abençoar
	Bênção
	7–12
	Curar
	Curar Ferimentos (de 2º círculo)
	13–16
	Favorecer
	Restauração Maior
	17–18
	Destruir
	Destruição Radiante
	19
	Invocar
	Defensor da Fé
	20
	Caminhar no Vento
	Caminhar no Vento',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"rare","rarityLabel":"Raro","requiresAttunement":true,"header":"Item Maravilhoso, Raro (Requer Sintonização por um Clérigo, Druida ou Paladino)","attunement":"Requer Sintonização por um Clérigo, Druida ou Paladino"}'::jsonb
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
  'colar-dos-pensamentos',
  'other'::rpg.item_type,
  'Colar dos Pensamentos',
  NULL,
  NULL,
  'O colar tem 5 cargas. Enquanto o estiver usando-o, você pode gastar 1 carga para conjurar Detectar Pensamentos (CD 13 para evitar) a partir dele. O colar recupera 1d4 cargas gastas diariamente ao amanhecer.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"uncommon","rarityLabel":"Incomum","requiresAttunement":true,"header":"Item Maravilhoso, Incomum (Requer Sintonização)","attunement":"Requer Sintonização"}'::jsonb
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
  'conta-de-hidratacao',
  'other'::rpg.item_type,
  'Conta de Hidratação',
  NULL,
  NULL,
  'Ao ser colocada em um líquido, esta esfera esponjosa, gelatinosa e insípida dissolve-se, transformando até meio litro de um líquido em água potável fresca e gelada. A esfera não afeta líquidos mágicos ou substâncias perigosas, como venenos.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"common","rarityLabel":"Comum","requiresAttunement":false,"header":"Item Maravilhoso, Comum"}'::jsonb
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
  'conta-de-nutricao',
  'other'::rpg.item_type,
  'Conta de Nutrição',
  NULL,
  NULL,
  'Esta esfera esponjosa, gelatinosa e insípida dissolve na língua e fornece nutrição equivalente a um dia de Rações.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"common","rarityLabel":"Comum","requiresAttunement":false,"header":"Item Maravilhoso, Comum"}'::jsonb
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
  'contas-energeticas',
  'other'::rpg.item_type,
  'Contas Energéticas',
  NULL,
  NULL,
  'Esta pequena esfera preta mede 2 centímetros de diâmetro e pesa 30 gramas. Normalmente, 1d4 + 4 Contas Energéticas são encontradas juntas.
Você pode executar uma ação Usar Magia para arremessar a conta a até 18 metros. Ela explode em uma esfera de 3 metros de raio e é destruída. Cada criatura na esfera deve ser bem-sucedida em uma salvaguarda de Destreza CD 15 ou sofre 5d4 pontos de dano Energético. Uma esfera energética transparente cerca a área por 1 minuto. Qualquer criatura que falhe na salvaguarda e que esteja completamente dentro da área está presa dentro da esfera. Criaturas bem-sucedidas ou que estejam parcialmente dentro da área são empurradas para fora do centro da esfera até que não estejam mais dentro dela. Apenas ar respirável pode passar através da parede da esfera. Nenhum ataque ou quaisquer outros efeitos podem atravessá-la.
Uma criatura aprisionada pode executar uma ação Usar Objeto para empurrar-se contra a parede da Esfera, movendo-a por até metade do Deslocamento da criatura. A Esfera pode ser pega, e a magia dela faz com que pese apenas meio quilo, independentemente do peso das criaturas lá dentro.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"rare","rarityLabel":"Raro","requiresAttunement":false,"header":"Item Maravilhoso, Raro"}'::jsonb
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
  'corda-autorreparadora',
  'other'::rpg.item_type,
  'Corda Autorreparadora',
  NULL,
  NULL,
  'Esta corda enrolada de 15 metros é capaz de se reparar quando cortada em qualquer número de pedaços menores. Ao executar uma ação Usar Magia, você pode fazer com que todos os pedaços da corda que estejam em contato entre si e não estejam sendo usados se unam novamente. Uma Corda Autorreparadora é permanentemente encurtada se alguma de suas partes for perdida ou destruída.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"common","rarityLabel":"Comum","requiresAttunement":false,"header":"Item Maravilhoso, Comum"}'::jsonb
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
  'corda-de-emaranhamento',
  'other'::rpg.item_type,
  'Corda de Emaranhamento',
  NULL,
  NULL,
  'Esta corda tem 9 metros de comprimento. Enquanto segura uma de suas extremidades, você pode executar uma ação Usar Magia para comandar que a outra extremidade dispare a avançar e enredar uma criatura à sua vista a até 6 metros de distância. O alvo deve ser bem-sucedido em uma salvaguarda de Destreza CD 15 ou tem a condição Contido. Você pode libertar o alvo soltando sua extremidade da corda (fazendo com que a corda se enrole no espaço do alvo) ou executando uma Ação Bônus para repetir o comando (fazendo com que a corda se enrole em sua mão).
Um alvo Contido pela corda pode executar uma ação para realizar um teste de Força (Atletismo) ou Destreza (Acrobacia) CD 15. Em caso de sucesso, o alvo não está mais Contido pela corda. Se você ainda estiver segurando a corda quando o alvo se soltar, pode executar uma Reação para comandar que ela se enrole em sua mão; caso contrário, ela se enrola no espaço do alvo.
A corda tem CA 20, 20 PV e Imunidade a Dano Psíquico e Venenoso. Ela recupera 1 Ponto de Vida a cada 5 minutos, desde que tenha pelo menos 1 Ponto de Vida. Se a corda for reduzida a 0 Pontos de Vida, ela é destruída.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"rare","rarityLabel":"Raro","requiresAttunement":false,"header":"Item Maravilhoso, Raro"}'::jsonb
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
  'corda-encantada',
  'other'::rpg.item_type,
  'Corda Encantada',
  NULL,
  NULL,
  'Esta corda de 18 metros de comprimento suporta até 1.500 quilos. Enquanto estiver segurando uma das extremidades, você pode executar uma ação Usar Magia para ordenar que a outra extremidade se anime e se mova até o destino de sua escolha, até o comprimento da corda e afastando-se de você. A extremidade percorre 3 metros no turno em que for comandada pela primeira vez e outros 3 metros no início de cada um dos seus turnos subsequentes, até alcançar o destino ou até que você a mande parar. Você também pode ordenar que a corda se prenda firmemente a um objeto, se solte, se ate, se desate ou se enrole para ser transportada.
Ao ordenar que ela se dê nós, nós largos se formam a cada 30 centímetros. Com os nós, a corda se encurta para 15 metros de comprimento e concede Vantagem em testes de atributo realizados para escalada.
A corda tem CA 20, 20 PV e Imunidade a Dano Psíquico e Venenoso. Ela recupera 1 Ponto de Vida a cada 5 minutos, desde que tenha pelo menos 1 Ponto de Vida. Se a corda for reduzida a 0 Pontos de Vida, ela é destruída.
Corselete de Couro Deslumbrante
Armadura (Armadura de Couro Batido) Raro
Enquanto estiver vestindo esta armadura, você recebe um bônus de +1 na Classe de Armadura. Você também pode executar uma Ação Bônus para a armadura assumir a aparência de roupas comuns ou de outro tipo de armadura. A escolha da aparência — incluindo cor, estilo e acessórios — é sua, mas a armadura conserva seu volume e peso normais. Essa aparência ilusória dura até que você a ative novamente ou remova a armadura.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"uncommon","rarityLabel":"Incomum","requiresAttunement":false,"header":"Item Maravilhoso, Incomum"}'::jsonb
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
  'cota-de-malha-elfica',
  'armor'::rpg.item_type,
  'Cota de Malha Élfica',
  NULL,
  NULL,
  'Enquanto estiver usando esta armadura você adquire um bônus de +1 na Classe de Armadura. Você é considerado proficiente com esta armadura, mesmo se não tiver treinamento com armaduras Médias ou Pesadas.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Armadura (Cota de Malha ou Cota de Malha Parcial)","rarity":"rare","rarityLabel":"Raro","requiresAttunement":false,"header":"Armadura (Cota de Malha ou Cota de Malha Parcial), Raro","armorSubtype":"Cota de Malha ou Cota de Malha Parcial"}'::jsonb
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
  'cota-de-malha-ifriti',
  'armor'::rpg.item_type,
  'Cota de Malha Ifriti',
  NULL,
  NULL,
  'Enquanto estiver vestindo esta armadura, você recebe um bônus de +3 na Classe de Armadura, tem Imunidade a dano Ígneo e conhece o idioma Primordial. Além disso, você pode andar ou se mover pela rocha derretida como se fosse chão firme.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Armadura (Cota de Malha ou Cota de Malha Parcial)","rarity":"legendary","rarityLabel":"Lendário","requiresAttunement":true,"header":"Armadura (Cota de Malha ou Cota de Malha Parcial), Lendário (Requer Sintonização)","attunement":"Requer Sintonização","armorSubtype":"Cota de Malha ou Cota de Malha Parcial"}'::jsonb
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
  'cubo-de-invocacao',
  'other'::rpg.item_type,
  'Cubo de Invocação',
  NULL,
  NULL,
  'Este cubo minúsculo parece uma caixinha de surpresas. Quando você torce a manivela como uma ação Usar Magia, uma melodia alegre emana da caixa, a tampa se abre, uma criatura aparece no espaço desocupado mais próximo e a tampa se fecha. Caso contrário, a tampa não pode ser aberta.
Jogue na tabela Cubo de Invocação para determinar qual magia o cubo conjura para invocar a criatura. A magia é conjurada no 5º círculo (CD 17 para evitar, +9 de bônus de ataque) e não requer Concentração, mas você age como o conjurador.
Uma vez que o cubo invoca uma criatura, ele não pode fazer isso novamente até o próximo amanhecer.
1d6
	Magia
	1
	Invocar Aberração
	2
	Invocar Fera
	3
	Invocar Constructo
	4
	Invocar Dragão
	5
	Convocar Elemental
	6
	Convocar Feérico',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"rare","rarityLabel":"Raro","requiresAttunement":false,"header":"Item Maravilhoso, Raro"}'::jsonb
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
  'cubo-energetico',
  'other'::rpg.item_type,
  'Cubo Energético',
  NULL,
  NULL,
  'Este cubo tem cerca de 2,5 centímetros de lados. Cada face tem uma marcação distinta. Você pode pressionar uma dessas faces, gastar o número de cargas necessárias para isso e, assim, conjurar a magia associada a ela (CD 17 para evitar), conforme mostrado na tabela Faces do Cubo Energético.
O cubo começa com 10 cargas e recupera 1d6 cargas gastas diariamente ao amanhecer.
Faces do Cubo Energético
Magia
	Carga Usada
	Armadura Arcana
	1
	Escudo Arcano
	1
	Esfera Resiliente de Otiluke
	4
	Muralha de Energia
	5
	Pequeno Refúgio de Leomund
	3
	Santuário Particular de Mordenkainen
	4',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"rare","rarityLabel":"Raro","requiresAttunement":true,"header":"Item Maravilhoso, Raro (Requer Sintonização)","attunement":"Requer Sintonização"}'::jsonb
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
  'cubo-portal',
  'other'::rpg.item_type,
  'Cubo-Portal',
  NULL,
  NULL,
  'Este cubo tem 7 centímetros de lados e irradia energia mágica palpável. Cada um dos seis lados do cubo são ligados a um plano de existência diferente, um dos quais sendo o Plano Material. Os demais são determinados pelo Mestre.
O cubo tem 3 cargas e recupera 1d3 cargas gastas diariamente ao amanhecer. Como uma ação Usar Magia, você pode gastar 1 das cargas do cubo para conjurar uma das seguintes magias usando o cubo.
Portal. Pressionando um dos lados do cubo, você conjura Portal, abrindo uma passagem para o plano de existência conectado àquele lado.
Transição Planar. Pressionando um lado do cubo duas vezes, você conjura Transição Planar, transportando os alvos para o plano de existência conectado àquele lado.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"legendary","rarityLabel":"Lendário","requiresAttunement":false,"header":"Item Maravilhoso, Lendário"}'::jsonb
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
  'dado-do-charlatao',
  'other'::rpg.item_type,
  'Dado do Charlatão',
  NULL,
  NULL,
  'Sempre que você jogar este dado de seis lados, você pode controlar qual número obtido na jogada.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"common","rarityLabel":"Comum","requiresAttunement":true,"header":"Item Maravilhoso, Comum (Requer Sintonização)","attunement":"Requer Sintonização"}'::jsonb
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
  'defensora',
  'weapon'::rpg.item_type,
  'Defensora',
  NULL,
  NULL,
  'Você recebe um bônus de +3 em jogadas de ataque e dano realizadas com esta arma mágica.
Na primeira vez que você atacar com esta arma em cada um de seus turnos, pode transferir parte ou todo o bônus da arma para sua Classe de Armadura. Por exemplo, você pode reduzir o bônus nas jogadas de ataque e de dano para +1 e adquirir um bônus de +2 na Classe de Armadura. Os bônus ajustados têm efeito até o início do seu próximo turno, embora você precise segurar a arma para obter o bônus na CA.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Arma (Qualquer Arma Corpo a Corpo)","rarity":"legendary","rarityLabel":"Lendário","requiresAttunement":true,"header":"Arma (Qualquer Arma Corpo a Corpo), Lendário (Requer Sintonização)","attunement":"Requer Sintonização","weaponSubtype":"Qualquer Arma Corpo a Corpo"}'::jsonb
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
  'demonomico-de-lggwilv',
  'other'::rpg.item_type,
  'Demonômico de lggwilv',
  NULL,
  NULL,
  'Este tratado, de autoria de Iggwilv, a arquimagista, documenta as camadas e habitantes do Abismo, sendo amplamente considerado o tomo de demonologia mais completo e blasfemo do multiverso. O tomo registra tanto as profanidades mais antigas quanto as mais recentes do Abismo e dos demônios. Demônios tentaram censurar o texto e, embora seções tenham sido arrancadas da lombada do livro, os capítulos principais permanecem, sempre revelando segredos demoníacos. Por trás das palavras escritas, uma parte oculta do Abismo se agita, mantendo o livro sempre atualizado, independentemente do número de páginas removidas, e pretende ser mais do que um simples material de referência.
Conhecimento Abissal. Você pode consultar o Demonômico sempre que realizar um teste de Inteligência para discernir informações sobre demônios ou um teste de Sabedoria (Sobrevivência) relacionado ao Abismo. Você tem Vantagem no teste ao realizá-lo.
Contenção. As primeiras dez páginas do Demonômico estão em branco. Enquanto segura o livro, como uma ação Usar Magia, você pode escolher como alvo um Ínfero que esteja preso dentro da área de uma magia Círculo Mágico. O Ínfero deve ser bem-sucedido em uma salvaguarda de Carisma CD 20 com Desvantagem ou fica preso em uma das páginas em branco do Demonômico, que se preenche com texto detalhando o nome amplamente conhecido da criatura e suas depravações. Uma vez executada, essa ação não pode ser usada novamente até o próximo amanhecer.
Ao completar um Descanso Longo, se você e o Demonômico estiverem no mesmo plano de existência, a criatura contida dentro do livro pode tentar possuí-lo. Você deve realizar uma salvaguarda de Carisma CD 20. Se falhar, você é possuído pela criatura, que o controla como um fantoche. Como uma ação Usar Magia, a criatura possuidora pode libertá-lo e aparecer no espaço desocupado mais próximo a você. Em caso de sucesso, o Ínfero não pode tentar possuí-lo novamente por 7 dias (mas outro Ínfero contido no livro certamente pode tentar).
Quando o tomo é descoberto, ele tem 1d4 Ínferos ocupando suas páginas — normalmente uma variedade de demônios.
Enredamento. Enquanto carrega o livro, sempre que você conjurar uma das magias Âncora Planar ou Círculo Mágico, tendo como alvos Ínferos, a magia é conjurada como 9º círculo, independentemente do nível do espaço de magia usado, se houver. Além disso, o Ínfero tem Desvantagem em sua salvaguarda contra a magia.
Flagelo Ínfero. Enquanto carrega o livro, ao realizar uma jogada de dano para uma magia que você conjure contra um Ínfero, você usa o resultado máximo possível em vez de jogar os dados.
Propriedades Aleatórias. O Artefato tem as seguintes propriedades aleatórias (veja “Artefatos” neste capítulo):
● 2 propriedades benéficas menores
● 1 propriedade prejudicial menor
● 1 propriedade prejudicial maior
Magias. O livro possui 8 cargas e recupera 1d8 cargas gastas diariamente ao amanhecer. Enquanto segurar o livro, você pode executar uma ação Usar Magia para conjurar uma das magias (CD 20 para evitar) indicadas na tabela a seguir. A tabela indica quantas cargas você deve gastar para conjurar a magia.
Magia
	Carga Usada
	Aliado Extraplanar
	3
	Âncora Planar
	2
	Círculo Mágico
	1
	Gargalhada Nefasta de Tasha
	0
	Invocar Ínfero
	3
	Receptáculo Arcano
	3
	Transição Planar (apenas para o Abismo)
	3
	Destruindo o Demonômico. Para destruir o livro, seis lordes demônios diferentes devem, cada um, arrancar um sexto das páginas do livro. Se isso ocorrer, as páginas reaparecem após 24 horas. Antes que se passem essas horas, qualquer um que abrir a encadernação restante do livro será transportado para uma camada nascente do Abismo escondida dentro do livro. No coração desse domínio mortal e semisenciente encontra-se um Artefato há muito tempo perdido, o Cajado de Fraz-Urb''luu. Se o cajado for retirado do miniplano, o tomo é reduzido a uma cópia mundana e desatualizada do Tomo de Zyx, a obra que serviu de base para o Demonômico de lggwilv. O Tomo de Zyx pode ser destruído como qualquer livro comum. Assim que o cajado emerge, o lorde demônio Fraz-Urb''luu sabe instantaneamente.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"artifact","rarityLabel":"Artefato","requiresAttunement":true,"header":"Item Maravilhoso, Artefato (Requer Sintonização)","attunement":"Requer Sintonização"}'::jsonb
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
  'diadema-da-explosao',
  'other'::rpg.item_type,
  'Diadema da Explosão',
  NULL,
  NULL,
  'Enquanto estiver vestindo esta diadema, você pode conjurar Raio Ardente com ela (bônus de +5 para acertar). O diadema não pode conjurar esta magia novamente até o próximo amanhecer.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"uncommon","rarityLabel":"Incomum","requiresAttunement":false,"header":"Item Maravilhoso, Incomum"}'::jsonb
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
  'dispositivo-de-kwalish',
  'other'::rpg.item_type,
  'Dispositivo de Kwalish',
  NULL,
  NULL,
  'À primeira vista, o item se assemelha a um enorme barril de ferro selado, pesando cerca de 250 quilos. Ele possui um trinco oculto que pode ser encontrado com um teste de Inteligência (Investigação) CD 20. Ao soltar o trinco, um alçapão se abre em uma das extremidades, permitindo que duas criaturas Médias ou menores rastejem para dentro. Na extremidade oposta, dez alavancas estão dispostas paralelamente, em posição neutra, podendo ser movidas para cima ou para baixo. Ao acionar certas alavancas, o dispositivo se transforma em uma lagosta gigante.
O Dispositivo de Kwalish é um objeto Grande com as seguintes estatísticas: CA 20; PV 200; Deslocamento 9 m, Natação 9 m (ou 0 m para ambas se as pernas não estiverem estendidas); Imunidade a dano Psíquico e Venenoso.
Para funcionar como um veículo, o dispositivo requer um piloto. Com a escotilha fechada, o compartimento fica hermeticamente selado e impermeável, com ar suficiente para 10 horas, dividido pelo número de criaturas que precisam respirar.
O dispositivo flutua e pode submergir até 275 metros; em profundidades maiores, o veículo sofre 2d6 pontos de dano Contundente por minuto devido à pressão.
Uma criatura no compartimento pode executar uma ação Utilizar Magia para mover até duas alavancas do dispositivo para cima ou para baixo. Após serem acionadas, as alavancas retornam à posição neutra. Cada alavanca, da esquerda para a direita, opera conforme a tabela Alavancas do Dispositivo de Kwalish.
Alavancas do Dispositivo de Kwalish
Alavanca
	Para Cima
	Para Baixo
	1
	Pernas se estendem, permitindo que o dispositivo caminhe e nade.
	Pernas se retraem, reduzindo o Deslocamento e o Deslocamento de Natação do aparelho para 0 e tornando-o incapaz de se beneficiar de bônus de Deslocamento.
	2
	Abre o visor da janela frontal.
	Fecha o visor da janela frontal.
	3
	Abre os visores das janelas laterais (duas de cada lado)
	Fecha os visores das janelas laterais (duas de cada lado)
	4
	Duas garras se estendem das laterais dianteiras do dispositivo.
	As garras se retraem.
	5
	Cada garra estendida realiza o seguinte ataque corpo a corpo: +8 para acertar, alcance 1,5 m Dano: 7 (2d6) Contundente.
	Cada garra estendida realiza o seguinte ataque corpo a corpo: +8 para acertar, alcance 1,5 m Dano: O alvo tem a condição Imobilizado (CD 15 para escapar).
	6
	O dispositivo caminha ou nada para frente.
	O dispositivo caminha ou nada para trás, desde que suas pernas estejam estendidas.
	7
	O dispositivo gira 90 graus no sentido anti-horário, desde que suas pernas estejam estendidas.
	O aparelho gira 90 graus no sentido horário, desde que suas pernas estejam estendidas.
	8
	Luminárias tipo pálpebra emitem Luz Plena em um raio de 9 metros e Meia-luz por mais 9 metros.
	A luz se apaga.
	9
	O dispositivo afunda até 6 metros se estiver em líquido.
	O dispositivo sobe até 6 metros se estiver em líquido.
	10
	A escotilha traseira destranca e se abre.
	A escotilha traseira fecha e tranca.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"legendary","rarityLabel":"Lendário","requiresAttunement":false,"header":"Item Maravilhoso, Lendário"}'::jsonb
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
  'elmo-da-compreensao-de-idiomas',
  'other'::rpg.item_type,
  'Elmo da Compreensão de Idiomas',
  NULL,
  NULL,
  'Enquanto estiver vestindo este elmo, você pode conjurar Compreender Idiomas a partir dele.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"uncommon","rarityLabel":"Incomum","requiresAttunement":false,"header":"Item Maravilhoso, Incomum"}'::jsonb
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
  'elmo-de-telepatia',
  'other'::rpg.item_type,
  'Elmo de Telepatia',
  NULL,
  NULL,
  'Enquanto estiver usando este elmo, você tem telepatia com um alcance de 9 metros, e pode conjurar Detectar Pensamentos ou Sugestão (CD 13 para evitar) a partir do elmo. Uma vez que uma das magias é conjurada do elmo, essa magia não pode ser conjurada novamente até o próximo amanhecer.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"uncommon","rarityLabel":"Incomum","requiresAttunement":true,"header":"Item Maravilhoso, Incomum (Requer Sintonização)","attunement":"Requer Sintonização"}'::jsonb
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
  'elmo-de-teleporte',
  'other'::rpg.item_type,
  'Elmo de Teleporte',
  NULL,
  NULL,
  'Este elmo tem 3 cargas. Enquanto o estiver usando-o, você pode gastar 1 carga para conjurar Teleporte a partir dele. O elmo recupera 1d3 cargas gastas diariamente ao amanhecer.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"rare","rarityLabel":"Raro","requiresAttunement":true,"header":"Item Maravilhoso, Raro (Requer Sintonização)","attunement":"Requer Sintonização"}'::jsonb
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
  'elmo-do-esplendor',
  'other'::rpg.item_type,
  'Elmo do Esplendor',
  NULL,
  NULL,
  'Este elmo é cravejado com 1d10 diamantes, 2d10 rubis, 3d10 opalas de fogo e 4d10 opalas. Qualquer joia extraída do elmo se desfaz em pó. Quando todas as joias são removidas ou destruídas, o elmo perde sua magia.
Você adquire os seguintes benefícios enquanto estiver usando o elmo.
Chamas de Opala de Fogo. Enquanto houver pelo menos uma opala de fogo no elmo, você pode executar uma ação Usar Magia para fazer com que uma arma que estiver empunhando irrompa em chamas. As chamas emitem Luz Plena em um raio de 3 metros e Meia-luz por mais 3 metros. As chamas são inofensivas para você e para a arma. Ao atingir com um ataque usando a arma em chamas, o alvo sofre 1d6 pontos de dano Ígneo adicionais. As chamas permanecem até que você execute uma Ação Bônus para apagá-las ou até que você solte ou guarde a arma.
Luz Diamantina. Enquanto houver pelo menos um diamante, o elmo emite uma Emanação de 9 metros. Quando pelo menos um Morto-vivo estiver dentro dessa área, a Emanação se enche de Meia-luz. Qualquer Morto-vivo que inicie seu turno nessa área sofre 1d6 pontos de dano Radiante.
Magias. Você pode conjurar uma das seguintes magias (CD 18 para evitar), usando uma das joias do elmo do tipo especificado como componente: Luz do Dia (opala), Bola de Fogo (opala de fogo), Rajada Prismática (diamante) ou Muralha de Fogo (rubi). A gema é destruída quando a magia é conjurada e desaparece do elmo.
Resistência de Rubi. Enquanto houver pelo menos um rubi no elmo, você tem Resistência a dano Ígneo.
Sofrendo Dano Ígneo. Jogue 1d20 se estiver usando o elmo e sofra dano Ígneo se falhar em uma salvaguarda contra uma magia. Ao tirar 1, o elmo emite feixes de luz de suas joias restantes e é então destruído. Cada criatura em uma Emanação de 18 metros originada em você deve ser bem-sucedida em uma salvaguarda de Destreza CD 17 ou é atingida por uma feixe, sofrendo dano Radiante igual ao número de joias no elmo.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"very-rare","rarityLabel":"Muito Raro","requiresAttunement":true,"header":"Item Maravilhoso, Muito Raro (Requer Sintonização)","attunement":"Requer Sintonização"}'::jsonb
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
  'elmo-do-medo',
  'other'::rpg.item_type,
  'Elmo do Medo',
  NULL,
  NULL,
  'Enquanto estiver usando este temível elmo de aço, seus olhos brilham em vermelho e o resto do rosto fica escondido na sombra.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"common","rarityLabel":"Comum","requiresAttunement":false,"header":"Item Maravilhoso, Comum"}'::jsonb
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
  'escara-gelida',
  'weapon'::rpg.item_type,
  'Escara Gélida',
  NULL,
  NULL,
  'Ao acertar com uma jogada de ataque usando esta arma mágica, o alvo sofre 1d6 pontos de dano Gélido adicionais. Além disso, enquanto segura a arma, você tem Resistência a dano Ígneo.
Em temperaturas congelantes, a arma emite Luz Plena em um raio de 3 metros e Meia-luz por mais 3 metros.
Ao sacar esta arma, você pode extinguir todas as chamas não mágicas a até 9 metros de você. Uma vez usada, esta propriedade não pode ser utilizada novamente por 1 hora.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Arma (Cimitarra, Espada Curta, Espada Grande, Espada Longa, Glaive, Rapieira)","rarity":"very-rare","rarityLabel":"Muito Raro","requiresAttunement":true,"header":"Arma (Cimitarra, Espada Curta, Espada Grande, Espada Longa, Glaive, Rapieira), Muito Raro (Requer Sintonização)","attunement":"Requer Sintonização","weaponSubtype":"Cimitarra, Espada Curta, Espada Grande, Espada Longa, Glaive, Rapieira"}'::jsonb
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
  'escaravelho-de-protecao',
  'other'::rpg.item_type,
  'Escaravelho de Proteção',
  NULL,
  NULL,
  'Este medalhão em forma de besouro oferece três benefícios enquanto estiver com você.
Defensivo. Você adquire um bônus de +1 na Classe de Armadura.
Preservação. O escaravelho tem 12 cargas. Ao falhar em uma salvaguarda contra uma magia de Necromancia ou um efeito prejudicial proveniente de um Morto-vivo, pode executar uma Reação para gastar 1 carga e transformar a falha em um sucesso. O escaravelho se desintegra em pó e é destruído quando sua última carga é gasta.
Resistência à Magia. Você tem Vantagem em salvaguardas contra magias.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"legendary","rarityLabel":"Lendário","requiresAttunement":true,"header":"Item Maravilhoso, Lendário (Requer Sintonização)","attunement":"Requer Sintonização"}'::jsonb
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
  'escudo-animado',
  'armor'::rpg.item_type,
  'Escudo Animado',
  NULL,
  NULL,
  'Enquanto empunhar este Escudo, você pode executar uma Ação Bônus para animá-lo. O Escudo salta no ar e paira em seu espaço para protegê-lo como se você o estivesse empunhando, deixando as mãos livres. O Escudo permanece animado por 1 minuto ou até que você morra, ou tenha a condição Incapacitado ou execute uma Ação Bônus para encerrar esse efeito, momento em que o Escudo cai no chão ou em sua mão, se você tiver uma livre.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Armadura (Escudo)","rarity":"very-rare","rarityLabel":"Muito Raro","requiresAttunement":true,"header":"Armadura (Escudo), Muito Raro (Requer Sintonização)","attunement":"Requer Sintonização","armorSubtype":"Escudo"}'::jsonb
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
  'escudo-apanhador-de-flechas',
  'armor'::rpg.item_type,
  'Escudo Apanhador de Flechas',
  NULL,
  NULL,
  'Você recebe um bônus de +2 na Classe de Armadura contra jogadas de ataque à distância enquanto empunha este Escudo. Este bônus soma ao bônus normal do Escudo para a CA.
Sempre que um atacante realizar uma jogada de ataque à distância contra um alvo a até 1,5 metro de você, você pode executar uma Reação para se tornar alvo do ataque.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Armadura (Escudo)","rarity":"rare","rarityLabel":"Raro","requiresAttunement":true,"header":"Armadura (Escudo), Raro (Requer Sintonização)","attunement":"Requer Sintonização","armorSubtype":"Escudo"}'::jsonb
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
  'escudo-bloqueador-de-magias',
  'armor'::rpg.item_type,
  'Escudo Bloqueador de Magias',
  NULL,
  NULL,
  'Ao estar equipado com este Escudo, você tem Vantagem em salvaguardas contra magias e outros efeitos mágicos, e jogadas de ataque mágico têm Desvantagem contra você.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Armadura (Escudo)","rarity":"very-rare","rarityLabel":"Muito Raro","requiresAttunement":true,"header":"Armadura (Escudo), Muito Raro (Requer Sintonização)","attunement":"Requer Sintonização","armorSubtype":"Escudo"}'::jsonb
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
  'escudo-de-atracao-de-projeteis',
  'armor'::rpg.item_type,
  'Escudo de Atração de Projéteis',
  NULL,
  NULL,
  'Ao ter este Escudo equipado, você tem Resistência a dano de ataques originados de armas à Distância.
Maldição. Este Escudo está amaldiçoado. Sintonizar-se a ele o amaldiçoa até que você seja alvo de uma magia Remover Maldição ou efeito mágico semelhante. Remover o Escudo não encerra a maldição sobre você. Sempre que um ataque com uma arma à distância tem como alvo uma criatura a até 3 metros de você, a maldição faz com que você se torne o alvo.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Armadura (Escudo)","rarity":"rare","rarityLabel":"Raro","requiresAttunement":true,"header":"Armadura (Escudo), Raro (Requer Sintonização)","attunement":"Requer Sintonização","armorSubtype":"Escudo"}'::jsonb
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
  'escudo-do-cavaleiro',
  'armor'::rpg.item_type,
  'Escudo do Cavaleiro',
  NULL,
  NULL,
  'Ao ter este Escudo equipado, você tem um bônus de +2 na Classe de Armadura. Este bônus soma ao bônus normal do Escudo para a CA.
O Escudo possui as seguintes propriedades adicionais que você pode usar enquanto o tem equipado.
Campo de Proteção. Como uma Reação, quando você ou um aliado à sua vista e a até 1,5 metro de distância for alvo de um ataque ou realizar uma salvaguarda contra uma área de efeito, você pode usar o Escudo para criar uma Emanação imóvel de 1,5 metro originando em você. Quando a Emanação aparece, quaisquer criaturas ou objetos que não estejam totalmente dentro dela são empurrados para os espaços desocupados mais próximos fora dela. O ataque ou área de efeito que acionou a Reação não afeta criaturas e objetos dentro da Emanação, que dura até 1 minuto enquanto você mantiver a Concentração. Nada pode entrar ou sair da Emanação. Uma criatura ou objeto dentro da Emanação não pode sofrer dano de ataques, ou efeitos originados de fora, nem uma criatura dentro da Emanação pode causar dano a qualquer coisa fora dela. Uma vez que esta propriedade é usada, ela não pode ser usada novamente até o próximo amanhecer.
Pancada Forte. Ao executar a ação Atacar, você pode realizar uma das jogadas de ataque usando o Escudo contra um alvo a até 1,5 metro de distância. Aplique seu Bônus de Proficiência e modificador de Força à jogada de ataque. Em um acerto, o Escudo causa um dano Energético ao alvo igual a 2d6 + 2 mais seu modificador de Força, e se o alvo for uma criatura, você pode empurrá-lo até 3 metros para longe. Se a criatura for do seu tamanho ou menor, você também pode derrubá-la, impondo-lhe a condição Caído.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Armadura (Escudo)","rarity":"very-rare","rarityLabel":"Muito Raro","requiresAttunement":true,"header":"Armadura (Escudo), Muito Raro (Requer Sintonização)","attunement":"Requer Sintonização","armorSubtype":"Escudo"}'::jsonb
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
  'escudo-expressivo',
  'armor'::rpg.item_type,
  'Escudo Expressivo',
  NULL,
  NULL,
  'O Escudo está estampado com o símbolo de um rosto. Ao ter este Escudo equipado, você pode executar uma Ação Bônus para alterar a expressão do rosto.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Armadura (Escudo)","rarity":"common","rarityLabel":"Comum","requiresAttunement":false,"header":"Armadura (Escudo), Comum","armorSubtype":"Escudo"}'::jsonb
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
  'escudo-sentinela',
  'armor'::rpg.item_type,
  'Escudo Sentinela',
  NULL,
  NULL,
  'Ao ter este Escudo equipado, você tem Vantagem em jogadas de Iniciativa e testes de Sabedoria (Percepção). O Escudo está estampado com o símbolo de um olho.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Armadura (Escudo)","rarity":"uncommon","rarityLabel":"Incomum","requiresAttunement":false,"header":"Armadura (Escudo), Incomum","armorSubtype":"Escudo"}'::jsonb
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
  'escudo-1-2-ou-3',
  'armor'::rpg.item_type,
  'Escudo, +1, +2 ou +3',
  NULL,
  NULL,
  'Ao ter este Escudo equipado, você tem um bônus na Classe de Armadura determinado pela raridade do Escudo, além do bônus normal do Escudo para a CA.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Armadura (Escudo)","rarity":"uncommon","rarityLabel":"Incomum","requiresAttunement":false,"header":"Armadura (Escudo), Incomum (+1), Raro (+2) ou Muito Raro (+3)","armorSubtype":"Escudo"}'::jsonb
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
  'esfera-da-aniquilacao',
  'other'::rpg.item_type,
  'Esfera da Aniquilação',
  NULL,
  NULL,
  'Essa esfera negra, com 60 centímetros de diâmetro, é uma ruptura no multiverso, suspensa no espaço e estabilizada por um campo mágico que a envolve.
A esfera aniquila toda matéria com a qual entra em contato, bem como toda matéria que a atravessa. Artefatos são exceções. A menos que um Artefato seja suscetível ao dano de uma Esfera da Aniquilação, ele atravessa ela ileso. Qualquer outra coisa que toque a esfera, mas não seja totalmente engolida e obliterada por ela, sofre 8d10 pontos de dano Energético.
Controlando a Esfera. Uma Esfera da Aniquilação fica parada até que alguém assuma o controle dela. Estando a até 18 metros da esfera, você pode executar uma ação Usar Magia para realizar um teste de Inteligência (Arcanismo) CD 25. Em caso de sucesso, você controla a esfera até o início do seu próximo turno e se ela estiver sob o controle de outra criatura, essa criatura perde o controle. Se falhar, a esfera se move 3 metros em sua direção em linha reta.
Enquanto estiver controlando a esfera, você pode executar uma Ação Bônus para fazê-la se mover em uma direção à sua escolha, até uma distância em metros igual a 1,5 vezes o seu modificador de Inteligência (mínimo de 1,5 metro). Qualquer criatura cujo espaço seja invadido pela esfera deve ser bem-sucedida em uma salvaguarda de Destreza CD 19 ou é tocada por ela, sofrendo 8d10 pontos de dano Energético. Uma criatura reduzida a 0 Pontos de Vida por este dano é obliterada, deixando seus pertences para trás, mas nenhum outro vestígio físico.
Interações com a Esfera. Se a esfera entrar em contato com um portal planar (como o criado pela magia Portal) ou um espaço extradimensional (como o de um Buraco Portátil), o Mestre determina aleatoriamente o que acontece usando a tabela a seguir.
1d100
	Resultado
	01–50
	A esfera é destruída.
	51–85
	A esfera se move através do portal ou para o espaço extradimensional.
	86–00
	Uma fenda espacial envia a esfera e cada criatura e objeto a até 54 metros da esfera para um plano de existência aleatório.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"legendary","rarityLabel":"Lendário","requiresAttunement":false,"header":"Item Maravilhoso, Lendário"}'::jsonb
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
  'esfera-da-direcao',
  'other'::rpg.item_type,
  'Esfera da Direção',
  NULL,
  NULL,
  'Esta esfera pode ser usada como um Foco Arcano.
Enquanto segura esta esfera, você pode executar uma ação Usar Magia para determinar para que lado fica o norte magnético. Nada acontece se a esfera for usada em um local que não tenha norte magnético.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"common","rarityLabel":"Comum","requiresAttunement":false,"header":"Item Maravilhoso, Comum"}'::jsonb
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
  'esfera-do-tempo',
  'other'::rpg.item_type,
  'Esfera do Tempo',
  NULL,
  NULL,
  'Esta esfera pode ser usada como um Foco Arcano.
Enquanto segura a esfera, você pode executar uma ação Usar Magia para descobrir se é manhã, tarde, noite ou madrugada. Esta propriedade funciona apenas no Plano Material.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"common","rarityLabel":"Comum","requiresAttunement":false,"header":"Item Maravilhoso, Comum"}'::jsonb
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
  'espada-da-precisao',
  'weapon'::rpg.item_type,
  'Espada da Precisão',
  NULL,
  NULL,
  'Ao atacar um objeto com esta arma mágica e acertar, maximize os dados de dano da arma contra o alvo.
Ao atacar uma criatura com esta arma e obter 20 no d20 na jogada de ataque, o alvo sofre 14 pontos de dano Cortante adicionais e adquire 1 nível de Exaustão.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Arma (Cimitarra, Espada Grande, Espada Longa ou Glaive)","rarity":"very-rare","rarityLabel":"Muito Raro","requiresAttunement":true,"header":"Arma (Cimitarra, Espada Grande, Espada Longa ou Glaive), Muito Raro (Requer Sintonização)","attunement":"Requer Sintonização","weaponSubtype":"Cimitarra, Espada Grande, Espada Longa ou Glaive"}'::jsonb
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
  'espada-da-vinganca',
  'weapon'::rpg.item_type,
  'Espada da Vingança',
  NULL,
  NULL,
  'Você adquire um bônus de +1 em jogadas de ataque e dano realizadas com esta arma mágica.
Maldição. Esta arma é amaldiçoada e está possuída por um espírito vingativo. Sintonizar-se com ela estende a maldição a você. Enquanto permanecer amaldiçoado, você não deseja se separar da arma, mantendo-a em sua posse o tempo todo. Enquanto estiver sintonizado com esta arma, você tem Desvantagem em jogadas de ataque realizadas com armas diferentes desta.
Além disso, enquanto a arma estiver em sua posse, você deve ser bem-sucedido em uma salvaguarda de Sabedoria CD 15 sempre que sofrer dano de outra criatura em combate. Se falhar, você deve atacar a criatura que o causou dano até ser reduzida a 0 Pontos de Vida ou até que você não consiga alcançá-la para realizar um ataque corpo a corpo contra ela.
Você pode quebrar a maldição das maneiras usuais. Alternativamente, conjurar Banimento na arma força o espírito vingativo a deixá-la. A arma então se torna uma Arma +1 sem outras propriedades.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Arma (Cimitarra, Espada Curta, Espada Grande, Espada Longa, Glaive ou Rapieira)","rarity":"uncommon","rarityLabel":"Incomum","requiresAttunement":true,"header":"Arma (Cimitarra, Espada Curta, Espada Grande, Espada Longa, Glaive ou Rapieira), Incomum (Requer Sintonização)","attunement":"Requer Sintonização","weaponSubtype":"Cimitarra, Espada Curta, Espada Grande, Espada Longa, Glaive ou Rapieira"}'::jsonb
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
  'espada-dancarina',
  'weapon'::rpg.item_type,
  'Espada Dançarina',
  NULL,
  NULL,
  'Você pode usar uma Ação Bônus para lançar esta arma mágica no ar. Ao fazer isso, a arma começa a pairar, voa até 9 metros e ataca uma criatura à sua escolha a até 1,5 metro da arma. A arma usa a sua jogada de ataque e adiciona o seu modificador de atributo às jogadas de dano.
Enquanto a arma estiver pairando, você pode executar uma Ação Bônus para fazê-la voar até 9 metros para outro ponto a até 9 metros de você. Como parte da mesma Ação Bônus, você pode fazer com que a arma ataque uma criatura a até 1,5 metro da arma.
Após a arma pairar e atacar pela quarta vez, ela voa de volta para você e tenta retornar para sua mão. Se você não tiver a mão livre, a arma cai no chão em seu espaço. Se a arma não tiver um caminho desobstruído até você, ela se move o mais próximo possível de você e depois cai no chão. Ela também deixa de pairar se você a pegar ou estiver a mais de 9 metros de distância dela.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Arma (Cimitarra, Espada Curta, Espada Grande, Espada Longa, Rapieira)","rarity":"very-rare","rarityLabel":"Muito Raro","requiresAttunement":true,"header":"Arma (Cimitarra, Espada Curta, Espada Grande, Espada Longa, Rapieira), Muito Raro (Requer Sintonização)","attunement":"Requer Sintonização","weaponSubtype":"Cimitarra, Espada Curta, Espada Grande, Espada Longa, Rapieira"}'::jsonb
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
  'espada-das-respostas',
  'weapon'::rpg.item_type,
  'Espada das Respostas',
  NULL,
  NULL,
  'Você adquire um bônus de +3 em jogadas de ataque e dano realizadas com esta espada. Além disso, ao empunhar a espada, você pode executar uma Reação para realizar um ataque corpo a corpo com ela contra qualquer criatura ao seu alcance que cause dano a você. Você tem Vantagem na jogada de ataque, e qualquer dano causado por este ataque especial ignora qualquer Imunidade ou Resistência que o alvo possua a esse dano.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Arma (Espada Longa)","rarity":"legendary","rarityLabel":"Lendário","requiresAttunement":true,"header":"Arma (Espada Longa), Lendário (Requer Sintonização)","attunement":"Requer Sintonização","weaponSubtype":"Espada Longa"}'::jsonb
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
  'espada-de-kas',
  'weapon'::rpg.item_type,
  'Espada de Kas',
  NULL,
  NULL,
  'Kas foi um poderoso guerreiro que serviu Vecna e cuja lealdade foi recompensada com esta espada. À medida que o poder de Kas cresceu, sua também cresceu sua arrogância. A espada incitou Kas a destruir Vecna e usurpar seu trono. A lenda diz que a destruição de Vecna veio pelas mãos de Kas, mas Vecna também forjou a desgraça de seu tenente rebelde, deixando para trás apenas a espada de Kas.
Arma Mágica. Você adquire um bônus de +3 em jogadas de ataque e dano realizadas com a espada, que obtém um Acerto Crítico em um resultado de 19 ou 20 no d20 e causa 2d10 pontos de dano Cortante adicionais a Mortos-Vivos.
Espírito de Kas. Enquanto a espada estiver em sua posse, você adquire os seguintes benefícios:
Fome de Batalha. Você adiciona 1d10 às suas jogadas de Iniciativa.
Lâmina Defensiva. Ao executar uma ação para atacar com a espada, você pode transferir parte ou todo o bônus de ataque dela para sua Classe de Armadura. Os bônus ajustados permanecem em efeito até o início do seu próximo turno.
Personalidade. O propósito da espada é trazer ruína a Vecna. Matar os adoradores de Vecna, destruir as obras do lich e frustrar seus planos contribuem para esse objetivo.
A Espada de Kas também procura destruir qualquer um corrompido pelo Olho e Mão de Vecna.
Resistência Necrótica. Você tem Resistência a dano Necrótico.
Senciência. A Espada de Kas é uma arma senciente Caótica e Má com Inteligência 15, Sabedoria 13 e Carisma 16. Possui audição e Visão no Escuro até 36 metros.
A arma se comunica telepaticamente com seu portador e fala Comum.
Propriedades Aleatórias
Propriedades Aleatórias. A espada tem as seguintes propriedades aleatórias (veja Artefatos):
● 1 propriedade benéfica menor
● 1 propriedade benéfica maior
● 1 propriedade prejudicial menor
● 1 propriedade prejudicial maior
Magias. Enquanto a espada estiver em sua posse, você pode conjurar as seguintes magias a partir dela (CD 18 para evitar):
● Convocar Relâmpagos
● Dedo da Morte
● Palavra Sagrada
Ao conjurar uma magia com esta espada, você não pode conjurá-la novamente até o próximo amanhecer.
Sede de Sangue. A espada anseia por sangue. Se a espada não provar sangue em sua lâmina dentro de 1 minuto após ser sacada da bainha, seu portador deve realizar uma salvaguarda de Carisma CD 15. Em caso de sucesso, o portador sofre 3d6 pontos de dano Psíquico. Se falhar, o portador é dominado pela espada, como na magia Dominar Monstro, e a espada exige sangue. O efeito da magia encerra quando a exigência da espada é atendida.
Destruindo a Espada. Uma criatura sintonizada tanto com o Olho de Vecna quanto com a Mão de Vecna pode usar a propriedade Desejo desses Artefatos combinados para desfazer a Espada de Kas, desde que a espada esteja a até 9 metros do conjurador. Ao conjurar Desejo, a criatura realiza uma salvaguarda de Carisma CD 18. Se falhar, nada acontece e a magia Desejo é desperdiçada. Em caso de sucesso, a Espada de Kas é destruída.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Arma (Espada Longa)","rarity":"artifact","rarityLabel":"Artefato","requiresAttunement":true,"header":"Arma (Espada Longa), Artefato (Requer Sintonização)","attunement":"Requer Sintonização","weaponSubtype":"Espada Longa"}'::jsonb
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
  'espada-laceradora',
  'weapon'::rpg.item_type,
  'Espada Laceradora',
  NULL,
  NULL,
  'Ao atingir uma criatura com um ataque usando esta arma mágica, o alvo sofre 2d6 pontos de dano Necrótico adicionais e deve ser bem-sucedido em uma salvaguarda de Constituição CD 15 ou não pode recuperar Pontos de Vida por 1 hora. O alvo repete a salvaguarda no final de cada um dos turnos dele, encerrando o efeito em caso de sucesso.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Arma (Cimitarra, Espada Curta, Espada Grande, Espada Longa, Glaive ou Rapieira)","rarity":"rare","rarityLabel":"Raro","requiresAttunement":true,"header":"Arma (Cimitarra, Espada Curta, Espada Grande, Espada Longa, Glaive ou Rapieira), Raro (Requer Sintonização)","attunement":"Requer Sintonização","weaponSubtype":"Cimitarra, Espada Curta, Espada Grande, Espada Longa, Glaive ou Rapieira"}'::jsonb
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
  'espada-lunar',
  'weapon'::rpg.item_type,
  'Espada Lunar',
  NULL,
  NULL,
  'Na Escuridão, a lâmina desembainhada desta arma emite a luz do luar, criando Luz Plena em um raio de 4,5 metros e Meia-luz por mais 4,5 metros.
Espada Lunar (Rapieira)',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Arma (Cimitarra, Espada Curta, Espada Grande, Espada Longa, Glaive, Rapieira)","rarity":"common","rarityLabel":"Comum","requiresAttunement":false,"header":"Arma (Cimitarra, Espada Curta, Espada Grande, Espada Longa, Glaive, Rapieira), Comum","weaponSubtype":"Cimitarra, Espada Curta, Espada Grande, Espada Longa, Glaive, Rapieira"}'::jsonb
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
  'espada-usurpadora-de-vida',
  'weapon'::rpg.item_type,
  'Espada Usurpadora de Vida',
  NULL,
  NULL,
  'Ao atacar uma criatura com esta arma mágica e obter 20 no d20 na jogada de ataque, o alvo sofre 15 pontos de dano Necrótico adicionais se não for um Constructo ou um Morto-Vivo, e você recebe Pontos de Vida Temporários iguais à quantidade de dano Necrótico sofrido.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Arma (Cimitarra, Espada Curta, Espada Grande, Espada Longa, Glaive ou Rapieira)","rarity":"rare","rarityLabel":"Raro","requiresAttunement":true,"header":"Arma (Cimitarra, Espada Curta, Espada Grande, Espada Longa, Glaive ou Rapieira), Raro (Requer Sintonização)","attunement":"Requer Sintonização","weaponSubtype":"Cimitarra, Espada Curta, Espada Grande, Espada Longa, Glaive ou Rapieira"}'::jsonb
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
  'espada-vorpal',
  'weapon'::rpg.item_type,
  'Espada Vorpal',
  NULL,
  NULL,
  'Você adquire um bônus de +3 em jogadas de ataque e dano realizadas com esta arma mágica. Além disso, a arma ignora Resistência a dano Cortante.
Ao usar esta arma para atacar uma criatura que tenha pelo menos uma cabeça e obter 20 no d20 na jogada de ataque, você corta uma das cabeças da criatura. A criatura morre se não puder sobreviver sem a cabeça perdida. Uma criatura é imune a esse efeito se tiver Imunidade a dano Cortante, se não tiver ou não precisar de uma cabeça, ou se o Mestre decidir que a criatura é grande demais para sua cabeça ser cortada com esta arma. Tal criatura, em vez disso, sofre 30 pontos de dano Cortante adicionais do acerto. Se a criatura tiver Resistência Lendária, ela pode gastar um uso diário desse traço para evitar perder a cabeça, sofrendo o dano adicional.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Arma (Cimitarra, Espada Grande, Espada Longa ou Glaive)","rarity":"legendary","rarityLabel":"Lendário","requiresAttunement":true,"header":"Arma (Cimitarra, Espada Grande, Espada Longa ou Glaive), Lendário (Requer Sintonização)","attunement":"Requer Sintonização","weaponSubtype":"Cimitarra, Espada Grande, Espada Longa ou Glaive"}'::jsonb
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
  'espelho-aprisionador-de-vida',
  'other'::rpg.item_type,
  'Espelho Aprisionador de Vida',
  NULL,
  NULL,
  'Quando este espelho de um metro e meio de altura e um metro e meio de largura é visto indiretamente, sua superfície mostra imagens tênues de criaturas. O espelho pesa 25 quilos e tem CA 11, 10 PV, Imunidade a dano Psíquico e Venenoso e Vulnerabilidade a dano Contundente. Ele quebra e é destruído quando reduzido a 0 Pontos de Vida.
Se o espelho estiver pendurado em uma superfície vertical e você estiver a até 1,5 metro dele, você pode executar uma ação Usar Magia e usar uma palavra de comando para ativá-lo. Ele permanece ativado até que você execute uma ação Usar Magia e repita a palavra de comando para desativá-lo.
Qualquer criatura que não seja você que veja seu próprio reflexo no espelho ativado enquanto estiver a até 9 metros do espelho deve ser bem-sucedida em uma salvaguarda de Carisma CD 15 ou fica presa, junto com qualquer coisa que estiver usando ou carregando, em uma das doze celas extradimensionais do espelho. Uma criatura que conhece a natureza do espelho realiza a salvaguarda com Vantagem, e Constructos são bem-sucedidos automaticamente.
Uma cela extradimensional é uma extensão infinita cheia de uma névoa espessa que reduz a visibilidade a 3 metros. As criaturas presas nas celas do espelho não envelhecem e não precisam comer, beber ou dormir. Uma criatura presa dentro de uma cela pode escapar usando magia que permite viagens planares. Caso contrário, a criatura fica confinada na cela até ser liberta.
Se o espelho prender uma criatura, mas suas doze celas extradimensionais já estiverem ocupadas, o espelho liberta uma criatura presa aleatoriamente para acomodar o novo prisioneiro. Uma criatura livre aparece em um espaço desocupado à vista do espelho, mas de costas para ele. Se o espelho for quebrado, todas as criaturas que ele contém são libertadas e aparecem em espaços desocupados perto dele.
Enquanto estiver a até 1,5 metro do espelho, você pode executar uma ação Usar Magia para nomear uma criatura presa nele ou chamar uma célula específica por número. A criatura nomeada ou contida na célula nomeada aparece como uma imagem na superfície do espelho. Você e a criatura podem então se comunicar.
Da mesma forma, você pode executar uma ação Usar Magia e usar uma segunda palavra de comando para libertar uma criatura presa no espelho. A criatura liberta aparece, junto com suas posses, no espaço desocupado mais próximo do espelho e voltado para as costas dele.
Colocar o espelho dentro de um espaço extradimensional criado por uma Bolsa Cabe Tudo, Buraco Portátil ou item semelhante destrói instantaneamente ambos os itens e abre um portal para o Plano Astral. O portal tem origem onde um item foi colocado dentro do outro. Qualquer criatura a até 3 metros do portal e que não esteja atrás de uma Cobertura Total é sugada por ele e depositada em um local aleatório no Plano Astral. O portal então se fecha. O portal é unidirecional e não pode ser reaberto.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"very-rare","rarityLabel":"Muito Raro","requiresAttunement":false,"header":"Item Maravilhoso, Muito Raro"}'::jsonb
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
  'estatueta-de-poder-maravilhoso',
  'other'::rpg.item_type,
  'Estatueta de Poder Maravilhoso',
  NULL,
  NULL,
  'Estatuetas de Poder Maravilhoso (Corcel de Obsidiana, Mosca de Ébano, Elefante de Mármore, Cão de Ônix, Leões de Ouro)
Uma Estatueta de Poder Maravilhoso é pequena o suficiente para caber em um bolso. Ao usar uma ação Usar Magia para jogar a estatueta em um ponto no chão a até 18 metros de você, ela se torna uma criatura viva conforme descrito abaixo. Se o local da criatura estiver ocupado por outras criaturas ou objetos, ou se não houver espaço suficiente, a estatueta não se transforma em uma criatura.
A criatura é Amigável a você e a seus aliados. Ele entende seus idiomas, obedece aos seus comandos e realiza o turno imediatamente após você na contagem de Iniciativa. Se você não emitir nenhum comando, a criatura se defende, mas não realiza outras ações.
A criatura tem uma duração específica, após a qual retorna à forma de estatueta. Ela volta a ser estatueta mais cedo ao ser reduzida a 0 Pontos de Vida ou se você executar uma ação Usar Magia ao tocá-la. Quando a criatura se transforma novamente em estatueta, esta propriedade dela não pode ser usada até que um certo tempo passe, conforme indicado na descrição da estatueta.
Cabras de Marfim (Raro). Essas estatuetas de marfim representando cabras são sempre criadas em conjuntos de três. Cada cabra parece única e funciona de forma diferente das outras. Suas propriedades são as seguintes:
Cabra da Labuta. Esta estatueta pode se tornar uma Cabra Gigante por até 3 horas. Uma vez utilizada, não pode ser usada novamente até passarem 30 dias.
Cabra de Viagem. Esta estatueta pode se transformar em uma cabra Grande com as mesmas estatísticas de um Cavalo de Montaria. Ela possui 24 cargas, e cada hora ou fração gasta na forma de cabra consome 1 carga. Embora tenha cargas, você pode usá-la quantas vezes quiser. Ao esgotar as cargas, a cabra reverte para a forma de estatueta e não pode ser utilizada novamente por 7 dias, quando recupera todas as cargas.
Cabra do Terror. Esta estatueta pode se transformar em uma Cabra Gigante por até 3 horas. A cabra não pode atacar, mas você pode (inofensivamente) remover os chifres dela e usá-los como armas. Um chifre se torna uma Lança de Montaria +1 e o outro se torna uma Espada Longa +2. Como uma ação Usar Magia você pode remover um chifre. As armas desaparecem quando a cabra retorna à forma de estatueta. Enquanto você monta a cabra, qualquer criatura Hostil que inicie o próprio turno em uma Emanação de 9 metros originária da cabra deve ser bem-sucedida em uma salvaguarda de Sabedoria CD 15 ou tem a condição Amedrontado por 1 minuto, encerrando o efeito se você não estiver mais montando a cabra ou se ela voltar à forma de estatueta. A criatura Amedrontada repete a salvaguarda no final de cada turno dela, encerrando o efeito sobre si em caso de sucesso, e fica imune a esse efeito pelas próximas 24 horas. Após utilizada, a estatueta não pode ser usada novamente por 15 dias.
Cão de Ônix (Raro). Esta estatueta de ônix representando um cão pode se transformar em um Mastim por até 6 horas. O mastim possui valor de Inteligência 8, pode falar Comum e tem Visão às Cegas com alcance de 18 metros. Após ser utilizada, não pode ser usada novamente por 7 dias.
Corcel de Obsidiana (Muito Raro). Este cavalo de obsidiana polido pode se tornar um Pesadelo por até 24 horas. O pesadelo luta apenas para se defender. Uma vez utilizada, a estatueta não pode ser usada novamente até passarem 5 dias.
A estatueta tem 10% de chance de ignorar suas ordens a cada uso, incluindo o comando para reverter à forma de estatueta. Se você montar o pesadelo enquanto ele ignora suas ordens, tanto você quanto o pesadelo são instantaneamente transportados para um local aleatório no plano de Hades, onde o pesadelo retorna à forma de estatueta.
Coruja de Serpentina (Raro). Esta estatueta de serpentina representando uma coruja pode se transformar em uma Coruja Gigante por até 8 horas. A coruja se comunica telepaticamente com você a qualquer distância, contanto que ambos estejam no mesmo plano de existência. Após o uso, não pode ser utilizada novamente por 2 dias.
Corvo de Prata (Incomum). Esta estatueta de prata representando um corvo pode se transformar em um Corvo por até 12 horas. Após ser utilizada, não pode ser usada novamente por 2 dias. Enquanto estiver na forma de corvo, a estatueta permite que você conjure Mensageiro Animal através dela.
Elefante de Mármore (Raro). Esta estatueta de mármore se assemelha a um elefante bramidor. Pode se tornar um Elefante por até 24 horas. Uma vez utilizada, não pode ser usada novamente até passarem 7 dias.
Grifo de Bronze (Raro). Esta estatueta de bronze representa um grifo sobre as pernas traseiras. Pode se tornar um Grifo por até 6 horas. Uma vez utilizada, não pode ser usada novamente até passarem 5 dias.
Leões de Ouro (Raro). Essas estatuetas douradas representando leões são sempre criadas em pares. Você pode usar uma estatueta ou ambas simultaneamente. Cada uma pode se tornar um Leão por até 1 hora. Uma vez que tenha sido utilizada, uma estatueta de leão não pode ser usada novamente até passarem 7 dias.
Mosca de Ébano (Raro). Esta estatueta de ébano, esculpida à semelhança de uma mosca, pode se tornar uma Mosca Gigante (veja o bloco de estatísticas que a acompanha) por até 12 horas e pode ser usada como uma montaria. Uma vez utilizada, não pode ser usada novamente até passarem 2 dias.
Mosca Gigante
Fera Grande, Sem Alinhamento
CA 11         Iniciativa +1 (11)
PV 19 (3d10 + 3)
Deslocamento 9 m, Voo 18 m
 
	 
	Mod
	Salvaguarda
	For
	14
	+2
	+2
	Des
	13
	+1
	+1
	Con
	13
	+1
	+1
	Int
	2
	−4
	−4
	Sab
	10
	+0
	+0
	Car
	3
	−4
	−4
	Sentidos Visão no Escuro 18 m, Percepção Passiva 10
Idiomas —
ND 0 (XP 0; BP +2)',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"varies","rarityLabel":"Raridade Variável","requiresAttunement":false,"header":"Item Maravilhoso, Raridade Variável"}'::jsonb
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
  'faixas-de-ferro-de-bilarro',
  'other'::rpg.item_type,
  'Faixas de Ferro de Bilarro',
  NULL,
  NULL,
  'Esta esfera de ferro enferrujada mede 7,5 centímetros de diâmetro e pesa 0,5 quilo. Você pode executar uma ação Usar Magia para arremessar a esfera em uma criatura Enorme ou menor à sua vista a até 18 metros de distância. À medida que a esfera se move pelo ar, ela se abre em um emaranhado de faixas de metal.
Realize uma jogada de ataque à distância com um bônus de ataque igual ao seu modificador de Destreza mais seu Bônus de Proficiência. Em caso de acerto, o alvo tem a condição Contido até que você execute uma Ação Bônus para emitir um comando que o libere. Fazer isso ou errar o ataque faz com que as faixas se contraiam e se tornem uma esfera mais uma vez.
Uma criatura que toque as faixas, incluindo a criatura Contida, pode executar uma ação para realizar um teste de Força (Atletismo) CD 20 para romper as faixas de ferro. Em caso de sucesso, o item é destruído e a criatura Contida é liberta. Se falhar, quaisquer outras tentativas realizadas por essa criatura falham automaticamente até que se passem 24 horas.
Uma vez que as faixas são usadas, elas não podem ser usadas novamente até o próximo amanhecer.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"rare","rarityLabel":"Raro","requiresAttunement":false,"header":"Item Maravilhoso, Raro"}'::jsonb
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
  'ferraduras-de-velocidade',
  'other'::rpg.item_type,
  'Ferraduras de Velocidade',
  NULL,
  NULL,
  'Essas ferraduras vêm em um conjunto de quatro. Como uma ação Usar Magia, você pode tocar uma das ferraduras no casco de um cavalo ou criatura semelhante, fazendo-a se fixar. Remover uma ferradura também exige executar uma ação Usar Magia.
Enquanto todas as quatro ferraduras estão fixadas à mesma criatura, o Deslocamento da criatura aumenta em 9 metros.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"rare","rarityLabel":"Raro","requiresAttunement":false,"header":"Item Maravilhoso, Raro"}'::jsonb
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
  'ferraduras-de-zefiro',
  'other'::rpg.item_type,
  'Ferraduras de Zéfiro',
  NULL,
  NULL,
  'Essas ferraduras vêm em um conjunto de quatro. Como uma ação Usar Magia, você pode tocar uma das ferraduras no casco de um cavalo ou criatura semelhante, fazendo-a se fixar. Remover uma ferradura também exige executar uma ação Usar Magia.
Enquanto todas as quatro ferraduras estão fixadas nos cascos de um cavalo ou criatura semelhante, elas permitem que a criatura se mova normalmente enquanto flutua a 10 centímetros acima de uma superfície. Esse efeito possibilita que a criatura atravesse ou permaneça sobre superfícies não sólidas ou instáveis, como água ou lava. A criatura não deixa rastros e ignora Terreno Difícil. Além disso, a criatura pode viajar por até 12 horas por dia sem sofrer níveis de Exaustão devido a viagens longas.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"very-rare","rarityLabel":"Muito Raro","requiresAttunement":false,"header":"Item Maravilhoso, Muito Raro"}'::jsonb
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
  'flauta-atormentadora',
  'other'::rpg.item_type,
  'Flauta Atormentadora',
  NULL,
  NULL,
  'Essa flauta possui 3 cargas e recupera 1d3 cargas gastas diariamente ao amanhecer. Você pode executar uma ação Usar Magia para tocar a flauta e gastar 1 carga para criar uma melodia misteriosa e fascinante. Cada criatura à sua escolha, a até 9 metros de você, deve ser bem-sucedida em uma salvaguarda de Sabedoria CD 15 ou tem a condição Amedrontado por 1 minuto. Se falhar, a criatura pode repetir a salvaguarda no final de cada um dos turnos dela, encerrando o efeito em caso de sucesso. Uma criatura bem-sucedida na salvaguarda torna-se imune ao efeito dessa flauta por 24 horas.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"uncommon","rarityLabel":"Incomum","requiresAttunement":false,"header":"Item Maravilhoso, Incomum"}'::jsonb
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
  'flauta-dos-esgotos',
  'other'::rpg.item_type,
  'Flauta dos Esgotos',
  NULL,
  NULL,
  'Enquanto essa flauta estiver em sua posse, ratos comuns e ratos gigantes são Indiferentes a você e não o atacam, a menos que você os ameace ou os machuque.
A flauta possui 3 cargas e recupera 1d3 cargas gastas diariamente ao amanhecer. Se tocar a flauta como uma ação Usar Mágica, você pode executar uma Ação Bônus para gastar de 1 a 3 cargas, invocando um Enxame de Ratos com cada carga gasta, desde que haja ratos suficientes em até 750 metros de você para serem chamados desse modo (conforme determinado pelo Mestre). Se não houver ratos suficientes para formar um exame, a carga é desperdiçada. Os enxames invocados se movem em direção à música pela rota mais curta disponível, mas não estão sob seu controle de outro modo.
Sempre que um Enxame de Ratos que não esteja sob o controle de outra criatura estiver a até 9 metros de você enquanto você toca a flauta, o enxame realiza uma salvaguarda de Sabedoria CD 15. Em caso de sucesso, o enxame se comporta normalmente e não pode ser influenciado pela música da flauta pelas próximas 24 horas. Se falhar, o enxame é interferido pela música da flauta e se torna Amigável para você e seus aliados enquanto você continuar a tocar a flauta a cada rodada como uma ação Usar Magia. Um enxame Amigável obedece aos seus comandos. Se você não emitir comandos para um enxame Amigável, ele se defende, mas não realiza outras ações. Se um enxame Amigável iniciar seu turno a até 9 metros de distância de você, seu controle sobre esse enxame se encerra e ele se comporta normalmente, não podendo ser influenciado pela música da flauta pelas próximas 24 horas.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"uncommon","rarityLabel":"Incomum","requiresAttunement":true,"header":"Item Maravilhoso, Incomum (Requer Sintonização)","attunement":"Requer Sintonização"}'::jsonb
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
  'fortaleza-instantanea-de-daern',
  'other'::rpg.item_type,
  'Fortaleza Instantânea de Daern',
  NULL,
  NULL,
  'Como uma ação Usar Magia, você pode colocar esta estatueta de adamantina de 2,5 centímetros no chão e, ao pronunciar uma palavra de comando, fazê-la crescer rapidamente em uma torre quadrada de adamantina. Repetir a palavra de comando faz com que a torre retorne à forma de estatueta, funcionando apenas se a torre estiver vazia. Cada criatura na área onde a torre aparece é empurrada para um espaço desocupado ao lado dela, assim como objetos na área que não estão sendo usados ou carregados.
A torre mede 6 metros de lados e 9 metros de altura, com seteiras em todos os lados e uma muralha no topo. Seu interior é dividido em dois andares, conectados por uma escada, escaleira ou rampa à sua escolha, que termina em um alçapão que leva ao telhado. Ao ser criada, a torre possui uma única porta ao nível do solo, voltada para você, que se abre apenas com seu comando, acionado como uma Ação Bônus. A porta é imune à magia Arrombar e efeitos mágicos semelhantes.
A magia impede que a torre seja derrubada. A torre possui CA 20 no telhado, porta e paredes, com 100 PV, Imunidade a dano Contundente, Cortante e Perfurante, exceto dano causado por equipamento de cerco, e Resistência a todos os outros tipos de dano. Encolher a torre não a repara, apenas a magia Desejo (este uso da magia conta como replicação de uma magia de 8º círculo ou inferior) pode repará-la. Cada conjuração de Desejo faz com que a torre restaure todos os Pontos de Vida.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"rare","rarityLabel":"Raro","requiresAttunement":true,"header":"Item Maravilhoso, Raro (Requer Sintonização)","attunement":"Requer Sintonização"}'::jsonb
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
  'garra-silvestre',
  'weapon'::rpg.item_type,
  'Garra Silvestre',
  NULL,
  NULL,
  'Enquanto esta arma estiver em sua posse, você compreende a comunicação não escrita de todos os Feéricos, e eles compreendem a sua.
Mensagem Secreta. Como uma ação Usar Magia, você pode usar esta arma para conjurar Mensagem. Uma vez que esta propriedade é usada, ela não pode ser usada novamente até o próximo amanhecer.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Arma (Adaga, Cimitarra, Espada Curta, Foice, Lança ou Rapieira)","rarity":"common","rarityLabel":"Comum","requiresAttunement":true,"header":"Arma (Adaga, Cimitarra, Espada Curta, Foice, Lança ou Rapieira), Comum (Requer Sintonização)","attunement":"Requer Sintonização","weaponSubtype":"Adaga, Cimitarra, Espada Curta, Foice, Lança ou Rapieira"}'::jsonb
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
  'garrafa-da-agua-infinita',
  'other'::rpg.item_type,
  'Garrafa da Água Infinita',
  NULL,
  NULL,
  'Esse frasco com tampa faz barulho ao ser sacudido, como se contivesse água. A garrafa pesa 1 quilo.
Você pode executar uma ação Usar Magia para remover a rolha e pronunciar uma das três palavras de comando, momento em que uma quantidade de água fresca ou salgada (à sua escolha) é derramada do frasco. A água para de jorrar no início do seu próximo turno. Escolha entre as seguintes palavras de comando:
Riacho. A garrafa produz 4 litros de água.
Fonte. A garrafa produz 20 litros de água.
Gêiser. A garrafa produz 120 litros de água que jorram em uma linha de 9 metros de comprimento e 30 centímetros de largura. Se você estiver segurando a garrafa, pode apontar o gêiser em uma direção (nenhuma ação é necessária). Uma criatura à sua escolha na Linha deve ser bem-sucedida em uma salvaguarda de Força CD 13 ou sofre 1d4 pontos de dano Contundente e tem a condição Caído. Em vez de uma criatura, você pode apontar em um objeto na Linha que não esteja sendo usado ou carregado e que não pese mais de 100 quilos. O objeto é derrubado pelo gêiser.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"uncommon","rarityLabel":"Incomum","requiresAttunement":false,"header":"Item Maravilhoso, Incomum"}'::jsonb
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
  'garrafa-do-fumace-eterno',
  'other'::rpg.item_type,
  'Garrafa do Fumacê Eterno',
  NULL,
  NULL,
  'Como uma ação Usar Magia, você pode abrir ou fechar esta garrafa.
Abrir a garrafa faz com que uma fumaça espessa se espalhe, formando uma nuvem que preenche uma Emanação de 18 metros originada da garrafa. A área na fumaça é Totalmente Obscurecida.
Cada minuto que a garrafa permanecer aberta, o tamanho da Emanação aumenta em 3 metros, até atingir o tamanho máximo de 36 metros.
Fechar a garrafa faz com que a nuvem fique fixa no lugar até se dissipar após 10 minutos. Um vento forte (como o criado pela magia Lufada de Vento) dissipa a nuvem após 1 minuto.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"uncommon","rarityLabel":"Incomum","requiresAttunement":false,"header":"Item Maravilhoso, Incomum"}'::jsonb
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
  'garrafa-ifriti',
  'other'::rpg.item_type,
  'Garrafa Ifriti',
  NULL,
  NULL,
  'Ao executar uma ação Usar Magia para remover a rolha desta garrafa de latão pintada, uma nuvem de fumaça espessa sai dela. No final do seu turno, a fumaça desaparece com um lampejo de fogo inofensivo e um Ifriti aparece em um espaço desocupado a até 9 metros de você.
Na primeira vez que a garrafa é aberta, o Mestre joga 1d10 na tabela a seguir para determinar o efeito.
1d10
	Efeito
	1
	O Ifriti ataca você. Após lutar por 5 rodadas, o Ifriti desaparece e a garrafa perde a magia.
	2–9
	O Ifriti entende seus idiomas e obedece aos seus comandos por 1 hora, após o qual retorna à garrafa e uma nova rolha a fecha. A rolha não pode ser removida pelas próximas 24 horas. Nas duas vezes seguintes em que a garrafa é aberta, ocorre o mesmo efeito. Se a garrafa for aberta pela quarta vez, o Ifriti escapa e desaparece, e a garrafa perde a magia.
	10
	O Ifriti compreende seus idiomas e pode conjurar Desejo uma vez para você. Ele desaparece após conceder o desejo ou depois de 1 hora, e a garrafa perde a magia.
	Garrafa Ifriti',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"very-rare","rarityLabel":"Muito Raro","requiresAttunement":false,"header":"Item Maravilhoso, Muito Raro"}'::jsonb
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
  'gema-da-claridade',
  'other'::rpg.item_type,
  'Gema da Claridade',
  NULL,
  NULL,
  'Este prisma tem 50 cargas. Enquanto o estiver segurando, você pode executar uma ação Usar Magia e dizer uma das três palavras de comando para produzir um dos seguintes efeitos:
Primeira Palavra de Comando. A gema emite Luz Plena em um raio de 9 metros e Meia-luz por mais 9 metros. Este efeito não consome uma carga, permanecendo até que você execute uma Ação Bônus para repetir a palavra de comando ou até que você use outra função da gema.
Segunda Palavra de Comando. Você gasta 1 carga e faz com que a gema dispare um feixe de luz brilhante em uma criatura à sua vista a até 18 metros. A criatura deve ser bem-sucedida em uma salvaguarda de Constituição CD 15 ou tem a condição Cego por 1 minuto. A criatura repete a salvaguarda no final de cada um dos turnos dela, encerrando o efeito em caso de sucesso.
Terceira Palavra de Comando. Você gasta 5 cargas e faz com que a gema brilhe com luz intensa em um Cone de 9 metros. Cada criatura dentro do Cone realiza uma salvaguarda como se tivesse sido atingida pelo feixe criado com a segunda palavra de comando.
Quando todas as cargas da gema são gastas, a gema se torna uma joia não mágica no valor de 50 PO.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"uncommon","rarityLabel":"Incomum","requiresAttunement":false,"header":"Item Maravilhoso, Incomum"}'::jsonb
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
  'gema-da-visao',
  'other'::rpg.item_type,
  'Gema da Visão',
  NULL,
  NULL,
  'Esta gema tem 3 cargas. Como uma ação Usar Magia, você pode consumir 1 carga. Nos próximos 10 minutos, você tem Visão Verdadeira a 36 metros quando olha através da gema.
A gema recupera 1d3 cargas gastas diariamente ao amanhecer.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"rare","rarityLabel":"Raro","requiresAttunement":true,"header":"Item Maravilhoso, Raro (Requer Sintonização)","attunement":"Requer Sintonização"}'::jsonb
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
  'gema-elemental',
  'other'::rpg.item_type,
  'Gema Elemental',
  NULL,
  NULL,
  'Esta gema contém uma partícula de energia elemental. Ao quebrá-la como uma ação Usar Objeto, ela invoca um Elemental (veja também o Livro dos Monstros para o bloco de estatísticas) e deixa de ser mágica. O Elemental aparece em um espaço desocupado próximo à gema quebrada, entende seus idiomas, obedece a seus comandos e age imediatamente após você na contagem de Iniciativa. Ele desaparece após 1 hora, quando morre ou quando você o dispensa como uma Ação Bônus.
Gema
	Elemental Invocado
	Corindo vermelho
	Elemental do Fogo
	Diamante amarelo
	Elemental da Terra
	Esmeralda
	Elemental da Água
	Safira azul
	Elemental do Ar',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"uncommon","rarityLabel":"Incomum","requiresAttunement":false,"header":"Item Maravilhoso, Incomum"}'::jsonb
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
  'grilhoes-dimensionais',
  'other'::rpg.item_type,
  'Grilhões Dimensionais',
  NULL,
  NULL,
  'Você pode executar uma ação Usar Objeto para colocar esses grilhões em uma criatura que tem a condição Incapacitado. Os grilhões se ajustam para caber em uma criatura de tamanho Pequeno a Grande. Os grilhões impedem que a criatura presa por eles use qualquer método de movimento extradimensional, incluindo teleporte ou viagem para um plano de existência diferente. Eles não impedem a criatura de passar por um portal interdimensional.
Você e qualquer criatura escolhida por você ao usar os grilhões podem executar uma ação Utilizar Objeto para removê-los. Uma vez a cada 30 dias, a criatura acorrentada pode fazer um teste de Força (Atletismo) com CD 30. Em caso de sucesso, a criatura se liberta e destrói os grilhões.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"rare","rarityLabel":"Raro","requiresAttunement":false,"header":"Item Maravilhoso, Raro"}'::jsonb
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
  'haste-retratil',
  'other'::rpg.item_type,
  'Haste Retrátil',
  NULL,
  NULL,
  'Este item funciona como uma Haste. Enquanto a segura, você pode executar uma ação Usar Magia para reduzi-la em um cetro de 30 centímetros de comprimento para facilitar o armazenamento (o peso da haste não muda) ou fazer com que o cetro de 30 centímetros de comprimento reverta para uma Haste. O cetro se alonga apenas até onde o espaço circundante permitir.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"common","rarityLabel":"Comum","requiresAttunement":false,"header":"Item Maravilhoso, Comum"}'::jsonb
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
  'incensario-de-controlar-elementais-do-ar',
  'other'::rpg.item_type,
  'Incensário de Controlar Elementais do Ar',
  NULL,
  NULL,
  'Enquanto incenso estiver queimando neste incensário, você pode executar uma ação Usar Magia para invocar um Elemental do Ar. O elemental aparece em um espaço desocupado próximo ao braseiro, entende seus idiomas, obedece aos seus comandos e age imediatamente após sua contagem de iniciativa. Ele desaparece após 1 hora, quando morre ou quando você o dispensa como uma Ação Bônus. O incensário não pode ser utilizado novamente desse modo até o próximo amanhecer.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"rare","rarityLabel":"Raro","requiresAttunement":false,"header":"Item Maravilhoso, Raro"}'::jsonb
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
  'insignia-da-pena-de-quaal',
  'other'::rpg.item_type,
  'Insígnia da Pena de Quaal',
  NULL,
  NULL,
  'Este objeto se parece com uma pena. Existem diferentes tipos de insígnias da pena, cada uma com um efeito de uso único. O Mestre escolhe o tipo de insígnia ou determina aleatoriamente jogando na tabela Insígnias da Pena de Quaal. O tipo da insígnia determina sua raridade.
1d100
	Insígnia
	Raridade
	01–20
	Âncora
	Incomum
	21–35
	Pássaro
	Rara
	36–50
	Leque
	Incomum
	51–65
	Barco-cisne
	Raro
	66–90
	Árvore
	Incomum
	91–00
	Chicote
	Raro
	Insígnias da Pena de Quaal',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"varies","rarityLabel":"Raridade Variável","requiresAttunement":false,"header":"Item Maravilhoso, Raridade Variável"}'::jsonb
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
  'instrumento-musical-de-escrita',
  'other'::rpg.item_type,
  'Instrumento Musical de Escrita',
  NULL,
  NULL,
  'Este instrumento musical possui 3 cargas e restaura todas as cargas gastas diariamente ao amanhecer. Enquanto estiver tocando este instrumento, você pode executar uma ação Usar Magia para gastar 1 carga e escrever uma mensagem mágica em um objeto ou superfície não mágica à sua vista e a até 9 metros de distância. A mensagem pode conter até seis palavras escritas em um idioma que você conhece. Se você for um Bardo, pode adicionar mais sete palavras e fazer a mensagem brilhar levemente, permitindo que ela seja visível em Escuridão não mágica. Conjurar Dissipar Magia na mensagem a apaga. Caso contrário, a mensagem desaparece após 24 horas.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"common","rarityLabel":"Comum","requiresAttunement":false,"header":"Item Maravilhoso, Comum"}'::jsonb
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
  'instrumento-musical-de-ilusoes',
  'other'::rpg.item_type,
  'Instrumento Musical de Ilusões',
  NULL,
  NULL,
  'Enquanto estiver tocando este instrumento musical, você pode executar uma ação Usar Magia para criar efeitos visuais ilusórios e inofensivos dentro de uma Emanação de 1,5 metro originada do instrumento. Se você for um Bardo, o tamanho da Emanação aumenta para 4,5 metros. Exemplos de efeitos visuais incluem notas musicais luminosas, uma dançarina espectral, borboletas e neve caindo suavemente. Os efeitos mágicos não têm matéria nem som, e são obviamente ilusórios. Os efeitos encerram quando você para de tocar o instrumento.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"common","rarityLabel":"Comum","requiresAttunement":false,"header":"Item Maravilhoso, Comum"}'::jsonb
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
  'instrumento-musical-dos-bardos',
  'other'::rpg.item_type,
  'Instrumento Musical dos Bardos',
  NULL,
  NULL,
  'Um Instrumento Musical dos Bardos é superior a um instrumento musical comum em todos os aspectos. Existem sete tipos desses instrumentos, cada um nomeado em homenagem a um colégio de Bardo. A tabela Instrumentos Musicais dos Bardos lista as magias comuns a todos os instrumentos, assim como as magias específicas de cada um e sua raridade. Uma criatura que tentar tocar o instrumento sem estar sintonizada com ele deve ser bem-sucedida em uma salvaguarda de Sabedoria CD 15 ou sofre 2d4 pontos de dano Psíquico.
Você pode tocar o instrumento musical para conjurar uma de suas magias. Uma vez que o instrumento tenha sido usado para conjurar uma magia, ele não pode ser usado para conjurar essa magia novamente até o próximo amanhecer. As magias usam o seu atributo de conjuração e a CD para evitar sua magia.
Instrumentos Musicais dos Bardos
Instrumento
	Raridade
	Magias
	Todos
	—
	Invisibilidade, Levitação, Proteção Contra o Bem e o Mal, Voo, mais as magias listadas para o instrumento específico
	Harpa Anstruth
	Muito Raro
	Curar Ferimentos (5º círculo), Muralha de Espinhos, Tempestade Glacial
	Bandolim Canaith
	Raro
	Curar Ferimentos (3º círculo), Dissipar Magia, Proteção contra Energia (apenas dano Elétrico)
	Lira Cli
	Raro
	Moldar Rochas, Muralha de Fogo, Muralha de Vento
	Alaúde Doss
	Incomum
	Amizade Animal, Proteção Contra Energia (apenas dano Ígneo), Proteção Contra Veneno
	Bandurria de Fochlucan
	Incomum
	Bordão Místico, Emaranhar, Falar com Animais, Fogo das Fadas
	Cistre Mac-Fuirmidh
	Incomum
	Curar Ferimentos, Névoa Obscurecente, Pele-Casca
	Harpa Ollamh
	Lendário
	Confusão, Controlar o Clima, Tempestade de Fogo
	Instrumentos Musicais dos Bardos (Alaúde Doss, Bandolim Canaith, Bandurria de Fochlucan, Cistre Mac-Fuirmidh, Harpa Anstruth, Harpa Ollamh, Lira Cli)',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"varies","rarityLabel":"Raridade Variável","requiresAttunement":true,"header":"Item Maravilhoso, Raridade Variável (Requer Sintonização por um Bardo)","attunement":"Requer Sintonização por um Bardo"}'::jsonb
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
  'jarro-alquimico',
  'other'::rpg.item_type,
  'Jarro Alquímico',
  NULL,
  NULL,
  'Este jarro de cerâmica parece capaz de conter 4 litros de líquido e pesa 6 quilos, esteja cheio ou vazio. O jarro faz barulho de líquido ao ser agitado, mesmo quando vazio.
Você pode executar uma ação Usar Magia e nomear um líquido da tabela Líquidos do Jarro Alquímico para que o jarro produza o líquido escolhido. Após isso, você pode destampar o jarro como uma ação Usar Objeto e derramar o líquido, a uma taxa de até 8 litros por minuto. A quantidade máxima de líquido que o jarro pode produzir depende do líquido escolhido.
Uma vez que o jarro produza um líquido, ele não pode gerar outro tipo de líquido, nem produzir mais do mesmo, caso já tenha atingido o limite, até o próximo amanhecer.
Líquidos do Jarro Alquímico
Líquido
	Quant. Máx.
	Ácido
	240 mililitros
	Veneno Básico
	120 mililitros
	Cerveja
	16 litros
	Mel
	4 Litros
	Maionese
	8 litros
	Óleo
	1 litro
	Vinagre
	8 litros
	Água Fresca
	32 litros
	Água Salgada
	48 litros
	Vinho
	4 Litros',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"uncommon","rarityLabel":"Incomum","requiresAttunement":false,"header":"Item Maravilhoso, Incomum"}'::jsonb
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
  'lamina-da-sorte',
  'weapon'::rpg.item_type,
  'Lâmina da Sorte',
  NULL,
  NULL,
  'Você adquire um bônus de +1 em jogadas de ataque e dano realizadas com esta arma mágica. Enquanto estiver de posse da arma, você também recebe um bônus de +1 em salvaguardas.
Desejo. A arma possui 1d3 cargas. Ao segurá-la, você pode gastar 1 carga para conjurar Desejo a partir dela. Uma vez utilizada, essa propriedade não pode ser usada novamente até o próximo amanhecer. A arma perde essa propriedade se não tiver cargas.
Sorte. Se a arma estiver em sua posse, você pode invocar a sorte dela (nenhuma ação é necessária) para refazer um Teste de D20 que falhou, desde que não esteja com a condição Incapacitado. Você deve usar o segundo teste. Uma vez utilizada, esta propriedade não pode ser utilizada novamente até o próximo amanhecer.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Arma (Cimitarra, Espada Curta, Espada Grande, Espada Longa, Glaive, Rapieira)","rarity":"legendary","rarityLabel":"Lendário","requiresAttunement":true,"header":"Arma (Cimitarra, Espada Curta, Espada Grande, Espada Longa, Glaive, Rapieira), Lendário (Requer Sintonização)","attunement":"Requer Sintonização","weaponSubtype":"Cimitarra, Espada Curta, Espada Grande, Espada Longa, Glaive, Rapieira"}'::jsonb
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
  'lamina-solar',
  'weapon'::rpg.item_type,
  'Lâmina Solar',
  NULL,
  NULL,
  'Este item parece ser um cabo de espada.
Lâmina Radiante. Ao empunhar o cabo, você pode executar uma Ação Bônus para fazer com que uma lâmina de brilho puro surja ou desapareça. Enquanto a lâmina existir, esta arma mágica funciona como uma Espada Longa com a propriedade Acuidade. Se você é proficiente com Espadas Longas ou Curtas, você é proficiente com a Lâmina Solar.
Você adquire um bônus de +2 em jogadas de ataque e dano realizadas com esta arma, que causa dano Radiante em vez de dano Cortante. Em um acerto contra um Morto-vivo, o alvo sofre 1d8 pontos de dano Radiante adicionais.
Luz Solar. A lâmina iluminada da espada emite Luz Plena em um raio de 4,5 metros e Meia-luz por mais 4,5 metros. A luz é a luz do sol. Enquanto a lâmina persistir, você pode executar uma ação Usar Magia para expandir ou reduzir seu raio de Luz Plena e Meia-luz em 1,5 metro cada, até um máximo de 9 metros cada ou um mínimo de 3 metros cada.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Arma (Espada Longa)","rarity":"rare","rarityLabel":"Raro","requiresAttunement":true,"header":"Arma (Espada Longa), Raro (Requer Sintonização)","attunement":"Requer Sintonização","weaponSubtype":"Espada Longa"}'::jsonb
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
  'laminegra',
  'weapon'::rpg.item_type,
  'Laminegra',
  NULL,
  NULL,
  'Escondida na masmorra da Montanha Pluma Branca, Laminegra brilha como um pedaço de céu noturno repleto de estrelas. Sua bainha preta é adornada com fragmentos de obsidiana polida.
Você recebe um bônus de +3 em jogadas de ataque e dano realizadas com esta arma mágica. Ao atingir um Morto-Vivo com ela, você sofre 1d10 pontos de dano Necrótico e o alvo recupera 1d10 Pontos de Vida. Se esse dano Necrótico reduzir você a 0 Pontos de Vida, Laminegra devora sua alma (veja “Devorar Alma” abaixo).
Enquanto empunha esta arma, você possui Imunidade às condições Amedrontado e Enfeitiçado, além de Visão às Cegas com um alcance de 9 metros.
Devorar Alma. Ao reduzir uma criatura a 0 Pontos de Vida com a Laminegra, a espada mata a criatura e devora a alma dela, a menos que seja um Constructo ou um Morto-Vivo. Uma criatura cuja alma foi devorada por Laminegra só pode ser trazida de volta à vida pela magia Desejo.
Quando Laminegra devora uma alma que não é a sua, você recebe Pontos de Vida Temporários iguais aos Pontos de Vida Máximos da criatura morta.
Celeridade. Laminegra pode conjurar Celeridade em você. Laminegra decide quando conjurar a magia, que entra em vigor no início do seu turno. A magia dura 1 minuto (sem necessidade de Concentração) ou até que Laminegra decida encerrá-la, o que pode ocorrer no final de qualquer um dos seus turnos.
Senciência. Laminegra é uma arma Caótica e Neutra senciente com Inteligência 17, Sabedoria 10 e Carisma 19. Possui audição e visão no escuro até 36 metros.
A arma fala Comum e pode se comunicar telepaticamente com seu portador. A voz dela é profunda e ecoante. Enquanto você estiver sintonizado com ela, Laminegra também compreende todos os idiomas que você conhece.
Personalidade. Laminegra fala com um tom autoritário, como se estivesse habituada a ser obedecida.
O propósito da lâmina é consumir almas. Não se importa de quem é a alma que devora, incluindo a do portador. A lâmina acredita que toda matéria e energia surgiram de um vazio de energia negativa e um dia retornarão a ele. Laminegra é destinada a acelerar esse processo.
Apesar de seu narcisismo, Laminegra sente uma estranha afinidade por Onda e Opressor, duas outras armas trancadas sob a Montanha Pluma Branca. Ele deseja que as três armas sejam reunidas e empunhadas juntas em combate, mesmo que discorde violentamente de Opressor e ache Onda entediante.
A sede de almas de Laminegra deve ser regularmente saciada. Se a arma passar 3 dias ou mais sem consumir uma alma, um conflito entre ela e seu portador ocorrerá no próximo pôr do sol.
Destruindo Laminegra. Laminegra pode ser destruída esmagando-a nas grandes engrenagens de Mecânos. Primus, o criador dos modrons, também conhece uma série de tons musicais que Laminegra não suporta ouvir, fazendo com que a arma se despedace.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Arma (Espada Grande)","rarity":"artifact","rarityLabel":"Artefato","requiresAttunement":true,"header":"Arma (Espada Grande), Artefato (Requer Sintonização)","attunement":"Requer Sintonização","weaponSubtype":"Espada Grande"}'::jsonb
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
  'lanterna-reveladora',
  'other'::rpg.item_type,
  'Lanterna Reveladora',
  NULL,
  NULL,
  'Enquanto acesa, esta lanterna coberta queima por 6 horas com 0,5 litro de Óleo, emitindo Luz Plena em um raio de 9 metros e Meia-luz por mais 9 metros. Criaturas e objetos invisíveis tornam-se visíveis enquanto estiverem na Luz Plena da lanterna. Você pode executar uma ação Usar Objeto para abaixar a tampa, reduzindo a luz da lanterna para Meia-luz em um raio de 1,5 metro.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"uncommon","rarityLabel":"Incomum","requiresAttunement":false,"header":"Item Maravilhoso, Incomum"}'::jsonb
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
  'leque-do-vento',
  'other'::rpg.item_type,
  'Leque do Vento',
  NULL,
  NULL,
  'Enquanto segurar este leque, você pode conjurar Lufada de Vento (CD 13 para evitar) a partir dele. Cada vez que o leque é usado antes do próximo amanhecer, ele tem uma chance cumulativa de 20% de não funcionar. Se o leque não funcionar, ele se rasga em farrapos inúteis e não mágicos.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"uncommon","rarityLabel":"Incomum","requiresAttunement":false,"header":"Item Maravilhoso, Incomum"}'::jsonb
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
  'lingua-flamejante',
  'weapon'::rpg.item_type,
  'Língua Flamejante',
  NULL,
  NULL,
  'Enquanto estiver segurando esta arma mágica, você pode executar uma Ação Bônus e pronunciar uma palavra de comando para fazer com que chamas envolvam a lâmina. Essas chamas emitem Luz Plena em um raio de 12 metros e Meia-luz por mais 12 metros. Enquanto a arma estiver em chamas, ela causa 2d6 pontos de dano Ígneo adicionais ao acertar. As chamas permanecem até você executar uma Ação Bônus para repetir o comando ou até que você largue, guarde ou embainhe a arma.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Arma (Qualquer Arma Corpo a Corpo)","rarity":"rare","rarityLabel":"Raro","requiresAttunement":true,"header":"Arma (Qualquer Arma Corpo a Corpo), Raro (Requer Sintonização)","attunement":"Requer Sintonização","weaponSubtype":"Qualquer Arma Corpo a Corpo"}'::jsonb
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
  'livro-das-trevas-profanas',
  'other'::rpg.item_type,
  'Livro das Trevas Profanas',
  NULL,
  NULL,
  'O conteúdo deste manuscrito sujo é sórdido, de perversidade inefável. Ele abriga um conhecimento tão hediondo que até mesmo vislumbrar as páginas rabiscadas é um convite à desgraça.
A maioria acredita que o deus-lich Vecna foi o autor do Livro das Trevas Profanas. Ele registrou nessas páginas todas as ideias horríveis, todos os pensamentos sórdidos e todos os exemplos de magia macabra que encontrou ou inventou.
Outros praticantes do mal acrescentaram suas próprias contribuições ao catálogo de conhecimentos sórdidos do livro. Suas adições são evidentes, pois os autores de obras posteriores conectaram o que quer que estivessem escrevendo ao tomo ou, em alguns casos, fizeram anotações e adições ao texto existente. Há lugares onde as páginas estão faltando, rasgadas ou completamente cobertas com tinta, sangue e rabiscos, tornando o texto original indecifrável.
A natureza não tolera a presença do livro. Plantas comuns murcham em sua proximidade, animais comuns evitam se aproximar dele, e o livro destrói gradualmente tudo o que toca. Até mesmo pedras se partem e se transformam em pó se o livro repousar nelas por tempo suficiente.
Sempre que uma criatura que não seja um Ínfero ou um Morto-Vivo se sintoniza com o Livro das Trevas Profanas, deve realizar uma salvaguarda de Carisma CD 17. Se falhar, é magicamente transformada em uma Larva sob o controle do Mestre. Apenas a magia Desejo pode reverter essa transformação profana.
Uma criatura sintonizada ao livro deve passar 80 horas lendo-o e estudando-o para absorver seu conteúdo e receber os benefícios das propriedades Conhecimento Sombrio, Discurso Sombrio, Forma Incansável, Magias e Valores de Atributo Modificados.
O Livro das Trevas Profanas permanece com você apenas enquanto você se esforçar para espalhar o mal pelo mundo. Se você não realizar pelo menos um ato de maldade em um período de 10 dias, ou se cometer voluntariamente um ato de bondade, o livro desaparece, sua Sintonização com ele termina imediatamente e você perde todos os benefícios que ele concede. Se você morrer enquanto estiver sintonizado com o livro, uma entidade de grande maldade reivindica sua alma. Você não pode ser restaurado à vida de forma alguma enquanto sua alma permanecer aprisionada.
Conhecimento Sombrio. Você pode consultar o Livro das Trevas Profanas sempre que realizar um teste de Inteligência para recordar informações sobre algum aspecto do mal, como o conhecimento sobre demônios. Ao fazer isso, você tem Vantagem nesse teste.
A critério do Mestre, o livro pode revelar segredos que nenhum mortal deveria conhecer, como os verdadeiros nomes de Ínferos poderosos, rituais terríveis que permitem que alguém se transforme em um cavaleiro da morte ou lich, ou magias há muito esquecidas criadas por seres tão malignos que seus nomes nunca deveriam ser pronunciados em voz alta.
Discurso Sombrio. Enquanto estiver carregando o livro, você pode executar uma ação Usar Magia para recitar palavras de suas páginas em uma linguagem sórdida e morta. Cada vez que realizar isso, você sofre 1d12 pontos de dano Psíquico e cada criatura a até 4,5 metros de você sofre 3d6 pontos de dano Psíquico, a menos que a criatura seja um Ínfero ou um Morto-Vivo.
Forma Incansável. Enquanto o livro estiver com você, você tem Imunidade à Condição Exaustão.
Valores de Atributo Modificados. Um valor de atributo à sua escolha aumenta em 2, até o máximo de 24. Outro valor de atributo à sua escolha diminui em 2, até o mínimo de 3. O livro não modifica seus valores de atributo novamente.
Propriedades Aleatórias. O Livro das Trevas Profanas possui as seguintes propriedades aleatórias (veja “Artefatos” neste capítulo):
● 3 propriedades benéficas menores
● 1 propriedade benéfica maior
● 3 propriedades prejudiciais menores
● 2 propriedades prejudiciais maiores
Magias. Enquanto possui o livro e o segura, você pode conjurar as seguintes magias dele (CD 18 para evitar):
● Animar Mortos
● Círculo da Morte
● Dedo da Morte
● Dominar Monstro
Ao conjurar uma magia com este livro, você não pode utilizá-la novamente até o próximo amanhecer.
Destruindo o Livro. O Livro das Trevas Profanas permite que suas páginas sejam arrancadas, mas qualquer conhecimento maligno contido nessas páginas inevitavelmente encontra seu caminho de volta ao livro, quando um novo autor adiciona páginas ao tomo.
Se um solar rasgar o livro em dois, o livro é destruído por 1d100 anos, mas após esse tempo, ele se reconstitui em algum canto sombrio do multiverso.
Uma criatura sintonizada com o livro por 100 anos pode descobrir uma frase escondida no texto original que, se traduzida para o Celestial e lida em voz alta, destrói tanto o orador quanto o livro em um lampejo de brilho. No entanto, enquanto o mal existir no multiverso, o livro se reconstitui 1d10 × 100 anos depois.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"artifact","rarityLabel":"Artefato","requiresAttunement":true,"header":"Item Maravilhoso, Artefato (Requer Sintonização)","attunement":"Requer Sintonização"}'::jsonb
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
  'livro-de-magias-duravel',
  'other'::rpg.item_type,
  'Livro de Magias Durável',
  NULL,
  NULL,
  'Este livro de magias, assim como tudo o que estiver escrito em suas páginas, não pode ser danificado por fogo ou água. Além disso, o livro de magias não se deteriora com o tempo.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"common","rarityLabel":"Comum","requiresAttunement":false,"header":"Item Maravilhoso, Comum"}'::jsonb
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
  'livro-dos-feitos-sublimes',
  'other'::rpg.item_type,
  'Livro dos Feitos Sublimes',
  NULL,
  NULL,
  'O Livro dos Feitos Sublimes, um tratado essencial sobre o bem no multiverso, é fundamental em muitas religiões. Em vez de representar uma fé específica, seus diversos autores expressaram suas visões sobre a verdadeira virtude, oferecendo diretrizes para combater o mal.
O Livro dos Feitos Sublimes raramente permanece em um só lugar. Após ser lido, ele desaparece para um local do multiverso onde sua orientação moral pode trazer esperança a um mundo ameaçado. Embora tenham sido feitas tentativas de reproduzir a obra, os esforços para isso não conseguem capturar sua essência mágica nem traduzir os benefícios que ela proporciona aos puros de coração e firmes de propósito.
Um fecho pesado, projetado para parecer asas de anjos, mantém o conteúdo do livro em segurança. Apenas uma criatura sintonizada ao livro pode abrir o fecho que o mantém lacrado. Uma vez que o livro é aberto, a criatura sintonizada deve passar 80 horas lendo e estudando o livro para absorver seu conteúdo e receber seus benefícios.
Outras criaturas que tentarem ler não compreendem o significado profundo e não recebem nenhum benefício. Um Ínfero, um Morto-Vivo ou um servo de um deus dos Planos Inferiores que tentar o livro sofre 24d6 pontos de dano Radiante, que ignora Resistência e Imunidade, e não pode ser evitado de forma alguma. Uma criatura reduzida a 0 Pontos de Vida devido a esse dano desaparece em um brilho ofuscante, é destruída e deixa suas posses para trás. O livro então desaparece e a Sintonia da criatura com ele termina.
Os benefícios concedidos pelo Livro dos Feitos Sublimes se mantêm enquanto você se esforçar para fazer o bem. Se não realizar nenhum ato de bondade ou generosidade em um período de 10 dias, ou cometer voluntariamente um ato de maldade, você perde todos os benefícios do livro.
Auréola. Após dedicar o tempo necessário à leitura e ao estudo do livro, você recebe uma auréola protetora que emite Luz Plena em um raio de 3 metros e Meia-luz por mais 3 metros. Você pode dispensar ou manifestar a auréola como uma Ação Bônus. Enquanto estiver presente, a auréola lhe concede Vantagem em testes de Carisma (Persuasão). Além disso, Ínferos e Mortos-vivos dentro da Luz Plena da auréola realizam jogadas de ataque contra você com Desvantagem.
Estabilidade Celestial. Enquanto estiver sintonizado com o livro, você possui Imunidade às condições Amedrontado e Enfeitiçado, além de Resistência a Dano Psíquico. Esses benefícios se tornam permanentes após você passar o tempo necessário lendo e estudando o livro.
Magia Esclarecida. Após dedicar o tempo necessário à leitura e ao estudo do livro, qualquer espaço de magia que você gastar para conjurar uma magia conta como um espaço de magia de um círculo superior.
Sabedoria Divina. Após dedicar o tempo necessário à leitura e ao estudo do livro, seu valor de Sabedoria aumenta em 2, até o máximo de 24. Você não pode obter esse benefício do livro mais de uma vez.
Propriedades Aleatórias. O Livro dos Feitos Sublimes possui as seguintes propriedades aleatórias (veja “Artefatos” neste capítulo):
● 2 propriedades benéficas menores
● 2 propriedades benéficas maiores
Destruindo o Livro. O Livro dos Feitos Sublimes não pode ser destruído. No entanto, imergir o livro no Rio Estige remove todos os textos e imagens de suas páginas, deixando-o sem poder por 1d100 anos.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"artifact","rarityLabel":"Artefato","requiresAttunement":true,"header":"Item Maravilhoso, Artefato (Requer Sintonização)","attunement":"Requer Sintonização"}'::jsonb
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
  'loriga-de-escamas-draconicas',
  'armor'::rpg.item_type,
  'Loriga de Escamas Dracônicas',
  NULL,
  NULL,
  'A Loriga de Escamas Dracônicas é feita das escamas de um tipo específico de dragão. Algumas vezes, dragões recolhem suas escamas caídas e as oferecem como presente. Outras vezes, caçadores esfolam cuidadosamente o couro de um dragão morto. Seja qual for o caso, a Loriga de Escamas Dracônicas é altamente valorizada.
Enquanto estiver vestindo esta armadura, você adquire um bônus de +1 na Classe de Armadura, tem Vantagem em salvaguardas contra ataques de sopro de Dragões e possui Resistência a um tipo de dano determinado pelo tipo de dragão cujas escamas foram usadas (veja a tabela a seguir).
Além disso, você pode focar seus sentidos como uma ação Usar Magia para discernir a distância e a direção do dragão mais próximo em um raio de 48 quilômetros de você que seja do mesmo tipo da armadura. Esta ação não pode ser usada novamente até o próximo amanhecer.
 
Dragão
	Resistência
	Azul
	Elétrico
	Branco
	Gélido
	Bronze
	Elétrico
	Cobre
	Ácido
	Latão
	Ígneo
	Negro
	Ácido
	Ouro
	Ígneo
	Prata
	Gélido
	Verde
	Venenoso
	Vermelho
	Ígneo',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Armadura (Loriga de Escamas)","rarity":"very-rare","rarityLabel":"Muito Raro","requiresAttunement":true,"header":"Armadura (Loriga de Escamas), Muito Raro (Requer Sintonização)","attunement":"Requer Sintonização","armorSubtype":"Loriga de Escamas"}'::jsonb
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
  'lunamina',
  'weapon'::rpg.item_type,
  'Lunâmina',
  NULL,
  NULL,
  'De todos os itens mágicos criados pelos elfos, um dos mais valiosos e zelosamente protegidos é a Lunâmina. Em tempos antigos, quase todas as casas nobres élficas reivindicavam uma dessas armas. Ao longo dos séculos, algumas desapareceram do mundo, sua magia perdida à medida que linhagens familiares se extinguiram. Outras sumiram com seus portadores durante grandes jornadas. Assim, apenas algumas dessas armas ainda existem.
Toda Lunâmina anseia por um portador cuja índole e objetivos sejam compatíveis com os seus. Ao tentar se sintonizar com uma Lunâmina que não o aceita como portador, a arma não apenas rejeita você, mas também impõe uma maldição: durante 24 horas, ou até que a maldição seja encerrada por uma magia Remover Maldição ou efeito similar, você deve realizar Testes de D20 com Desvantagem. Se a arma o aceitar e você tentar se sintonizar com ela, a sintonização ocorre instantaneamente e uma nova runa surge em sua lâmina. Você permanece sintonizado com a arma até morrer ou até que ela seja destruída. Para qualquer criatura que não seja seu portador escolhido, uma Lunâmina funciona como uma arma não mágica de seu tipo.
Uma Lunâmina possui uma runa para cada portador que serviu voluntariamente (normalmente 1d6 + 1). A primeira runa oferece um bônus de +1 em jogadas de ataque e dano realizadas com esta arma mágica. Cada runa, além da primeira, confere à Lunâmina uma propriedade adicional. O Mestre escolhe cada propriedade ou a determina aleatoriamente jogando na tabela Propriedades da Lunâmina.
Propriedade Menor. Além de suas propriedades acima mencionadas, cada Lunâmina tem uma propriedade menor determinada ao jogar na tabela Propriedade Menor do Item Mágico.
Senciência. Uma Lunâmina é uma arma inteligente com Inteligência 12, Sabedoria 10 e Carisma 12. Possui audição e visão no escuro até 36 metros. Seu alinhamento corresponde ao de seu criador.
A arma se comunica por meio da transmissão de emoções, enviando uma sensação de formigamento pela mão do portador quando deseja transmitir algo que percebeu. Ela também pode se comunicar por meio de visões ou sonhos enquanto o portador está em transe ou dormindo.
Personalidade. Uma Lunâmina possui uma personalidade que reflete a de seu criador. Uma vez que uma Lunâmina escolhe um proprietário, ela acredita que apenas essa pessoa deve empunhá-la, mesmo que o alinhamento do portador destoe dos objetivos da arma ou que o portador entre em conflito com os propósitos da lâmina.
Lunâmina (Espada Longa)
Propriedades da Lunâmina.
1d100
	Propriedade
	01–60
	Aumente o bônus da arma em jogadas de ataque e dano em 1, até no máximo +3. Jogue novamente se a Lunâmina já tiver um bônus de +3.
	61–75
	Ao acertar com uma jogada de ataque usando a Lunâmina, você causa 1d6 pontos de dano Energético adicionais. Cada vez que a arma recebe essa propriedade após a primeira, o dano adicional aumenta em 1d6, até um máximo de 3d6. Jogue novamente se a Lunâmina já causar 3d6 pontos de dano Energético adicionais em um acerto.
	76–80
	A Lunâmina recebe a propriedade Arremesso com um alcance normal de 6 metros e um alcance máximo de 18 metros. Cada vez que você arremessa a arma, ela retorna à sua mão após o ataque.
	81–85
	A Lunâmina obtém um Acerto Crítico em jogadas com resultados 19 ou 20 no d20.
	86–95
	Você pode executar uma Ação Bônus para fazer com que a Lunâmina brilhe intensamente. Cada outra criatura que esteja a até 9 metros de você, que não esteja atrás de uma Cobertura Total, deve ser bem-sucedida em uma salvaguarda de Constituição CD 15 ou tem a condição Cego por 1 minuto. Uma criatura repete a salvaguarda no final de cada um dos turnos dela, encerrando o efeito em caso de sucesso. Você não pode usar esta propriedade novamente até completar um Descanso Curto ou Longo.
	96–99
	A Lunâmina tem as propriedades de um Anel Armazenador de Magias.
	00
	Você pode executar uma ação Usar Magia para conjurar uma entidade espectral que se assemelha a um elfo sombrio, caso ainda não tenha uma a seu serviço. A entidade surge em um espaço desocupado a até 36 metros de você. Ela utiliza o bloco de estatísticas de uma Sombra, com as seguintes alterações: seu tipo de criatura é Feérico, seu alinhamento é Neutro, e ela não cria novas sombras. Você controla essa entidade, decidindo como ela age e se movimenta. Ela permanece até ser reduzida a 0 Pontos de Vida ou até você dissipá-la por meio de uma ação Usar Magia.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Arma (Espada Grande, Espada Longa, Rapieira, Cimitarra ou Espada Curta)","rarity":"legendary","rarityLabel":"Lendário","requiresAttunement":true,"header":"Arma (Espada Grande, Espada Longa, Rapieira, Cimitarra ou Espada Curta), Lendário (Requer Sintonização por uma Criatura da Escolha da Arma)","attunement":"Requer Sintonização por uma Criatura da Escolha da Arma","weaponSubtype":"Espada Grande, Espada Longa, Rapieira, Cimitarra ou Espada Curta"}'::jsonb
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
  'luvas-da-ladinagem',
  'other'::rpg.item_type,
  'Luvas da Ladinagem',
  NULL,
  NULL,
  'Estas luvas são imperceptíveis durante o uso. Ao usá-las, você recebe bônus de +5 em testes de Destreza (Prestidigitação).',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"uncommon","rarityLabel":"Incomum","requiresAttunement":false,"header":"Item Maravilhoso, Incomum"}'::jsonb
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
  'luvas-de-apanhar-projeteis',
  'other'::rpg.item_type,
  'Luvas de Apanhar Projéteis',
  NULL,
  NULL,
  'Enquanto usar estas luvas, ao ser atingido por uma jogada de ataque com uma arma de Arremesso ou à Distância, você pode executar uma Reação para reduzir o dano em 1d10 mais seu modificador de Destreza, desde que tenha uma mão livre. Se reduzir o dano a 0, você pode pegar a munição ou arma, se for pequena o suficiente para sua mão.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"uncommon","rarityLabel":"Incomum","requiresAttunement":true,"header":"Item Maravilhoso, Incomum (Requer Sintonização)","attunement":"Requer Sintonização"}'::jsonb
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
  'luvas-de-natacao-e-escalada',
  'other'::rpg.item_type,
  'Luvas de Natação e Escalada',
  NULL,
  NULL,
  'Enquanto estiver vestindo estas luvas, você tem um Deslocamento de Escalada e um Deslocamento de Natação igual ao seu Deslocamento, e você recebe um bônus de +5 nos testes de Força (Atletismo) realizados para escalar ou nadar.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"uncommon","rarityLabel":"Incomum","requiresAttunement":true,"header":"Item Maravilhoso, Incomum (Requer Sintonização)","attunement":"Requer Sintonização"}'::jsonb
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
  'maca-da-destruicao',
  'weapon'::rpg.item_type,
  'Maça da Destruição',
  NULL,
  NULL,
  'Você adquire um bônus de +1 em jogadas de ataque e dano realizadas com esta arma mágica. O bônus aumenta para +3 quando você ataca um Constructo com ela.
Ao tirar 20 em uma jogada de ataque realizada com esta arma, o alvo sofre 7 pontos de dano Contundente adicionais ou 14 pontos de dano Contundente adicionais se for um Constructo. Se um Constructo tiver 25 Pontos de Vida ou menos após sofrer esse dano, ele é destruído.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Arma (Maça)","rarity":"rare","rarityLabel":"Raro","requiresAttunement":false,"header":"Arma (Maça), Raro","weaponSubtype":"Maça"}'::jsonb
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
  'maca-da-disrupcao',
  'weapon'::rpg.item_type,
  'Maça da Disrupção',
  NULL,
  NULL,
  'Ao acertar um Ínfero ou um Morto-Vivo com esta arma mágica, essa criatura sofre 2d6 pontos de dano Radiante adicionais. Se o alvo tiver 25 Pontos de Vida ou menos após sofrer esse dano, ele deve ser bem-sucedido em uma salvaguarda de Sabedoria CD 15 ou é destruído. Em caso de sucesso, a criatura tem a condição Amedrontado até o final do seu próximo turno.
Iluminação. Enquanto você empunha esta arma, ela emite Luz Plena em um raio de 6 metros e Meia-luz por mais 6 metros.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Arma (Maça)","rarity":"rare","rarityLabel":"Raro","requiresAttunement":true,"header":"Arma (Maça), Raro (Requer Sintonização)","attunement":"Requer Sintonização","weaponSubtype":"Maça"}'::jsonb
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
  'maca-do-terror',
  'weapon'::rpg.item_type,
  'Maça do Terror',
  NULL,
  NULL,
  'Esta arma mágica possui 3 cargas e recupera 1d3 cargas gastas diariamente ao amanhecer. Enquanto estiver empunhando-a, você pode executar uma ação Usar Magia e gastar 1 carga para liberar uma onda de terror a partir dela. Cada criatura à sua escolha a até 9 metros de você deve ser bem-sucedida em uma salvaguarda de Sabedoria CD 15 ou tem com a condição Amedrontado por 1 minuto. Enquanto estiver Amedrontada deste modo, uma criatura deve gastar seus turnos tentando se mover para o mais longe possível de você e não pode realizar Ataques de Oportunidade. Durante sua ação, ela pode usar apenas a opção Correr ou tentar escapar de um efeito que a impeça de se mover. Se não houver nenhum lugar para onde possa se mover, a criatura pode executar a ação Esquivar. No final de cada um dos turnos da criatura, ela pode repetir a salvaguarda, encerrando o efeito sobre si em caso de sucesso.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Arma (Maça)","rarity":"rare","rarityLabel":"Raro","requiresAttunement":true,"header":"Arma (Maça), Raro (Requer Sintonização)","attunement":"Requer Sintonização","weaponSubtype":"Maça"}'::jsonb
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
  'machado-do-carrasco',
  'weapon'::rpg.item_type,
  'Machado do Carrasco',
  NULL,
  NULL,
  'Você adquire um bônus de +1 em jogadas de ataque e dano realizadas com esta arma mágica.
Qualquer Humanoide que você acertar com a arma sofre 2d6 pontos de dano Cortante adicionais, e você adquire Pontos de Vida Temporários iguais ao dano adicional causado.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Arma (Alabarda, Machadinha, Machado de Batalha ou Machado Grande)","rarity":"very-rare","rarityLabel":"Muito Raro","requiresAttunement":false,"header":"Arma (Alabarda, Machadinha, Machado de Batalha ou Machado Grande), Muito Raro","weaponSubtype":"Alabarda, Machadinha, Machado de Batalha ou Machado Grande"}'::jsonb
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
  'machado-dos-senhores-anoes',
  'weapon'::rpg.item_type,
  'Machado dos Senhores Anões',
  NULL,
  NULL,
  'Um jovem príncipe anão embarcou em uma jornada para forjar uma arma que simbolizasse a unidade de seu povo. Aventurando-se como nenhum anão antes dele, chegou ao núcleo ardente de um grande vulcão. Com a ajuda de Moradin, deus da criação, ele criou quatro poderosas ferramentas: a Picareta do Metal Estelar, a Forja Coração da Terra, a Bigorna das Melodias e o Martelo Moldador. Usando essas ferramentas, forjou o lendário Machado dos Senhores Anões.
Empunhando o Artefato, o príncipe trouxe paz aos clãs anões, encerrando rixas e reparando antigas ofensas. Os clãs se tornaram aliados, repeliram seus inimigos e desfrutaram de uma era de prosperidade. Esse jovem anão é lembrado como o Primeiro Rei. Já em sua velhice, ele passou a arma, que se tornara símbolo de sua autoridade, para seu herdeiro. Por gerações, os herdeiros legítimos mantiveram o machado.
Mais tarde, em uma era de traição e maldade, o machado foi perdido durante uma sangrenta guerra civil fomentada pela ganância por seu poder e pelo status que conferia. Séculos depois, os anões ainda o procuram, enquanto muitos aventureiros dedicaram suas vidas a perseguir rumores e saquear antigos cofres em busca do lendário artefato.
Arma Mágica. O Machado dos Senhores Anões é uma arma mágica que concede um bônus de +3 para jogadas de ataque e dano realizadas com ele.
Ao atacar uma criatura com o machado e ter 20 no d20 em uma jogada de ataque, o machado causa 20 pontos de dano Cortante adicionais.
O machado tem a propriedade Arremesso, com alcance normal de 6 metros e máximo de 18 metros. Ao atingir um ataque à distância com esta arma, ela causa 1d8 pontos de dano Energético adicionais ou 2d8 pontos de dano Energético adicionais se o alvo for uma criatura do tipo Gigante. Imediatamente após atingir ou errar, a arma retorna à sua mão.
Bênçãos de Moradin. Enquanto estiver sintonizado com o machado, você adquire os seguintes benefícios:
Dádivas do Criador. Você tem proficiência com Suprimentos de Cervejeiro, Ferramentas de Pedreiro e Ferramentas de Ferreiro.
Fortaleza de Pedra. Sua Constituição aumenta em 2, até no máximo 20.
Separação. Ao atingir um objeto com o machado, o objeto sofre o máximo de dano possível.
Um com a Forja. Você tem Imunidade a dano Venenoso e Resistência a dano Ígneo.
Visão no Escuro. Você adquire Visão no Escuro com um alcance de 18 metros. Se você já tem Visão no Escuro, seu alcance aumenta em 18 metros.
Invocar Elemental da Terra. Enquanto segura o machado, você pode executar uma ação Usar Magia para invocar um Elemental da Terra. Ele aparece em um espaço desocupado à sua escolha a até 9 metros de você, entende seus idiomas, obedece aos seus comandos e realiza o turno imediatamente após a sua contagem de Iniciativa. O elemental desaparece após 24 horas, quando ele morre ou quando você o dispensa como uma Ação Bônus. Você restaura esta propriedade após o próximo amanhecer.
Propriedades Aleatórias. O machado tem as seguintes propriedades aleatórias (veja “Artefatos” neste capítulo):
● 2 propriedades benéficas menores
● 1 propriedade benéfica maior
● 2 propriedades prejudiciais menores
Viagem às Profundezas. Ao tocar o machado com uma ação Usar Magia em uma peça fixa de trabalho anão em pedra, você pode conjurar Teleporte a partir do machado. Se o destino pretendido for subterrâneo, não há chance de ocorrer um acidente ou chegar a algum lugar inesperado. Você não pode usar esta propriedade novamente até que 3 dias tenham se passado.
Destruindo o Machado. A única maneira de destruir o machado é derretê-lo na Forja Coração da Terra, onde foi criado. Ele deve permanecer na forja em chamas por 50 anos antes de finalmente sucumbir ao fogo e ser consumido.
Armadura +1 (Armadura de Placas), Machado dos Senhores Anões',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Arma (Machado de Batalha)","rarity":"artifact","rarityLabel":"Artefato","requiresAttunement":true,"header":"Arma (Machado de Batalha), Artefato (Requer Sintonização)","attunement":"Requer Sintonização","weaponSubtype":"Machado de Batalha"}'::jsonb
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
  'machado-berserker',
  'weapon'::rpg.item_type,
  'Machado-Berserker',
  NULL,
  NULL,
  'Você recebe um bônus de +1 em jogadas de ataque e dano realizadas com esta arma mágica. Além disso, enquanto você estiver sintonizado com esta arma, seus Pontos de Vida máximos aumentam em 1 para cada nível que você atingiu.
Maldição. Esta arma é amaldiçoada e sintonizar-se com ela compartilha a maldição com você. Enquanto estiver amaldiçoado, você não deseja se separar dela, mantendo-a ao alcance o tempo todo. Você também tem Desvantagem em jogadas de ataque com armas que não sejam esta.
Sempre que outra criatura causar dano a você enquanto a arma estiver em sua posse, você deve ser bem-sucedido em uma salvaguarda de Sabedoria CD 15 ou entra em estado de berserk. Esse estado termina quando você começa o seu turno e não há criaturas a até 18 metros de você que possa ver ou ouvir.
Em berserk, você considera a criatura mais próxima à sua vista e que puder ouvir como seu inimigo. Se houver várias, escolha uma aleatoriamente. Durante cada um dos seus turnos, mova-se o mais próximo possível da criatura e execute a ação Atacar, atacando-a. Se não puder se aproximar o suficiente para atacá-la, seu turno termina após usar todo o movimento disponível. Se a criatura morrer ou deixar de ser visível ou audível para você, escolha a criatura mais próxima que você puder ver ou ouvir como seu novo alvo.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Arma (Alabarda, Machado de Batalha ou Machado Grande)","rarity":"rare","rarityLabel":"Raro","requiresAttunement":true,"header":"Arma (Alabarda, Machado de Batalha ou Machado Grande), Raro (Requer Sintonização)","attunement":"Requer Sintonização","weaponSubtype":"Alabarda, Machado de Batalha ou Machado Grande"}'::jsonb
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
  'manoplas-de-poder-do-ogro',
  'other'::rpg.item_type,
  'Manoplas de Poder do Ogro',
  NULL,
  NULL,
  'Seu valor de Força é 19 enquanto estiver usando estas luvas. Elas não afetam você se sua Força for 19 ou superior sem elas.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"uncommon","rarityLabel":"Incomum","requiresAttunement":true,"header":"Item Maravilhoso, Incomum (Requer Sintonização)","attunement":"Requer Sintonização"}'::jsonb
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
  'manto-da-arraia',
  'other'::rpg.item_type,
  'Manto da Arraia',
  NULL,
  NULL,
  'Enquanto estiver vestindo este manto, você pode respirar debaixo d’água e tem um Deslocamento de Natação de 18 metros.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"uncommon","rarityLabel":"Incomum","requiresAttunement":true,"header":"Item Maravilhoso, Incomum (Requer Sintonização)","attunement":"Requer Sintonização"}'::jsonb
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
  'manto-da-natureza',
  'other'::rpg.item_type,
  'Manto da Natureza',
  NULL,
  NULL,
  'Este manto muda de cor e textura para se misturar com o terreno ao seu redor. Enquanto estiver usando o manto, você pode usá-la como um Foco de Conjuração para suas magias de Druida e Guardião.
Enquanto estiver em uma área Parcialmente Obscurecida, você pode executar a ação Esconder como uma Ação Bônus, mesmo que esteja sendo observado diretamente.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"uncommon","rarityLabel":"Incomum","requiresAttunement":true,"header":"Item Maravilhoso, Incomum (Requer Sintonização por um Druida ou Ranger)","attunement":"Requer Sintonização por um Druida ou Ranger"}'::jsonb
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
  'manto-das-asas',
  'other'::rpg.item_type,
  'Manto das Asas',
  NULL,
  NULL,
  'Enquanto estiver usando este manto, você pode executar uma ação Usar Magia para transformá-lo em um par de asas em suas costas. As asas duram 1 hora ou até você encerrar o efeito como uma ação Usar Magia. As asas concedem a você um Deslocamento de Voo de 18 metros. Se estiver no alto quando as asas desaparecerem, você cai. Quando as asas desaparecem, você não pode usá-las novamente por 1d12 horas.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"rare","rarityLabel":"Raro","requiresAttunement":true,"header":"Item Maravilhoso, Raro (Requer Sintonização)","attunement":"Requer Sintonização"}'::jsonb
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
  'manto-de-invisibilidade',
  'other'::rpg.item_type,
  'Manto de Invisibilidade',
  NULL,
  NULL,
  'Este manto tem 3 cargas e recupera 1d3 cargas gastas diariamente ao amanhecer. Enquanto estiver vestindo este manto, você pode executar uma ação Usar Mágica para colocar o capuz sobre sua cabeça e gastar 1 carga para conceder a si a condição Invisível por 1 hora. O efeito encerra se você retirar o capuz (nenhuma ação é necessária) ou parar de usar o manto.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"legendary","rarityLabel":"Lendário","requiresAttunement":true,"header":"Item Maravilhoso, Lendário (Requer Sintonização)","attunement":"Requer Sintonização"}'::jsonb
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
  'manto-de-protecao',
  'other'::rpg.item_type,
  'Manto de Proteção',
  NULL,
  NULL,
  'Você recebe um bônus de +1 na Classe de Armadura e em salvaguardas enquanto estiver usando este manto.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"uncommon","rarityLabel":"Incomum","requiresAttunement":true,"header":"Item Maravilhoso, Incomum (Requer Sintonização)","attunement":"Requer Sintonização"}'::jsonb
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
  'manto-de-resistencia-a-magia',
  'other'::rpg.item_type,
  'Manto de Resistência à Magia',
  NULL,
  NULL,
  'Você tem Vantagem em salvaguardas contra magias enquanto estiver vestindo este manto.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"rare","rarityLabel":"Raro","requiresAttunement":true,"header":"Item Maravilhoso, Raro (Requer Sintonização)","attunement":"Requer Sintonização"}'::jsonb
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
  'manto-do-morcego',
  'other'::rpg.item_type,
  'Manto do Morcego',
  NULL,
  NULL,
  'Enquanto estiver vestindo este manto, você tem Vantagem em testes de Destreza (Furtividade). Em uma área de Meia-luz ou Escuridão, você pode segurar as bordas do manto e usá-lo para ter um Deslocamento de Voo de 12 metros. Se você não conseguir pegar as bordas do manto enquanto voa deste modo, ou se não estiver mais em Meia-luz ou Escuridão, você perde este Deslocamento de Voo.
Enquanto estiver usando o manto em uma área de Meia-luz ou Escuridão, você pode conjurar Polimorfia em si, multimorfando-se em um Morcego. Enquanto estiver nessa forma, você mantém seus valores de Inteligência, Sabedoria e Carisma. O manto não pode ser usado desta forma novamente até o próximo amanhecer.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"rare","rarityLabel":"Raro","requiresAttunement":true,"header":"Item Maravilhoso, Raro (Requer Sintonização)","attunement":"Requer Sintonização"}'::jsonb
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
  'manual-de-rapidez-nas-acoes',
  'other'::rpg.item_type,
  'Manual de Rapidez nas Ações',
  NULL,
  NULL,
  'Este livro descreve exercícios de coordenação e equilíbrio, e suas palavras são carregadas de magia. Se você passar 48 horas em um período de 6 dias ou menos estudando o conteúdo do livro e praticando as diretrizes apresentadas, sua Destreza aumenta em 2, até no máximo 30. O manual então perde sua magia, mas a recupera em um século.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"very-rare","rarityLabel":"Muito Raro","requiresAttunement":false,"header":"Item Maravilhoso, Muito Raro"}'::jsonb
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
  'manual-de-saude-corporal',
  'other'::rpg.item_type,
  'Manual de Saúde Corporal',
  NULL,
  NULL,
  'Este livro contém dicas de saúde e nutrição e suas palavras são carregadas de magia. Se você passar 48 horas em um período de 6 dias ou menos estudando o conteúdo do livro e praticando as diretrizes apresentadas, seu valor de Constituição aumenta em 2, até no máximo 30. A magia do manual se dissipa, retornando após um século.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"very-rare","rarityLabel":"Muito Raro","requiresAttunement":false,"header":"Item Maravilhoso, Muito Raro"}'::jsonb
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
  'manual-dos-exercicios-beneficos',
  'other'::rpg.item_type,
  'Manual dos Exercícios Benéficos',
  NULL,
  NULL,
  'Este livro descreve exercícios de condicionamento físico e suas palavras são carregadas de magia. Se você passar 48 horas em um período de 6 dias ou menos estudando o conteúdo do livro e praticando as diretrizes apresentadas, seu valor de Força aumenta em 2, até no máximo 30. A magia do manual se dissipa, retornando após um século.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"very-rare","rarityLabel":"Muito Raro","requiresAttunement":false,"header":"Item Maravilhoso, Muito Raro"}'::jsonb
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
  'manual-dos-golens',
  'other'::rpg.item_type,
  'Manual dos Golens',
  NULL,
  NULL,
  'Este tomo contém informações e encantamentos necessários para fazer um tipo específico de golem. O Mestre escolhe o tipo ou o determina aleatoriamente jogando na tabela a seguir. Para decifrar e usar o manual, você deve ser um conjurador com pelo menos dois espaços de magia de 5º círculo. Uma criatura que não pode usar um Manual dos Golens e tentar lê-lo sofre 6d6 pontos de dano Psíquico.
Você deve dedicar o tempo mostrado na tabela para criar um golem, trabalhando sem pausas com o manual à disposição e descansando no máximo 8 horas por dia. Você também deve pagar o custo especificado para comprar suprimentos.
Após criar o golem, o livro é consumido em chamas místicas. O golem fica animado quando as cinzas do manual são polvilhadas sobre ele. Veja o Livro dos Monstros para o bloco de estatísticas do golem. O golem está sob seu controle e entende e obedece aos seus comandos.
1d20
	Golem
	Tempo
	Custo
	1–5
	Golem de Argila
	30 dias
	65.000 PO
	6–17
	Golem de Carne
	60 dias
	50.000 PO
	18
	Golem de Ferro
	120 dias
	100.000 PO
	19–20
	Golem de Pedra
	90 dias
	80.000 PO
	Manual dos Golens (Argila, Carne, Ferro, Pedra), Manual de Saúde Corporal',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"very-rare","rarityLabel":"Muito Raro","requiresAttunement":false,"header":"Item Maravilhoso, Muito Raro"}'::jsonb
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
  'martelo-arremessavel-dos-anoes',
  'weapon'::rpg.item_type,
  'Martelo Arremessável dos Anões',
  NULL,
  NULL,
  'Você recebe um bônus de +3 nas jogadas de ataque e dano realizadas com esta arma mágica. Ela tem a propriedade Arremesso, com alcance normal de 6 metros e máximo de 18 metros. Ao atingir um ataque à distância com esta arma, ela causa 1d8 pontos de dano Energético adicionais ou 2d8 pontos de dano Energético se o alvo for um Gigante. Imediatamente após atingir ou errar, a arma retorna à sua mão.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Arma (Martelo de Guerra)","rarity":"very-rare","rarityLabel":"Muito Raro","requiresAttunement":true,"header":"Arma (Martelo de Guerra), Muito Raro (Requer Sintonização por um Anão ou uma Criatura Sintonizada a um Cinturão do Povo Anão)","attunement":"Requer Sintonização por um Anão ou uma Criatura Sintonizada a um Cinturão do Povo Anão","weaponSubtype":"Martelo de Guerra"}'::jsonb
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
  'martelo-do-trovao',
  'weapon'::rpg.item_type,
  'Martelo do Trovão',
  NULL,
  NULL,
  'Você adquire um bônus de +1 em jogadas de ataque e dano realizadas com esta arma mágica.
A arma tem 5 cargas. Você pode gastar 1 carga e realizar um ataque à distância com a arma, arremessando-a como se ela tivesse a propriedade Arremesso, com alcance normal de 6 metros e máximo de 18 metros. Se o ataque acertar, a arma libera um estrondo audível a 90 metros. O alvo e todas as criaturas a até 9 metros dele, exceto você, devem ser bem-sucedidos em uma salvaguarda de Constituição CD 17 ou têm a condição Atordoado até o final do seu próximo turno. Imediatamente após atingir ou errar, a arma retorna à sua mão. A arma recupera 1d4 + 1 cargas gastas diariamente ao amanhecer.
Força dos Gigantes. O valor de Força concedido pelo seu Cinturão de Força de Gigante ou Manoplas de Poder do Ogro aumenta em 4, até no máximo 30.
Perdição do Gigante. Enquanto estiver sintonizado com a arma e vestindo um Cinturão de Força de Gigante ou Manoplas de Poder do Ogro com as quais também estiver sintonizado, você adquire os seguintes benefícios:
Perdição dos Gigantes. Ao tirar 20 no d20 em uma jogada de ataque realizada com esta arma contra um Gigante, a criatura deve ser bem-sucedida em uma salvaguarda de Constituição CD 17 ou morre.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Arma (Malho ou Martelo de Guerra)","rarity":"legendary","rarityLabel":"Lendário","requiresAttunement":true,"header":"Arma (Malho ou Martelo de Guerra), Lendário (Requer Sintonização)","attunement":"Requer Sintonização","weaponSubtype":"Malho ou Martelo de Guerra"}'::jsonb
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
  'matadora-de-dragoes',
  'weapon'::rpg.item_type,
  'Matadora de Dragões',
  NULL,
  NULL,
  'Você adquire um bônus de +1 em jogadas de ataque e dano realizadas com esta arma mágica.
A arma causa 3d6 pontos de dano adicionais do tipo da arma se o alvo for um Dragão.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Arma (Qualquer Simples ou Marcial)","rarity":"rare","rarityLabel":"Raro","requiresAttunement":false,"header":"Arma (Qualquer Simples ou Marcial), Raro","weaponSubtype":"Qualquer Simples ou Marcial"}'::jsonb
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
  'matadora-de-gigantes',
  'weapon'::rpg.item_type,
  'Matadora de Gigantes',
  NULL,
  NULL,
  'Você adquire um bônus de +1 em jogadas de ataque e dano realizadas com esta arma mágica.
Ao atingir um Gigante com esta arma, ele sofre 2d6 pontos de dano adicionais do tipo da arma e deve ser bem-sucedido em uma salvaguarda de Força CD 15 ou tem a condição Caído.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Arma (Qualquer Simples ou Marcial)","rarity":"rare","rarityLabel":"Raro","requiresAttunement":false,"header":"Arma (Qualquer Simples ou Marcial), Raro","weaponSubtype":"Qualquer Simples ou Marcial"}'::jsonb
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
  'membro-protetico',
  'other'::rpg.item_type,
  'Membro Protético',
  NULL,
  NULL,
  'Este item mágico substitui um membro perdido — uma mão, um braço, um pé, uma perna ou parte semelhante do corpo. Enquanto a prótese estiver acoplada, ela funciona de forma idêntica à parte que substitui. Você pode retirá-la ou acoplá-la novamente como uma ação Usar Magia, e ela não pode ser removida contra a sua vontade enquanto você estiver vivo.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"common","rarityLabel":"Comum","requiresAttunement":false,"header":"Item Maravilhoso, Comum"}'::jsonb
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
  'mochila-prestativa-de-heward',
  'other'::rpg.item_type,
  'Mochila Prestativa de Heward',
  NULL,
  NULL,
  'Esta mochila tem um bolso central e dois bolsos laterais, cada um das quais é um espaço extradimensional. Cada bolso lateral pode conter até 100 quilos de material, não excedendo um volume de 75 centímetros cúbicos. O bolso central pode conter até 250 quilos de material, não excedendo um volume de 1,8 metros cúbicos. A mochila sempre pesa 2,5 quilos, independentemente do seu conteúdo.
Recuperar um item da mochila exige uma ação Usar Objeto ou uma Ação Bônus (à sua escolha). Ao buscar um item específico dentro da mochila, o item está sempre magicamente no topo.
Se algum de seus bolsos estiver sobrecarregado, furado ou rasgado, a mochila se rompe e é destruída. Se a mochila for destruída, seu conteúdo é perdido para sempre, embora um Artefato sempre apareça novamente em algum lugar. Se a mochila for virada do avesso, seu conteúdo é despejado ileso, e a mochila deve ser virada do lado correto antes que possa ser usada novamente.
Cada bolso da mochila contém ar suficiente para 10 minutos de respiração, dividido pelo número de criaturas que respiram lá dentro.
Colocar a mochila em um espaço extradimensional criado por uma Bolsa Cabe Tudo, Buraco Portátil ou item semelhante destrói instantaneamente ambos os itens e abre um portal para o Plano Astral. O portal surge onde um item foi colocado dentro do outro. Qualquer criatura a até 3 metros do portal e não estiver atrás de uma Cobertura Total é sugada por ele e deixada em um local aleatório no Plano Astral. O portal então se fecha. O portal é unidirecional e não pode ser reaberto.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"rare","rarityLabel":"Raro","requiresAttunement":false,"header":"Item Maravilhoso, Raro"}'::jsonb
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
  'moeda-rival',
  'other'::rpg.item_type,
  'Moeda Rival',
  NULL,
  NULL,
  'Esta moeda de ouro tem uma criatura em relevo em cada lado. As duas criaturas representadas devem ser rivais famosas ou inimigas uma da outra. Por exemplo, uma Moeda Rival pode mostrar Iggwilv de um lado e Mordenkainen do outro, ou Vingador de um lado e Tiamat do outro. Uma dessas figuras está no lado “cara” da moeda, a outra no lado “coroa”.
A moeda tem 1 carga e recupera sua carga gasta diariamente ao amanhecer. Você pode executar uma ação Usar Magia para lançar a moeda, gastando sua carga. Jogue qualquer dado (1d2) para determinar se a moeda gera cara (em um número par) ou coroa (em um número ímpar). A jogada também determina o efeito:
Cara. Escolha como alvo uma criatura à sua vista a até 18 metros de distância. O alvo realiza uma salvaguarda de Sabedoria CD 13. Se falhar, o alvo sofre 2d4 pontos de dano Psíquico e tem Desvantagem na próxima jogada de ataque que realizar antes do final do próximo turno dele. Em caso de sucesso, o alvo sofre apenas metade do dano.
Coroa. Você sofre 1d4 pontos de dano Psíquico.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"common","rarityLabel":"Comum","requiresAttunement":false,"header":"Item Maravilhoso, Comum"}'::jsonb
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
  'municao-exterminadora',
  'weapon'::rpg.item_type,
  'Munição Exterminadora',
  NULL,
  NULL,
  'Esta munição mágica é projetada para eliminar criaturas de um tipo específico, escolhida pelo Mestre ou determinada aleatoriamente na tabela abaixo. Uma criatura alvo ao sofrer dano, deve realizar uma salvaguarda de Constituição CD 17; se falhar, sofre 6d10 pontos de dano Energético adicionais, ou metade desse dano em caso de sucesso.
Após causar o dano adicional a uma criatura, a munição deixa de ser mágica.
 
1d100
	Tipo de Criatura
	01–10
	Aberrações
	11–15
	Feras
	16–20
	Celestiais
	21–25
	Constructos
	26–35
	Dragões
	36–45
	Elementais
	46–50
	Humanoides
	51–60
	Feéricos
	61–70
	Ínferos
	71–75
	Gigantes
	76–80
	Monstruosidades
	81–85
	Gosmas
	86–90
	Plantas
	91–00
	Mortos-vivos',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Arma (Qualquer Munição)","rarity":"very-rare","rarityLabel":"Muito Raro","requiresAttunement":false,"header":"Arma (Qualquer Munição), Muito Raro","weaponSubtype":"Qualquer Munição"}'::jsonb
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
  'municao-impactante',
  'weapon'::rpg.item_type,
  'Munição Impactante',
  NULL,
  NULL,
  'Uma criatura atingida por esta munição deve ser bem-sucedida em uma salvaguarda de Força CD 10 ou tem a condição Caído.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Arma (Qualquer Munição)","rarity":"common","rarityLabel":"Comum","requiresAttunement":false,"header":"Arma (Qualquer Munição), Comum","weaponSubtype":"Qualquer Munição"}'::jsonb
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
  'municao-1-2-ou-3',
  'weapon'::rpg.item_type,
  'Munição, +1, +2 ou +3',
  NULL,
  NULL,
  'Você tem um bônus em jogadas de ataque e dano realizadas com esta peça de munição mágica. O bônus é determinado pela raridade da munição. Uma vez que atinge um alvo, a munição não é mais mágica.
Esta munição é normalmente encontrada ou vendida em quantidades de dez ou vinte peças. Dez peças dessa munição têm valor equivalente a uma poção da mesma raridade.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Arma (Qualquer Munição)","rarity":"uncommon","rarityLabel":"Incomum","requiresAttunement":false,"header":"Arma (Qualquer Munição), Incomum (+1), Raro (+2) ou Muito Raro (+3)","weaponSubtype":"Qualquer Munição"}'::jsonb
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
  'oleo-de-forma-eterea',
  'gear'::rpg.item_type,
  'Óleo de Forma Etérea',
  NULL,
  NULL,
  'Um frasco deste óleo pode cobrir uma criatura Média ou menor, juntamente com o equipamento que ela está usando e carregando (um frasco adicional é necessário para cada categoria de tamanho acima de Médio). A aplicação do óleo leva 10 minutos. A criatura afetada então recebe o efeito da magia Forma Etérea por 1 hora.
Bolhas deste óleo cinza turvo se formam do lado de fora de seu recipiente e evaporam rapidamente.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Poção","rarity":"rare","rarityLabel":"Raro","requiresAttunement":false,"header":"Poção, Raro"}'::jsonb
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
  'oleo-de-precisao',
  'gear'::rpg.item_type,
  'Óleo de Precisão',
  NULL,
  NULL,
  'Um frasco deste óleo pode revestir uma arma Corpo a Corpo ou até vinte peças de munição, mas apenas armas e munições não mágicas que causem dano Cortante ou Perfurante são afetadas. Aplicar o óleo leva 1 minuto, após o qual ele se impregna magicamente no item coberto, transformando a arma em uma Arma +3 ou a munição em Munição +3.
Este óleo transparente e gelatinoso brilha com pequenos fragmentos de prata ultrafinos.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Poção","rarity":"very-rare","rarityLabel":"Muito Raro","requiresAttunement":false,"header":"Poção, Muito Raro"}'::jsonb
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
  'oleo-escorregadio',
  'gear'::rpg.item_type,
  'Óleo Escorregadio',
  NULL,
  NULL,
  'Um frasco deste óleo pode cobrir uma criatura Média ou menor, juntamente com o equipamento que ela está usando e carregando (um frasco adicional é necessário para cada categoria de tamanho acima de Médio). A aplicação do óleo leva 10 minutos. A criatura afetada então recebe o efeito da magia Movimentação Livre por 8 horas.
Alternativamente, o óleo pode ser derramado no chão como uma ação Usar Magia, onde cobre um quadrado de 3 metros de lado, duplicando o efeito da magia Graxa nessa área por 8 horas.
Este unguento preto e pegajoso é espesso e denso, mas flui rapidamente ao ser derramado.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Poção","rarity":"uncommon","rarityLabel":"Incomum","requiresAttunement":false,"header":"Poção, Incomum"}'::jsonb
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
  'olho-de-megera',
  'other'::rpg.item_type,
  'Olho de Megera',
  NULL,
  NULL,
  'Um Olho de Megera tem 3 cargas. Enquanto estiver vestindo ou segurando este item, você pode gastar 1 carga para conjurar Ver o Invisível ou Visão no Escuro (aplicando apenas em si). O Olho de Megera recupera todas as cargas gastas diariamente ao amanhecer.
Compondo um Olho de Megera. Apenas uma laia de megeras pode compor este item, feito de um olho real revestido em verniz e geralmente exibido em um pingente ou outro acessório. Uma laia pode ter apenas um Olho de Megera por vez, e compor um novo exige que todos os três membros realizem um rito especial de 1 hora. Megeras não podem realizar o rito se uma delas tiver a condição Incapacitado. Qualquer outra ação durante o rito resulta em falha e término imediato.
Visão de Laia. O Olho de Megera é normalmente confiado a um lacaio de uma megera para segurança e transporte. Como uma ação Usar Magia, uma megera da laia que compôs o Olho pode ver o que ele vê, desde que ambos estejam no mesmo plano de existência. Esse efeito permanece enquanto a megera manter a Concentração. Várias megeras podem observar através do Olho de Megera simultaneamente.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"uncommon","rarityLabel":"Incomum","requiresAttunement":false,"header":"Item Maravilhoso, Incomum"}'::jsonb
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
  'olho-e-mao-de-vecna',
  'other'::rpg.item_type,
  'Olho e Mão de Vecna',
  NULL,
  NULL,
  'Vecna foi um poderoso mago que, por meio de magia e conquista, formou um terrível império. Contudo, apesar de todo o seu poder, Vecna temia a morte e tomou medidas para evitá-la, transformando-se em um lich.
Um tenente traiçoeiro chamado Kas pôs fim ao reinado de Vecna em uma terrível batalha. Tudo o que restou de Vecna foram uma mão e um olho, sinistros Artefatos que ainda buscam realizar sua vontade no mundo.
O Olho de Vecna e a Mão de Vecna são artefatos distintos que podem ser encontrados juntos ou separados. O Olho tem a aparência de um órgão ensanguentado, como se tivesse sido arrancado da órbita, enquanto a Mão é uma extremidade esquerda ressecada e encolhida.
Propriedades Aleatórias do Olho e da Mão. O Olho de Vecna e a Mão de Vecna têm as seguintes propriedades aleatórias (veja também “Artefatos” neste capítulo):
● 1 propriedade benéfica menor
● 1 propriedade benéfica maior
● 1 propriedade prejudicial menor
Sintonizando com o Olho. Para se sintonizar ao olho, você deve pressioná-lo em sua órbita ocular vazia. O olho se insere em sua cabeça e permanece lá até você morrer. Se o olho for removido, você morre.
Propriedades do Olho. Enquanto estiver sintonizando com o olho, você adquire os seguintes benefícios:
Conjuração. O olho possui 8 cargas e recupera 1d4 + 4 cargas gastas diariamente ao amanhecer. Você pode conjurar uma magia da Tabela Magias do Olho de Vecna usando o olho (CD 18 para evitar). A tabela indica quantas cargas você deve gastar para conjurar cada magia. Sempre que conjurar uma magia do olho, há uma chance de 5% de Vecna arrancar sua alma do corpo, devorá-la e assumir controle de seu corpo como uma marionete. Nesse caso, você se torna um PNJ sob o controle do Mestre.
Magias do Olho de Vecna
Magia
	Carga Usada
	Clarividência
	2
	Coroa da Loucura
	1
	Desintegrar
	4
	Dominar Monstro
	5
	Mau Olhado
	4
	Visão de Raios-X. Como uma ação Usar Magia, você pode adquirir visão de raios-X com alcance de 9 metros por 1 minuto. Objetos sólidos dentro desse raio aparecem transparentes para você e não bloqueiam a passagem de luz. A visão penetra até 30 centímetros de pedra, 2,5 centímetros de metal comum ou 90 centímetros de madeira ou terra. Substâncias mais espessas ou uma fina camada de chumbo bloqueiam a visão.
Visão Verdadeira. Você possui Visão Verdadeira a até 72 metros.
Sintonizando com a Mão. Para se sintonizar com a mão, você deve pressioná-la contra o coto onde sua mão esquerda estava. A mão se conecta ao seu braço e se torna um membro funcional. Se a mão for removida, você morre.
Propriedades da Mão. Quando você está sintonizado com a mão, seu alinhamento é Neutro e Mau, e você adquire os seguintes benefícios:
Conjuração. A mão possui 8 cargas e recupera 1d4 + 4 cargas gastas diariamente ao amanhecer. Você pode conjurar uma magia da Tabela Magias da Mão de Vecna usando a mão (CD 18 para evitar). A tabela indica quantas cargas você deve gastar para conjurar cada magia. Sempre que conjura uma magia com a mão, ela conjura Sugestão em você (CD 18; sem necessidade de Concentração), exigindo que você cometa um ato maligno. A mão pode sugerir um ato específico ou deixar a escolha por sua conta.
Magias da Mão de Vecna
Magia
	Carga Usada
	Dedo da Morte
	5
	Sono
	1
	Lentidão
	2
	Teleporte
	3
	Força Grandiosa. Sua Força se torna 20, a menos que já seja 20 ou superior.
Toque Gelado. Qualquer ataque mágico corpo a corpo que você realizar com a mão ou com uma arma segurada por ela causa 2d8 pontos de dano Gélido adicional ao acertar.
Sentido de Perigo. Você tem Vantagem em jogadas de Iniciativa.
Propriedades do Olho e da Mão. Enquanto estiver sintonizando com o olho e com a mão, você adquire os seguintes benefícios:
Desejo. Você pode conjurar Desejo. Uma vez usada, esta propriedade não pode ser usada novamente até passarem 30 dias.
Imunidade a Veneno. Você tem Imunidade a dano Venenoso e à condição Envenenado.
Redução Necrótica. Como uma ação Usar Magia, você pode escolher como alvo uma criatura à sua vista a até 1,5 metro. O alvo deve realizar uma salvaguarda de Constituição CD 18, sofrendo 7d6 pontos de dano Necrótico se falhar ou metade do dano em caso de sucesso. Uma criatura reduzida a 0 Pontos de Vida por este dano transforma-se em lodo verde que cobre o solo no espaço da criatura (veja o capítulo 3), cada quadrado de 1,5 metro representando uma porção distinta. Objetos não mágicos de metal ou materiais orgânicos que o alvo carregava ou vestia são destruídos pelo lodo.
Regeneração. Se você começar seu turno com ao menos 1 Ponto de Vida, você recupera 1d10 Pontos de Vida.
Sentido de Perigo. Você tem Vantagem em jogadas de Iniciativa.
Destruindo o Olho e a Mão. Se o Olho de Vecna e a Mão de Vecna estiverem ligados à mesma criatura e essa criatura for morta pela Espada de Kas, tanto o olho quanto a mão explodem em chamas, se transformam em cinzas e são destruídos. Qualquer outra tentativa de destruir o olho ou a mão parece funcionar, mas o Artefato reaparece em um dos muitos cofres escondidos de Vecna, onde espera para ser redescoberto.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"artifact","rarityLabel":"Artefato","requiresAttunement":true,"header":"Item Maravilhoso, Artefato (Requer Sintonização)","attunement":"Requer Sintonização"}'::jsonb
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
  'olho-ersatz',
  'other'::rpg.item_type,
  'Olho Ersatz',
  NULL,
  NULL,
  'Este olho mágico substitui um olho real que foi perdido ou removido. Enquanto o Olho Ersatz estiver encaixado na sua cavidade ocular, você pode enxergar através do pequeno orbe como se ele fosse seu olho natural. Você pode inserir ou remover o Olho Ersatz como uma ação Usar Magia, e ele não pode ser removido contra sua vontade enquanto você estiver vivo.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"common","rarityLabel":"Comum","requiresAttunement":false,"header":"Item Maravilhoso, Comum"}'::jsonb
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
  'olhos-ampliadores-da-visao',
  'other'::rpg.item_type,
  'Olhos Ampliadores da Visão',
  NULL,
  NULL,
  'Essas lentes de cristal se ajustam sobre os olhos. Ao usá-las, você pode ver muito melhor do que o habitual em um alcance de 30 centímetros, concedendo-lhe Visão no Escuro neste alcance e Vantagem em testes de Inteligência (Investigação) realizados para examinar algo dentro desse alcance.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"uncommon","rarityLabel":"Incomum","requiresAttunement":false,"header":"Item Maravilhoso, Incomum"}'::jsonb
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
  'olhos-da-aguia',
  'other'::rpg.item_type,
  'Olhos da Águia',
  NULL,
  NULL,
  'Estas lentes de cristal se ajustam sobre os olhos. Ao usá-las, você tem Vantagem em testes de Sabedoria (Percepção) que dependem da visão. Em condições de boa visibilidade, você pode distinguir detalhes até mesmo de criaturas e objetos extremamente distantes, tão pequenos quanto 60 centímetros de extensão.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"uncommon","rarityLabel":"Incomum","requiresAttunement":false,"header":"Item Maravilhoso, Incomum"}'::jsonb
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
  'olhos-de-enfeiticar',
  'other'::rpg.item_type,
  'Olhos de Enfeitiçar',
  NULL,
  NULL,
  'Essas lentes de cristal se ajustam sobre os olhos. Elas possuem 3 cargas. Enquanto as usar, você pode gastar 1 ou mais cargas para conjurar Enfeitiçar Pessoa (CD 13 para evitar). Por 1 carga, você conjura como 1º círculo da magia. Você aumenta o círculo da magia em um para cada carga adicional que gastar. As lentes recuperam todas as cargas gastas diariamente ao amanhecer.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"uncommon","rarityLabel":"Incomum","requiresAttunement":true,"header":"Item Maravilhoso, Incomum (Requer Sintonização)","attunement":"Requer Sintonização"}'::jsonb
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
  'olhos-noturnos',
  'other'::rpg.item_type,
  'Olhos Noturnos',
  NULL,
  NULL,
  'Ao usar essas lentes escuras, você tem Visão no Escuro a até 18 metros. Se você já tem Visão no Escuro, usar as lentes aumenta seu alcance em 18 metros.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"uncommon","rarityLabel":"Incomum","requiresAttunement":false,"header":"Item Maravilhoso, Incomum"}'::jsonb
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
  'onda',
  'weapon'::rpg.item_type,
  'Onda',
  NULL,
  NULL,
  'Você adquire um bônus de +3 em jogadas de ataque e dano realizadas com esta arma mágica. Ao ter um 20 no d20 em uma jogada de ataque com esta arma, o alvo sofre 21 pontos de dano Necrótico adicionais.
Ao segurar Onda, você adquire os seguintes benefícios:
Adaptação Subaquática. Uma bolha de ar se forma em torno de sua cabeça enquanto está debaixo d''água, permitindo que você respire normalmente nesse ambiente.
Pronto para o Combate. Você tem Vantagem nas jogadas de Iniciativa.
Comando Aquático. Onda tem 3 cargas e recupera 1d3 cargas gastas diariamente ao amanhecer. Enquanto a carrega, você pode gastar 1 carga para conjurar Dominar Fera (CD 20 para evitar) em uma Fera que tenha Deslocamento de Natação.
Globo de Invulnerabilidade. Ao segurar Onda, você pode conjurar a versão de 9º círculo da magia Globo de Invulnerabilidade a partir dela. Uma vez usada, esta propriedade não pode ser usada novamente até o próximo amanhecer.
Mantida na masmorra da Montanha Pluma Branca, Onda é gravada com imagens de ondas, conchas e criaturas marinhas.
Personalidade. Onda incentiva os mortais a adorar deuses do mar e costuma cantar canções marítimas. Surgem conflitos se o portador não promove os objetivos da arma no mundo.
Senciência. Onda é uma arma senciente de alinhamento Neutro, com Inteligência 14, Sabedoria 10 e Carisma 18. Ela possui audição e Visão no Escuro até 36 metros.
A arma se comunica telepaticamente com seu portador e fala Aquan.
Destruindo Onda. Onda pode ser destruída apenas na ilha de Forja do Trovão, onde foi forjada. A arma deve ser derretida por um gigante da tempestade ou alguém imbuído da força de um gigante da tempestade. Destruir Onda irrita uma divindade marinha, que envia agentes poderosos para atacar a ilha e punir os destruidores.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Arma (Tridente)","rarity":"artifact","rarityLabel":"Artefato","requiresAttunement":true,"header":"Arma (Tridente), Artefato (Requer Sintonização)","attunement":"Requer Sintonização","weaponSubtype":"Tridente"}'::jsonb
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
  'opressor',
  'weapon'::rpg.item_type,
  'Opressor',
  NULL,
  NULL,
  'Arma marcial, arma corpo a corpo
Opressor é uma arma poderosa forjada por anões e perdida na masmorra da Montanha Pluma Branca.
Você adquire um bônus de +3 em jogadas de ataque e dano realizadas com esta arma mágica.
Arremesso. Opressor tem a propriedade Arremesso com um alcance normal de 18 metros e um alcance máximo de 45 metros. Ao acertar com uma jogada de ataque à distância usando Opressor, o alvo sofre 1d8 pontos de dano Energético adicionais ou 4d8 pontos de dano Energético adicionais se o alvo for um Construto, um Elemental ou um Gigante. Imediatamente após acertar ou errar, a arma retorna à sua mão.
Consciência Sobrenatural. Enquanto você está segurando a arma, ela o alerta para a localização de qualquer porta secreta ou oculta a até 9 metros de você. Além disso, você pode conjurar Detectar o Bem e o Mal ou Localizar Objeto a partir da arma. Após conjurar qualquer magia, você não pode conjurá-la a partir da arma novamente até o próximo amanhecer.
Onda de Choque. Você pode executar uma ação Usar Magia para atingir o chão com Opressor e enviar uma onda de choque para fora do ponto de impacto. Cada criatura à sua escolha no chão a até 18 metros desse ponto deve ser bem-sucedida em uma salvaguarda de Constituição CD 20 ou tem a condição Atordoado por 1 minuto. Uma criatura repete a salvaguarda no final de cada um dos turnos dela, encerrando o efeito sobre si em caso de sucesso. Uma vez usada, esta propriedade não pode ser usada novamente até o próximo amanhecer.
Senciência. Opressor é uma arma senciente Ordeira e Neutra com Inteligência 15, Sabedoria 12 e Carisma 15. Ela possui audição e Visão no Escuro até 36 metros.
A arma se comunica telepaticamente com seu portador e fala Anão, Gigante e Goblin.
Personalidade. Opressor tem laços com o clã anão que o criou, chamado Dankil ou o clã Martelo Soberano. Ele anseia por ser devolvido a esse clã. O propósito de Opressor é proteger anões. Conflito surge se o portador não compartilhar esse objetivo.
Destruindo Opressor. Opressor pode ser dissolvido na bile ácida de um dragão negro ancião recentemente morto. Também pode ser derretido nas forjas do clã dos anões Martelo Soberano, mas apenas pelo líder legítimo desse clã.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Arma (Martelo de Guerra)","rarity":"artifact","rarityLabel":"Artefato","requiresAttunement":true,"header":"Arma (Martelo de Guerra), Artefato (Requer Sintonização com um Anão ou uma Criatura Sintonizada com um Cinturão do Povo Anão)","attunement":"Requer Sintonização com um Anão ou uma Criatura Sintonizada com um Cinturão do Povo Anão","weaponSubtype":"Martelo de Guerra"}'::jsonb
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
  'orbe-flutuante',
  'other'::rpg.item_type,
  'Orbe Flutuante',
  NULL,
  NULL,
  'Esta pequena esfera de vidro espesso pesa meio quilo. Se você estiver a até 18 metros dela, pode ordenar que ela emita luz equivalente à magia Luz ou Luz do Dia (à sua escolha). Após ser utilizada, o efeito de Luz do Dia não pode ser usado novamente até o próximo amanhecer.
Você pode dar outra ordem como uma ação Usar Magia para fazer o globo iluminado subir no ar e pairar a no máximo 1,5 metro do chão. O globo paira dessa forma até que você ou outra criatura agarre o globo. Se você se mover para mais de 18 metros do globo flutuante, ele o segue até estar a até 18 metros de você, tomando a rota mais curta para isso. Se impedido de se mover, o globo desce suavemente ao chão, torna-se inativo, e sua luz se apaga.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"uncommon","rarityLabel":"Incomum","requiresAttunement":false,"header":"Item Maravilhoso, Incomum"}'::jsonb
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
  'orbes-draconicos',
  'other'::rpg.item_type,
  'Orbes Dracônicos',
  NULL,
  NULL,
  'Um orbe é um globo de cristal gravado com cerca de 25 centímetros de diâmetro. Quando usado, cresce até cerca de 50 centímetros de diâmetro e uma névoa gira dentro dele.
Enquanto estiver sintonizado com um orbe, você pode executar uma ação Usar Magia para espiar as profundezas do orbe. Você deve então realizar uma salvaguarda de Carisma CD 15. Em caso de sucesso, você controla o orbe enquanto permanecer sintonizado com ele. Se falhar, o orbe impõe a condição Enfeitiçado a você enquanto permanecer sintonizado com ele.
Enquanto você estiver Enfeitiçado pelo orbe, não pode encerrar voluntariamente sua sintonização com ele, e o orbe conjura Sugestão em você à vontade (CD 18 para evitar), solicitando que você trabalhe para os fins malignos que ele deseja. A essência dracônica dentro do orbe pode almejar muitas coisas: a aniquilação de uma sociedade ou organização específica, a liberdade do orbe, espalhar sofrimento pelo mundo, promover a adoração de Tiamat ou qualquer outra coisa que o Mestre decida.
Propriedades Aleatórias. Um Orbe Dracônico tem as seguintes propriedades aleatórias:
● 2 propriedades benéficas menores
● 1 propriedade prejudicial menor
● 1 propriedade prejudicial maior
Magias. O orbe possui 7 cargas e recupera 1d4 + 3 cargas gastas diariamente ao amanhecer. Se você controlar o orbe, pode conjurar uma das magias da tabela a seguir a partir dele. A tabela indica quantas cargas você deve gastar para conjurar a magia.
Magia
	Carga Usada
	Curar Ferimentos (de 9º círculo)
	4
	Detectar Magia
	0
	Luz do Dia
	1
	Proteção Contra a Morte
	2
	Vidência (CD 18 para evitar)
	3
	 
Chamar Dragões. Enquanto você controla o orbe, pode executar uma ação Usar Magia para fazer com que o orbe emita um chamado telepático que se propaga em todas as direções por 60 quilômetros. Os dragões cromáticos dentro do alcance sentem-se compelidos a se dirigir até o orbe o mais rápido possível pela rota mais direta. Divindades dracônicas como Tiamat não são afetadas por esse chamado. Dragões cromáticos atraídos pelo orbe podem se tornar hostis a você por serem forçados contra sua vontade. Após usar esta propriedade, ela não pode ser utilizada novamente por 1 hora.
Destruir um Orbe. Um Orbe Dracônico tem CA 20 e é destruído se sofrer dano de uma Arma +3 ou de uma magia Desintegrar. Nada mais pode causar dano a ele.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"artifact","rarityLabel":"Artefato","requiresAttunement":true,"header":"Item Maravilhoso, Artefato (Requer Sintonização)","attunement":"Requer Sintonização"}'::jsonb
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
  'pedra-da-boa-sorte-pedra-da-sorte',
  'other'::rpg.item_type,
  'Pedra da Boa Sorte (Pedra-da-Sorte)',
  NULL,
  NULL,
  'Enquanto esta ágata polida estiver em sua posse, você recebe um bônus de +1 em testes de atributo e salvaguardas.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"uncommon","rarityLabel":"Incomum","requiresAttunement":true,"header":"Item Maravilhoso, Incomum (Requer Sintonização)","attunement":"Requer Sintonização"}'::jsonb
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
  'pedra-de-controlar-elementais-da-terra',
  'other'::rpg.item_type,
  'Pedra de Controlar Elementais da Terra',
  NULL,
  NULL,
  'Ao tocar esta pedra de 2,5 kg no chão, você pode executar uma ação Usar Magia para invocar um Elemental da Terra. O elemental aparece em um espaço desocupado à sua escolha e a até 9 metros de você, obedece aos seus comandos e age imediatamente após sua contagem de iniciativa. O elemental desaparece após 1 hora, quando morre ou quando você o dispensar como uma Ação Bônus. A pedra não pode ser usada dessa maneira novamente até o próximo amanhecer.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"rare","rarityLabel":"Raro","requiresAttunement":false,"header":"Item Maravilhoso, Raro"}'::jsonb
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
  'pedra-de-ioun',
  'other'::rpg.item_type,
  'Pedra de Ioun',
  NULL,
  NULL,
  'Do tamanho aproximado de uma bola de gude, as Pedras de Ioun recebem esse nome em homenagem a Ioun, um deus do conhecimento e da profecia venerado em alguns mundos. Existem muitos tipos de Pedras de Ioun, cada um com uma combinação distinta de forma e cor.
Ao executar uma ação Usar Magia para lançar uma Pedra de Ioun no ar, a pedra orbita sua cabeça a uma distância de 1d3 x 30 centímetros, conferindo a você um benefício. Você pode ter até três Pedras de Ioun orbitando sua cabeça ao mesmo tempo.
Cada Pedra de Ioun que orbita sua cabeça é considerada um objeto que você está utilizando. A pedra em órbita evita o contato com outras criaturas e objetos, ajustando sua trajetória para evitar colisões e frustrando todas as tentativas de outras criaturas de atacá-la ou capturá-la.
Como uma ação Usar Objeto, você pode capturar e guardar qualquer número de Pedras de Ioun orbitando sua cabeça. Se sua Sintonização com uma Pedra de Ioun encerrar enquanto estiver orbitando sua cabeça, a pedra cai como se você a tivesse largado.
O tipo de pedra determina sua raridade e efeitos.
Absorção (Muito Raro). Enquanto este elipsoide de cor lavanda pálida orbita sua cabeça, você pode executar uma Reação para anular uma magia de 4º círculo ou inferior conjurada por uma criatura à sua vista. Uma magia anulada não tem efeito e quaisquer recursos utilizados para conjurá-la são desperdiçados. Uma vez que a pedra tenha anulado 20 círculos de magia, ela queima, torna-se um cinza opaco e perde sua magia.
Absorção (Muito Raro). Enquanto este elipsoide de cor lavanda pálida orbita sua cabeça, você pode executar uma Reação para anular uma magia de 8º círculo ou inferior conjurada por uma criatura à sua vista. Uma magia anulada não tem efeito e quaisquer recursos utilizados para conjurá-la são desperdiçados. Uma vez que a pedra tenha anulado 20 círculos de magia, ela queima, torna-se um cinza opaco e perde sua magia.
Agilidade (Muito Raro). Enquanto esta esfera de um vermelho profundo orbitar sua cabeça, sua Destreza aumenta em 2, até no máximo 20.
Força (Muito Raro). Enquanto este romboide azul pálido orbita sua cabeça, sua Força aumenta em 2, até no máximo 20.
Fortitude (Muito Raro). Enquanto este romboide rosa orbita sua cabeça, sua Constituição aumenta em 2, até no máximo 20.
Intelecto (Muito Raro). Enquanto esta esfera escarlate e azul marmorizada orbita sua cabeça, sua Inteligência aumenta em 2, até no máximo 20.
Intuição (Muito Raro). Enquanto esta esfera azul incandescente orbita sua cabeça, sua Sabedoria aumenta em 2, até no máximo 20.
Liderança (Muito Raro). Enquanto esta esfera rosa e verde marmorizada orbita sua cabeça, seu Carisma aumenta em 2, até no máximo 20.
Maestria (Lendário). Enquanto este prisma verde-pálido orbita sua cabeça, seu Bônus de Proficiência aumenta em 1.
Prontidão (Raro). Enquanto este romboide azul-escuro orbita sua cabeça, você tem Vantagem em jogadas de Iniciativa e testes de Sabedoria (Percepção).
Proteção (Raro). Enquanto este prisma rosa opaco orbita sua cabeça, você recebe um bônus de +1 na Classe de Armadura.
Provisão (Raro). Este prisma roxo vibrante armazena magias conjuradas nele, mantendo-as até que você as use. A pedra pode armazenar até 4 círculos de magias de cada vez. Quando encontrada, contém 1d4 círculos de magias armazenadas escolhidas pelo Mestre.
Qualquer criatura pode conjurar uma magia de 1º a 4º círculo ao tocar a pedra no momento em que a magia é conjurada. A magia não tem efeito, exceto por ser armazenada na pedra. Se a pedra não puder conter a magia, esta é gasta sem efeito. O círculo de espaço utilizado para conjurar a magia determina quanto espaço ela ocupa.
Enquanto esta pedra orbita sua cabeça, você pode conjurar qualquer magia que esteja armazenada nela. A magia utiliza o círculo de espaço, CD para evitar magia, bônus de ataque mágico e atributo de conjuração do conjurador original, mas é considerada como se você a estivesse conjurando. A magia conjurada da pedra não está mais armazenada nela, liberando espaço.
Regeneração (Lendário). Você recupera 15 Pontos de Vida ao final de cada hora que este fuso branco perolado orbita sua cabeça se você tiver pelo menos 1 Ponto de Vida.
Sustento (Raro). Enquanto este fuso cristalino orbita sua cabeça, você não precisa comer ou beber.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"varies","rarityLabel":"Raridade Variável","requiresAttunement":true,"header":"Item Maravilhoso, Raridade Variável (Requer Sintonização)","attunement":"Requer Sintonização"}'::jsonb
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
  'pedras-mensageiras',
  'other'::rpg.item_type,
  'Pedras Mensageiras',
  NULL,
  NULL,
  'As Pedras Mensageiras vêm em pares, com cada pedra esculpida para combinar com a outra, de modo que a combinação seja facilmente reconhecida. Ao tocar uma pedra, você pode conjurar Remeter a partir dela. O alvo é o portador da outra pedra. Se nenhuma criatura estiver portando a outra pedra, você sabe desse fato assim que usar a pedra, e você não conjura a magia.
Uma vez que Remeter seja conjurada usando uma das pedras, as pedras não podem ser usadas novamente até o próximo amanhecer. Se uma das pedras em um par for destruída, a outra se torna não mágica.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"uncommon","rarityLabel":"Incomum","requiresAttunement":false,"header":"Item Maravilhoso, Incomum"}'::jsonb
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
  'perfume-de-encantamento',
  'other'::rpg.item_type,
  'Perfume de Encantamento',
  NULL,
  NULL,
  'Este minúsculo frasco contém um perfume mágico, suficiente para uma aplicação. Você pode executar uma ação Usar Magia para aplicar o perfume em si mesmo, e o efeito dura 1 hora. Durante esse tempo, você tem Vantagem em todos os testes de Carisma (Enganação e Persuasão) realizados para influenciar uma criatura a até 1,5 metro de você.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"common","rarityLabel":"Comum","requiresAttunement":false,"header":"Item Maravilhoso, Comum"}'::jsonb
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
  'pergaminho-da-invocacao-de-tita',
  'other'::rpg.item_type,
  'Pergaminho da Invocação de Titã',
  NULL,
  NULL,
  'Ao executar uma ação Usar Magia para ler este pergaminho, um titã em particular cujo nome consta no pergaminho aparece em um espaço desocupado no chão ou na água à sua vista a até 1,5 km de distância. O Mestre escolhe um titã adequado ou o determina aleatoriamente jogando na tabela abaixo (veja o Livro dos Monstros para o bloco de estatísticas da criatura).
O titã é Hostil em relação a todas as outras criaturas e desaparece ao ser reduzido a 0 Pontos de Vida. Se o titã for invocado para um espaço que não seja grande o suficiente para contê-lo, a invocação falha e o pergaminho é desperdiçado.
1d100
	Titã
	01–15
	Animal Soberano
	16–30
	Gosma da Aniquilação
	31–45
	Colosso
	46–60
	Cataclisma Elemental
	61–75
	Empiriano
	76–90
	Kraken (um kraken requer um corpo de água grande o suficiente para contê-lo, ou a invocação falha e o pergaminho é desperdiçado)
	91–00
	Tarrasque',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Pergaminho","rarity":"legendary","rarityLabel":"Lendário","requiresAttunement":false,"header":"Pergaminho, Lendário"}'::jsonb
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
  'pergaminho-de-circulo-da-protecao',
  'other'::rpg.item_type,
  'Pergaminho de Círculo da Proteção',
  NULL,
  NULL,
  'Cada Pergaminho de Círculo da Proteção funciona contra criaturas de um tipo de criatura escolhido pelo Mestre ou determinado jogando na tabela a seguir.
1d100
	Tipo de Criatura
	01–10
	Aberrações
	11–15
	Feras
	16–20
	Celestiais
	21–25
	Constructos
	26–35
	Dragões
	36–45
	Elementais
	46–50
	Humanoides
	51–60
	Feéricos
	61–70
	Ínferos
	71–75
	Gigantes
	76–80
	Monstruosidades
	81–85
	Gosmas
	86–90
	Plantas
	91–00
	Mortos-vivos
	Executar uma ação Usar Magia para ler o pergaminho cria uma Emanação de 1,5 metro originada a partir de você. Por 5 minutos, criaturas do tipo especificado não podem entrar ou afetar algo na área. No entanto, se você se mover de tal forma que uma criatura do tipo especificado esteja dentro da área, o efeito se encerra.
Como uma ação Usar Magia, uma criatura a até 1,5 metro da Emanação pode tentar superá-la, o que força a criatura a realizar uma salvaguarda de Carisma CD 15. Em caso de sucesso, a criatura deixa de ser afetada pela Emanação.
Pergaminho de Círculo da Proteção, Cimitarra da Velocidade, Pedras Mensageiras
Pergaminho Mágico
Um Pergaminho Mágico contém as palavras de uma única magia, escrita em uma cifra mística. Se a magia estiver na sua lista de magias, você pode ler o pergaminho e conjurá-la sem a necessidade de componentes Materiais. Caso contrário, o pergaminho é indecifrável. Conjurar a magia lendo o pergaminho requer o tempo de conjuração normal da magia. Após ser conjurada, o pergaminho se desfaz em pó. O pergaminho não é perdido se a conjuração for interrompida.
Se a magia estiver na sua lista de magias, mas de um círculo superior ao que pode conjurar normalmente, você deve realizar um teste de atributo usando seu atributo de conjuração para determinar se a magia é conjurada. A CD é igual a 10 mais o círculo da magia. Se falhar, a magia desaparece do pergaminho sem produzir efeito algum.
O círculo da magia vinculada ao pergaminho determina a CD da salvaguarda para evitar a magia, o bônus de ataque, bem como a raridade do pergaminho, conforme mostrado na tabela a seguir.
Círculo de Magia
	Raridade
	CD da Salvaguarda
	Bônus de Ataque
	Truque
	Comum
	13
	+5
	1º
	Comum
	13
	+5
	2º
	Incomum
	13
	+5
	3º
	Incomum
	15
	+7
	4º
	Muito Raro
	15
	+7
	5º
	Muito Raro
	 17
	+9
	6º
	Muito Raro
	 17
	+9
	7º
	Muito Raro
	18
	+10
	8º
	Muito Raro
	18
	+10
	9º
	Lendário
	19
	+11
	 
Copiar um Pergaminho para um Livro de Magias. Uma magia de Mago em um Pergaminho Mágico pode ser copiada para um livro de magias. Ao fazer isso, deve ser bem-sucedido em um teste de Inteligência (Arcanismo) com CD igual a 10 mais o círculo da magia. Em caso de sucesso, a magia é copiada. Independentemente do resultado do teste, o Pergaminho Mágico é destruído.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Pergaminho","rarity":"rare","rarityLabel":"Raro","requiresAttunement":false,"header":"Pergaminho, Raro"}'::jsonb
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
  'periapto-de-cicatrizacao',
  'other'::rpg.item_type,
  'Periapto de Cicatrização',
  NULL,
  NULL,
  'Ao usar este pingente, você adquire os seguintes benefícios.
Aumento de Cura Natural. Sempre que você jogar um Dado de Ponto de Vida para recuperar Pontos de Vida, dobre o número de Pontos de Vida que ele restaura.
Preservação da Vida. Sempre que realizar uma Salvaguarda Contra Morte, você pode alterar uma jogada de 9 ou menos para 10, transformando uma falha em um sucesso.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"uncommon","rarityLabel":"Incomum","requiresAttunement":true,"header":"Item Maravilhoso, Incomum (Requer Sintonização)","attunement":"Requer Sintonização"}'::jsonb
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
  'periapto-de-protecao-contra-veneno',
  'other'::rpg.item_type,
  'Periapto de Proteção Contra Veneno',
  NULL,
  NULL,
  'Esta delicada corrente de prata possui um pingente de gema preta com corte brilhante. Ao usá-la, você recebe Imunidade à condição Envenenado e ao dano Venenoso.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"rare","rarityLabel":"Raro","requiresAttunement":true,"header":"Item Maravilhoso, Raro (Requer Sintonização)","attunement":"Requer Sintonização"}'::jsonb
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
  'periapto-de-saude',
  'other'::rpg.item_type,
  'Periapto de Saúde',
  NULL,
  NULL,
  'Ao usar este pingente, você pode executar uma ação Usar Magia para recuperar 2d4 + 2 Pontos de Vida. Uma vez usada, esta propriedade não pode ser utilizada novamente até o próximo amanhecer.
Além disso, você tem Vantagem nas salvaguardas para evitar ou encerrar a condição Envenenado enquanto usa este pingente.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"uncommon","rarityLabel":"Incomum","requiresAttunement":true,"header":"Item Maravilhoso, Incomum (Requer Sintonização)","attunement":"Requer Sintonização"}'::jsonb
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
  'perola-de-poder',
  'other'::rpg.item_type,
  'Pérola de Poder',
  NULL,
  NULL,
  'Enquanto esta pérola estiver em sua posse, você pode executar uma ação Usar Magia para recuperar um espaço de magia gasto de 3º círculo ou inferior. Após usar a pérola, ela não pode ser usada novamente até o próximo amanhecer.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"uncommon","rarityLabel":"Incomum","requiresAttunement":true,"header":"Item Maravilhoso, Incomum (Requer Sintonização por um Conjurador)","attunement":"Requer Sintonização por um Conjurador"}'::jsonb
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
  'pigmentos-maravilhosos-de-nolzur',
  'other'::rpg.item_type,
  'Pigmentos Maravilhosos de Nolzur',
  NULL,
  NULL,
  'Esta bela caixa de madeira contém 1d4 potes de pigmento e uma escova (pesando 0,5 quilo no total).
Usando o pincel e consumindo 1 pote de pigmento, você pode pintar qualquer quantidade de objetos tridimensionais e características do terreno (como paredes, portas, árvores, flores, armas, teias e fossos), desde que esses elementos estejam todos confinados a um Cubo de 6 metros de lado. O processo leva 10 minutos (independentemente do número de elementos que você faz), durante os quais você deve permanecer no Cubo, e requer Concentração. Se sua Concentração for interrompida ou se você deixar o Cubo antes que o trabalho seja concluído, todos os elementos pintados desaparecem e o pote de pigmento é desperdiçado.
Ao concluir o trabalho, todos os objetos pintados e características do terreno se tornam reais. Assim, pintar uma porta em uma parede cria uma porta real, que pode ser aberta para o que estiver além. Pintar um fosso cria um fosso real, cuja profundidade total deve estar dentro do Cubo de 6 metros de lado.
Nenhum objeto feito por um pote de pigmento pode ter um valor superior a 25 PO, e o valor total de todos os objetos criados por um pote de pigmento não pode exceder 500 PO. Se você pintar objetos de maior valor (como uma grande pilha de ouro), eles parecem autênticos, mas uma inspeção minuciosa revela serem feitos de massa, pasta ou algum outro material sem valor.
Se você pintar uma forma de energia como fogo ou relâmpago, a energia se dissipa assim que você completa a pintura, causando nenhum dano.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"very-rare","rarityLabel":"Muito Raro","requiresAttunement":false,"header":"Item Maravilhoso, Muito Raro"}'::jsonb
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
  'po-da-seca',
  'other'::rpg.item_type,
  'Pó da Seca',
  NULL,
  NULL,
  'Este pequeno pacote contém 1d6 + 4 pitadas de poeira. Como uma ação Usar Objeto, você pode salpicar uma pitada da poeira sobre a água, transformando um Cubo de 4,5 metros de água em uma esfera do tamanho de uma bola de gude, que flutua ou repousa próxima ao local onde a poeira foi jogada. O peso da esfera é insignificante. Uma criatura pode executar uma ação Usar Objeto para esmagar a esfera contra uma superfície dura, fazendo com que ela se rompa e libere a água absorvida pela poeira. Fazer isso destrói a esfera e a magia se encerra.
Como uma ação Usar Objeto, você pode salpicar uma pitada da poeira em um Elemental a até 1,5 metro de você que seja composto principalmente de água (como um Aquanômalo ou um Elemental da Água). Essa criatura exposta à poeira deve realizar uma salvaguarda de Constituição CD 13, sofrendo 10d6 pontos de dano Necrótico se falhar ou metade desse dano em caso de sucesso.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"uncommon","rarityLabel":"Incomum","requiresAttunement":false,"header":"Item Maravilhoso, Incomum"}'::jsonb
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
  'po-de-desaparecimento',
  'other'::rpg.item_type,
  'Pó de Desaparecimento',
  NULL,
  NULL,
  'Este pó se assemelha a areia fina. Há o suficiente para um único uso. Quando você executa uma ação Usar Objeto para lançar o pó no ar, você e cada criatura e objeto em uma Emanação de 3 metros centrada em você fica com a condição Invisível por 2d4 minutos. A duração é a mesma para todos os alvos, e o pó é consumido quando sua magia surte efeito. Imediatamente após uma criatura afetada realizar uma jogada de ataque, causar dano ou conjurar uma magia, a condição Invisível encerra para essa criatura.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"uncommon","rarityLabel":"Incomum","requiresAttunement":false,"header":"Item Maravilhoso, Incomum"}'::jsonb
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
  'po-de-espirro-engasgo',
  'other'::rpg.item_type,
  'Pó de Espirro-engasgo',
  NULL,
  NULL,
  'Este pó, encontrado em um pequeno recipiente, se assemelha ao Pó de Desaparecimento e é revelado como tal por uma magia Identificar. Há quantidade suficiente para um único uso.
Como uma ação Usar Objeto, você pode arremessar o pó no ar, forçando você e todas as criaturas em uma Emanação de 9 metros originados em você a realizar uma salvaguarda de Constituição CD 15. Constructos, Elementais, Gosmas, Plantas e Mortos-Vivos têm sucesso automaticamente.
Se falharem, as criaturas começam a espirrar incontrolavelmente e têm a condição Incapacitado e estão sufocando. As criaturas repetem a salvaguarda ao final dos próprios turnos, encerrando o efeito em caso de sucesso. O efeito também encerra em qualquer criatura afetada por uma magia Restauração Menor.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"uncommon","rarityLabel":"Incomum","requiresAttunement":false,"header":"Item Maravilhoso, Incomum"}'::jsonb
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
  'pocao-bafo-de-fogo',
  'gear'::rpg.item_type,
  'Poção Bafo de Fogo',
  NULL,
  NULL,
  'Após beber esta poção, você pode executar uma Ação Bônus para exalar fogo em um alvo a até 9 metros de distância. O alvo deve realizar uma salvaguarda de Destreza CD 13 ou sofre 4d6 pontos de dano Ígneo se falhar e metade desse dano em caso de sucesso. O efeito termina depois que você exala o fogo três vezes ou quando 1 hora tenha se passado.
O líquido laranja desta poção pisca e fumaça preenche a parte superior do recipiente e se espalha sempre que é aberta.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Poção","rarity":"uncommon","rarityLabel":"Incomum","requiresAttunement":false,"header":"Poção, Incomum"}'::jsonb
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
  'pocao-da-saude',
  'gear'::rpg.item_type,
  'Poção da Saúde',
  NULL,
  NULL,
  'O líquido claro e vermelho contém pequenas bolhas de luz.
Quando você bebe esta poção, todos os contágios mágicos em você são curados. Além disso, as seguintes condições encerram em você: Cego, Envenenado, Paralisado e Surdo.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Poção","rarity":"rare","rarityLabel":"Raro","requiresAttunement":false,"header":"Poção, Raro"}'::jsonb
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
  'pocao-das-formas-gasosas',
  'gear'::rpg.item_type,
  'Poção das Formas Gasosas',
  NULL,
  NULL,
  'Ao beber esta poção, você adquire o efeito da magia Forma Gasosa por 1 hora (sem necessidade de Concentração) ou até encerrar o efeito como uma Ação Bônus.
O recipiente desta poção parece conter névoa que se move e derrama como água.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Poção","rarity":"rare","rarityLabel":"Raro","requiresAttunement":false,"header":"Poção, Raro"}'::jsonb
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
  'pocao-de-amizade-animal',
  'gear'::rpg.item_type,
  'Poção de Amizade Animal',
  NULL,
  NULL,
  'Ao beber esta poção, você pode conjurar a magia Amizade Animal como 3º círculo (CD 13 para evitar).
Agitar o líquido turvo desta poção revela pequenos fragmentos: uma escama de peixe, uma pena de beija-flor, uma garra de gato ou um pelo de esquilo.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Poção","rarity":"uncommon","rarityLabel":"Incomum","requiresAttunement":false,"header":"Poção, Incomum"}'::jsonb
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
  'pocao-de-clarividencia',
  'gear'::rpg.item_type,
  'Poção de Clarividência',
  NULL,
  NULL,
  'Ao beber esta poção, você recebe o efeito da magia Clarividência (sem necessidade de Concentração).
Um globo ocular flutua no líquido amarelado desta poção, mas desaparece quando a poção é aberta.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Poção","rarity":"rare","rarityLabel":"Raro","requiresAttunement":false,"header":"Poção, Raro"}'::jsonb
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
  'pocao-de-compreensao',
  'gear'::rpg.item_type,
  'Poção de Compreensão',
  NULL,
  NULL,
  'Ao beber esta poção, você recebe o efeito da magia Compreender Idiomas por 1 hora.
O líquido desta poção é uma mistura translúcida com fragmentos de sal e fuligem que giram nela.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Poção","rarity":"common","rarityLabel":"Comum","requiresAttunement":false,"header":"Poção, Comum"}'::jsonb
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
  'pocao-de-cura',
  'gear'::rpg.item_type,
  'Poção de Cura',
  NULL,
  NULL,
  'Você recupera 2d4 + 2 Pontos de Vida ao beber esta poção.
Qualquer que seja sua potência, o líquido vermelho da poção brilha quando agitada.
Poção
	PV Recuperado
	Raridade
	Poção de Cura
	2d4 + 2
	Comum
	Poção de Cura (maior)
	4d4 + 4
	Incomum
	Poção de Cura (superior)
	8d4 + 8
	Raro
	Poção de Cura (suprema)
	10d4 + 20
	Muito Raro',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Poção","rarity":"common","rarityLabel":"Comum","requiresAttunement":false,"header":"Poção, Comum"}'::jsonb
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
  'pocao-de-escalada',
  'gear'::rpg.item_type,
  'Poção de Escalada',
  NULL,
  NULL,
  'Ao beber esta poção, você adquire um Deslocamento de Escalada igual ao seu Deslocamento por 1 hora. Durante esse período, você tem Vantagem em testes de Força (Atletismo) para escalar.
Esta poção é composta por camadas marrons, prateadas e cinzentas que se assemelham a faixas de pedra. Agitar a garrafa não consegue misturar as cores.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Poção","rarity":"common","rarityLabel":"Comum","requiresAttunement":false,"header":"Poção, Comum"}'::jsonb
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
  'pocao-de-forca-de-gigante',
  'gear'::rpg.item_type,
  'Poção de Força de Gigante',
  NULL,
  NULL,
  'Ao beber esta poção, seu valor de Força muda por 1 hora. O tipo de gigante determina o valor (veja a tabela abaixo). A poção não afeta você se sua Força for igual ou maior do que esse valor.
O líquido transparente desta poção contém um fragmento de luz flutuante que se assemelha à unha de um gigante.
Poção
	For.
	Raridade
	Poção de Força de Gigante (da colina)
	21
	Incomum
	Poção de Força de Gigante (de pedra/gelo)
	23
	Raro
	Poção de Força de Gigante (de fogo)
	25
	Raro
	Poção de Força de Gigante (das nuvens)
	27
	Muito Raro
	Poção de Força de Gigante (da tempestade)
	29
	Lendário',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Poção","rarity":"varies","rarityLabel":"Raridade Variável","requiresAttunement":false,"header":"Poção, Raridade Variável"}'::jsonb
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
  'pocao-de-heroismo',
  'gear'::rpg.item_type,
  'Poção de Heroísmo',
  NULL,
  NULL,
  'Ao beber esta poção, você adquire 10 Pontos de Vida Temporários que duram 1 hora. Pela mesma duração, você está sob o efeito da magia Bênção (sem necessidade de Concentração).
O líquido azul desta poção borbulha e solta vapor, como se estivesse fervendo.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Poção","rarity":"rare","rarityLabel":"Raro","requiresAttunement":false,"header":"Poção, Raro"}'::jsonb
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
  'pocao-de-invisibilidade',
  'gear'::rpg.item_type,
  'Poção de Invisibilidade',
  NULL,
  NULL,
  'O recipiente desta poção parece vazio, mas aparenta conter líquido. Ao beber a poção, você tem a condição Invisível por 1 hora. O efeito termina se você realizar uma jogada de ataque, causar dano ou conjurar uma magia.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Poção","rarity":"rare","rarityLabel":"Raro","requiresAttunement":false,"header":"Poção, Raro"}'::jsonb
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
  'pocao-de-invisibilidade-maior',
  'gear'::rpg.item_type,
  'Poção de Invisibilidade Maior',
  NULL,
  NULL,
  'O recipiente desta poção parece vazio, mas aparenta conter líquido. Ao beber a poção, você tem a condição Invisível por 1 hora.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Poção","rarity":"very-rare","rarityLabel":"Muito Raro","requiresAttunement":false,"header":"Poção, Muito Raro"}'::jsonb
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
  'pocao-de-invulnerabilidade',
  'gear'::rpg.item_type,
  'Poção de Invulnerabilidade',
  NULL,
  NULL,
  'Por 1 minuto após beber esta poção, você tem Resistência a todos os tipos de dano.
O líquido xaroposo desta poção parece ferro liquefeito.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Poção","rarity":"rare","rarityLabel":"Raro","requiresAttunement":false,"header":"Poção, Raro"}'::jsonb
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
  'pocao-de-ler-mentes',
  'gear'::rpg.item_type,
  'Poção de Ler Mentes',
  NULL,
  NULL,
  'Ao beber esta poção, você recebe o efeito da magia Detectar Pensamentos (sem necessidade de Concentração).
O líquido denso e roxo desta poção contém uma nuvem rosa de formato oval flutuando em seu interior.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Poção","rarity":"rare","rarityLabel":"Raro","requiresAttunement":false,"header":"Poção, Raro"}'::jsonb
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
  'pocao-de-longevidade',
  'gear'::rpg.item_type,
  'Poção de Longevidade',
  NULL,
  NULL,
  'Ao beber esta poção, sua idade física é reduzida em 1d6 + 6 anos, para um mínimo de 13 anos. Cada vez que você subsequentemente bebe uma Poção de Longevidade, há 10% de chance cumulativa de que você, em vez de rejuvenescer, envelheça 1d6 + 6 anos.
Suspenso neste líquido âmbar está um pequeno coração que, contra toda lógica, ainda está batendo. Esse ingrediente desaparece ao abrir a poção.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Poção","rarity":"very-rare","rarityLabel":"Muito Raro","requiresAttunement":false,"header":"Poção, Muito Raro"}'::jsonb
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
  'pocao-de-pugilismo',
  'gear'::rpg.item_type,
  'Poção de Pugilismo',
  NULL,
  NULL,
  'Após beber esta poção, cada Ataque Desarmado que você realizar causa 1d6 pontos de dano Energético adicionais em caso de acerto. Este efeito dura 10 minutos.
Esta poção é um líquido verde espesso que tem gosto de espinafre.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Poção","rarity":"uncommon","rarityLabel":"Incomum","requiresAttunement":false,"header":"Poção, Incomum"}'::jsonb
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
  'pocao-de-resistencia',
  'gear'::rpg.item_type,
  'Poção de Resistência',
  NULL,
  NULL,
  'Ao beber esta poção, você tem Resistência a um tipo de dano por 1 hora. O Mestre escolhe o tipo ou o determina aleatoriamente jogando na tabela a seguir.
1d10
	Tipo de Dano
	1
	Ácido
	2
	Gélido
	3
	Ígneo
	4
	Energético
	5
	Elétrico
	6
	Necrótico
	7
	Venenoso
	8
	Psíquico
	9
	Radiante
	10
	Trovejante',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Poção","rarity":"uncommon","rarityLabel":"Incomum","requiresAttunement":false,"header":"Poção, Incomum"}'::jsonb
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
  'pocao-de-respirar-na-agua',
  'gear'::rpg.item_type,
  'Poção de Respirar na Água',
  NULL,
  NULL,
  'Você pode respirar debaixo d’água por 24 horas após beber esta poção.
O fluido verde turvo desta poção tem cheiro de maresia e possui uma bolha no formato de água-viva flutuando em seu meio.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Poção","rarity":"uncommon","rarityLabel":"Incomum","requiresAttunement":false,"header":"Poção, Incomum"}'::jsonb
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
  'pocao-de-velocidade',
  'gear'::rpg.item_type,
  'Poção de Velocidade',
  NULL,
  NULL,
  'Ao beber esta poção, você adquire o efeito da magia Celeridade por 1 minuto (sem necessidade de Concentração) e sem sofrer a onda de letargia que normalmente ocorre quando o efeito termina.
O fluido amarelo desta poção é manchado de preto e gira por conta própria.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Poção","rarity":"very-rare","rarityLabel":"Muito Raro","requiresAttunement":false,"header":"Poção, Muito Raro"}'::jsonb
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
  'pocao-de-vitalidade',
  'gear'::rpg.item_type,
  'Poção de Vitalidade',
  NULL,
  NULL,
  'Ao beber esta poção, ela remove quaisquer níveis de Exaustão que você tenha e encerra a condição Envenenado em você. Pelas próximas 24 horas, você recupera o número máximo de Pontos de Vida para qualquer Dado de Ponto de Vida que gastar.
O líquido carmesim desta poção pulsa regularmente com uma luz opaca, lembrando o ritmo do batimento cardíaco.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Poção","rarity":"very-rare","rarityLabel":"Muito Raro","requiresAttunement":false,"header":"Poção, Muito Raro"}'::jsonb
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
  'pocao-de-voo',
  'gear'::rpg.item_type,
  'Poção de Voo',
  NULL,
  NULL,
  'Ao beber esta poção, você adquire um Deslocamento de Voo igual ao seu Deslocamento por 1 hora e pode pairar. Se você estiver no ar quando a poção terminar o efeito, você cai, a menos que tenha algum outro meio de permanecer no ar.
O líquido transparente desta poção flutua no topo de seu recipiente e tem impurezas brancas turvas flutuando.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Poção","rarity":"very-rare","rarityLabel":"Muito Raro","requiresAttunement":false,"header":"Poção, Muito Raro"}'::jsonb
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
  'pocao-do-amor',
  'gear'::rpg.item_type,
  'Poção do Amor',
  NULL,
  NULL,
  'Da próxima vez que avistar uma criatura nos 10 minutos seguintes após beber esta poção, você fica enfeitiçado por ela e tem a condição Enfeitiçado por 1 hora.
Este líquido efervescente em tons de rosa possui bolhas quase imperceptíveis em forma de coração.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Poção","rarity":"uncommon","rarityLabel":"Incomum","requiresAttunement":false,"header":"Poção, Incomum"}'::jsonb
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
  'pocao-do-crescimento',
  'gear'::rpg.item_type,
  'Poção do Crescimento',
  NULL,
  NULL,
  'Ao beber esta poção, você recebe o efeito “aumentar” da magia Aumentar/Reduzir por 10 minutos (sem necessidade de Concentração).
O vermelho no líquido da poção se expande continuamente a partir de uma pequena gota para colorir o líquido claro ao seu redor e depois se contrai. Agitar a garrafa não interrompe esse processo.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Poção","rarity":"uncommon","rarityLabel":"Incomum","requiresAttunement":false,"header":"Poção, Incomum"}'::jsonb
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
  'pocao-do-encolhimento',
  'gear'::rpg.item_type,
  'Poção do Encolhimento',
  NULL,
  NULL,
  'Ao beber esta poção, você recebe o efeito “reduzir” da magia Aumentar/Reduzir por 1d4 horas (sem necessidade de Concentração).
O vermelho no líquido da poção se contrai continuamente em uma pequena gota e depois se expande para colorir o líquido claro ao seu redor. Agitar a garrafa não interrompe esse processo.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Poção","rarity":"rare","rarityLabel":"Raro","requiresAttunement":false,"header":"Poção, Raro"}'::jsonb
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
  'pocao-falsa',
  'gear'::rpg.item_type,
  'Poção Falsa',
  NULL,
  NULL,
  'Esta mistura parece, cheira e tem o gosto de uma Poção de Cura ou outra poção benéfica. No entanto, na verdade, é veneno mascarado por magia de ilusão. A magia Identificar revela sua verdadeira natureza.
Se você beber esta poção, sofre 4d6 pontos de dano Venenoso e deve ser bem-sucedido em uma salvaguarda de Constituição CD 13 ou tem a condição Envenenado por 1 hora.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Poção","rarity":"uncommon","rarityLabel":"Incomum","requiresAttunement":false,"header":"Poção, Incomum"}'::jsonb
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
  'poco-dos-mundos',
  'other'::rpg.item_type,
  'Poço dos Mundos',
  NULL,
  NULL,
  'Este fino tecido preto, macio como seda, é dobrado até as dimensões de um lenço. Ele se desdobra em uma folha circular de 1,8 metro de diâmetro.
Você pode executar uma ação Usar Magia para desdobrar o Poço dos Mundos e colocá-lo em uma superfície sólida, quando ele forma um portal circular bidirecional de 1,8 metro de diâmetro para outro mundo ou plano de existência. Cada vez que o item abre um portal, o Mestre decide para onde ele leva. O portal permanece aberto até que uma criatura a até 1,5 metro dele execute uma ação Usar Magia para fechá-lo, segurando as bordas do tecido e dobrando-o.
Uma vez que o Poço dos Mundos abre um portal, ele não pode fazer isso novamente por 1d8 horas.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"legendary","rarityLabel":"Lendário","requiresAttunement":false,"header":"Item Maravilhoso, Lendário"}'::jsonb
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
  'pote-de-ferro',
  'other'::rpg.item_type,
  'Pote de Ferro',
  NULL,
  NULL,
  'Enquanto segura este pote de ferro com rolha de latão, você pode executar uma ação Usar Magia para selecionar a criatura à sua vista a até 18 metros de distância como alvo. Se o pote estiver vazio e o alvo for nativo de um plano de existência diferente daquele em que você se encontra, o alvo deve ser bem-sucedido em uma salvaguarda de Sabedoria CD 17 ou fica preso no pote. Se o alvo já tiver sido aprisionado pelo pote anteriormente, ele tem Vantagem na salvaguarda. Uma vez aprisionada, uma criatura permanece no pote até ser liberada. O pote pode conter somente uma criatura por vez. Uma criatura presa no pote não envelhece e não precisa respirar, comer ou beber.
Você pode executar uma ação Usar Magia para remover a rolha do pote e libertar a criatura contida nele. A criatura então obedece aos seus comandos por 1 hora, compreendendo essas instruções, mesmo que não conheça o idioma em que são dadas. Caso não emita comandos ou dê à criatura uma ordem que provavelmente resulte na morte ou captura dela, ela se defende, mas, de outra forma, não executa nenhuma ação. Ao final da duração, a criatura age de acordo com sua disposição e alinhamento normais.
Uma magia Identificar revela se o pote contém uma criatura, mas a única maneira de determinar o tipo de criatura é abrir o pote. Um Pote de Ferro recém-descoberto pode já conter uma criatura escolhida pelo Mestre ou determinada aleatoriamente jogando na tabela a seguir (veja o Livro dos Monstros para o bloco de estatísticas da criatura).
Tabela de Jogada de Possíveis Criaturas
1d100
	Conteúdo
	01–50
	Nenhuma criatura
	51
	Arcanaloth
	52–54
	Diabo dos Ossos
	55–56
	Cambião
	57–58
	Dao
	59
	Deva
	60–61
	Djinni
	62–63
	Ifriti
	64–65
	Erínia
	66–67
	Fomoriano
	68
	Githyanki Cavaleiro
	69
	Githzerai Zerth
	70–71
	Glabrezu
	72–74
	Hezrou
	75
	Íncubo
	76–77
	Espreitador Invisível
	78–79
	Marid
	80
	Marilith
	81–82
	Mezzoloth
	83–84
	Nalfeshnee
	85–86
	Megera da Noite
	87–88
	Nycaloth
	89
	Planetar
	90–91
	Slaad Vermelho
	92–93
	Salamandra
	94
	Solar
	95
	Súcubo
	96
	Ultroloth
	97–99
	Vrock
	00
	Xorn',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"legendary","rarityLabel":"Lendário","requiresAttunement":false,"header":"Item Maravilhoso, Lendário"}'::jsonb
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
  'pote-do-despertar',
  'other'::rpg.item_type,
  'Pote do Despertar',
  NULL,
  NULL,
  'Se você plantar um arbusto comum neste vaso de barro de 5 quilos e deixá-lo crescer por 30 dias, o arbusto magicamente se transforma em um Arbusto Desperto no final desse período. Quando o arbusto desperta, suas raízes quebram o vaso, destruindo-o.
O arbusto desperto é Amigável a você e obedece aos seus comandos. Se você não emitir comandos, o arbusto não realiza nada.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"common","rarityLabel":"Comum","requiresAttunement":false,"header":"Item Maravilhoso, Comum"}'::jsonb
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
  'roupas-autoconcertantes',
  'other'::rpg.item_type,
  'Roupas Autoconcertantes',
  NULL,
  NULL,
  'Esta roupa elegante remenda-se magicamente para seus próprios desgastes diários. Peças da roupa totalmente destruídas não podem ser reparadas deste modo.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"common","rarityLabel":"Comum","requiresAttunement":false,"header":"Item Maravilhoso, Comum"}'::jsonb
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
  'rubi-do-mago-de-batalha',
  'other'::rpg.item_type,
  'Rubi do Mago de Batalha',
  NULL,
  NULL,
  'Gravado com runas místicas, este rubi de 2,5 centímetros de diâmetro permite que você use uma arma Simples ou Marcial como um Foco de Conjuração para suas magias. Para que esta propriedade funcione, você deve prender o rubi à arma pressionando-o contra ela por pelo menos 10 minutos. Depois disso, o rubi não pode ser removido, a menos que você o remova como uma ação Usar Magia, a arma seja destruída ou sua Sintonização com o rubi termine.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"common","rarityLabel":"Comum","requiresAttunement":true,"header":"Item Maravilhoso, Comum (Requer Sintonização por um Conjurador)","attunement":"Requer Sintonização por um Conjurador"}'::jsonb
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
  'sacro-vingadora',
  'weapon'::rpg.item_type,
  'Sacro Vingadora',
  NULL,
  NULL,
  'Você adquire um bônus de +3 em jogadas de ataque e dano realizadas com esta arma mágica. Ao atingir um Ínfero ou um Morto-Vivo com a arma, essa criatura sofre 2d10 pontos de dano Radiante adicionais.
Ela cria uma Emanação de 3 metros originada em você enquanto empunhada. Você e todas as criaturas Amigáveis a você na Emanação têm Vantagem em salvaguardas contra magias e outros efeitos mágicos. Se você tiver 17 ou mais níveis na classe Paladino, o tamanho da Emanação aumenta para 9 metros.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Arma (Qualquer Simples ou Marcial)","rarity":"legendary","rarityLabel":"Lendário","requiresAttunement":true,"header":"Arma (Qualquer Simples ou Marcial), Lendário (Requer Sintonização por um Paladino)","attunement":"Requer Sintonização por um Paladino","weaponSubtype":"Qualquer Simples ou Marcial"}'::jsonb
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
  'sandalias-de-escalada-de-aranha',
  'other'::rpg.item_type,
  'Sandálias de Escalada de Aranha',
  NULL,
  NULL,
  'Enquanto calçar estas sandálias, você pode se mover por superfícies verticais e ao longo de tetos, mantendo as mãos livres. Você tem um Deslocamento de Escalada igual ao seu Deslocamento. No entanto, as sandálias não permitem que você se mova desse modo em superfícies escorregadias, como aquelas cobertas por gelo ou óleo.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"uncommon","rarityLabel":"Incomum","requiresAttunement":true,"header":"Item Maravilhoso, Incomum (Requer Sintonização)","attunement":"Requer Sintonização"}'::jsonb
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
  'sela-do-cavaleiro',
  'other'::rpg.item_type,
  'Sela do Cavaleiro',
  NULL,
  NULL,
  'Esta sela confere os seguintes benefícios enquanto você estiver sentado nela e montado em uma montaria.
Cavaleiro Seguro. Você não pode ser desmontado contra sua vontade. Esta propriedade é suprimida se você tem a condição Incapacitado.
Montaria Protegida. Jogadas de ataque contra a montaria têm Desvantagem.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"uncommon","rarityLabel":"Incomum","requiresAttunement":false,"header":"Item Maravilhoso, Incomum"}'::jsonb
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
  'solvente-universal',
  'other'::rpg.item_type,
  'Solvente Universal',
  NULL,
  NULL,
  'Este tubo contém um líquido leitoso com um forte cheiro de álcool. Quando encontrado, um tubo contém 1d6 + 30 gramas.
Você pode executar uma ação Usar Objeto para despejar 30 gramas ou mais de solvente do tubo em uma superfície ao seu alcance. Cada 30 gramas de solvente dissolve instantaneamente até um quadrado de 30 centímetros de lados de adesivo que tocar, incluindo Cola Suprema.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"legendary","rarityLabel":"Lendário","requiresAttunement":false,"header":"Item Maravilhoso, Lendário"}'::jsonb
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
  'sorvedora-das-nove-almas',
  'weapon'::rpg.item_type,
  'Sorvedora das Nove Almas',
  NULL,
  NULL,
  'Você adquire um bônus de +2 em jogadas de ataque e dano realizadas com esta arma mágica.
Roubar Vida. A arma possui 1d8 + 1 cargas. Ao atacar uma criatura com menos de 100 Pontos de Vida usando esta arma e obtendo 20 no d20 para a jogada de ataque, a criatura deve ser bem-sucedida em uma salvaguarda de Constituição CD 15 ou é morta instantaneamente enquanto a espada drena sua força vital. Constructos e Mortos-Vivos são bem-sucedidos automaticamente. A arma perde 1 carga se a criatura for morta. Quando a arma não tiver cargas restantes, ela perde esta propriedade.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Arma (Qualquer Simples ou Marcial)","rarity":"very-rare","rarityLabel":"Muito Raro","requiresAttunement":true,"header":"Arma (Qualquer Simples ou Marcial), Muito Raro (Requer Sintonização)","attunement":"Requer Sintonização","weaponSubtype":"Qualquer Simples ou Marcial"}'::jsonb
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
  'tabuleiro-espiritual',
  'other'::rpg.item_type,
  'Tabuleiro Espiritual',
  NULL,
  NULL,
  'Essa placa de madeira ornamentada tem, de um lado, as letras do alfabeto comum, ao lado das palavras “Sim” e “Não” e símbolos que representam “Fortuna” e “Infortúnio”. Acompanha uma prancheta de madeira em forma de coração. Esta prancheta deve estar apoiada no lado com letras do tabuleiro para que a magia do tabuleiro funcione.
Este tabuleiro possui 3 cargas e recupera 1 carga gasta diariamente ao amanhecer. Ao tocar a prancheta, você pode levar 1 minuto para conjurar uma das magias na tabela abaixo, que indica quantas cargas você deve gastar para conjurar a magia. Ao conjurar a magia, você invoca os espíritos dos mortos para guiar a prancheta pela superfície do tabuleiro, respondendo às suas perguntas apontando para as letras ou palavras no tabuleiro.
Magia
	Carga Usada
	Augúrio
	1
	Comunhão
	3',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"very-rare","rarityLabel":"Muito Raro","requiresAttunement":false,"header":"Item Maravilhoso, Muito Raro"}'::jsonb
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
  'tacape-trovejante',
  'weapon'::rpg.item_type,
  'Tacape Trovejante',
  NULL,
  NULL,
  'Enquanto estiver sintonizado com esta arma mágica, seu valor de Força é 20, a menos que já seja maior ou igual. A arma causa 1d8 pontos adicionais de dano Trovejante a qualquer criatura atingida e 3d8 pontos adicionais de dano Trovejante a objetos atingidos que não estão sendo usados ou carregados.
Esta arma tem as seguintes propriedades adicionais.
Estrondo Trovejante. Como uma ação Usar Magia, você pode bater a arma contra uma superfície dura para produzir um estrondo de trovão audível a até 90 metros. Você também forma um Cone de 9 metros de energia estrondosa. Cada criatura no Cone deve ser bem-sucedida em uma salvaguarda de Força CD 15 ou tem a condição Caído. Objetos não mágicos no Cone que não estão sendo usados ou carregados sofrem 3d8 pontos de dano Trovejante.
Terremoto. Como uma ação Usar Magia, você pode golpear o chão com a arma para criar uma perturbação sísmica em um círculo de 15 metros de raio centrado no ponto de impacto. Estruturas em contato com o solo nessa área sofrem 50 pontos de dano Contundente, e cada criatura no solo nessa área deve ser bem-sucedida em uma salvaguarda de Destreza CD 20 ou tem a condição Caído. Se essa criatura também estiver se concentrando, ela deve ser bem-sucedida em uma salvaguarda de Constituição CD 20 ou sua Concentração é quebrada. Além disso, você pode abrir uma fissura no chão de 9 metros de profundidade e 3 metros de largura em qualquer lugar da área. Qualquer criatura em um ponto onde a fissura se abre deve ser bem-sucedida em uma salvaguarda de Destreza CD 20, caindo na fissura se falhar ou se movendo com a borda da fissura em caso de sucesso. Qualquer estrutura em um local onde a fissura se abre desaba na fissura. Depois de usar esta propriedade, ela não pode ser usada novamente até o próximo amanhecer.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Arma (Clava Grande)","rarity":"very-rare","rarityLabel":"Muito Raro","requiresAttunement":true,"header":"Arma (Clava Grande), Muito Raro (Requer Sintonização)","attunement":"Requer Sintonização","weaponSubtype":"Clava Grande"}'::jsonb
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
  'talisma-da-esfera',
  'other'::rpg.item_type,
  'Talismã da Esfera',
  NULL,
  NULL,
  'Ao segurar ou usar este talismã, você tem Vantagem em qualquer teste de Inteligência (Arcanismo) para controlar uma Esfera da Aniquilação. Além disso, ao iniciar seu turno controlando uma Esfera da Aniquilação, você pode executar uma ação Usar Magia para movê-la 3 metros mais um número de metros adicionais igual a 3 vezes seu modificador de Inteligência. Esse movimento não precisa ser em linha reta.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"legendary","rarityLabel":"Lendário","requiresAttunement":true,"header":"Item Maravilhoso, Lendário (Requer Sintonização)","attunement":"Requer Sintonização"}'::jsonb
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
  'talisma-do-bem-sem-ver-a-quem',
  'other'::rpg.item_type,
  'Talismã do Bem Sem Ver a Quem',
  NULL,
  NULL,
  'Este talismã é um poderoso símbolo de bondade. Um Ínfero ou um Morto-Vivo que o toque sofre 8d6 pontos de dano Radiante, e sofre esse mesmo dano novamente ao final de cada turno em que estiver segurando ou carregando o talismã.
Repreensão Pura. O talismã possui 7 cargas. Enquanto estiver segurando ou usando o talismã, você pode executar uma ação Usar Magia para gastar 1 carga e escolher como alvo uma criatura que esteja no chão e à sua vista, a até 36 metros de distância. Uma fissura flamejante se abre sob o alvo, que deve realizar uma salvaguarda de Destreza CD 20. Se o alvo for um Ínfero ou um Morto-Vivo, ele realiza a salvaguarda com Desvantagem. Se falhar, o alvo cai na fissura e é destruído, sem deixar restos mortais. Com um sucesso, o alvo evita a queda, mas sofre 4d6 pontos de dano Psíquico devido à provação. Em ambos os casos, a fissura se fecha em seguida, sem deixar vestígios de sua existência. Ao gastar a última carga, o talismã se dispersa em partículas de luz dourada e é destruído.
Símbolo Sagrado. Você pode usar o talismã como um Símbolo Sagrado. Você adquire um bônus de +2 nas jogadas de ataque mágico enquanto o usa ou segura.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"legendary","rarityLabel":"Lendário","requiresAttunement":true,"header":"Item Maravilhoso, Lendário (Requer Sintonização por um Clérigo ou Paladino)","attunement":"Requer Sintonização por um Clérigo ou Paladino"}'::jsonb
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
  'talisma-do-mal-universal',
  'other'::rpg.item_type,
  'Talismã do Mal Universal',
  NULL,
  NULL,
  'Este talismã representa o mal impenitente. Qualquer criatura que não seja um Ínfero ou um Morto-Vivo que o toque sofre 8d6 pontos de dano Necrótico, e sofre esse mesmo dano novamente ao final de cada turno em que o estiver segurando ou carregando.
Fim Supremo. O talismã tem 6 cargas. Ao segurar este talismã, você pode executar uma ação Usar Magia para gastar 1 carga e escolher como alvo uma criatura à sua vista, no chão, a até 36 metros de distância. Uma fissura flamejante se abre sob o alvo, e o alvo faz uma salvaguarda de Destreza CD 20. Se o alvo for um Celestial, ele tem Desvantagem na salvaguarda. Se falhar, o alvo cai na fissura e é destruído, não deixando restos mortais. Em caso de sucesso, o alvo não é jogado na fissura, mas sofre 4d6 pontos de dano Psíquico devido à provação. Em ambos os casos, a fissura então se fecha, não deixando vestígios de sua existência. Quando você gasta a última carga, o talismã se dissolve em partículas de luz dourada e é destruído.
Símbolo Sagrado. Você pode usar o talismã como um Símbolo Sagrado. Você adquire um bônus de +2 nas jogadas de ataque mágico enquanto o usa ou segura.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"legendary","rarityLabel":"Lendário","requiresAttunement":true,"header":"Item Maravilhoso, Lendário (Requer Sintonização)","attunement":"Requer Sintonização"}'::jsonb
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
  'tapete-voador',
  'other'::rpg.item_type,
  'Tapete Voador',
  NULL,
  NULL,
  'Você pode fazer o tapete pairar e voar utilizando uma ação Usar Magia e a palavra de comando do tapete. Ele se move conforme suas instruções, desde que você esteja a até 9 metros dele.
Existem quatro tamanhos de Tapete Voador. O Mestre pode escolher o tamanho ou determinar aleatoriamente utilizando a tabela a seguir. Um tapete pode carregar até o dobro do peso indicado na tabela, mas o Deslocamento de Voo é reduzido pela metade ao exceder a capacidade normal.
1d100
	Tamanho
	Capacidade
	Deslocamento de Voo
	01–20
	1 m × 1,5 m
	100 kg
	24 metros
	21–55
	1,2 m × 1,8 m
	200 kg
	18 metros
	56–80
	1,5 m × 2,1 m
	300 kg
	12 metros
	81–00
	1,8 m × 2,7 m
	400 kg
	9 metros
	Tapete Voador: Tamanho, Capacidade e Deslocamento',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"very-rare","rarityLabel":"Muito Raro","requiresAttunement":false,"header":"Item Maravilhoso, Muito Raro"}'::jsonb
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
  'tiara-do-intelecto',
  'other'::rpg.item_type,
  'Tiara do Intelecto',
  NULL,
  NULL,
  'Sua Inteligência é 19 enquanto estiver vestindo esta bandana. Ela não tem efeito se sua Inteligência for 19 ou superior sem ela.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"uncommon","rarityLabel":"Incomum","requiresAttunement":true,"header":"Item Maravilhoso, Incomum (Requer Sintonização)","attunement":"Requer Sintonização"}'::jsonb
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
  'tigela-de-comandar-elementais-da-agua',
  'other'::rpg.item_type,
  'Tigela de Comandar Elementais da Água',
  NULL,
  NULL,
  'Enquanto a tigela estiver cheia de água e você estiver a até 1,5 metro dela, você pode executar uma ação Usar Magia para invocar um Elemental da Água. O elemental aparece em um espaço desocupado próximo à tigela, entende seus idiomas, obedece aos seus comandos e age imediatamente após sua contagem de iniciativa. Ele desaparece após 1 hora, quando morre ou quando você o dispensa como uma Ação Bônus. A tigela não pode ser utilizada novamente desse modo até o próximo amanhecer.
A tigela possui cerca de 30 centímetros de diâmetro e 15 centímetros de profundidade, podendo conter aproximadamente 12 litros.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"rare","rarityLabel":"Raro","requiresAttunement":false,"header":"Item Maravilhoso, Raro"}'::jsonb
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
  'tomo-da-compreensao',
  'other'::rpg.item_type,
  'Tomo da Compreensão',
  NULL,
  NULL,
  'Este livro contém exercícios de discernimento e intuição e suas palavras são carregadas de magia. Se você passar 48 horas em um período de 6 dias ou menos estudando o conteúdo do livro e praticando as diretrizes apresentadas, seu valor de Sabedoria aumenta em 2, até no máximo 30. A magia do manual se dissipa, retornando após um século.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"very-rare","rarityLabel":"Muito Raro","requiresAttunement":false,"header":"Item Maravilhoso, Muito Raro"}'::jsonb
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
  'tomo-da-lideranca-e-influencia',
  'other'::rpg.item_type,
  'Tomo da Liderança e Influência',
  NULL,
  NULL,
  'Este livro contém diretrizes para influenciar e encantar outros, e suas palavras são carregadas de magia. Se você passar 48 horas em um período de 6 dias ou menos estudando o conteúdo do livro e praticando as diretrizes apresentadas, seu valor de Carisma aumenta em 2, até no máximo 30. A magia do manual se dissipa, retornando após um século.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"very-rare","rarityLabel":"Muito Raro","requiresAttunement":false,"header":"Item Maravilhoso, Muito Raro"}'::jsonb
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
  'tomo-das-palavras-tranquilizantes',
  'other'::rpg.item_type,
  'Tomo das Palavras Tranquilizantes',
  NULL,
  NULL,
  'Este livro tem uma língua dissecada presa na capa. Existem cinco desses tomos, e não se sabe qual é o original. A terrível decoração de capa do primeiro Tomo das Palavras Tranquilizantes pertenceu a um antigo servo traiçoeiro do deus lich Vecna. As línguas presas às capas das quatro cópias vieram de outros conjuradores que desafiaram Vecna. As primeiras páginas de cada tomo estão cheias de rabiscos indecifráveis. As páginas restantes estão em branco.
Enquanto estiver sintonizado com este item, você pode usá-lo como um Livro de Magias e um Foco Arcano. Além disso, enquanto segura o tomo, você pode executar uma Ação Bônus para conjurar uma magia que escreveu nele, sem gastar um espaço de magia ou usar quaisquer componentes Verbais ou Somáticos. Uma vez usada, esta propriedade do tomo não pode ser usada novamente até o próximo amanhecer.
Somente você pode remover a língua da capa do livro. Ao fazer isso, todas as magias escritas no livro são permanentemente apagadas.
Vecna observa qualquer pessoa que use este tomo e pode escrever mensagens enigmáticas nele. Essas mensagens normalmente desaparecem após serem lidas.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"legendary","rarityLabel":"Lendário","requiresAttunement":true,"header":"Item Maravilhoso, Lendário (Requer Sintonização por um Mago)","attunement":"Requer Sintonização por um Mago"}'::jsonb
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
  'tomo-dos-pensamentos-objetivos',
  'other'::rpg.item_type,
  'Tomo dos Pensamentos Objetivos',
  NULL,
  NULL,
  'Este tomo contém exercícios de memória e lógica e suas palavras são carregadas de magia. Se você passar 48 horas em um período de 6 dias ou menos estudando o conteúdo do livro e praticando as diretrizes apresentadas, seu valor de Inteligência aumenta em 2, até no máximo 30. A magia do manual se dissipa, retornando após um século.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"very-rare","rarityLabel":"Muito Raro","requiresAttunement":false,"header":"Item Maravilhoso, Muito Raro"}'::jsonb
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
  'touca-de-respirar-na-agua',
  'other'::rpg.item_type,
  'Touca de Respirar na Água',
  NULL,
  NULL,
  'Enquanto estiver usando esta touca debaixo d''água, você pode executar uma ação Usar Magia para criar uma bolha de ar ao redor da sua cabeça, permitindo que respire normalmente. A bolha permanece até que a touca seja removida ou você saia da água.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"uncommon","rarityLabel":"Incomum","requiresAttunement":false,"header":"Item Maravilhoso, Incomum"}'::jsonb
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
  'tridente-de-comandar-peixes',
  'weapon'::rpg.item_type,
  'Tridente de Comandar Peixes',
  NULL,
  NULL,
  'Esta arma mágica tem 3 cargas e recupera 1d3 cargas gastas diariamente ao amanhecer. Enquanto o carrega, você pode gastar 1 carga para conjurar Dominar Fera (CD 15 para evitar) em uma Fera que tenha Deslocamento de Natação.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Arma (Tridente)","rarity":"uncommon","rarityLabel":"Incomum","requiresAttunement":true,"header":"Arma (Tridente), Incomum (Requer Sintonização)","attunement":"Requer Sintonização","weaponSubtype":"Tridente"}'::jsonb
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
  'trombeta-de-explosao',
  'other'::rpg.item_type,
  'Trombeta de Explosão',
  NULL,
  NULL,
  'Você pode executar uma ação Usar Magia para soprar a trombeta, que emite uma explosão estrondosa em um Cone de 9 metros que é audível a até 180 metros. Cada criatura no Cone realiza uma salvaguarda de Constituição CD 15. Se falhar, uma criatura sofre 5d8 pontos de dano Trovejante e tem a condição Surdo por 1 minuto. Em caso de sucesso, uma criatura sofre apenas metade do dano. Objetos de vidro ou cristal no Cone, que não estão sendo usados ou carregados, sofrem 10d8 pontos de dano Trovejante.
Cada uso da magia da trombeta tem 20% de chance de fazê-la explodir. A explosão causa 10d6 pontos de dano Energético ao usuário e destrói a trombeta.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"rare","rarityLabel":"Raro","requiresAttunement":false,"header":"Item Maravilhoso, Raro"}'::jsonb
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
  'trombeta-do-valhalla',
  'other'::rpg.item_type,
  'Trombeta do Valhalla',
  NULL,
  NULL,
  'Você pode executar uma ação Usar Magia para soprar esta trombeta. Em resposta, espíritos combatentes do plano de Ysgard aparecem em espaços desocupados a até 18 metros de você. Cada espírito usa o bloco de estatísticas do Berserker e retorna a Ysgard após 1 hora ou quando é reduzido a 0 Ponto de Vida. Os espíritos parecem combatentes vivos, e têm Imunidade às condições Amedrontado e Enfeitiçado. Após usar a trombeta, ela não pode ser utilizada novamente até que se passem 7 dias.
Sabe-se que existem quatro tipos de Trombeta do Valhalla, cada uma feita de um metal diferente. O tipo de trombeta determina quantos espíritos ela invoca, bem como o requisito para seu uso. O Mestre escolhe o tipo da trombeta ou o determina aleatoriamente jogando na tabela a seguir.
Se você soprar a trombeta sem atender aos requisitos, os espíritos invocados o atacam. Se você atender ao requisito, eles são Amigáveis a você e aos seus aliados e seguem seus comandos.
1d100
	Tipo de Trombeta
	Espíritos
	Requisito
	01–40
	Prata
	2
	Nenhum
	41–75
	Latão
	3
	Proficiência com todas as armas Simples
	76–90
	Bronze
	4
	Treinamento com todas as armaduras Médias
	91–00
	Ferro
	5
	Proficiência com todas as armas Marciais',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"rare","rarityLabel":"Raro","requiresAttunement":false,"header":"Item Maravilhoso, Raro (Prata ou Latão), Muito Raro (Bronze) ou Lendário (Ferro)"}'::jsonb
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
  'tunica-das-cores-cintilantes',
  'other'::rpg.item_type,
  'Túnica das Cores Cintilantes',
  NULL,
  NULL,
  'Esta túnica tem 3 cargas e recupera 1d3 cargas gastas diariamente ao amanhecer. Enquanto a usa, você pode executar uma ação Usar Magia e gastar 1 carga para fazer com que o traje exiba um padrão de mudança de tons deslumbrantes até o final do seu próximo turno. Durante esse tempo, a túnica projeta Luz Plena em um raio de 9 metros e Meia-luz por mais 9 metros, e criaturas que podem ver você têm Desvantagem nas jogadas de ataque contra você. Qualquer criatura na Luz Plena que possa vê-lo quando o poder da túnica for ativado deve ser bem-sucedida em uma salvaguarda de Sabedoria CD 15 ou tem a condição Atordoado até o efeito terminar.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"very-rare","rarityLabel":"Muito Raro","requiresAttunement":true,"header":"Item Maravilhoso, Muito Raro (Requer Sintonização)","attunement":"Requer Sintonização"}'::jsonb
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
  'tunica-das-estrelas',
  'other'::rpg.item_type,
  'Túnica das Estrelas',
  NULL,
  NULL,
  'Esta túnica preta ou azul escuro é bordada com pequenas estrelas brancas ou prateadas. Você adquire um bônus de +1 em salvaguardas enquanto estiver usando esta túnica.
Seis estrelas, localizadas na parte superior frontal da túnica, são particularmente grandes. Enquanto estiver usando esta túnica, você pode executar uma ação Usar Magia para remover uma das estrelas e gastá-la para conjurar como 5º círculo de Mísseis Mágicos. Diariamente ao anoitecer, 1d6 estrelas removidas reaparecem no manto.
Enquanto usa a túnica, você pode executar uma ação Usar Magia para entrar no Plano Astral junto com tudo o que você está vestindo e carregando. Você permanece lá até executar uma ação Usar Magia para retornar ao plano em que estava. Você reaparece no último espaço que ocupou ou, se esse espaço estiver ocupado, no espaço desocupado mais próximo.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"very-rare","rarityLabel":"Muito Raro","requiresAttunement":true,"header":"Item Maravilhoso, Muito Raro (Requer Sintonização)","attunement":"Requer Sintonização"}'::jsonb
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
  'tunica-das-quinquilharias-uteis',
  'other'::rpg.item_type,
  'Túnica das Quinquilharias Úteis',
  NULL,
  NULL,
  'Esta túnica é coberta por remendos de pano de várias formas e cores. Enquanto estiver usando a túnica, você pode executar uma ação Usar Magia para remover um dos remendos, fazendo com que ele se torne o objeto ou criatura que representa. Uma vez que o último remendo é removido, a túnica se torna uma peça de vestuário comum.
A túnica tem dois de cada um dos seguintes remendos:
● Adaga
● Baliza
● Corda (enrolada)
● Espelho
● Lanterna Foca-Facho (cheia e acesa)
● Saca
Além disso, o manto tem 4d4 outros remendos. O Mestre escolhe os remendos ou os determina aleatoriamente jogando na tabela a seguir.
1d100
	Remendo
	01–08
	Bolsa de 100 PO
	09–15
	Cofre de prata (30 cm de comprimento, 15 cm de largura e profundidade) no valor de 500 PO
	16–22
	Porta de ferro (até 3 metros de largura e 3 metros de altura, barrada em um lado de sua escolha), que você pode colocar em uma abertura ao seu alcance; está se ajusta com a abertura, encaixando-se e articulando-se sozinha
	23–30
	10 gemas no valor de 100 PO cada
	31–44
	Escada de madeira (7 metros de comprimento)
	45–51
	Cavalo de Montaria com Sela
	52–59
	Poço aberto (um cubo de 3 metros de lado), que você pode colocar no chão a até 3 metros de si mesmo
	60–68
	4 Poções de Cura
	69–75
	Barco a remo (4 metros de comprimento)
	76–83
	Pergaminho Mágico contendo uma magia de 1º, 2º ou 3º círculo (à sua escolha)
	84–90
	2 Mastins
	91–96
	Janela (60 cm por 1,2 m, até 60 cm de profundidade), que você pode colocar em uma superfície vertical ao seu alcance
	97–00
	Aríete Portátil',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"uncommon","rarityLabel":"Incomum","requiresAttunement":false,"header":"Item Maravilhoso, Incomum"}'::jsonb
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
  'tunica-do-arquimago',
  'other'::rpg.item_type,
  'Túnica do Arquimago',
  NULL,
  NULL,
  'Este traje elegante é feito de um tecido requintado e adornado com runas.
Você adquire os seguintes benefícios enquanto estiver usando a túnica.
Armadura. Se você não estiver vestindo armadura, sua Classe de Armadura base é 15 mais seu modificador de Destreza.
Mago de Guerra. A CD para evitar sua magia e seu bônus de ataque mágico aumentam em 2.
Resistência à Magia. Você tem Vantagem em salvaguardas contra magias e outros efeitos mágicos.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"legendary","rarityLabel":"Lendário","requiresAttunement":true,"header":"Item Maravilhoso, Lendário (Requer Sintonização por um Bruxo, Feiticeiro ou Mago)","attunement":"Requer Sintonização por um Bruxo, Feiticeiro ou Mago"}'::jsonb
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
  'tunica-ocular',
  'other'::rpg.item_type,
  'Túnica Ocular',
  NULL,
  NULL,
  'Esta túnica é adornada com padrões em formas de olho. Ao usar a túnica, você adquire os seguintes benefícios:
Sentidos Especiais. Você tem Visão no Escuro e Visão Verdadeira, ambas com um alcance de 36 metros.
Visão Abrangente. A túnica lhe dá Vantagem em testes de Sabedoria (Percepção) que dependem da visão.
Limitações. Uma magia Luz conjurada na túnica ou uma magia Luz do Dia conjurada a até 1,5 metro da túnica lhe impõe a condição Cego por 1 minuto. No final de cada um dos seus turnos, você realiza uma salvaguarda de Constituição (CD 11 para Luz ou CD 15 para Luz do Dia), encerrando a condição em caso de sucesso.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"rare","rarityLabel":"Raro","requiresAttunement":true,"header":"Item Maravilhoso, Raro (Requer Sintonização)","attunement":"Requer Sintonização"}'::jsonb
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
  'unguento-de-keoghtom',
  'other'::rpg.item_type,
  'Unguento de Keoghtom',
  NULL,
  NULL,
  'Esta ampola de vidro de 7,5 centímetros de diâmetro contém 1d4 + 1 doses de uma mistura espessa que cheira levemente a babosa. A ampola e seu conteúdo pesam 250 gramas.
Como uma ação Usar Objeto, você pode engolir uma dose do unguento ou aplicá-lo a uma criatura a até 1,5 metro de você. A criatura que o receber recupera 2d8 + 2 Pontos de Vida e não tem mais a condição Envenenado.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"uncommon","rarityLabel":"Incomum","requiresAttunement":false,"header":"Item Maravilhoso, Incomum"}'::jsonb
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
  'vara-de-pesca',
  'other'::rpg.item_type,
  'Vara de Pesca',
  NULL,
  NULL,
  'Este item funciona como uma Haste. Enquanto a segura, você pode executar uma ação Usar Magia para fazer com que ela se transforme em uma vara de pescar com um anzol, uma linha e uma carretilha, ou fazer com que a vara de pescar reverta para uma Haste.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"common","rarityLabel":"Comum","requiresAttunement":false,"header":"Item Maravilhoso, Comum"}'::jsonb
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
  'varinha-cuspidora-de-fogo',
  'other'::rpg.item_type,
  'Varinha Cuspidora de Fogo',
  NULL,
  NULL,
  'Esta varinha tem 7 cargas. Enquanto a segurar, você não pode gastar mais do que 3 cargas para conjurar Bola de Fogo (CD 15 para evitar) a partir dela. Por 1 carga, você conjura a versão de 3º círculo da magia. Você pode aumentar o círculo da magia em 1 para cada carga adicional que gastar.
Recuperando Cargas. A varinha recupera 1d6 + 1 cargas gastas diariamente ao amanhecer. Se você gastar a última carga da varinha, jogue 1d20. Em um 1, a varinha se desfaz em cinzas e é destruída.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Varinha","rarity":"rare","rarityLabel":"Raro","requiresAttunement":true,"header":"Varinha, Raro (Requer Sintonização por um Conjurador)","attunement":"Requer Sintonização por um Conjurador"}'::jsonb
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
  'varinha-das-maravilhas',
  'other'::rpg.item_type,
  'Varinha das Maravilhas',
  NULL,
  NULL,
  'Esta varinha tem 7 cargas. Enquanto a segurar, você pode executar uma ação Usar Magia para gastar 1 carga enquanto escolhe um ponto a até 36 metros de você. Esse local se torna o ponto de origem de uma magia ou outro efeito mágico determinado pela jogada na tabela Efeitos da Varinha das Maravilhas. As magias conjuradas a partir da varinha têm salvaguardas com CD 15. Se o alcance máximo de uma magia normalmente for inferior a 36 metros, ela se torna 36 metros quando conjurada a partir da varinha. Se um efeito tiver vários alvos possíveis, o Mestre determina aleatoriamente quais deles são afetados.
Recuperando Cargas. A varinha recupera 1d6 + 1 cargas gastas diariamente ao amanhecer. Se você gastar a última carga da varinha, jogue 1d20. Em um 1, a varinha se desfaz em pó e é destruída.
 
1d100
	Efeito
	01–20
	Você conjura uma magia originada no ponto escolhido. Jogue 1d10 para determinar a magia: em um 1–2, Escuridão; em um 3–4, Fogo das Fadas; em um 5–6, Bola de Fogo; em um 7–8, Lentidão; em um 9–10, Nuvem Fétida.
	21–25
	Nada acontece no ponto de origem escolhido. Em vez disso, você tem a condição Atordoado até o início do seu próximo turno, acreditando que algo incrível acabou de acontecer.
	26–30
	Você conjura Lufada de Vento. A Linha criada pela magia se estende de você até o ponto de origem escolhido.
	31–35
	Nada acontece no ponto de origem escolhido. Você sofre 1d6 pontos de dano Psíquico em vez disso.
	36–40
	Chuvas fortes caem por 1 minuto em um Cilindro de 36 metros de altura e 18 metros de raio centrado no ponto de origem escolhido. Durante esse tempo, a área de efeito é Parcialmente Obscurecida.
	41–45
	Uma nuvem de 600 borboletas supergrandes preenche um Cilindro de 18 metros de altura e 9 metros de raio centrado no ponto de origem escolhido. As borboletas permanecem por 10 minutos, durante os quais a área de efeito é Totalmente Obscurecida.
	46–50
	Você conjura Relâmpago. A Linha criada pela magia se estende de você até o ponto de origem escolhido.
	51–55
	A criatura mais próxima do ponto de origem escolhido é ampliada como se você tivesse conjurado Aumentar/Reduzir nela. Se o alvo não for você e não puder ser afetado por essa magia, você se torna o alvo.
	56–60
	Uma criatura formada magicamente aparece em um espaço desocupado o mais próximo possível do ponto de origem escolhido. A criatura não está sob seu controle, age como normalmente faria e desaparece após 1 hora ou quando é reduzida a 0 Pontos de Vida. Jogue 1d4 para determinar qual criatura aparece. Em um 1, um Rinoceronte aparece; em um 2, um Elefante aparece; e em um 3–4, um Rato aparece.
	61–64
	Grama cobre um círculo de 18 metros de raio, com o centro desse círculo o mais próximo possível do ponto de origem escolhido. A grama que já está lá cresce dez vezes seu tamanho normal e permanece assim por 1 minuto.
	65–68
	Um objeto da escolha do Mestre desaparece para o interior do Plano Etéreo. O objeto não pode estar sendo usado ou carregado, deve estar a até 36 metros do ponto de origem escolhido e não pode ter mais de 3 metros em nenhuma dimensão. Se não houver tais objetos no alcance, nada acontece.
	69–72
	Nada acontece no ponto de origem escolhido. Em vez disso, você encolhe como se tivesse conjurado Aumentar/Reduzir em si mesmo e permanece nesse estado por 1 minuto.
	73–77
	Folhas crescem na criatura mais próxima do ponto de origem escolhido. A menos que sejam retiradas, as folhas ficam marrons e caem após 24 horas.
	78–82
	Nada acontece no ponto de origem escolhido. Em vez disso, uma explosão de luz colorida e cintilante se estende de você em uma Emanação de 9 metros. Cada criatura na área deve ser bem-sucedida em uma salvaguarda de Constituição CD 15 ou tem a condição Cego por 1 minuto. Uma criatura repete a salvaguarda no final de cada um dos turnos dela, encerrando o efeito em si em caso de sucesso.
	83–87
	Nada acontece no ponto de origem escolhido. Em vez disso, você conjura Invisibilidade em si mesmo.
	88–92
	Nada acontece no ponto de origem escolhido. Em vez disso, um fluxo de 1d4 x 10 gemas, cada uma valendo 1 PO, dispara da ponta da varinha em uma Linha de 9 metros de comprimento e 1,5 metro de largura em direção ao ponto de origem escolhido. Cada gema causa 1 ponto dano Contundente, e o dano total das gemas é dividido igualmente entre todas as criaturas na Linha.
	93–97
	Você conjura Polimorfia, escolhendo como alvo a criatura mais próxima do ponto de origem escolhido. Jogue 1d4 para determinar a nova forma do alvo. Em um 1, a nova forma é um Urso Negro; em um 2, a nova forma é uma Vespa Gigante; em um 3–4, a nova forma é uma Rã.
	98–00
	A criatura mais próxima do ponto de origem escolhido realiza uma salvaguarda de Constituição CD 15. Se falhar, a criatura tem a condição Contido e começa a se transformar em pedra. Enquanto Contida dessa maneira, a criatura repete a salvaguarda no final do próximo turno dela. Em caso de sucesso, o efeito se encerra. Se falhar, a criatura tem a condição Petrificado em vez de Contido. A petrificação dura até que a criatura seja liberada pela magia Restauração Maior ou efeito mágico semelhante.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Varinha","rarity":"rare","rarityLabel":"Raro","requiresAttunement":true,"header":"Varinha, Raro (Requer Sintonização)","attunement":"Requer Sintonização"}'::jsonb
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
  'varinha-de-detectar-inimigo',
  'other'::rpg.item_type,
  'Varinha de Detectar Inimigo',
  NULL,
  NULL,
  'Esta varinha tem 7 cargas. Enquanto a segura, você pode executar uma ação Usar Magia para gastar 1 carga. Por 1 minuto, você sabe a direção da criatura Hostil mais próxima a você a até 18 metros, mas não a distância dela de você. A varinha pode sentir a presença de criaturas Hostis que estão Invisíveis, etéreas, disfarçadas ou ocultas, bem como aquelas à vista de todos. O efeito se encerra se você parar de segurar a varinha.
Recuperando Cargas. A varinha recupera 1d6 + 1 cargas gastas diariamente ao amanhecer. Se você gastar a última carga da varinha, jogue 1d20. Em um 1, a varinha se desfaz em cinzas e é destruída.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Varinha","rarity":"rare","rarityLabel":"Raro","requiresAttunement":true,"header":"Varinha, Raro (Requer Sintonização)","attunement":"Requer Sintonização"}'::jsonb
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
  'varinha-de-misseis-magicos',
  'other'::rpg.item_type,
  'Varinha de Mísseis Mágicos',
  NULL,
  NULL,
  'Esta varinha tem 7 cargas. Enquanto a segurar, você não pode gastar mais do que 3 cargas para conjurar Mísseis Mágicos a partir dela. Por 1 carga, você conjura a versão de 1º círculo da magia. Você pode aumentar o círculo da magia em 1 para cada carga adicional que gastar.
Recuperando Cargas. A varinha recupera 1d6 + 1 cargas gastas diariamente ao amanhecer. Se você gastar a última carga da varinha, jogue 1d20. Em um 1, a varinha se desfaz em cinzas e é destruída.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Varinha","rarity":"uncommon","rarityLabel":"Incomum","requiresAttunement":false,"header":"Varinha, Incomum"}'::jsonb
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
  'varinha-de-orcus',
  'other'::rpg.item_type,
  'Varinha de Orcus',
  NULL,
  NULL,
  'Criada e empunhada por Orcus, esta varinha medonha escapa das garras do lorde demônio de tempos em tempos. Quando isso acontece, ela aparece magicamente onde quer que o lorde demônio sinta uma oportunidade de alcançar algum objetivo maligno.
A varinha é coberta na sua extremidade por um crânio que pertenceu a um herói humano morto por Orcus. A varinha pode mudar magicamente de tamanho para melhor se adequar às mãos de seu usuário. Toda Água Benta a até 3 metros da varinha é destruída.
Qualquer criatura, exceto Orcus, que tentar sintonizar com a varinha realiza uma salvaguarda de Constituição CD 17. Em caso de sucesso, a criatura sofre 10d6 pontos de dano Necrótico. Se falhar, a criatura morre e, se for um Humanoide, se transforma em um Zumbi.
Arma Mágica. Você pode empunhar a varinha como uma Maça mágica que concede um bônus de +3 para jogadas de ataque e dano realizadas com ela. A varinha causa 2d12 pontos de dano Necrótico adicionais em um acerto.
Propriedades Aleatórias
Propriedades Aleatórias. A Varinha de Orcus tem as seguintes propriedades aleatórias (veja Artefatos neste capítulo):
● 2 propriedades benéficas menores
● 1 propriedade benéfica maior
● 2 propriedades prejudiciais menores
● 1 propriedade prejudicial maior
As propriedades prejudiciais da Varinha de Orcus são suprimidas enquanto a varinha está sintonizada com Orcus.
Magias. A varinha possui 7 cargas e recupera 1d4 + 3 cargas gastas diariamente ao amanhecer. Enquanto segura a varinha, você pode conjurar uma das magias na tabela a seguir a partir dela (CD 18 para evitar). A tabela indica quantas cargas você deve gastar para conjurar a magia.
Magia
	Carga Usada
	Animar Mortos
	1
	Círculo da Morte
	3
	Dedo da Morte
	3
	Falar com Mortos
	1
	Malogro
	2
	Palavra de Poder: Matar
	4
	Enquanto estiver sintonizado com a varinha, Orcus ou um seguidor abençoado por ele pode conjurar cada uma das magias da varinha usando 2 cargas a menos (mínimo de 0).
Convocar Mortos-Vivos. Enquanto segurar a varinha, você pode executar uma ação Usar Magia para conjurar 15 Esqueletos e 15 Zumbis. Esses Mortos-Vivos se erguem magicamente do chão ou se formam em espaços desocupados a até 90 metros de você e obedecem aos seus comandos até serem destruídos ou até o próximo amanhecer, quando colapsam em pilhas inanimadas de ossos e cadáveres em decomposição. Após usar esta propriedade, você não pode usá-la novamente até o próximo amanhecer.
Enquanto segura a varinha, Orcus pode invocar qualquer tipo de Morto-Vivo, não apenas esqueletos e zumbis. Esses Mortos-Vivos não são destruídos ao amanhecer do dia seguinte, permanecendo até que Orcus os dispense.
Personalidade. O propósito da varinha é ajudar a satisfazer o desejo de Orcus de matar tudo no multiverso. A varinha é cruel, niilista e desprovida de humor.
Para promover os objetivos de Orcus, a varinha finge devoção ao seu usuário atual e faz promessas grandiosas que não tem intenção de cumprir, como prometer ajudar seu usuário a derrubar Orcus.
Proteção. Você recebe um bônus de +3 na Classe de Armadura enquanto estiver segurando a varinha.
Senciência. A Varinha de Orcus é um item senciente Caótico e Mau com Inteligência 16, Sabedoria 12 e Carisma 16. Ela também possui audição e Visão no Escuro até 36 metros.
A varinha se comunica telepaticamente com seu portador e fala Abissal e Comum.
Destruindo a Varinha. Destruir a Varinha de Orcus requer que ela seja levada para o Plano de Energia Positiva pelo antigo herói cujo crânio está nela. Para isso acontecer, o herói há muito perdido deve primeiro ser restaurado à vida — e isso não é uma tarefa fácil, considerando que Orcus aprisionou a alma do herói e a mantém escondida e bem guardada.
Banhar a varinha em energia positiva (como a que permeia o Plano Positivo) faz com que ela rache e exploda, mas a menos que as condições acima sejam atendidas, a varinha se reconstrói instantaneamente na camada de Orcus no Abismo.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Varinha","rarity":"artifact","rarityLabel":"Artefato","requiresAttunement":true,"header":"Varinha, Artefato (Requer Sintonização)","attunement":"Requer Sintonização"}'::jsonb
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
  'varinha-de-paralisia',
  'other'::rpg.item_type,
  'Varinha de Paralisia',
  NULL,
  NULL,
  'Esta varinha tem 7 cargas. Enquanto a segurar, você pode executar uma ação Usar Magia para gastar 1 carga e fazer com que um fino raio azul saia da ponta da varinha em direção a uma criatura à sua vista a até 18 metros de distância. O alvo deve ser bem-sucedido em uma salvaguarda de Constituição CD 15 ou tem a condição Paralisado por 1 minuto. No final de cada um dos turnos do alvo, ele repete a salvaguarda, encerrando o efeito em si em caso de sucesso.
Recuperando Cargas. A varinha recupera 1d6 + 1 cargas gastas diariamente ao amanhecer. Se você gastar a última carga da varinha, jogue 1d20. Em um 1, a varinha se desfaz em cinzas e é destruída.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Varinha","rarity":"rare","rarityLabel":"Raro","requiresAttunement":true,"header":"Varinha, Raro (Requer Sintonização por um Conjurador)","attunement":"Requer Sintonização por um Conjurador"}'::jsonb
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
  'varinha-de-polimorfia',
  'other'::rpg.item_type,
  'Varinha de Polimorfia',
  NULL,
  NULL,
  'Esta varinha tem 7 cargas. Enquanto a segurar, você pode gastar 1 carga para conjurar Polimorfia (CD 15 para evitar) a partir dela.
Recuperando Cargas. A varinha recupera 1d6 + 1 cargas gastas diariamente ao amanhecer. Se você gastar a última carga da varinha, jogue 1d20. Em um 1, a varinha se desfaz em cinzas e é destruída.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Varinha","rarity":"very-rare","rarityLabel":"Muito Raro","requiresAttunement":true,"header":"Varinha, Muito Raro (Requer Sintonização por um Conjurador)","attunement":"Requer Sintonização por um Conjurador"}'::jsonb
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
  'varinha-de-relampagos',
  'other'::rpg.item_type,
  'Varinha de Relâmpagos',
  NULL,
  NULL,
  'Esta varinha tem 7 cargas. Enquanto a segurar, você não pode gastar mais do que 3 cargas para conjurar Relâmpago (CD 15 para evitar) a partir dela. Por 1 carga, você conjura a versão de 3º círculo da magia. Você pode aumentar o círculo da magia em 1 para cada carga adicional que gastar.
Recuperando Cargas. A varinha recupera 1d6 + 1 cargas gastas diariamente ao amanhecer. Se você gastar a última carga da varinha, jogue 1d20. Em um 1, a varinha se desfaz em cinzas e é destruída.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Varinha","rarity":"rare","rarityLabel":"Raro","requiresAttunement":true,"header":"Varinha, Raro (Requer Sintonização por um Conjurador)","attunement":"Requer Sintonização por um Conjurador"}'::jsonb
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
  'varinha-de-teia',
  'other'::rpg.item_type,
  'Varinha de Teia',
  NULL,
  NULL,
  'Esta varinha tem 7 cargas. Enquanto a segurar, você pode gastar 1 carga para conjurar Teia (CD 13 para evitar) a partir dela.
Recuperando Cargas. A varinha recupera 1d6 + 1 cargas gastas diariamente ao amanhecer. Se você gastar a última carga da varinha, jogue 1d20. Em um 1, a varinha se desfaz em cinzas e é destruída.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Varinha","rarity":"uncommon","rarityLabel":"Incomum","requiresAttunement":true,"header":"Varinha, Incomum (Requer Sintonização por um Conjurador)","attunement":"Requer Sintonização por um Conjurador"}'::jsonb
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
  'varinha-do-mago-de-guerra-1-2-ou-3',
  'other'::rpg.item_type,
  'Varinha do Mago de Guerra, +1, +2 ou +3',
  NULL,
  NULL,
  'Enquanto estiver segurando esta varinha, você adquire um bônus em jogadas de ataque mágico determinadas pela raridade da varinha. Além disso, você ignora a Cobertura Parcial ao realizar uma jogada de ataque mágico.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Varinha","rarity":"uncommon","rarityLabel":"Incomum","requiresAttunement":true,"header":"Varinha, Incomum (+1), Raro (+2) ou Muito Raro (+3) (Requer Sintonização por um Conjurador)","attunement":"Requer Sintonização por um Conjurador"}'::jsonb
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
  'varinha-do-medo',
  'other'::rpg.item_type,
  'Varinha do Medo',
  NULL,
  NULL,
  'Esta varinha tem 7 cargas.
Magias. Enquanto segurar a varinha, você pode conjurar uma das magias (CD 15 para evitar) na tabela a seguir a partir dela. A tabela indica quantas cargas você deve gastar para conjurar a magia.
Magia
	Carga Usada
	Comando (“abaixar” ou “fugir” apenas)
	1
	Medo (Cone de 18 metros)
	3
	Recuperando Cargas. A varinha recupera 1d6 + 1 cargas gastas diariamente ao amanhecer. Se você gastar a última carga da varinha, jogue 1d20. Em um 1, a varinha se desfaz em cinzas e é destruída.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Varinha","rarity":"rare","rarityLabel":"Raro","requiresAttunement":true,"header":"Varinha, Raro (Requer Sintonização)","attunement":"Requer Sintonização"}'::jsonb
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
  'varinha-dos-segredos',
  'other'::rpg.item_type,
  'Varinha dos Segredos',
  NULL,
  NULL,
  'Esta varinha tem 3 cargas e recupera 1d3 cargas gastas diariamente ao amanhecer. Enquanto a segurar, você pode executar uma ação Usar Magia para gastar 1 carga e, se uma porta ou armadilha secreta estiver a até 18 metros de você, a varinha pulsa e aponta para a mais próxima.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Varinha","rarity":"uncommon","rarityLabel":"Incomum","requiresAttunement":false,"header":"Varinha, Incomum"}'::jsonb
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
  'varinha-farejadora-de-magias',
  'other'::rpg.item_type,
  'Varinha Farejadora de Magias',
  NULL,
  NULL,
  'Esta varinha tem 3 cargas. Enquanto a segurar, você pode gastar 1 carga para conjurar Detectar Magia a partir dela. A varinha recupera 1d3 cargas gastas diariamente ao amanhecer.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Varinha","rarity":"uncommon","rarityLabel":"Incomum","requiresAttunement":false,"header":"Varinha, Incomum"}'::jsonb
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
  'varinha-imobilizadora',
  'other'::rpg.item_type,
  'Varinha Imobilizadora',
  NULL,
  NULL,
  'Esta varinha tem 7 cargas.
Magias. Enquanto segurar a varinha, você pode conjurar uma das magias (CD 17 para evitar) na tabela a seguir a partir dela. A tabela indica quantas cargas você deve gastar para conjurar a magia.
Magia
	Carga Usada
	Paralisar Monstro
	5
	Paralisar Pessoa
	2
	Recuperando Cargas. A varinha recupera 1d6 + 1 cargas gastas diariamente ao amanhecer. Se você gastar a última carga da varinha, jogue 1d20. Em um 1, a varinha se desfaz em cinzas e é destruída.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Varinha","rarity":"rare","rarityLabel":"Raro","requiresAttunement":true,"header":"Varinha, Raro (Requer Sintonização)","attunement":"Requer Sintonização"}'::jsonb
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
  'varinha-pirotecnica',
  'other'::rpg.item_type,
  'Varinha Pirotécnica',
  NULL,
  NULL,
  'Esta varinha tem 7 cargas. Enquanto a segurar, você pode executar uma ação Usar Magia para gastar 1 carga e criar uma explosão inofensiva de luz multicolorida em um ponto à sua vista a até 36 metros de distância. A explosão de luz é acompanhada por um ruído crepitante que pode ser ouvido a até 90 metros de distância. A luz é tão brilhante quanto uma chama de tocha, mas dura apenas um segundo.
Recuperando Cargas. A varinha recupera 1d6 + 1 cargas gastas diariamente ao amanhecer. Se você gastar a última carga da varinha, jogue 1d20. Em um 1, a varinha irrompe em uma exibição pirotécnica inofensiva e é destruída.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Varinha","rarity":"common","rarityLabel":"Comum","requiresAttunement":false,"header":"Varinha, Comum"}'::jsonb
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
  'vassoura-dancante-de-baba-yaga',
  'other'::rpg.item_type,
  'Vassoura Dançante de Baba Yaga',
  NULL,
  NULL,
  'A arquifada Baba Yaga criou muitas vassouras mágicas, cada uma delas única. Nenhuma é exatamente igual. Ao segurar a vassoura, você pode executar uma ação Usar Magia para transformá-la em uma Vassoura Agressora sob seu controle. A vassoura então se move para um espaço desocupado mais próximo de você, agindo imediatamente após você na contagem de Iniciativa e permanece animada até que você execute uma Ação Bônus e pronuncie uma palavra de comando para torná-la inanimada.
No seu turno, você pode controlar mentalmente a vassoura animada se ela estiver a até 9 metros de você e não estiver sob a condição Incapacitado (nenhuma ação é necessária). Você decide a ação que a vassoura executa e o movimento dela no próximo turno, ou pode dar um comando geral, como atacar inimigos ou proteger um local.
Ao voltar a sua forma inanimada antes de ser reduzida a 0 Pontos de Vida, a vassoura os restaura completamente, caso contrário, quebra e é destruída.
Vassoura Dançante de Baba Yaga',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"uncommon","rarityLabel":"Incomum","requiresAttunement":true,"header":"Item Maravilhoso, Incomum (Requer Sintonização)","attunement":"Requer Sintonização"}'::jsonb
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
  'vassoura-voadora',
  'other'::rpg.item_type,
  'Vassoura Voadora',
  NULL,
  NULL,
  'Esta vassoura de madeira funciona como uma vassoura comum até que você monte nela e use a ação Usar Magia para fazê-la pairar, permitindo que seja montada no ar. A vassoura possui um Deslocamento de Voo de 15 metros e suporta até 200 quilos, mas o Deslocamento de Voo diminui para 9 metros se carregar mais de 100 quilos. A vassoura para de pairar quando você desce ou deixa de estar montado nela.
Com uma ação Usar Magia, você pode enviar a vassoura para um destino a até 1,5 quilômetro de você, desde que nomeie o local e esteja familiarizado com ele. A vassoura retorna a você quando você executa uma ação Usar Magia e pronuncia uma palavra de comando, caso ela ainda esteja a 1,5 quilômetro de você.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"uncommon","rarityLabel":"Incomum","requiresAttunement":true,"header":"Item Maravilhoso, Incomum (Requer Sintonização)","attunement":"Requer Sintonização"}'::jsonb
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
  'vela-das-profundezas',
  'other'::rpg.item_type,
  'Vela das Profundezas',
  NULL,
  NULL,
  'A chama desta vela não se apaga quando mergulhada em água. Ela emite luz e calor como uma vela normal.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"common","rarityLabel":"Comum","requiresAttunement":false,"header":"Item Maravilhoso, Comum"}'::jsonb
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
  'vela-de-invocacao',
  'other'::rpg.item_type,
  'Vela de Invocação',
  NULL,
  NULL,
  'A magia da vela é ativada ao acendê-la, o que requer uma ação Usar Magia. Após queimar por 4 horas, a vela é destruída, mas pode ser apagada antes para uso posterior — deduza o tempo queimado em frações de 1 minuto do total de queima.
Enquanto estiver acesa, a vela emite Meia-luz em um raio de 9 metros. Dentro dessa luz, você tem Vantagem em Testes de D20. Além disso, Clérigos ou Druidas podem conjurar magias preparadas de 1º círculo sem gastar espaços de magia.
Como alternativa, ao acender a vela pela primeira vez, você pode conjurar Portal, o que a destrói. O portal criado se conecta a um Plano Externo específico escolhido pelo Mestre ou determinado através da tabela a seguir.
1d100 Plano Externo
01–05
	Abismo
	06–10
	Aqueronte
	11–17
	Arbórea
	18–25
	Arcádia
	26–33
	Terras Ferais
	34–41
	Bitopia
	42–46
	Cárceri
	47–54
	Elísio
	55–59
	Gehenna
	60–64
	Hades
	65–69
	Limbo
	70–77
	Mecânos
	78–85
	Monte Celéstia
	86–90
	Nove Infernos
	91–95
	Pandemônio
	96–00
	Ysgard
	Vela de Invocação: Destino do Plano Externo',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Item Maravilhoso","rarity":"very-rare","rarityLabel":"Muito Raro","requiresAttunement":true,"header":"Item Maravilhoso, Muito Raro (Requer Sintonização)","attunement":"Requer Sintonização"}'::jsonb
)
ON CONFLICT (slug) DO UPDATE SET
  item_type = EXCLUDED.item_type,
  name = EXCLUDED.name,
  cost = EXCLUDED.cost,
  weight = EXCLUDED.weight,
  description = EXCLUDED.description,
  properties = EXCLUDED.properties;
