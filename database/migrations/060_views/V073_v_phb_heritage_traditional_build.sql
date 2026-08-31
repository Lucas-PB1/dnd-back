-- Build tradicional sugerido (8 traços por herança)

CREATE OR REPLACE VIEW rpg.v_phb_heritage_traditional_build AS
SELECT
  h.slug AS heritage_slug,
  tr.slug AS trait_slug,
  tr.name AS trait_name,
  tr.category::text AS category,
  trt.category_hint::text AS category_hint,
  trt.sort_order,
  tr.benefit_base,
  tr.benefit_improved,
  tr.improved_name,
  tr.max_takes,
  tr.take_mode::text AS take_mode,
  h.source_meta->>'editionSlug' AS edition_slug
FROM rpg.phb_heritage_traditional trt
JOIN rpg.phb_heritage h ON h.id = trt.heritage_id
JOIN rpg.phb_heritage_trait tr ON tr.id = trt.trait_id
ORDER BY h.slug, trt.sort_order;
