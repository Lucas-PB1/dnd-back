-- Seed Gunslinger skill pool

INSERT INTO rpg.phb_class_skill_pool (class_id, skill_id)
VALUES
  ((SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'), (SELECT id FROM rpg.phb_skill WHERE slug = 'acrobatics')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'), (SELECT id FROM rpg.phb_skill WHERE slug = 'animal-handling')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'), (SELECT id FROM rpg.phb_skill WHERE slug = 'athletics')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'), (SELECT id FROM rpg.phb_skill WHERE slug = 'deception')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'), (SELECT id FROM rpg.phb_skill WHERE slug = 'insight')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'), (SELECT id FROM rpg.phb_skill WHERE slug = 'intimidation')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'), (SELECT id FROM rpg.phb_skill WHERE slug = 'perception')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'), (SELECT id FROM rpg.phb_skill WHERE slug = 'persuasion')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'), (SELECT id FROM rpg.phb_skill WHERE slug = 'sleight-of-hand')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'), (SELECT id FROM rpg.phb_skill WHERE slug = 'stealth'))
ON CONFLICT DO NOTHING;
