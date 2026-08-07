-- View rpg.v_phb_subclass_prepared_spell
-- Lote A: terrain is now enum column, no join needed

CREATE OR REPLACE VIEW rpg.v_phb_subclass_prepared_spell AS
SELECT
  s.slug AS subclass_slug,
  ps.unlock_level,
  sp.slug AS spell_slug,
  sp.name AS spell_name,
  ps.terrain::text AS terrain_slug,
  INITCAP(ps.terrain::text) AS terrain_label
FROM rpg.phb_subclass_prepared_spell ps
JOIN rpg.phb_subclass s ON s.id = ps.subclass_id
JOIN rpg.phb_spell sp ON sp.id = ps.spell_id;
