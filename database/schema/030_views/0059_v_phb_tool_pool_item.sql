CREATE VIEW rpg.v_phb_tool_pool_item AS
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
