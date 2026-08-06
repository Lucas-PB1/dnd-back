-- Encantos de Arma (Valdas Player Pack 2) — um item por raridade/variante

INSERT INTO rpg.phb_item (
  slug, item_type, name, cost, weight, description, properties
)
VALUES (
  'weapon-charm-arrowhead',
  'other'::rpg.item_type,
  'Encanto de Arma: Ponta de Flecha',
  NULL,
  NULL,
  'Este encanto dourado retrata uma ponta de flecha de pedra. Você pode realizar uma Ação Mágica para prender o encanto a uma arma, geralmente no pomo dela, ou removê-lo. Prender um encanto faz a arma se tornar uma arma mágica que requer sintonização. Uma arma só pode ter um encanto preso por vez.

Enquanto estiver preso a uma arma, seus ataques à distância com ela ignoram Meia Cobertura e Cobertura de Três Quartos.',
  '{"magic":true,"category":"Encanto de Arma","rarity":"uncommon","rarityLabel":"Incomum","requiresAttunement":true,"attunement":"Requer Sintonização","source":"valdas-spire-player-pack-2","editionSlug":"valdas-spire-2024-en","citationSlug":"valdas-spire-2024-en:player-pack-2","weaponCharm":{"kind":"arrowhead"}}'::jsonb
)
ON CONFLICT (slug) DO UPDATE SET
  item_type = EXCLUDED.item_type,
  name = EXCLUDED.name,
  cost = EXCLUDED.cost,
  weight = EXCLUDED.weight,
  description = EXCLUDED.description,
  properties = EXCLUDED.properties;

INSERT INTO rpg.phb_item (
  slug, item_type, name, cost, weight, description, properties
)
VALUES (
  'weapon-charm-blade-1',
  'other'::rpg.item_type,
  'Encanto de Arma: Lâmina +1',
  NULL,
  NULL,
  'Este encanto de adamantina se assemelha a uma espada longa em miniatura. Você pode realizar uma Ação Mágica para prender o encanto a uma arma, geralmente no pomo dela, ou removê-lo. Prender um encanto faz a arma se tornar uma arma mágica que requer sintonização. Uma arma só pode ter um encanto preso por vez.

Enquanto estiver preso a uma arma, você tem um bônus de +1 nas jogadas de ataque e dano feitas com esta arma mágica. Se a arma já tiver tal bônus, você escolhe qual bônus usar; não pode usar mais de um.',
  '{"magic":true,"category":"Encanto de Arma","rarity":"uncommon","rarityLabel":"Incomum","requiresAttunement":true,"attunement":"Requer Sintonização","source":"valdas-spire-player-pack-2","editionSlug":"valdas-spire-2024-en","citationSlug":"valdas-spire-2024-en:player-pack-2","weaponCharm":{"kind":"blade","attackBonus":1,"damageBonus":1}}'::jsonb
)
ON CONFLICT (slug) DO UPDATE SET
  item_type = EXCLUDED.item_type,
  name = EXCLUDED.name,
  cost = EXCLUDED.cost,
  weight = EXCLUDED.weight,
  description = EXCLUDED.description,
  properties = EXCLUDED.properties;

INSERT INTO rpg.phb_item (
  slug, item_type, name, cost, weight, description, properties
)
VALUES (
  'weapon-charm-blade-2',
  'other'::rpg.item_type,
  'Encanto de Arma: Lâmina +2',
  NULL,
  NULL,
  'Este encanto de adamantina se assemelha a uma espada longa em miniatura. Você pode realizar uma Ação Mágica para prender o encanto a uma arma, geralmente no pomo dela, ou removê-lo. Prender um encanto faz a arma se tornar uma arma mágica que requer sintonização. Uma arma só pode ter um encanto preso por vez.

Enquanto estiver preso a uma arma, você tem um bônus de +2 nas jogadas de ataque e dano feitas com esta arma mágica. Se a arma já tiver tal bônus, você escolhe qual bônus usar; não pode usar mais de um.',
  '{"magic":true,"category":"Encanto de Arma","rarity":"rare","rarityLabel":"Raro","requiresAttunement":true,"attunement":"Requer Sintonização","source":"valdas-spire-player-pack-2","editionSlug":"valdas-spire-2024-en","citationSlug":"valdas-spire-2024-en:player-pack-2","weaponCharm":{"kind":"blade","attackBonus":2,"damageBonus":2}}'::jsonb
)
ON CONFLICT (slug) DO UPDATE SET
  item_type = EXCLUDED.item_type,
  name = EXCLUDED.name,
  cost = EXCLUDED.cost,
  weight = EXCLUDED.weight,
  description = EXCLUDED.description,
  properties = EXCLUDED.properties;

INSERT INTO rpg.phb_item (
  slug, item_type, name, cost, weight, description, properties
)
VALUES (
  'weapon-charm-blade-3',
  'other'::rpg.item_type,
  'Encanto de Arma: Lâmina +3',
  NULL,
  NULL,
  'Este encanto de adamantina se assemelha a uma espada longa em miniatura. Você pode realizar uma Ação Mágica para prender o encanto a uma arma, geralmente no pomo dela, ou removê-lo. Prender um encanto faz a arma se tornar uma arma mágica que requer sintonização. Uma arma só pode ter um encanto preso por vez.

Enquanto estiver preso a uma arma, você tem um bônus de +3 nas jogadas de ataque e dano feitas com esta arma mágica. Se a arma já tiver tal bônus, você escolhe qual bônus usar; não pode usar mais de um.',
  '{"magic":true,"category":"Encanto de Arma","rarity":"very-rare","rarityLabel":"Muito Raro","requiresAttunement":true,"attunement":"Requer Sintonização","source":"valdas-spire-player-pack-2","editionSlug":"valdas-spire-2024-en","citationSlug":"valdas-spire-2024-en:player-pack-2","weaponCharm":{"kind":"blade","attackBonus":3,"damageBonus":3}}'::jsonb
)
ON CONFLICT (slug) DO UPDATE SET
  item_type = EXCLUDED.item_type,
  name = EXCLUDED.name,
  cost = EXCLUDED.cost,
  weight = EXCLUDED.weight,
  description = EXCLUDED.description,
  properties = EXCLUDED.properties;

INSERT INTO rpg.phb_item (
  slug, item_type, name, cost, weight, description, properties
)
VALUES (
  'weapon-charm-die',
  'other'::rpg.item_type,
  'Encanto de Arma: Dado',
  NULL,
  NULL,
  'Este encanto de prata retrata um dado de seis faces. Você pode realizar uma Ação Mágica para prender o encanto a uma arma, geralmente no pomo dela, ou removê-lo. Prender um encanto faz a arma se tornar uma arma mágica que requer sintonização. Uma arma só pode ter um encanto preso por vez.

Enquanto estiver preso a uma arma, ela causa acertos críticos mais potentes. Quando você marca um Acerto Crítico com esta arma, se rolar o número mais alto em qualquer dado de dano, pode rolar outro daquele dado e adicioná-lo ao dano. Você pode adicionar no máximo 5 dados à jogada de dano do ataque dessa forma.',
  '{"magic":true,"category":"Encanto de Arma","rarity":"uncommon","rarityLabel":"Incomum","requiresAttunement":true,"attunement":"Requer Sintonização","source":"valdas-spire-player-pack-2","editionSlug":"valdas-spire-2024-en","citationSlug":"valdas-spire-2024-en:player-pack-2","weaponCharm":{"kind":"die"}}'::jsonb
)
ON CONFLICT (slug) DO UPDATE SET
  item_type = EXCLUDED.item_type,
  name = EXCLUDED.name,
  cost = EXCLUDED.cost,
  weight = EXCLUDED.weight,
  description = EXCLUDED.description,
  properties = EXCLUDED.properties;

INSERT INTO rpg.phb_item (
  slug, item_type, name, cost, weight, description, properties
)
VALUES (
  'weapon-charm-flame',
  'other'::rpg.item_type,
  'Encanto de Arma: Chama',
  NULL,
  NULL,
  'Este encanto de latão se assemelha a um fogo ardente. Você pode realizar uma Ação Mágica para prender o encanto a uma arma, geralmente no pomo dela, ou removê-lo. Prender um encanto faz a arma se tornar uma arma mágica que requer sintonização. Uma arma só pode ter um encanto preso por vez.

Enquanto estiver preso a uma arma, ela causa dano Ígneo em vez do tipo de dano normal. Quando você acerta uma criatura ou objeto com esta arma, ela começa a Queimar por 1 minuto. Se você acertar novamente um alvo Queimando com esta arma, o dano que o alvo Queimando sofre no início de cada um de seus turnos aumenta em um passo (d4 → d6 → d8 → d10 → d12, até o máximo de 1d12).',
  '{"magic":true,"category":"Encanto de Arma","rarity":"uncommon","rarityLabel":"Incomum","requiresAttunement":true,"attunement":"Requer Sintonização","source":"valdas-spire-player-pack-2","editionSlug":"valdas-spire-2024-en","citationSlug":"valdas-spire-2024-en:player-pack-2","weaponCharm":{"kind":"flame","damageTypeOverride":"Ígneo"}}'::jsonb
)
ON CONFLICT (slug) DO UPDATE SET
  item_type = EXCLUDED.item_type,
  name = EXCLUDED.name,
  cost = EXCLUDED.cost,
  weight = EXCLUDED.weight,
  description = EXCLUDED.description,
  properties = EXCLUDED.properties;

INSERT INTO rpg.phb_item (
  slug, item_type, name, cost, weight, description, properties
)
VALUES (
  'weapon-charm-hook',
  'other'::rpg.item_type,
  'Encanto de Arma: Gancho',
  NULL,
  NULL,
  'Este encanto de bronze tem forma de anzol. Você pode realizar uma Ação Mágica para prender o encanto a uma arma, geralmente no pomo dela, ou removê-lo. Prender um encanto faz a arma se tornar uma arma mágica que requer sintonização. Uma arma só pode ter um encanto preso por vez.

Enquanto estiver preso a uma arma, se a arma estiver no mesmo plano de existência que você, pode realizar uma Ação Bônus para teleportá-la até sua mão.',
  '{"magic":true,"category":"Encanto de Arma","rarity":"common","rarityLabel":"Comum","requiresAttunement":true,"attunement":"Requer Sintonização","source":"valdas-spire-player-pack-2","editionSlug":"valdas-spire-2024-en","citationSlug":"valdas-spire-2024-en:player-pack-2","weaponCharm":{"kind":"hook"}}'::jsonb
)
ON CONFLICT (slug) DO UPDATE SET
  item_type = EXCLUDED.item_type,
  name = EXCLUDED.name,
  cost = EXCLUDED.cost,
  weight = EXCLUDED.weight,
  description = EXCLUDED.description,
  properties = EXCLUDED.properties;

INSERT INTO rpg.phb_item (
  slug, item_type, name, cost, weight, description, properties
)
VALUES (
  'weapon-charm-spear',
  'other'::rpg.item_type,
  'Encanto de Arma: Lança',
  NULL,
  NULL,
  'Este encanto de cobre retrata uma lança curta. Você pode realizar uma Ação Mágica para prender o encanto a uma arma, geralmente no pomo dela, ou removê-lo. Prender um encanto faz a arma se tornar uma arma mágica que requer sintonização. Uma arma só pode ter um encanto preso por vez.

Enquanto estiver preso a uma arma, uma vez em cada um de seus turnos, quando você fizer uma jogada de ataque corpo a corpo com esta arma contra uma criatura que possa ver, pode avançar até 15 pés em direção ao alvo antes de fazer o ataque. Este movimento não provoca Ataques de Oportunidade. Você pode realizar este movimento mesmo que o faça atravessar o ar, embora caia após o ataque se nada o mantiver no alto.',
  '{"magic":true,"category":"Encanto de Arma","rarity":"uncommon","rarityLabel":"Incomum","requiresAttunement":true,"attunement":"Requer Sintonização","source":"valdas-spire-player-pack-2","editionSlug":"valdas-spire-2024-en","citationSlug":"valdas-spire-2024-en:player-pack-2","weaponCharm":{"kind":"spear"}}'::jsonb
)
ON CONFLICT (slug) DO UPDATE SET
  item_type = EXCLUDED.item_type,
  name = EXCLUDED.name,
  cost = EXCLUDED.cost,
  weight = EXCLUDED.weight,
  description = EXCLUDED.description,
  properties = EXCLUDED.properties;

INSERT INTO rpg.phb_item (
  slug, item_type, name, cost, weight, description, properties
)
VALUES (
  'weapon-charm-lightning',
  'other'::rpg.item_type,
  'Encanto de Arma: Raio',
  NULL,
  NULL,
  'Este encanto de mithral retrata um raio selvagem. Você pode realizar uma Ação Mágica para prender o encanto a uma arma, geralmente no pomo dela, ou removê-lo. Prender um encanto faz a arma se tornar uma arma mágica que requer sintonização. Uma arma só pode ter um encanto preso por vez.

Enquanto estiver preso a uma arma, ela causa dano Elétrico em vez do tipo de dano normal e causa 1d6 de dano Elétrico extra em um acerto.',
  '{"magic":true,"category":"Encanto de Arma","rarity":"rare","rarityLabel":"Raro","requiresAttunement":true,"attunement":"Requer Sintonização","source":"valdas-spire-player-pack-2","editionSlug":"valdas-spire-2024-en","citationSlug":"valdas-spire-2024-en:player-pack-2","weaponCharm":{"kind":"lightning","damageTypeOverride":"Elétrico","extraDamageDice":"1d6"}}'::jsonb
)
ON CONFLICT (slug) DO UPDATE SET
  item_type = EXCLUDED.item_type,
  name = EXCLUDED.name,
  cost = EXCLUDED.cost,
  weight = EXCLUDED.weight,
  description = EXCLUDED.description,
  properties = EXCLUDED.properties;

INSERT INTO rpg.phb_item (
  slug, item_type, name, cost, weight, description, properties
)
VALUES (
  'weapon-charm-quiver',
  'other'::rpg.item_type,
  'Encanto de Arma: Aljava',
  NULL,
  NULL,
  'Este encanto de quartzo se assemelha a uma aljava eriçada de flechas. Você pode realizar uma Ação Mágica para prender o encanto a uma arma, geralmente no pomo dela, ou removê-lo. Prender um encanto faz a arma se tornar uma arma mágica que requer sintonização. Uma arma só pode ter um encanto preso por vez.

Enquanto estiver preso a uma arma, ela ignora a propriedade Recarga. A munição que você estiver carregando se teleporta para a arma quando necessário.',
  '{"magic":true,"category":"Encanto de Arma","rarity":"uncommon","rarityLabel":"Incomum","requiresAttunement":true,"attunement":"Requer Sintonização","source":"valdas-spire-player-pack-2","editionSlug":"valdas-spire-2024-en","citationSlug":"valdas-spire-2024-en:player-pack-2","weaponCharm":{"kind":"quiver"}}'::jsonb
)
ON CONFLICT (slug) DO UPDATE SET
  item_type = EXCLUDED.item_type,
  name = EXCLUDED.name,
  cost = EXCLUDED.cost,
  weight = EXCLUDED.weight,
  description = EXCLUDED.description,
  properties = EXCLUDED.properties;
