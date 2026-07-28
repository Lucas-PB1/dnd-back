-- View rpg.v_phb_background_language

CREATE OR REPLACE VIEW rpg.v_phb_background_language AS
SELECT
  b.slug AS background_slug,
  l.slug AS language_slug,
  l.name AS language_name,
  l.is_rare AS language_is_rare
FROM rpg.phb_background b
JOIN rpg.phb_background_language bl ON bl.background_id = b.id
JOIN rpg.phb_language l ON l.id = bl.language_id
ORDER BY b.slug, l.slug;
