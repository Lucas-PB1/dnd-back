-- Seed Gunslinger primary ability

INSERT INTO rpg.phb_class_primary_ability (class_id, ability_id, sort_order)
VALUES (
  (SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'),
  (SELECT id FROM rpg.phb_ability WHERE slug = 'destreza'),
  1
)
ON CONFLICT (class_id, ability_id) DO UPDATE SET sort_order = EXCLUDED.sort_order;
