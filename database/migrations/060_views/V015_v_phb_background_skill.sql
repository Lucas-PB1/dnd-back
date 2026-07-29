-- View rpg.v_phb_background_skill

CREATE OR REPLACE VIEW rpg.v_phb_background_skill AS
SELECT
  b.slug AS background_slug,
  s.slug AS skill_slug,
  s.name AS skill_name
FROM rpg.phb_background b
JOIN rpg.phb_background_skill bs ON bs.background_id = b.id
JOIN rpg.phb_skill s ON s.id = bs.skill_id
ORDER BY b.slug, s.slug;
