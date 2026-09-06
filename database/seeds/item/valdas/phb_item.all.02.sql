-- Seed Valdas Player Pack 2 magic items

INSERT INTO rpg.phb_item (
  slug, item_type, name, cost, weight, description, properties
)
VALUES (
  'bag-of-cheer',
  'other'::rpg.item_type,
  'Bolsa da Alegria',
  NULL,
  NULL,
  'Este saco grande, que pesa 30 libras e é feito de veludo vermelho, parece estar cheio de presentes em embalagens coloridas. Como uma Ação Mágica, você pode retirar um presente da bolsa e dá-lo a outra criatura. O presente é feito sob medida para o destinatário; o Mestre determina sua natureza ou rola na tabela Presentes. O valor do presente não pode exceder 100 PO.

Depois que três presentes forem retirados da bolsa, ela não poderá ser usada novamente até o próximo amanhecer. Quaisquer presentes adicionais removidos da bolsa são caixas vazias, porém bem decoradas.

Presentes

d10
Presente

1
Uma arma ou Escudo

2
Peças de Ouro

3
Um objeto de arte

4
Roupas Finas

5
Uma ferramenta ou Instrumento Musical

6
Uma Poção de Cura

7
Gemas

8
Uma comida exótica

9
Um Livro

10
Um brinquedo ou Kit de Jogos',
  '{"magic":true,"category":"Item Maravilhoso","rarity":"very-rare","rarityLabel":"Muito Raro","requiresAttunement":false,"source":"valdas-spire-player-pack-2","editionSlug":"valdas-spire-2024-en","citationSlug":"valdas-spire-2024-en:player-pack-2"}'::jsonb
)
ON CONFLICT (slug) DO UPDATE SET
  item_type = EXCLUDED.item_type,
  name = EXCLUDED.name,
  cost = EXCLUDED.cost,
  weight = EXCLUDED.weight,
  description = EXCLUDED.description,
  properties = EXCLUDED.properties;

INSERT INTO rpg.phb_item (
  slug, item_type, name, cost, weight, description, properties
)
VALUES (
  'gambler-s-coin',
  'other'::rpg.item_type,
  'Moeda do Apostador',
  NULL,
  NULL,
  'Esta Peça de Ouro tem riscos profundos em um dos lados. Ela tem 3 cargas e recupera todas as cargas gastas diariamente ao amanhecer. Quando você fizer um Teste de D20, pode gastar 1 carga para substituir a rolagem do d20 por um cara ou coroa. Em cara, a rolagem é tratada como 20 (embora você não marque um Acerto Crítico com uma jogada de ataque nem ative quaisquer outros efeitos que se desencadeiem ao rolar 20). Em coroa, a rolagem é tratada como 1.',
  '{"magic":true,"category":"Item Maravilhoso","rarity":"rare","rarityLabel":"Raro","requiresAttunement":true,"attunement":"Requer Sintonização","source":"valdas-spire-player-pack-2","editionSlug":"valdas-spire-2024-en","citationSlug":"valdas-spire-2024-en:player-pack-2"}'::jsonb
)
ON CONFLICT (slug) DO UPDATE SET
  item_type = EXCLUDED.item_type,
  name = EXCLUDED.name,
  cost = EXCLUDED.cost,
  weight = EXCLUDED.weight,
  description = EXCLUDED.description,
  properties = EXCLUDED.properties;

INSERT INTO rpg.phb_item (
  slug, item_type, name, cost, weight, description, properties
)
VALUES (
  'leaden-manacles',
  'other'::rpg.item_type,
  'Algemas de Chumbo',
  NULL,
  NULL,
  'Estas Algemas mágicas são usadas para restringir conjuradores. Quando uma criatura tenta conjurar uma magia ou realizar a Ação Mágica enquanto está presa com estas Algemas, ela faz um teste de atributo CD 20 usando seu atributo de conjuração. Em caso de falha, a magia ou Ação Mágica falha e a criatura sofre 4d6 de dano Ígneo. O espaço de magia ou o uso daquela Ação Mágica é desperdiçado, assim como a ação, Ação Bônus ou Reação utilizada.',
  '{"magic":true,"category":"Item Maravilhoso","rarity":"uncommon","rarityLabel":"Incomum","requiresAttunement":false,"source":"valdas-spire-player-pack-2","editionSlug":"valdas-spire-2024-en","citationSlug":"valdas-spire-2024-en:player-pack-2","combatNotes":["Em conjurador preso: teste CD 20 no atributo de conjuração ou magia/Ação Mágica falha e 4d6 Ígneo."]}'::jsonb
)
ON CONFLICT (slug) DO UPDATE SET
  item_type = EXCLUDED.item_type,
  name = EXCLUDED.name,
  cost = EXCLUDED.cost,
  weight = EXCLUDED.weight,
  description = EXCLUDED.description,
  properties = EXCLUDED.properties;

INSERT INTO rpg.phb_item (
  slug, item_type, name, cost, weight, description, properties
)
VALUES (
  'nolzur-s-painted-world',
  'other'::rpg.item_type,
  'Mundo Pintado de Nolzur',
  NULL,
  NULL,
  'Esta pintura magistral, que é Média ou Grande, foi criada por um mestre pintor usando pelo menos dez potes de Pigmentos Maravilhosos de Nolzur. A pintura retrata um mundo pintado sereno e funciona como um portal para um semiplano no qual aquele mundo existe. Criaturas do tamanho da pintura ou menores podem atravessar o portal para o semiplano.

Dentro do mundo pintado, um portal para o mundo real aparece como um arco enevoado. Se a face da pintura estiver bloqueada, o arco enevoado no semiplano desaparece. A localização, os objetos e as criaturas retratados no mundo pintado são determinados pelo criador da pintura. Tais objetos e criaturas se dissipam em fumaça se forem removidos da pintura. O tempo passa com metade da velocidade dentro do mundo pintado.',
  '{"magic":true,"category":"Item Maravilhoso","rarity":"legendary","rarityLabel":"Lendário","requiresAttunement":false,"source":"valdas-spire-player-pack-2","editionSlug":"valdas-spire-2024-en","citationSlug":"valdas-spire-2024-en:player-pack-2"}'::jsonb
)
ON CONFLICT (slug) DO UPDATE SET
  item_type = EXCLUDED.item_type,
  name = EXCLUDED.name,
  cost = EXCLUDED.cost,
  weight = EXCLUDED.weight,
  description = EXCLUDED.description,
  properties = EXCLUDED.properties;

INSERT INTO rpg.phb_item (
  slug, item_type, name, cost, weight, description, properties
)
VALUES (
  'reaper-s-ammunition',
  'other'::rpg.item_type,
  'Munição da Ceifadora',
  NULL,
  NULL,
  'Se uma criatura sofrer dano desta munição mágica, ela morre. A munição então se torna não mágica.',
  '{"magic":true,"category":"Munição","rarity":"legendary","rarityLabel":"Lendário","requiresAttunement":false,"source":"valdas-spire-player-pack-2","editionSlug":"valdas-spire-2024-en","citationSlug":"valdas-spire-2024-en:player-pack-2","combatNotes":["Criatura que sofre dano desta munição morre; a munição se torna não mágica."]}'::jsonb
)
ON CONFLICT (slug) DO UPDATE SET
  item_type = EXCLUDED.item_type,
  name = EXCLUDED.name,
  cost = EXCLUDED.cost,
  weight = EXCLUDED.weight,
  description = EXCLUDED.description,
  properties = EXCLUDED.properties;

INSERT INTO rpg.phb_item (
  slug, item_type, name, cost, weight, description, properties
)
VALUES (
  'soul-figurine',
  'other'::rpg.item_type,
  'Figurinha da Alma',
  NULL,
  NULL,
  'Esta figurinha sorridente em forma humana contém uma reserva de força vital. Se você cair a 0 Pontos de Vida enquanto estiver sintonizado com a figurinha, role 2d10 + 10. Seus Pontos de Vida passam a ser o número rolado. A expressão da figurinha se torna pesarosa e ela se torna não mágica.',
  '{"magic":true,"category":"Item Maravilhoso","rarity":"uncommon","rarityLabel":"Incomum","requiresAttunement":true,"attunement":"Requer Sintonização","source":"valdas-spire-player-pack-2","editionSlug":"valdas-spire-2024-en","citationSlug":"valdas-spire-2024-en:player-pack-2"}'::jsonb
)
ON CONFLICT (slug) DO UPDATE SET
  item_type = EXCLUDED.item_type,
  name = EXCLUDED.name,
  cost = EXCLUDED.cost,
  weight = EXCLUDED.weight,
  description = EXCLUDED.description,
  properties = EXCLUDED.properties;

-- Encantos de Arma: ver P011_weapon_charms.sql (itens individuais por kind/raridade).
