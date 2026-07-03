-- View rpg.v_phb_class_equipment

CREATE OR REPLACE VIEW rpg.v_phb_class_equipment AS
SELECT
  c.slug AS class_slug,
  p.slug AS package_slug,
  p.label AS package_label,
  si.sort_order,
  i.slug AS item_slug,
  i.name AS item_name,
  si.quantity,
  si.choice_text,
  si.gold_amount
FROM rpg.phb_class c
JOIN rpg.phb_class_starting_package p ON p.class_id = c.id
JOIN rpg.phb_class_starting_item si ON si.package_id = p.id
LEFT JOIN rpg.phb_item i ON i.id = si.item_id
ORDER BY c.slug, p.sort_order, si.sort_order;
