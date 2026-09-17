CREATE VIEW rpg.v_phb_weapon_category AS
SELECT slug, name, sort_order FROM (VALUES
  ('simple'::rpg.weapon_category, 'Simples', 1),
  ('martial'::rpg.weapon_category, 'Marcial', 2),
  ('advanced'::rpg.weapon_category, 'Avançada', 3)
) AS t(slug, name, sort_order);
