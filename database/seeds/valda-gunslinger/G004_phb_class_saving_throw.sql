-- Seed Gunslinger saving throws

INSERT INTO rpg.phb_class_saving_throw (class_id, ability_id)
VALUES
  ((SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'), (SELECT id FROM rpg.phb_ability WHERE slug = 'destreza')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'), (SELECT id FROM rpg.phb_ability WHERE slug = 'carisma'))
ON CONFLICT DO NOTHING;
