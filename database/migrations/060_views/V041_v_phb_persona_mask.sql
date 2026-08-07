CREATE OR REPLACE VIEW rpg.v_phb_persona_mask AS
SELECT
  m.slug,
  m.name,
  sc.slug AS subclass_slug
FROM rpg.phb_persona_mask m
JOIN rpg.phb_subclass sc ON sc.id = m.subclass_id;
