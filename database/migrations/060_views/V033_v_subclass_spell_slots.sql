-- Espaços de magia + cotas por nível de personagem (subclasse conjuradora)

CREATE OR REPLACE VIEW rpg.v_subclass_spell_slots AS
SELECT
  sc.slug AS subclass_slug,
  c.slug AS class_slug,
  sp.level AS class_level,
  p.slug AS pattern_slug,
  p.name AS pattern_name,
  cp.proficiency_bonus,
  sp.cantrips,
  sp.prepared_spells,
  list_c.slug AS spell_list_class_slug,
  jsonb_object_agg(ss.circle::text, ss.slot_count ORDER BY ss.circle) AS spell_slots
FROM rpg.phb_subclass sc
JOIN rpg.phb_class c ON c.id = sc.class_id
JOIN rpg.phb_subclass_spellcasting ssc ON ssc.subclass_id = sc.id
JOIN rpg.phb_spell_slot_pattern p ON p.id = ssc.spell_slot_pattern_id
JOIN rpg.phb_subclass_progression sp ON sp.subclass_id = sc.id
JOIN rpg.phb_class list_c ON list_c.id = ssc.spell_list_class_id
JOIN rpg.phb_class_progression cp ON cp.class_id = c.id AND cp.level = sp.level
JOIN rpg.phb_spell_slot_by_level ss ON ss.pattern_id = p.id AND ss.level = sp.level
GROUP BY
  sc.slug,
  c.slug,
  sp.level,
  p.slug,
  p.name,
  cp.proficiency_bonus,
  sp.cantrips,
  sp.prepared_spells,
  list_c.slug;
