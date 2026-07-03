-- View rpg.v_phb_subclass

CREATE OR REPLACE VIEW rpg.v_phb_subclass AS
SELECT
  s.slug AS subclass_slug,
  s.name AS subclass_name,
  c.slug AS class_slug,
  c.name AS class_name,
  s.tagline,
  s.summary,
  cit.chapter AS source_chapter,
  e.slug AS edition_slug,
  ss.slug AS spell_source_slug,
  ss.label AS spell_source_label
FROM rpg.phb_subclass s
JOIN rpg.phb_class c ON c.id = s.class_id
LEFT JOIN rpg.phb_source_citation cit ON cit.id = s.source_citation_id
LEFT JOIN rpg.phb_edition e ON e.id = cit.edition_id
LEFT JOIN rpg.phb_spell_source ss ON ss.subclass_id = s.id;
