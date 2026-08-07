-- View rpg.v_phb_subclass_spells_expected

CREATE OR REPLACE VIEW rpg.v_phb_subclass_spells_expected AS
SELECT
  c.slug AS class_slug,
  s.slug AS subclass_slug,
  ps.unlock_level,
  sp.slug AS spell_slug,
  ss.slug AS spell_source_slug
FROM rpg.phb_subclass_prepared_spell ps
JOIN rpg.phb_subclass s ON s.id = ps.subclass_id
JOIN rpg.phb_class c ON c.id = s.class_id
JOIN rpg.phb_spell sp ON sp.id = ps.spell_id
LEFT JOIN rpg.phb_spell_source ss ON ss.subclass_id = s.id AND ss.origin_type = 'subclass';
