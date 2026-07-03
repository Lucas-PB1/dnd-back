-- View rpg.v_phb_background

CREATE OR REPLACE VIEW rpg.v_phb_background AS
SELECT
  b.slug AS background_slug,
  b.name AS background_name,
  b.equipment_gold_option,
  sc.chapter AS source_chapter,
  sc.chapter_title AS source_chapter_title,
  e.slug AS edition_slug,
  array_agg(ab.slug ORDER BY bao.sort_order) AS ability_option_slugs,
  array_agg(ab.name ORDER BY bao.sort_order) AS ability_option_names
FROM rpg.phb_background b
LEFT JOIN rpg.phb_source_citation sc ON sc.id = b.source_citation_id
LEFT JOIN rpg.phb_edition e ON e.id = sc.edition_id
LEFT JOIN rpg.phb_background_ability_option bao ON bao.background_id = b.id
LEFT JOIN rpg.phb_ability ab ON ab.id = bao.ability_id
GROUP BY b.id, b.slug, b.name, b.equipment_gold_option, sc.chapter, sc.chapter_title, e.slug;
