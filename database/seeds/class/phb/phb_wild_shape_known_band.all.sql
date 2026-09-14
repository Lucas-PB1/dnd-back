INSERT INTO rpg.phb_wild_shape_known_band (min_level, forms_known) VALUES
  (2, 4),
  (4, 6),
  (8, 8)
ON CONFLICT (min_level) DO UPDATE SET
  forms_known = EXCLUDED.forms_known;
