-- Espécies — Northlands Heroes of the Sagas (Wave 2)

INSERT INTO rpg.phb_species (
  slug, name, creature_type, size, speed, description, source_meta
)
VALUES
(
  'bearfolk',
  'Povo-urso',
  'Humanoide',
  'Médio (cerca de 2,10 m; 110–160 kg)',
  '9 metros',
  'O povo-urso une força ursina a espírito indomável. Grandes e musculosos, chegam a mais de 2 m e pesam entre 110 e 160 kg. Predadores de ápice nas terras nórdicas, dividem-se em linhagens como Andari (purificadores) e Garhamr (peliças grisalhas).',
  '{"editionSlug":"northlands-heroes-2024-en","book":"Northlands Worldbook: Heroes of the Sagas","language":"pt","citationSlug":"northlands-heroes-2024-en:heroes-of-the-sagas","source":"northlands-heroes"}'::jsonb
),
(
  'beastkin',
  'Povo-fera',
  'Humanoide',
  'Médio (cerca de 1,20–2,40 m) ou Pequeno (cerca de 0,60–1,20 m), escolhido ao selecionar esta espécie',
  '9 metros',
  'O povo-fera (também chamado wildkin) carrega características animais — asas, garras, escamas ou pelegos — e adaptações naturais à caça, ao mar, ao vôo ou à resistência. Cada um manifesta um instinto animal e armas naturais.',
  '{"editionSlug":"northlands-heroes-2024-en","book":"Northlands Worldbook: Heroes of the Sagas","language":"pt","citationSlug":"northlands-heroes-2024-en:heroes-of-the-sagas","source":"northlands-heroes"}'::jsonb
),
(
  'giantkin',
  'Giganteide',
  'Humanoide',
  'Médio (altura varia)',
  '9 metros',
  'Giganteides descendem de linhagens jotun. Herdam resistência a ambientes extremos e dons sobrenaturais conforme a ancestria — nuvem, fogo, geada, colina, pedra ou tempestade — além de constituição poderosa e reflexos para interceptar projéteis.',
  '{"editionSlug":"northlands-heroes-2024-en","book":"Northlands Worldbook: Heroes of the Sagas","language":"pt","citationSlug":"northlands-heroes-2024-en:heroes-of-the-sagas","source":"northlands-heroes"}'::jsonb
),
(
  'trollkin',
  'Trollide',
  'Humanoide',
  'Médio (cerca de 1,80–2,10 m)',
  '9 metros',
  'Trollides carregam sangue de ancestrais não humanos — fey, ogro ou troll. Visão no escuro profunda, armas naturais e regeneração trollística os marcam como sobreviventes duros das terras nórdicas.',
  '{"editionSlug":"northlands-heroes-2024-en","book":"Northlands Worldbook: Heroes of the Sagas","language":"pt","citationSlug":"northlands-heroes-2024-en:heroes-of-the-sagas","source":"northlands-heroes"}'::jsonb
),
(
  'werekin',
  'Homem-fera',
  'Humanoide',
  'Médio (cerca de 1,50–1,80 m)',
  '9 metros',
  'Homens-fera herdam o poder licantropo dos antepassados. Garras, faro e a capacidade de assumir um aspecto primal por um minuto os tornam caçadores temidos — e heróis quando dominam a besta interior.',
  '{"editionSlug":"northlands-heroes-2024-en","book":"Northlands Worldbook: Heroes of the Sagas","language":"pt","citationSlug":"northlands-heroes-2024-en:heroes-of-the-sagas","source":"northlands-heroes"}'::jsonb
),
(
  'baugsmidr-dwarf',
  'Anão Baugsmidr',
  'Humanoide',
  'Médio (cerca de 1,20–1,50 m)',
  '9 metros',
  'Anões Baugsmidr (“anões dos anéis”) substituem o pacote de traços anões comuns por afinidade arcana: lore mágica, visão profunda, resiliência, crafteria mágica e o dom de sentir magia e criaturas de outros mundos.',
  '{"editionSlug":"northlands-heroes-2024-en","book":"Northlands Worldbook: Heroes of the Sagas","language":"pt","citationSlug":"northlands-heroes-2024-en:heroes-of-the-sagas","source":"northlands-heroes","variantOf":"dwarf"}'::jsonb
),
(
  'fjord-dwarf',
  'Anão dos Fiordes',
  'Humanoide',
  'Médio (cerca de 1,20–1,50 m)',
  '9 metros',
  'Anões dos fiordes substituem o pacote de traços anões comuns por vida costeira: visão no escuro, tenacidade, combate em terreno difícil e maestria nas ondas (natação e fôlego prolongado).',
  '{"editionSlug":"northlands-heroes-2024-en","book":"Northlands Worldbook: Heroes of the Sagas","language":"pt","citationSlug":"northlands-heroes-2024-en:heroes-of-the-sagas","source":"northlands-heroes","variantOf":"dwarf"}'::jsonb
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  creature_type = EXCLUDED.creature_type,
  size = EXCLUDED.size,
  speed = EXCLUDED.speed,
  description = EXCLUDED.description,
  source_meta = EXCLUDED.source_meta;
