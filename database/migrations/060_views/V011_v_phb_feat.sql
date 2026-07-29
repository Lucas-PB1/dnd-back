-- View rpg.v_phb_feat

CREATE OR REPLACE VIEW rpg.v_phb_feat AS
SELECT
  f.slug AS feat_slug,
  f.name AS feat_name,
  fc.slug AS category_slug,
  fc.name AS category_name,
  fc.type_label AS category_type_label,
  f.repeatable,
  f.prerequisite,
  sc.chapter AS source_chapter,
  sc.chapter_title AS source_chapter_title,
  e.slug AS edition_slug,
  COALESCE(
    jsonb_agg(
      jsonb_strip_nulls(jsonb_build_object('name', fb.name, 'description', fb.description))
      ORDER BY fb.sort_order
    ) FILTER (WHERE fb.id IS NOT NULL),
    '[]'::jsonb
  ) AS benefits
FROM rpg.phb_feat f
JOIN rpg.phb_feat_category fc ON fc.id = f.category_id
LEFT JOIN rpg.phb_source_citation sc ON sc.id = f.source_citation_id
LEFT JOIN rpg.phb_edition e ON e.id = sc.edition_id
LEFT JOIN rpg.phb_feat_benefit fb ON fb.feat_id = f.id
GROUP BY f.id, f.slug, f.name, fc.slug, fc.name, fc.type_label, f.repeatable, f.prerequisite,
  sc.chapter, sc.chapter_title, e.slug;
