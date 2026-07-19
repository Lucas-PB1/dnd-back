-- Expõe tagline, summary e description do antecedente.
-- DROP + CREATE: CREATE OR REPLACE não permite alterar a lista de colunas.

DROP VIEW IF EXISTS rpg.v_phb_background;

CREATE VIEW rpg.v_phb_background AS
SELECT
  b.slug AS background_slug,
  b.name AS background_name,
  b.tagline,
  b.summary,
  b.description,
  b.equipment_gold_option,
  sc.chapter AS source_chapter,
  sc.chapter_title AS source_chapter_title,
  e.slug AS edition_slug,
  array_agg(ab.slug ORDER BY bao.sort_order)
    FILTER (WHERE ab.slug IS NOT NULL) AS ability_option_slugs,
  array_agg(ab.name ORDER BY bao.sort_order)
    FILTER (WHERE ab.name IS NOT NULL) AS ability_option_names,
  f.slug AS feat_slug,
  f.name AS feat_name,
  b.tool_proficiency_kind,
  b.tool_proficiency_description,
  ti.slug AS tool_item_slug,
  ti.name AS tool_item_name,
  tc.slug AS tool_category_slug,
  tc.name AS tool_category_name
FROM rpg.phb_background b
LEFT JOIN rpg.phb_source_citation sc ON sc.id = b.source_citation_id
LEFT JOIN rpg.phb_edition e ON e.id = sc.edition_id
LEFT JOIN rpg.phb_feat f ON f.id = b.feat_id
LEFT JOIN rpg.phb_item ti ON ti.id = b.tool_item_id
LEFT JOIN rpg.phb_tool_category tc ON tc.id = b.tool_category_id
LEFT JOIN rpg.phb_background_ability_option bao ON bao.background_id = b.id
LEFT JOIN rpg.phb_ability ab ON ab.id = bao.ability_id
GROUP BY
  b.id,
  b.slug,
  b.name,
  b.tagline,
  b.summary,
  b.description,
  b.equipment_gold_option,
  sc.chapter,
  sc.chapter_title,
  e.slug,
  f.slug,
  f.name,
  b.tool_proficiency_kind,
  b.tool_proficiency_description,
  ti.slug,
  ti.name,
  tc.slug,
  tc.name;
