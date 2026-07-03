-- View rpg.v_phb_background_equipment

CREATE OR REPLACE VIEW rpg.v_phb_background_equipment AS
SELECT
  b.slug AS background_slug,
  p.slug AS package_slug,
  p.label AS package_label,
  p.gold AS package_gold,
  si.sort_order,
  i.slug AS item_slug,
  i.name AS item_name,
  si.quantity,
  si.choice_text
FROM rpg.phb_background b
JOIN rpg.phb_background_starting_package p ON p.background_id = b.id
JOIN rpg.phb_background_starting_item si ON si.package_id = p.id
LEFT JOIN rpg.phb_item i ON i.id = si.item_id
ORDER BY b.slug, p.sort_order, si.sort_order;
