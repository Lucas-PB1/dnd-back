-- Armaduras e equipamento de aventura mundanos — Northlands Cap. 5
-- (sem montarias / trenós / longships — alinhar modelo de veículo antes)

-- —— Armaduras ——
INSERT INTO rpg.phb_item (slug, item_type, name, cost, weight, description, properties)
VALUES
  (
    'walrus-hide',
    'armor'::rpg.item_type,
    'Pele de Morsa',
    '{"text":"75 PO"}'::jsonb,
    '10 kg',
    'Trajes espessos de pele de morsa tratada: flexíveis, porém pesados. Além da proteção, contam como roupa de inverno ao determinar os efeitos de frio extremo.',
    '{"acFormula":{"type":"dex-plus-base","base":13,"dexMax":2},"propertyIds":[],"source":"northlands-heroes","countsAsWinterClothing":true}'::jsonb
  ),
  (
    'hardened-mail-shirt',
    'armor'::rpg.item_type,
    'Camisa de Malha Endurecida',
    '{"text":"500 PO"}'::jsonb,
    '20 kg',
    'Camisa de malha com anéis de adamantina ou mithral tecidos em pontos-chave, oferecendo mais proteção que a malha comum.',
    '{"acFormula":{"type":"dex-plus-base","base":15,"dexMax":2},"propertyIds":["stealth-disadvantage","strength-requirement"],"source":"northlands-heroes"}'::jsonb
  ),
  (
    'beinagrind',
    'armor'::rpg.item_type,
    'Beinagrind',
    '{"text":"50 PO"}'::jsonb,
    '20 kg',
    'Armadura feita de discos ou telhas curtas de osso de baleia ou gigante, atados a um forro de couro flexível.',
    '{"acFormula":{"type":"fixed","base":15},"propertyIds":["stealth-disadvantage","strength-requirement"],"source":"northlands-heroes"}'::jsonb
  ),
  (
    'double-mail',
    'armor'::rpg.item_type,
    'Malha Dupla',
    '{"text":"350 PO"}'::jsonb,
    '32,5 kg',
    'Também chamada tvifold brynja: os anéis desta cota de malha são dobrados, de modo que cada par é atravessado por quatro outros pares. Muito pesada e volumosa.',
    '{"acFormula":{"type":"fixed","base":17},"propertyIds":["stealth-disadvantage","strength-requirement"],"source":"northlands-heroes"}'::jsonb
  )
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  cost = EXCLUDED.cost,
  weight = EXCLUDED.weight,
  description = EXCLUDED.description,
  properties = EXCLUDED.properties,
  item_type = EXCLUDED.item_type;

INSERT INTO rpg.phb_armor (item_id, category_id, ac_base, ac_formula, strength_req, stealth_disadvantage)
VALUES
  (
    (SELECT id FROM rpg.phb_item WHERE slug = 'walrus-hide'),
    (SELECT id FROM rpg.phb_armor_category WHERE slug = 'medium'),
    13,
    '13 + modificador de Des (máx. 2)',
    NULL,
    FALSE
  ),
  (
    (SELECT id FROM rpg.phb_item WHERE slug = 'hardened-mail-shirt'),
    (SELECT id FROM rpg.phb_armor_category WHERE slug = 'medium'),
    15,
    '15 + modificador de Des (máx. 2)',
    13,
    TRUE
  ),
  (
    (SELECT id FROM rpg.phb_item WHERE slug = 'beinagrind'),
    (SELECT id FROM rpg.phb_armor_category WHERE slug = 'heavy'),
    15,
    '15',
    13,
    TRUE
  ),
  (
    (SELECT id FROM rpg.phb_item WHERE slug = 'double-mail'),
    (SELECT id FROM rpg.phb_armor_category WHERE slug = 'heavy'),
    17,
    '17',
    16,
    TRUE
  )
ON CONFLICT (item_id) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  ac_base = EXCLUDED.ac_base,
  ac_formula = EXCLUDED.ac_formula,
  strength_req = EXCLUDED.strength_req,
  stealth_disadvantage = EXCLUDED.stealth_disadvantage;

-- —— Equipamento de aventura ——
INSERT INTO rpg.phb_item (slug, item_type, name, cost, weight, description, properties)
VALUES
  (
    'jotunskull-helm',
    'gear'::rpg.item_type,
    'Elmo de Crânio de Jotun',
    '{"text":"290 PO"}'::jsonb,
    '2 kg',
    'Favorecido por quem quer projetar um aspecto temível: elmos feitos dos ossos limpos de um gigante suficientemente grande. Enquanto o usa, você tem Vantagem em testes de Carisma (Intimidação) contra Gigantes (a critério do MJ).',
    '{"source":"northlands-heroes"}'::jsonb
  ),
  (
    'skates',
    'gear'::rpg.item_type,
    'Patins',
    '{"text":"25 PO"}'::jsonb,
    '1 kg',
    'Enquanto usa patins, você ignora Terreno Difícil de gelo escorregadio e passa automaticamente em testes de Destreza (Acrobacia) para evitar a condição Caído no gelo. Você se move com o dobro do Deslocamento normal no gelo, mas tem Deslocamento de 1,5 metro fora do gelo.',
    '{"source":"northlands-heroes"}'::jsonb
  ),
  (
    'skis',
    'gear'::rpg.item_type,
    'Esquis',
    '{"text":"75 PO"}'::jsonb,
    '3 kg',
    'Enquanto usa esquis, você ignora Terreno Difícil de neve profunda e se move com o dobro do Deslocamento normal ao descer em neve. Você tem Desvantagem em salvaguardas e testes de Destreza enquanto usa esquis, exceto os relacionados a mover-se pela neve.',
    '{"source":"northlands-heroes"}'::jsonb
  ),
  (
    'snow-goggles',
    'gear'::rpg.item_type,
    'Óculos de Neve',
    '{"text":"500 PO"}'::jsonb,
    '—',
    'Óculos espessos com lentes de vidro fumê, que impedem a cegueira da neve.',
    '{"source":"northlands-heroes"}'::jsonb
  ),
  (
    'snow-visor',
    'gear'::rpg.item_type,
    'Viseira de Neve',
    '{"text":"5 PO"}'::jsonb,
    '—',
    'Viseiras espessas de osso ou madeira fixadas à cabeça, com uma fenda estreita para os olhos. Criaturas usando viseira de neve têm Imunidade à cegueira da neve, mas Desvantagem em testes de Sabedoria (Percepção) relacionados à visão.',
    '{"source":"northlands-heroes"}'::jsonb
  ),
  (
    'snowshoes',
    'gear'::rpg.item_type,
    'Raquetes de Neve',
    '{"text":"35 PO"}'::jsonb,
    '2 kg',
    'Enquanto usa raquetes de neve, você pode ignorar Terreno Difícil de neve profunda. Você tem Desvantagem em salvaguardas e testes de Destreza enquanto as usa.',
    '{"source":"northlands-heroes"}'::jsonb
  ),
  (
    'talharpa',
    'tool'::rpg.item_type,
    'Talharpa',
    '{"text":"30 PO"}'::jsonb,
    '0,5 kg',
    'Instrumento musical de duas a quatro cordas, semelhante a uma lira e tocado com arco.',
    '{"variantOf":"instrumento-musical","attribute":"Carisma","source":"northlands-heroes"}'::jsonb
  )
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  cost = EXCLUDED.cost,
  weight = EXCLUDED.weight,
  description = EXCLUDED.description,
  properties = EXCLUDED.properties,
  item_type = EXCLUDED.item_type;

INSERT INTO rpg.phb_tool (item_id, category_id, use_description)
VALUES (
  (SELECT id FROM rpg.phb_item WHERE slug = 'talharpa'),
  (SELECT id FROM rpg.phb_tool_category WHERE slug = 'instrument'),
  'Tocar uma música conhecida (CD 10) ou improvisar uma melodia (CD 15)'
)
ON CONFLICT (item_id) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  use_description = EXCLUDED.use_description;

-- Talharpa nas opções de instrumento do Artista (+ Músico pega via phb_tool)
INSERT INTO rpg.phb_background_tool_option (background_id, item_id)
SELECT b.id, i.id
FROM rpg.phb_background b
JOIN rpg.phb_item i ON i.slug = 'talharpa'
WHERE b.slug = 'entertainer'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
SELECT
  'feat'::rpg.option_scope,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'musician'),
  v.option_key,
  i.slug,
  i.name,
  100 + ROW_NUMBER() OVER (PARTITION BY v.option_key ORDER BY i.name)::int
FROM rpg.phb_item i
CROSS JOIN (
  VALUES
    ('musicalInstrument1'),
    ('musicalInstrument2'),
    ('musicalInstrument3')
) AS v(option_key)
WHERE i.slug = 'talharpa'
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE
SET label = EXCLUDED.label;
