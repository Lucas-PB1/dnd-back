-- View rpg.v_spell_by_class

CREATE OR REPLACE VIEW rpg.v_spell_by_class AS
SELECT
  c.slug AS class_slug,
  c.name AS class_name,
  s.level AS spell_level,
  s.slug AS spell_slug,
  s.name AS spell_name,
  sch.slug AS school_slug,
  sch.name AS school_name
FROM rpg.phb_class c
JOIN rpg.phb_spell_class sc ON sc.class_id = c.id
JOIN rpg.phb_spell s ON s.id = sc.spell_id
JOIN rpg.phb_spell_school sch ON sch.id = s.school_id;
