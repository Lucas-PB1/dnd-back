-- View rpg.v_phb_spell

CREATE OR REPLACE VIEW rpg.v_phb_spell AS
SELECT
  s.slug,
  s.name,
  s.level,
  s.level_label,
  sch.slug AS school_slug,
  sch.name AS school_name,
  s.casting_time,
  s.range,
  s.has_verbal,
  s.has_somatic,
  s.has_material,
  s.material_description,
  s.components_label,
  s.duration,
  s.concentration,
  s.ritual,
  s.description,
  s.higher_levels,
  sc.chapter AS source_chapter,
  e.slug AS edition_slug
FROM rpg.phb_spell s
JOIN rpg.phb_spell_school sch ON sch.id = s.school_id
LEFT JOIN rpg.phb_source_citation sc ON sc.id = s.source_citation_id
LEFT JOIN rpg.phb_edition e ON e.id = sc.edition_id;
