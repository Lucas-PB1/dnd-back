CREATE OR REPLACE VIEW rpg.v_phb_weapon_category AS
SELECT slug, name, sort_order FROM (VALUES
  ('simple'::rpg.weapon_category, 'Simples', 1),
  ('martial'::rpg.weapon_category, 'Marcial', 2),
  ('advanced'::rpg.weapon_category, 'Avançada', 3)
) AS t(slug, name, sort_order);

CREATE OR REPLACE VIEW rpg.v_phb_item_type AS
SELECT slug, name, sort_order FROM (VALUES
  ('weapon'::rpg.item_type, 'Arma', 1),
  ('armor'::rpg.item_type, 'Armadura', 2),
  ('gear'::rpg.item_type, 'Equipamento', 3),
  ('tool'::rpg.item_type, 'Ferramenta', 4),
  ('focus'::rpg.item_type, 'Foco', 5),
  ('other'::rpg.item_type, 'Outro', 6)
) AS t(slug, name, sort_order);

CREATE OR REPLACE VIEW rpg.v_phb_tool_pool_item AS
SELECT slug, name, 'instrument'::text AS pool
FROM rpg.phb_item
WHERE item_type = 'tool'
  AND properties->>'variantOf' = 'instrumento-musical'
UNION ALL
SELECT slug, name, 'gaming'::text AS pool
FROM rpg.phb_item
WHERE item_type = 'tool'
  AND properties->>'variantOf' = 'kit-de-jogos'
UNION ALL
SELECT slug, name, 'artisan'::text AS pool
FROM rpg.phb_item
WHERE slug IN (
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
  'ferramentas-de-vidreiro',
  'suprimentos-de-alquimista',
  'suprimentos-de-caligrafo',
  'suprimentos-de-cervejeiro',
  'suprimentos-de-pintor',
  'utensilios-de-cozinheiro'
);
