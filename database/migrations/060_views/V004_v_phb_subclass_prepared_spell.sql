-- View rpg.v_phb_subclass_prepared_spell

CREATE OR REPLACE VIEW rpg.v_phb_subclass_prepared_spell AS
SELECT
  s.slug AS subclass_slug,
  ps.unlock_level,
  sp.slug AS spell_slug,
  sp.name AS spell_name,
  t.slug AS terrain_slug,
  t.label AS terrain_label
FROM rpg.phb_subclass_prepared_spell ps
JOIN rpg.phb_subclass s ON s.id = ps.subclass_id
JOIN rpg.phb_spell sp ON sp.id = ps.spell_id
LEFT JOIN rpg.phb_druid_land_terrain t ON t.id = ps.terrain_id;
