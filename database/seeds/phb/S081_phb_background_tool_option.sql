-- Seed rpg.phb_background_tool_option (+ instrumentos / kits de jogos)

-- Instrumentos
INSERT INTO rpg.phb_item (slug, item_type, name, cost, weight, description)
VALUES
  ('gaita-de-foles', 'tool'::rpg.item_type, 'Gaita de Foles', '{"text":"30 PO"}'::jsonb, '3 kg', 'Instrumento musical.'),
  ('tambor', 'tool'::rpg.item_type, 'Tambor', '{"text":"6 PO"}'::jsonb, '1,5 kg', 'Instrumento musical.'),
  ('salterio', 'tool'::rpg.item_type, 'Saltério', '{"text":"25 PO"}'::jsonb, '5 kg', 'Instrumento musical.'),
  ('flauta', 'tool'::rpg.item_type, 'Flauta', '{"text":"2 PO"}'::jsonb, '0,5 kg', 'Instrumento musical.'),
  ('trompa', 'tool'::rpg.item_type, 'Trompa', '{"text":"3 PO"}'::jsonb, '1 kg', 'Instrumento musical.'),
  ('alaude', 'tool'::rpg.item_type, 'Alaúde', '{"text":"35 PO"}'::jsonb, '1 kg', 'Instrumento musical.'),
  ('lira', 'tool'::rpg.item_type, 'Lira', '{"text":"30 PO"}'::jsonb, '1 kg', 'Instrumento musical.'),
  ('flauta-de-pan', 'tool'::rpg.item_type, 'Flauta de Pã', '{"text":"12 PO"}'::jsonb, '1 kg', 'Instrumento musical.'),
  ('charamela', 'tool'::rpg.item_type, 'Charamela', '{"text":"2 PO"}'::jsonb, '0,5 kg', 'Instrumento musical.'),
  ('viola', 'tool'::rpg.item_type, 'Viola', '{"text":"30 PO"}'::jsonb, '0,5 kg', 'Instrumento musical.')
ON CONFLICT (slug) DO UPDATE
SET
  name = EXCLUDED.name,
  cost = EXCLUDED.cost,
  weight = EXCLUDED.weight,
  description = EXCLUDED.description;

-- Kits de jogos
INSERT INTO rpg.phb_item (slug, item_type, name, cost, weight, description)
VALUES
  ('conjunto-de-dados', 'tool'::rpg.item_type, 'Conjunto de Dados', '{"text":"1 PO"}'::jsonb, '—', 'Kit de jogos.'),
  ('xadrez-do-dragao', 'tool'::rpg.item_type, 'Xadrez-do-Dragão', '{"text":"1 PO"}'::jsonb, '0,25 kg', 'Kit de jogos.'),
  ('baralho', 'tool'::rpg.item_type, 'Baralho', '{"text":"5 PO"}'::jsonb, '—', 'Kit de jogos.'),
  ('ante-dos-tres-dragoes', 'tool'::rpg.item_type, 'Ante dos Três Dragões', '{"text":"1 PO"}'::jsonb, '—', 'Kit de jogos.')
ON CONFLICT (slug) DO UPDATE
SET
  name = EXCLUDED.name,
  cost = EXCLUDED.cost,
  weight = EXCLUDED.weight,
  description = EXCLUDED.description;

INSERT INTO rpg.phb_tool (item_id, category_id, use_description)
SELECT i.id, tc.id, 'Tocar uma música conhecida (CD 10) ou improvisar uma melodia.'
FROM rpg.phb_item i
CROSS JOIN rpg.phb_tool_category tc
WHERE tc.slug = 'instrument'
  AND i.slug IN (
    'gaita-de-foles',
    'tambor',
    'salterio',
    'flauta',
    'trompa',
    'alaude',
    'lira',
    'flauta-de-pan',
    'charamela',
    'viola'
  )
ON CONFLICT (item_id) DO NOTHING;

INSERT INTO rpg.phb_tool (item_id, category_id, use_description)
SELECT i.id, tc.id, 'Discernir se alguém está trapaceando (CD 10) ou vencer uma partida.'
FROM rpg.phb_item i
CROSS JOIN rpg.phb_tool_category tc
WHERE tc.slug = 'kit'
  AND i.slug IN (
    'conjunto-de-dados',
    'xadrez-do-dragao',
    'baralho',
    'ante-dos-tres-dragoes'
  )
ON CONFLICT (item_id) DO NOTHING;

-- Whitelist: Artesão (ferramentas de artesão — sem ladrão/navegador)
INSERT INTO rpg.phb_background_tool_option (background_id, item_id)
SELECT b.id, i.id
FROM rpg.phb_background b
JOIN rpg.phb_item i ON i.slug IN (
  'ferramentas-de-carpinteiro',
  'ferramentas-de-cartografo',
  'ferramentas-de-coureiro',
  'ferramentas-de-entalhador',
  'ferramentas-de-ferreiro',
  'ferramentas-de-funileiro',
  'ferramentas-de-joalheiro',
  'ferramentas-de-oleiro',
  'ferramentas-de-pedreiro',
  'ferramentas-de-sapateiro',
  'ferramentas-de-tecelao',
  'ferramentas-de-vidreiro'
)
WHERE b.slug = 'artisan'
ON CONFLICT DO NOTHING;

-- Whitelist: Artista (instrumentos)
INSERT INTO rpg.phb_background_tool_option (background_id, item_id)
SELECT b.id, i.id
FROM rpg.phb_background b
JOIN rpg.phb_item i ON i.slug IN (
  'gaita-de-foles',
  'tambor',
  'salterio',
  'flauta',
  'trompa',
  'alaude',
  'lira',
  'flauta-de-pan',
  'charamela',
  'viola'
)
WHERE b.slug = 'entertainer'
ON CONFLICT DO NOTHING;

-- Whitelist: Guarda / Nobre / Soldado (kits de jogos)
INSERT INTO rpg.phb_background_tool_option (background_id, item_id)
SELECT b.id, i.id
FROM rpg.phb_background b
JOIN rpg.phb_item i ON i.slug IN (
  'conjunto-de-dados',
  'xadrez-do-dragao',
  'baralho',
  'ante-dos-tres-dragoes'
)
WHERE b.slug IN ('guard', 'noble', 'soldier')
ON CONFLICT DO NOTHING;

-- Músico — refrescar opções de instrumento com o catálogo expandido
INSERT INTO rpg.phb_feat_option_value (feat_id, option_key, value_id, label, sort_order)
SELECT
  (SELECT id FROM rpg.phb_feat WHERE slug = 'musician'),
  v.option_key,
  i.slug,
  i.name,
  ROW_NUMBER() OVER (PARTITION BY v.option_key ORDER BY i.name)::int
FROM rpg.phb_item i
JOIN rpg.phb_tool t ON t.item_id = i.id
JOIN rpg.phb_tool_category c ON c.id = t.category_id
CROSS JOIN (
  VALUES
    ('musicalInstrument1'),
    ('musicalInstrument2'),
    ('musicalInstrument3')
) AS v(option_key)
WHERE c.slug = 'instrument'
  AND i.slug <> 'instrumento-musical'
ON CONFLICT (feat_id, option_key, value_id) DO UPDATE
SET label = EXCLUDED.label;
