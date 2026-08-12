-- Magias always_prepared de classe (phb_spell_grant origin=class)

CREATE OR REPLACE VIEW rpg.v_phb_class_granted_spell AS
SELECT
  c.slug AS class_slug,
  g.unlock_level,
  s.slug AS spell_slug,
  s.name AS spell_name
FROM rpg.phb_spell_grant g
JOIN rpg.phb_class c ON c.id = g.origin_id
JOIN rpg.phb_spell s ON s.id = g.spell_id
WHERE g.origin_type = 'class'::rpg.spell_grant_origin;
