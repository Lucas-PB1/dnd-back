CREATE OR REPLACE VIEW rpg.v_phb_battle_master_maneuver AS
SELECT
  m.slug,
  m.name,
  m.description,
  m.timing::text AS timing,
  m.adds_to_damage,
  m.adds_to_attack
FROM rpg.phb_battle_master_maneuver m;
