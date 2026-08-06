CREATE OR REPLACE VIEW rpg.v_phb_subclass_precaution_spell AS
SELECT
  sc.slug AS subclass_slug,
  sp.slug AS spell_slug,
  sp.name AS spell_name
FROM rpg.phb_subclass_precaution_spell link
JOIN rpg.phb_subclass sc ON sc.id = link.subclass_id
JOIN rpg.phb_spell sp ON sp.id = link.spell_id;
