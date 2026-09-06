CREATE VIEW rpg.v_phb_subclass_mechanics AS
SELECT
  c.slug AS class_slug,
  s.slug AS subclass_slug,
  sf.level AS feature_level,
  sf.name AS feature_name,
  sf.description AS feature_description,
  sf.feature_kind,
  sf.option_key,
  NULL::text AS resource_slug,
  NULL::text AS resource_name,
  NULL::integer AS resource_unlock_level,
  NULL::rpg.resource_max_formula AS max_formula,
  NULL::integer AS fixed_max
FROM rpg.phb_subclass_feature sf
JOIN rpg.phb_subclass s ON s.id = sf.subclass_id
JOIN rpg.phb_class c ON c.id = s.class_id;

-- View canÃ´nica rpg.v_phb_class (flavor + mastery eligibility)
