-- Seed Gunslinger starting packages A/B
-- Explorer's Pack (EN) → kit-de-aventureiro (PHB PT)

INSERT INTO rpg.phb_starting_package (source, owner_id, slug, label, sort_order)
VALUES
  ('class', (SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'), 'a', 'A', 1),
  ('class', (SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'), 'b', 'B', 2)
ON CONFLICT (source, owner_id, slug) DO NOTHING;

DELETE FROM rpg.phb_starting_item
WHERE package_id IN (
  SELECT p.id
  FROM rpg.phb_starting_package p JOIN rpg.phb_class c ON c.id = p.owner_id WHERE p.source = 'class' AND c.slug = 'gunslinger'
);

-- Package A: Leather Armor, 2 Daggers, Revolver, 50 Bullets, Explorer's Pack, 11 GP
INSERT INTO rpg.phb_starting_item (package_id, item_id, choice_text, gold_amount, quantity, sort_order)
VALUES
  ((SELECT p.id FROM rpg.phb_starting_package p JOIN rpg.phb_class c ON c.id = p.owner_id WHERE p.source = 'class' AND c.slug = 'gunslinger' AND p.slug = 'a'),
   (SELECT id FROM rpg.phb_item WHERE slug = 'leather'), NULL, NULL, 1, 1),
  ((SELECT p.id FROM rpg.phb_starting_package p JOIN rpg.phb_class c ON c.id = p.owner_id WHERE p.source = 'class' AND c.slug = 'gunslinger' AND p.slug = 'a'),
   (SELECT id FROM rpg.phb_item WHERE slug = 'dagger'), NULL, NULL, 2, 2),
  ((SELECT p.id FROM rpg.phb_starting_package p JOIN rpg.phb_class c ON c.id = p.owner_id WHERE p.source = 'class' AND c.slug = 'gunslinger' AND p.slug = 'a'),
   (SELECT id FROM rpg.phb_item WHERE slug = 'revolver'), NULL, NULL, 1, 3),
  ((SELECT p.id FROM rpg.phb_starting_package p JOIN rpg.phb_class c ON c.id = p.owner_id WHERE p.source = 'class' AND c.slug = 'gunslinger' AND p.slug = 'a'),
   (SELECT id FROM rpg.phb_item WHERE slug = 'bullets'), NULL, NULL, 5, 4),
  ((SELECT p.id FROM rpg.phb_starting_package p JOIN rpg.phb_class c ON c.id = p.owner_id WHERE p.source = 'class' AND c.slug = 'gunslinger' AND p.slug = 'a'),
   (SELECT id FROM rpg.phb_item WHERE slug = 'kit-de-aventureiro'), NULL, NULL, 1, 5),
  ((SELECT p.id FROM rpg.phb_starting_package p JOIN rpg.phb_class c ON c.id = p.owner_id WHERE p.source = 'class' AND c.slug = 'gunslinger' AND p.slug = 'a'),
   NULL, NULL, 11, 1, 6),
  ((SELECT p.id FROM rpg.phb_starting_package p JOIN rpg.phb_class c ON c.id = p.owner_id WHERE p.source = 'class' AND c.slug = 'gunslinger' AND p.slug = 'b'),
   NULL, NULL, 175, 1, 1);
