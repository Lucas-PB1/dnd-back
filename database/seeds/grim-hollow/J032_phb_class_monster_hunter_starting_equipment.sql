-- Caçador de Monstros — equipamento inicial (opções A / B / C)

INSERT INTO rpg.phb_starting_package (source, owner_id, slug, label, gold, sort_order)
VALUES
  ('class', (SELECT id FROM rpg.phb_class WHERE slug = 'monster-hunter'), 'a', 'A', NULL, 1),
  ('class', (SELECT id FROM rpg.phb_class WHERE slug = 'monster-hunter'), 'b', 'B', NULL, 2),
  ('class', (SELECT id FROM rpg.phb_class WHERE slug = 'monster-hunter'), 'c', 'C', 160, 3)
ON CONFLICT (source, owner_id, slug) DO UPDATE SET
  label = EXCLUDED.label,
  gold = EXCLUDED.gold,
  sort_order = EXCLUDED.sort_order;

DELETE FROM rpg.phb_starting_item
WHERE package_id IN (
  SELECT p.id
  FROM rpg.phb_starting_package p
  JOIN rpg.phb_class c ON c.id = p.owner_id
  WHERE p.source = 'class' AND c.slug = 'monster-hunter'
);

-- (A) Loriga de Escamas, Espada Longa, Besta Leve, 20 Virotes, Kit de Explorador de Masmorras, 5 PO
INSERT INTO rpg.phb_starting_item (package_id, item_id, choice_text, gold_amount, quantity, sort_order)
VALUES
  ((SELECT p.id FROM rpg.phb_starting_package p JOIN rpg.phb_class c ON c.id = p.owner_id WHERE p.source = 'class' AND c.slug = 'monster-hunter' AND p.slug = 'a'),
   (SELECT id FROM rpg.phb_item WHERE slug = 'scale-mail'), NULL, NULL, 1, 1),
  ((SELECT p.id FROM rpg.phb_starting_package p JOIN rpg.phb_class c ON c.id = p.owner_id WHERE p.source = 'class' AND c.slug = 'monster-hunter' AND p.slug = 'a'),
   (SELECT id FROM rpg.phb_item WHERE slug = 'longsword'), NULL, NULL, 1, 2),
  ((SELECT p.id FROM rpg.phb_starting_package p JOIN rpg.phb_class c ON c.id = p.owner_id WHERE p.source = 'class' AND c.slug = 'monster-hunter' AND p.slug = 'a'),
   (SELECT id FROM rpg.phb_item WHERE slug = 'light-crossbow'), NULL, NULL, 1, 3),
  ((SELECT p.id FROM rpg.phb_starting_package p JOIN rpg.phb_class c ON c.id = p.owner_id WHERE p.source = 'class' AND c.slug = 'monster-hunter' AND p.slug = 'a'),
   (SELECT id FROM rpg.phb_item WHERE slug = 'virotes'), NULL, NULL, 1, 4),
  ((SELECT p.id FROM rpg.phb_starting_package p JOIN rpg.phb_class c ON c.id = p.owner_id WHERE p.source = 'class' AND c.slug = 'monster-hunter' AND p.slug = 'a'),
   (SELECT id FROM rpg.phb_item WHERE slug = 'kit-de-explorador-de-masmorras'), NULL, NULL, 1, 5),
  ((SELECT p.id FROM rpg.phb_starting_package p JOIN rpg.phb_class c ON c.id = p.owner_id WHERE p.source = 'class' AND c.slug = 'monster-hunter' AND p.slug = 'a'),
   NULL, NULL, 5, 1, 6),

-- (B) Couro Batido, Cimitarra, Espada Curta, Arco Longo, 20 Flechas, Aljava, Kit de Explorador de Masmorras, 10 PO
  ((SELECT p.id FROM rpg.phb_starting_package p JOIN rpg.phb_class c ON c.id = p.owner_id WHERE p.source = 'class' AND c.slug = 'monster-hunter' AND p.slug = 'b'),
   (SELECT id FROM rpg.phb_item WHERE slug = 'studded-leather'), NULL, NULL, 1, 1),
  ((SELECT p.id FROM rpg.phb_starting_package p JOIN rpg.phb_class c ON c.id = p.owner_id WHERE p.source = 'class' AND c.slug = 'monster-hunter' AND p.slug = 'b'),
   (SELECT id FROM rpg.phb_item WHERE slug = 'scimitar'), NULL, NULL, 1, 2),
  ((SELECT p.id FROM rpg.phb_starting_package p JOIN rpg.phb_class c ON c.id = p.owner_id WHERE p.source = 'class' AND c.slug = 'monster-hunter' AND p.slug = 'b'),
   (SELECT id FROM rpg.phb_item WHERE slug = 'shortsword'), NULL, NULL, 1, 3),
  ((SELECT p.id FROM rpg.phb_starting_package p JOIN rpg.phb_class c ON c.id = p.owner_id WHERE p.source = 'class' AND c.slug = 'monster-hunter' AND p.slug = 'b'),
   (SELECT id FROM rpg.phb_item WHERE slug = 'longbow'), NULL, NULL, 1, 4),
  ((SELECT p.id FROM rpg.phb_starting_package p JOIN rpg.phb_class c ON c.id = p.owner_id WHERE p.source = 'class' AND c.slug = 'monster-hunter' AND p.slug = 'b'),
   (SELECT id FROM rpg.phb_item WHERE slug = 'flechas'), NULL, NULL, 1, 5),
  ((SELECT p.id FROM rpg.phb_starting_package p JOIN rpg.phb_class c ON c.id = p.owner_id WHERE p.source = 'class' AND c.slug = 'monster-hunter' AND p.slug = 'b'),
   (SELECT id FROM rpg.phb_item WHERE slug = 'aljava'), NULL, NULL, 1, 6),
  ((SELECT p.id FROM rpg.phb_starting_package p JOIN rpg.phb_class c ON c.id = p.owner_id WHERE p.source = 'class' AND c.slug = 'monster-hunter' AND p.slug = 'b'),
   (SELECT id FROM rpg.phb_item WHERE slug = 'kit-de-explorador-de-masmorras'), NULL, NULL, 1, 7),
  ((SELECT p.id FROM rpg.phb_starting_package p JOIN rpg.phb_class c ON c.id = p.owner_id WHERE p.source = 'class' AND c.slug = 'monster-hunter' AND p.slug = 'b'),
   NULL, NULL, 10, 1, 8);
