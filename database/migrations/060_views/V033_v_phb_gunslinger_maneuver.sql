CREATE OR REPLACE VIEW rpg.v_phb_gunslinger_maneuver AS
SELECT
  m.slug,
  m.name,
  m.description,
  m.effect_kind::text AS effect_kind,
  m.risk_cost,
  m.from_level,
  sc.slug AS subclass_slug
FROM rpg.phb_gunslinger_maneuver m
LEFT JOIN rpg.phb_subclass sc ON sc.id = m.subclass_id;
