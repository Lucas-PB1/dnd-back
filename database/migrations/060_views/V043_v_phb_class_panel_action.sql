CREATE OR REPLACE VIEW rpg.v_phb_class_panel_action AS
SELECT
  a.panel_key,
  c.slug AS class_slug,
  sc.slug AS subclass_slug,
  a.slug,
  a.name,
  a.title,
  a.unlock_level,
  a.resource_slug,
  a.section::text AS section,
  a.spends_focus,
  a.sort_order
FROM rpg.phb_class_panel_action a
JOIN rpg.phb_class c ON c.id = a.class_id
LEFT JOIN rpg.phb_subclass sc ON sc.id = a.subclass_id;
