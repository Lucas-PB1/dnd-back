CREATE OR REPLACE VIEW rpg.v_phb_dungeoneer_slayer_type AS
SELECT
  t.slug,
  t.label,
  t.sort_order
FROM rpg.phb_dungeoneer_slayer_type t;
