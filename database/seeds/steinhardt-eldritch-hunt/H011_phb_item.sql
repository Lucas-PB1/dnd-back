-- Itens de pacote Eldritch Hunt necessários aos antecedentes (flare, ferramentas, marca, algemas)
-- Descrições completas de Canhão / Marca Sacrificial ficam para o capítulo de itens.

INSERT INTO rpg.phb_item (slug, item_type, name, cost, weight, description, properties)
VALUES
  (
    'flare',
    'gear'::rpg.item_type,
    'Sinalizador',
    '{"text":"1 PO"}'::jsonb,
    '0,5 kg',
    'Um sinalizador de caça usado para marcar posição ou atrair atenção durante a Noite da Caça. Acende-se como uma ação e emite luz intensa por 1 minuto (detalhe de mesa a critério do Mestre).',
    '{"source":"steinhardt-eldritch-hunt","editionSlug":"steinhardt-eldritch-hunt-2024-en","citationSlug":"steinhardt-eldritch-hunt-2024-en:player-pack"}'::jsonb
  ),
  (
    'algemas',
    'gear'::rpg.item_type,
    'Algemas',
    '{"text":"2 PO"}'::jsonb,
    '3 kg',
    'Algemas para prender uma criatura Pequena ou Média. Escapar exige teste de Destreza (Prestidigitação) CD 20; quebrar exige teste de Força CD 20 (detalhe de mesa a critério do Mestre).',
    '{"source":"steinhardt-eldritch-hunt","editionSlug":"steinhardt-eldritch-hunt-2024-en","citationSlug":"steinhardt-eldritch-hunt-2024-en:player-pack"}'::jsonb
  ),
  (
    'torture-tools',
    'tool'::rpg.item_type,
    'Ferramentas de Tortura',
    '{"text":"10 PO"}'::jsonb,
    '2 kg',
    'Ferramentas usadas por inquisidores da Igreja Radiante para interrogatório. O Mestre determina usos e CDs em jogo.',
    '{"source":"steinhardt-eldritch-hunt","editionSlug":"steinhardt-eldritch-hunt-2024-en","citationSlug":"steinhardt-eldritch-hunt-2024-en:player-pack"}'::jsonb
  ),
  (
    'sacrificial-brand',
    'other'::rpg.item_type,
    'Marca Sacrificial',
    NULL,
    NULL,
    'Entalhe Eldritch (raridade varia). A marca — também chamada Marca da Morte — é um prenúncio temido: durante a Lua de Sangue atrai bestas e caçadores. Aplicar um Entalhe Eldritch leva 1 hora (pode ser parte de um Descanso Curto). Remover exige queimar a carne (entálhes escarificados não podem ser removidos). Variantes Desenhada / Tatuada / Escarificada têm efeitos distintos (ver capítulo de itens do Player Pack).',
    '{"magic":true,"category":"Entalhe Eldritch","rarity":"varies","rarityLabel":"Raridade varia","requiresAttunement":true,"source":"steinhardt-eldritch-hunt","editionSlug":"steinhardt-eldritch-hunt-2024-en","citationSlug":"steinhardt-eldritch-hunt-2024-en:player-pack"}'::jsonb
  )
ON CONFLICT (slug) DO UPDATE SET
  item_type = EXCLUDED.item_type,
  name = EXCLUDED.name,
  cost = EXCLUDED.cost,
  weight = EXCLUDED.weight,
  description = EXCLUDED.description,
  properties = EXCLUDED.properties;

INSERT INTO rpg.phb_tool (item_id, category_id, use_description)
VALUES (
  (SELECT id FROM rpg.phb_item WHERE slug = 'torture-tools'),
  (SELECT id FROM rpg.phb_tool_category WHERE slug = 'kit'),
  'Interrogar ou coagir (CD a critério do Mestre)'
)
ON CONFLICT (item_id) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  use_description = EXCLUDED.use_description;
