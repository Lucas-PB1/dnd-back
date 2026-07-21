-- View rpg.v_phb_background_tool_option — whitelist PHB (não a categoria inteira)

CREATE OR REPLACE VIEW rpg.v_phb_background_tool_option AS
SELECT
  b.slug AS background_slug,
  i.slug AS item_slug,
  i.name AS item_name,
  tc.slug AS category_slug,
  tc.name AS category_name
FROM rpg.phb_background b
JOIN rpg.phb_background_tool_option opt
  ON opt.background_id = b.id
JOIN rpg.phb_item i ON i.id = opt.item_id
LEFT JOIN rpg.phb_tool t ON t.item_id = i.id
LEFT JOIN rpg.phb_tool_category tc ON tc.id = t.category_id
WHERE b.tool_proficiency_kind = 'choice'
ORDER BY b.slug, i.name;
