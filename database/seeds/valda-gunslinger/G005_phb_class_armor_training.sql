-- Seed Gunslinger armor training

INSERT INTO rpg.phb_class_armor_training (class_id, category_id)
VALUES (
  (SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'),
  (SELECT id FROM rpg.phb_armor_category WHERE slug = 'light')
)
ON CONFLICT DO NOTHING;
