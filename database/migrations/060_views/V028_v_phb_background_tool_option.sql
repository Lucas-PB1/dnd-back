-- Opções de ferramenta quando o antecedente exige escolha (tool_proficiency_kind = choice)

CREATE OR REPLACE VIEW rpg.v_phb_background_tool_option AS
SELECT
  b.slug AS background_slug,
  i.slug AS item_slug,
  i.name AS item_name,
  tc.slug AS category_slug,
  tc.name AS category_name
FROM rpg.phb_background b
JOIN rpg.phb_tool_category tc ON tc.id = b.tool_category_id
JOIN rpg.phb_tool t ON t.category_id = tc.id
JOIN rpg.phb_item i ON i.id = t.item_id
WHERE b.tool_proficiency_kind = 'choice'
ORDER BY b.slug, i.name;
