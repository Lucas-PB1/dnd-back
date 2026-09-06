-- Seed Valdas magic items
-- Conteúdo canônico Valdas: Spire of Secrets

INSERT INTO rpg.phb_item (
  slug, item_type, name, cost, weight, description, properties
)
VALUES (
  'frog-prince-statuette',
  'other'::rpg.item_type,
  'Estatueta do Príncipe Sapo',
  NULL,
  NULL,
  'Enquanto segura esta estatueta de argila de um sapo, você pode falar sua palavra de comando e beijá-la para lançar a magia Seguidor Feral de Mandy, transformando a estatueta em um Plebeu. O plebeu criado pela estatueta retém as memórias de cada vez que ela é transformada, não importa a aparência que você atribua a ele.

Depois de usada, a estatueta não poderá se transformar novamente até o próximo amanhecer.',
  '{"magic":true,"category":"Item Maravilhoso","rarity":"rare","rarityLabel":"Raro","requiresAttunement":false,"source":"valdas-spire-player-pack","editionSlug":"valdas-spire-2024-en","citationSlug":"valdas-spire-2024-en:player-pack"}'::jsonb
)
ON CONFLICT (slug) DO UPDATE SET
  item_type = EXCLUDED.item_type,
  name = EXCLUDED.name,
  cost = EXCLUDED.cost,
  weight = EXCLUDED.weight,
  description = EXCLUDED.description,
  properties = EXCLUDED.properties;

INSERT INTO rpg.phb_item (
  slug, item_type, name, cost, weight, description, properties
)
VALUES (
  'leonora-s-throne-of-indolence',
  'other'::rpg.item_type,
  'Trono da Indolência de Leonora',
  NULL,
  '100 libras',
  'Esta poltrona de encosto alto feita de carvalho e ouro pesa 100 libras. Quando você se senta nele e fala sua palavra de comando como uma Ação Mágica, ele paira abaixo de você e pode voar pelo ar. O trono tem um Deslocamento de Voo de 50 pés, pode pairar e carregar até 400 libras. O trono para de pairar quando você pronuncia sua palavra de comando novamente.

Ao falar uma segunda palavra de comando, você pode lançar Servo Invisível usando o trono. O servo pode conjurar uma trombeta espectral para anunciar sua chegada, além de suas tarefas habituais.

Por último, você pode falar uma terceira palavra de comando como Ação Mágica para criar magicamente até 10 libras de comida deliciosa de sua escolha e até quatro garrafas de vinho. Só você pode participar desta refeição e beber; torna-se instantaneamente rançoso e nauseante na boca de outra criatura. Depois de ter falado esta terceira palavra de comando, você não poderá fazê-lo novamente até o próximo amanhecer.',
  '{"magic":true,"category":"Item Maravilhoso","rarity":"very-rare","rarityLabel":"Muito Raro","requiresAttunement":true,"attunement":"Requer Sintonização","source":"valdas-spire-player-pack","editionSlug":"valdas-spire-2024-en","citationSlug":"valdas-spire-2024-en:player-pack"}'::jsonb
)
ON CONFLICT (slug) DO UPDATE SET
  item_type = EXCLUDED.item_type,
  name = EXCLUDED.name,
  cost = EXCLUDED.cost,
  weight = EXCLUDED.weight,
  description = EXCLUDED.description,
  properties = EXCLUDED.properties;

INSERT INTO rpg.phb_item (
  slug, item_type, name, cost, weight, description, properties
)
VALUES (
  'memento-mori',
  'other'::rpg.item_type,
  'Memento Mori',
  NULL,
  NULL,
  'Esta carta selada, infundida com magia de Cronomancia, contém uma descrição escrita de como a criatura que a lê morrerá. A carta sempre contém descrições específicas, como “O orc de olhos vermelhos enfiou sua lâmina no coração de Faizon, o Azul”, mas também pode usar linguagem enigmática ou vaga. Nunca especifica uma hora exata. Uma vez que uma criatura tenha lido a carta, ela terá Vantagem em Salvaguardas contra a Morte e morrerá somente após obter cinco falhas no Salvaguarda contra a Morte, em vez de três. Porém, quando a criatura chega ao momento de sua morte descrito na carta, ela morre sem fazer Salvaguardas contra a Morte se for reduzida a 0 Pontos de Vida.

Depois que um Memento Mori é aberto e lido, ele se torna uma carta comum. Seus efeitos terminam apenas se a criatura que o leu morrer e mais tarde for restaurada à vida.',
  '{"magic":true,"category":"Item Maravilhoso","rarity":"rare","rarityLabel":"Raro","requiresAttunement":false,"source":"valdas-spire-player-pack","editionSlug":"valdas-spire-2024-en","citationSlug":"valdas-spire-2024-en:player-pack","combatNotes":["Após ler: Vantagem em Salvaguardas contra a Morte; morre só com 5 falhas (exceto morte descrita na carta)."]}'::jsonb
)
ON CONFLICT (slug) DO UPDATE SET
  item_type = EXCLUDED.item_type,
  name = EXCLUDED.name,
  cost = EXCLUDED.cost,
  weight = EXCLUDED.weight,
  description = EXCLUDED.description,
  properties = EXCLUDED.properties;

INSERT INTO rpg.phb_item (
  slug, item_type, name, cost, weight, description, properties
)
VALUES (
  'portable-cannonballs',
  'weapon'::rpg.item_type,
  'Bolas de Canhão Portáteis',
  NULL,
  NULL,
  'Este saco contém vinte bolas de ferro, cada uma medindo uma polegada de diâmetro e pesando 1/4 de libra. Quando retiradas do saco como uma ação Utilizar, as bolas funcionam como rolamentos de esferas.

Como uma Ação Bônus, você pode falar a palavra de comando, o que faz com que várias bolas que você escolher se expandam em balas de canhão de tamanho real, pesando 10 libras cada, adequadas para disparar de um canhão. Uma criatura no caminho de uma ou mais balas de canhão rolando colina abaixo deve ser bem sucedida em uma salvaguarda de Destreza CD 13 ou sofrerá 2d10 de dano Contundente e terá a condição Caído se for Grande ou menor.

Cada bola de ferro também pode ser usada como Bala de Funda ou Bala de Arma de Fogo. Como uma Ação Bônus, ao fazer um ataque com uma bola de ferro como munição, você pode expandi-la no ar. Se acertar, este ataque causa dano Contundente igual a 2d12 mais o modificador de habilidade usado para a jogada de ataque em vez do dano normal da arma.',
  '{"magic":true,"category":"Arma (Bala)","rarity":"uncommon","rarityLabel":"Incomum","requiresAttunement":false,"weaponSubtype":"Bala","source":"valdas-spire-player-pack","editionSlug":"valdas-spire-2024-en","citationSlug":"valdas-spire-2024-en:player-pack"}'::jsonb
)
ON CONFLICT (slug) DO UPDATE SET
  item_type = EXCLUDED.item_type,
  name = EXCLUDED.name,
  cost = EXCLUDED.cost,
  weight = EXCLUDED.weight,
  description = EXCLUDED.description,
  properties = EXCLUDED.properties;

INSERT INTO rpg.phb_item (
  slug, item_type, name, cost, weight, description, properties
)
VALUES (
  'ring-of-barrels',
  'other'::rpg.item_type,
  'Anel dos Barris',
  NULL,
  NULL,
  'Este anel tem 6 cargas e recupera 1d6 cargas gastas diariamente ao amanhecer. Enquanto estiver usando o anel, você pode realizar uma Ação Mágica e gastar de 1–3 cargas para invocar um número de barris vazios em espaços a até 5 pés de você, igual ao número de cargas gastas. Um Barril fornece Meia Cobertura para um alvo Médio ou menor atrás dele e pode ser movido ou colocado em movimento com uma ação Utilizar. Um Barril tem CA 15 e 20 PV.

Se você invocar um Barril em um espaço ocupado por uma criatura Média ou menor, a criatura deve ser bem sucedida em uma salvaguarda de Destreza CD 13 para ficar presa dentro do Barril. Ele tem Vantagem em sua salvaguarda, a menos que sua Velocidade seja 0. Uma criatura Média presa dentro de um Barril tem a condição Contido, enquanto uma criatura Pequena ou menor tem Cobertura Total contra efeitos fora do Barril. Libertar-se do Barril requer um teste bem sucedido de Força (Atletismo) CD 20 como uma ação.',
  '{"magic":true,"category":"Anel","rarity":"uncommon","rarityLabel":"Incomum","requiresAttunement":true,"attunement":"Requer Sintonização","source":"valdas-spire-player-pack","editionSlug":"valdas-spire-2024-en","citationSlug":"valdas-spire-2024-en:player-pack"}'::jsonb
)
ON CONFLICT (slug) DO UPDATE SET
  item_type = EXCLUDED.item_type,
  name = EXCLUDED.name,
  cost = EXCLUDED.cost,
  weight = EXCLUDED.weight,
  description = EXCLUDED.description,
  properties = EXCLUDED.properties;
