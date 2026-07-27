-- Seed Gunslinger fighting style allowlist (same breadth as fighter)

INSERT INTO rpg.phb_class_fighting_style (class_id, fighting_style_id)
VALUES
  ((SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'), (SELECT id FROM rpg.phb_fighting_style WHERE slug = 'archery')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'), (SELECT id FROM rpg.phb_fighting_style WHERE slug = 'blind-fighting')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'), (SELECT id FROM rpg.phb_fighting_style WHERE slug = 'defense')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'), (SELECT id FROM rpg.phb_fighting_style WHERE slug = 'dueling')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'), (SELECT id FROM rpg.phb_fighting_style WHERE slug = 'great-weapon-fighting')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'), (SELECT id FROM rpg.phb_fighting_style WHERE slug = 'interception')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'), (SELECT id FROM rpg.phb_fighting_style WHERE slug = 'protection')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'), (SELECT id FROM rpg.phb_fighting_style WHERE slug = 'thrown-weapon-fighting')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'), (SELECT id FROM rpg.phb_fighting_style WHERE slug = 'two-weapon-fighting')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'), (SELECT id FROM rpg.phb_fighting_style WHERE slug = 'unarmed-fighting'))
ON CONFLICT DO NOTHING;
