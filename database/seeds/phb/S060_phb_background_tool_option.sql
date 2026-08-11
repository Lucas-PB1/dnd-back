-- Seed rpg.phb_background_tool_option (+ opções de instrumento do talento Músico)
-- Itens de instrumento/jogos vivem em S031; aqui só whitelist e option_value.

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

-- Whitelist: Artista (instrumentos concretos)
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

-- Whitelist: Guarda / Nobre / Soldado (kits de jogos concretos)
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

-- Músico — opções de instrumento a partir do catálogo (exclui categoria genérica)
INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
SELECT
  'feat'::rpg.option_scope,
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
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE
SET label = EXCLUDED.label;

DELETE FROM rpg.phb_option_value ov
USING rpg.phb_feat f
WHERE ov.scope = 'feat'::rpg.option_scope
  AND ov.owner_id = f.id
  AND f.slug = 'musician'
  AND ov.value_id = 'instrumento-musical';
