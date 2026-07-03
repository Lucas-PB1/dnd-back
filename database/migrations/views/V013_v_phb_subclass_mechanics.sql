-- View rpg.v_phb_subclass_mechanics

CREATE OR REPLACE VIEW rpg.v_phb_subclass_mechanics AS
SELECT
  c.slug AS class_slug,
  s.slug AS subclass_slug,
  sf.level AS feature_level,
  sf.name AS feature_name,
  sf.feature_kind,
  sf.option_key,
  rd.slug AS resource_slug,
  rd.name AS resource_name,
  psr.unlock_level AS resource_unlock_level,
  psr.max_formula,
  psr.fixed_max
FROM rpg.phb_subclass_feature sf
JOIN rpg.phb_subclass s ON s.id = sf.subclass_id
JOIN rpg.phb_class c ON c.id = s.class_id
LEFT JOIN rpg.phb_subclass_resource psr ON psr.feature_id = sf.id
LEFT JOIN rpg.phb_resource_definition rd ON rd.id = psr.resource_id;
