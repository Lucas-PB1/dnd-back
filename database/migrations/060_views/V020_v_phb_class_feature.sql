-- View rpg.v_phb_class_feature

CREATE OR REPLACE VIEW rpg.v_phb_class_feature AS
SELECT
  c.slug AS class_slug,
  cf.level AS feature_level,
  cf.name AS feature_name,
  cf.description AS feature_description
FROM rpg.phb_class_feature cf
JOIN rpg.phb_class c ON c.id = cf.class_id;
