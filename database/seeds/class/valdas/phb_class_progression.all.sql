-- Seed Gunslinger progression (PB only)

INSERT INTO rpg.phb_class_progression (class_id, level, proficiency_bonus, cantrips, prepared_spells, channel_divinity)
VALUES
  ((SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'), 1, 2, NULL, NULL, NULL),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'), 2, 2, NULL, NULL, NULL),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'), 3, 2, NULL, NULL, NULL),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'), 4, 2, NULL, NULL, NULL),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'), 5, 3, NULL, NULL, NULL),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'), 6, 3, NULL, NULL, NULL),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'), 7, 3, NULL, NULL, NULL),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'), 8, 3, NULL, NULL, NULL),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'), 9, 4, NULL, NULL, NULL),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'), 10, 4, NULL, NULL, NULL),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'), 11, 4, NULL, NULL, NULL),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'), 12, 4, NULL, NULL, NULL),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'), 13, 5, NULL, NULL, NULL),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'), 14, 5, NULL, NULL, NULL),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'), 15, 5, NULL, NULL, NULL),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'), 16, 5, NULL, NULL, NULL),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'), 17, 6, NULL, NULL, NULL),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'), 18, 6, NULL, NULL, NULL),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'), 19, 6, NULL, NULL, NULL),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'), 20, 6, NULL, NULL, NULL)
ON CONFLICT (class_id, level) DO UPDATE SET
  proficiency_bonus = EXCLUDED.proficiency_bonus;
