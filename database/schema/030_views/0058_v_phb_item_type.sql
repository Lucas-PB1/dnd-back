CREATE VIEW rpg.v_phb_item_type AS
SELECT slug, name, sort_order FROM (VALUES
  ('weapon'::rpg.item_type, 'Arma', 1),
  ('armor'::rpg.item_type, 'Armadura', 2),
  ('gear'::rpg.item_type, 'Equipamento', 3),
  ('tool'::rpg.item_type, 'Ferramenta', 4),
  ('focus'::rpg.item_type, 'Foco', 5),
  ('other'::rpg.item_type, 'Outro', 6)
) AS t(slug, name, sort_order);
