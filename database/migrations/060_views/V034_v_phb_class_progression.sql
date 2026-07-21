-- View rpg.v_phb_class_progression

CREATE OR REPLACE VIEW rpg.v_phb_class_progression AS
SELECT
  c.slug AS class_slug,
  cp.level,
  cp.proficiency_bonus,
  cp.cantrips,
  cp.prepared_spells,
  cp.channel_divinity
FROM rpg.phb_class_progression cp
JOIN rpg.phb_class c ON c.id = cp.class_id;
