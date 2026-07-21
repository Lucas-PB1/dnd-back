-- Enriquece v_class_spell_slots com cotas de phb_class_progression (truques, preparadas/conhecidas).

CREATE OR REPLACE VIEW rpg.v_class_spell_slots AS
SELECT
  c.slug AS class_slug,
  cp.level AS class_level,
  p.slug AS pattern_slug,
  p.name AS pattern_name,
  cp.proficiency_bonus,
  cp.cantrips,
  cp.prepared_spells,
  cp.channel_divinity,
  jsonb_object_agg(ss.circle::text, ss.slot_count ORDER BY ss.circle) AS spell_slots
FROM rpg.phb_class c
JOIN rpg.phb_spell_slot_pattern p ON p.id = c.spell_slot_pattern_id
JOIN rpg.phb_class_progression cp ON cp.class_id = c.id
JOIN rpg.phb_spell_slot_by_level ss ON ss.pattern_id = p.id AND ss.level = cp.level
GROUP BY
  c.slug,
  cp.level,
  p.slug,
  p.name,
  cp.proficiency_bonus,
  cp.cantrips,
  cp.prepared_spells,
  cp.channel_divinity;
