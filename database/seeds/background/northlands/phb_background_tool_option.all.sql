-- Whitelist de ferramentas (escolha) — antecedentes Northlands

-- Condenado: ferramentas de artesão
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
WHERE b.slug = 'doomed'
ON CONFLICT DO NOTHING;

-- Herói Predestinado: kits de jogos
INSERT INTO rpg.phb_background_tool_option (background_id, item_id)
SELECT b.id, i.id
FROM rpg.phb_background b
JOIN rpg.phb_item i ON i.slug IN (
  'conjunto-de-dados',
  'xadrez-do-dragao',
  'baralho',
  'ante-dos-tres-dragoes'
)
WHERE b.slug = 'preordained-hero'
ON CONFLICT DO NOTHING;
