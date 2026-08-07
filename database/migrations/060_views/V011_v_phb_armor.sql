-- View rpg.v_phb_armor

CREATE OR REPLACE VIEW rpg.v_phb_armor AS
SELECT
  i.slug AS item_slug,
  i.name AS item_name,
  c.slug AS category_slug,
  c.name AS category_name,
  c.don_doff,
  a.ac_base,
  a.ac_formula,
  a.strength_req,
  a.stealth_disadvantage
FROM rpg.phb_armor a
JOIN rpg.phb_item i ON i.id = a.item_id
JOIN rpg.phb_armor_category c ON c.id = a.category_id;
