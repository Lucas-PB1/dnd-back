-- Artifista, Músico, Mestre das Armas — opções de origem / nível 4

INSERT INTO rpg.phb_feat_option_def (feat_id, option_key, label, value_type, sort_order)
VALUES
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'artisan'), 'artisanTool1', 'Ferramenta de artesão 1', 'proficiency', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'artisan'), 'artisanTool2', 'Ferramenta de artesão 2', 'proficiency', 2),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'artisan'), 'artisanTool3', 'Ferramenta de artesão 3', 'proficiency', 3),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'musician'), 'musicalInstrument1', 'Instrumento musical 1', 'proficiency', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'musician'), 'musicalInstrument2', 'Instrumento musical 2', 'proficiency', 2),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'musician'), 'musicalInstrument3', 'Instrumento musical 3', 'proficiency', 3),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'weapon-master'), 'masteryWeapon', 'Arma (propriedade de maestria)', 'catalog', 2)
ON CONFLICT (feat_id, option_key) DO NOTHING;

-- Mestre das Armas — armas com masteryId no catálogo
INSERT INTO rpg.phb_feat_option_value (feat_id, option_key, value_id, label, sort_order)
SELECT
  (SELECT id FROM rpg.phb_feat WHERE slug = 'weapon-master'),
  'masteryWeapon',
  i.slug,
  i.name,
  ROW_NUMBER() OVER (ORDER BY i.name)::int
FROM rpg.phb_item i
WHERE i.item_type = 'weapon'::rpg.item_type
  AND COALESCE(i.properties->>'masteryId', '') <> ''
ON CONFLICT (feat_id, option_key, value_id) DO NOTHING;

INSERT INTO rpg.phb_feat_option_value (feat_id, option_key, value_id, label, sort_order)
SELECT
  (SELECT id FROM rpg.phb_feat WHERE slug = 'artisan'),
  v.option_key,
  i.slug,
  i.name,
  ROW_NUMBER() OVER (PARTITION BY v.option_key ORDER BY i.name)::int
FROM rpg.phb_item i
JOIN rpg.phb_tool t ON t.item_id = i.id
JOIN rpg.phb_tool_category c ON c.id = t.category_id
CROSS JOIN (
  VALUES ('artisanTool1'), ('artisanTool2'), ('artisanTool3')
) AS v(option_key)
WHERE c.slug = 'artisan'
ON CONFLICT (feat_id, option_key, value_id) DO NOTHING;

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
ON CONFLICT (feat_id, option_key, value_id) DO NOTHING;
