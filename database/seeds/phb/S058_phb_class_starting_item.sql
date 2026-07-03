-- Seed rpg.phb_class_starting_item
-- Gerado automaticamente — não editar à mão

INSERT INTO rpg.phb_class_starting_item (package_id, item_id, choice_text, gold_amount, quantity, sort_order)
VALUES
  ((SELECT p.id FROM rpg.phb_class_starting_package p
    JOIN rpg.phb_class c ON c.id = p.class_id
    WHERE c.slug = 'barbarian' AND p.slug = 'a'), NULL, '4 Machadinhas', NULL, 1, 1),
  ((SELECT p.id FROM rpg.phb_class_starting_package p
    JOIN rpg.phb_class c ON c.id = p.class_id
    WHERE c.slug = 'barbarian' AND p.slug = 'a'), (SELECT id FROM rpg.phb_item WHERE slug = 'greataxe'), NULL, NULL, 1, 2),
  ((SELECT p.id FROM rpg.phb_class_starting_package p
    JOIN rpg.phb_class c ON c.id = p.class_id
    WHERE c.slug = 'barbarian' AND p.slug = 'a'), (SELECT id FROM rpg.phb_item WHERE slug = 'kit-de-aventureiro'), NULL, NULL, 1, 3),
  ((SELECT p.id FROM rpg.phb_class_starting_package p
    JOIN rpg.phb_class c ON c.id = p.class_id
    WHERE c.slug = 'barbarian' AND p.slug = 'a'), NULL, NULL, 15, 1, 4),
  ((SELECT p.id FROM rpg.phb_class_starting_package p
    JOIN rpg.phb_class c ON c.id = p.class_id
    WHERE c.slug = 'barbarian' AND p.slug = 'b'), NULL, NULL, 75, 1, 1),
  ((SELECT p.id FROM rpg.phb_class_starting_package p
    JOIN rpg.phb_class c ON c.id = p.class_id
    WHERE c.slug = 'bard' AND p.slug = 'a'), (SELECT id FROM rpg.phb_item WHERE slug = 'leather'), NULL, NULL, 1, 1),
  ((SELECT p.id FROM rpg.phb_class_starting_package p
    JOIN rpg.phb_class c ON c.id = p.class_id
    WHERE c.slug = 'bard' AND p.slug = 'a'), NULL, '2 Adagas', NULL, 1, 2),
  ((SELECT p.id FROM rpg.phb_class_starting_package p
    JOIN rpg.phb_class c ON c.id = p.class_id
    WHERE c.slug = 'bard' AND p.slug = 'a'), NULL, 'Instrumento Musical (escolha)', NULL, 1, 3),
  ((SELECT p.id FROM rpg.phb_class_starting_package p
    JOIN rpg.phb_class c ON c.id = p.class_id
    WHERE c.slug = 'bard' AND p.slug = 'a'), (SELECT id FROM rpg.phb_item WHERE slug = 'kit-de-artista'), NULL, NULL, 1, 4),
  ((SELECT p.id FROM rpg.phb_class_starting_package p
    JOIN rpg.phb_class c ON c.id = p.class_id
    WHERE c.slug = 'bard' AND p.slug = 'a'), NULL, NULL, 19, 1, 5),
  ((SELECT p.id FROM rpg.phb_class_starting_package p
    JOIN rpg.phb_class c ON c.id = p.class_id
    WHERE c.slug = 'bard' AND p.slug = 'b'), NULL, NULL, 90, 1, 1),
  ((SELECT p.id FROM rpg.phb_class_starting_package p
    JOIN rpg.phb_class c ON c.id = p.class_id
    WHERE c.slug = 'warlock' AND p.slug = 'a'), (SELECT id FROM rpg.phb_item WHERE slug = 'leather'), NULL, NULL, 1, 1),
  ((SELECT p.id FROM rpg.phb_class_starting_package p
    JOIN rpg.phb_class c ON c.id = p.class_id
    WHERE c.slug = 'warlock' AND p.slug = 'a'), (SELECT id FROM rpg.phb_item WHERE slug = 'sickle'), NULL, NULL, 1, 2),
  ((SELECT p.id FROM rpg.phb_class_starting_package p
    JOIN rpg.phb_class c ON c.id = p.class_id
    WHERE c.slug = 'warlock' AND p.slug = 'a'), NULL, '2 Adagas', NULL, 1, 3),
  ((SELECT p.id FROM rpg.phb_class_starting_package p
    JOIN rpg.phb_class c ON c.id = p.class_id
    WHERE c.slug = 'warlock' AND p.slug = 'a'), (SELECT id FROM rpg.phb_item WHERE slug = 'foco-arcano'), NULL, NULL, 1, 4),
  ((SELECT p.id FROM rpg.phb_class_starting_package p
    JOIN rpg.phb_class c ON c.id = p.class_id
    WHERE c.slug = 'warlock' AND p.slug = 'a'), (SELECT id FROM rpg.phb_item WHERE slug = 'livro'), NULL, NULL, 1, 5),
  ((SELECT p.id FROM rpg.phb_class_starting_package p
    JOIN rpg.phb_class c ON c.id = p.class_id
    WHERE c.slug = 'warlock' AND p.slug = 'a'), (SELECT id FROM rpg.phb_item WHERE slug = 'kit-de-erudito'), NULL, NULL, 1, 6),
  ((SELECT p.id FROM rpg.phb_class_starting_package p
    JOIN rpg.phb_class c ON c.id = p.class_id
    WHERE c.slug = 'warlock' AND p.slug = 'a'), NULL, NULL, 15, 1, 7),
  ((SELECT p.id FROM rpg.phb_class_starting_package p
    JOIN rpg.phb_class c ON c.id = p.class_id
    WHERE c.slug = 'warlock' AND p.slug = 'b'), NULL, NULL, 100, 1, 1),
  ((SELECT p.id FROM rpg.phb_class_starting_package p
    JOIN rpg.phb_class c ON c.id = p.class_id
    WHERE c.slug = 'cleric' AND p.slug = 'a'), (SELECT id FROM rpg.phb_item WHERE slug = 'leather'), NULL, NULL, 1, 1),
  ((SELECT p.id FROM rpg.phb_class_starting_package p
    JOIN rpg.phb_class c ON c.id = p.class_id
    WHERE c.slug = 'cleric' AND p.slug = 'a'), (SELECT id FROM rpg.phb_item WHERE slug = 'shield'), NULL, NULL, 1, 2),
  ((SELECT p.id FROM rpg.phb_class_starting_package p
    JOIN rpg.phb_class c ON c.id = p.class_id
    WHERE c.slug = 'cleric' AND p.slug = 'a'), (SELECT id FROM rpg.phb_item WHERE slug = 'mace'), NULL, NULL, 1, 3),
  ((SELECT p.id FROM rpg.phb_class_starting_package p
    JOIN rpg.phb_class c ON c.id = p.class_id
    WHERE c.slug = 'cleric' AND p.slug = 'a'), (SELECT id FROM rpg.phb_item WHERE slug = 'kit-de-sacerdote'), NULL, NULL, 1, 4),
  ((SELECT p.id FROM rpg.phb_class_starting_package p
    JOIN rpg.phb_class c ON c.id = p.class_id
    WHERE c.slug = 'cleric' AND p.slug = 'a'), (SELECT id FROM rpg.phb_item WHERE slug = 'simbolo-sagrado'), NULL, NULL, 1, 5),
  ((SELECT p.id FROM rpg.phb_class_starting_package p
    JOIN rpg.phb_class c ON c.id = p.class_id
    WHERE c.slug = 'cleric' AND p.slug = 'a'), NULL, NULL, 7, 1, 6),
  ((SELECT p.id FROM rpg.phb_class_starting_package p
    JOIN rpg.phb_class c ON c.id = p.class_id
    WHERE c.slug = 'cleric' AND p.slug = 'b'), NULL, NULL, 110, 1, 1),
  ((SELECT p.id FROM rpg.phb_class_starting_package p
    JOIN rpg.phb_class c ON c.id = p.class_id
    WHERE c.slug = 'druid' AND p.slug = 'a'), (SELECT id FROM rpg.phb_item WHERE slug = 'leather'), NULL, NULL, 1, 1),
  ((SELECT p.id FROM rpg.phb_class_starting_package p
    JOIN rpg.phb_class c ON c.id = p.class_id
    WHERE c.slug = 'druid' AND p.slug = 'a'), (SELECT id FROM rpg.phb_item WHERE slug = 'shield'), NULL, NULL, 1, 2),
  ((SELECT p.id FROM rpg.phb_class_starting_package p
    JOIN rpg.phb_class c ON c.id = p.class_id
    WHERE c.slug = 'druid' AND p.slug = 'a'), (SELECT id FROM rpg.phb_item WHERE slug = 'sickle'), NULL, NULL, 1, 3),
  ((SELECT p.id FROM rpg.phb_class_starting_package p
    JOIN rpg.phb_class c ON c.id = p.class_id
    WHERE c.slug = 'druid' AND p.slug = 'a'), (SELECT id FROM rpg.phb_item WHERE slug = 'foco-druidico'), NULL, NULL, 1, 4),
  ((SELECT p.id FROM rpg.phb_class_starting_package p
    JOIN rpg.phb_class c ON c.id = p.class_id
    WHERE c.slug = 'druid' AND p.slug = 'a'), NULL, NULL, 9, 1, 5),
  ((SELECT p.id FROM rpg.phb_class_starting_package p
    JOIN rpg.phb_class c ON c.id = p.class_id
    WHERE c.slug = 'druid' AND p.slug = 'b'), NULL, NULL, 50, 1, 1),
  ((SELECT p.id FROM rpg.phb_class_starting_package p
    JOIN rpg.phb_class c ON c.id = p.class_id
    WHERE c.slug = 'sorcerer' AND p.slug = 'a'), NULL, '2 Adagas', NULL, 1, 1),
  ((SELECT p.id FROM rpg.phb_class_starting_package p
    JOIN rpg.phb_class c ON c.id = p.class_id
    WHERE c.slug = 'sorcerer' AND p.slug = 'a'), (SELECT id FROM rpg.phb_item WHERE slug = 'foco-arcano'), NULL, NULL, 1, 2),
  ((SELECT p.id FROM rpg.phb_class_starting_package p
    JOIN rpg.phb_class c ON c.id = p.class_id
    WHERE c.slug = 'sorcerer' AND p.slug = 'a'), (SELECT id FROM rpg.phb_item WHERE slug = 'kit-de-explorador-de-masmorras'), NULL, NULL, 1, 3),
  ((SELECT p.id FROM rpg.phb_class_starting_package p
    JOIN rpg.phb_class c ON c.id = p.class_id
    WHERE c.slug = 'sorcerer' AND p.slug = 'a'), NULL, NULL, 28, 1, 4),
  ((SELECT p.id FROM rpg.phb_class_starting_package p
    JOIN rpg.phb_class c ON c.id = p.class_id
    WHERE c.slug = 'sorcerer' AND p.slug = 'b'), NULL, NULL, 50, 1, 1),
  ((SELECT p.id FROM rpg.phb_class_starting_package p
    JOIN rpg.phb_class c ON c.id = p.class_id
    WHERE c.slug = 'ranger' AND p.slug = 'a'), (SELECT id FROM rpg.phb_item WHERE slug = 'leather'), NULL, NULL, 1, 1),
  ((SELECT p.id FROM rpg.phb_class_starting_package p
    JOIN rpg.phb_class c ON c.id = p.class_id
    WHERE c.slug = 'ranger' AND p.slug = 'a'), NULL, '2 Adagas', NULL, 1, 2),
  ((SELECT p.id FROM rpg.phb_class_starting_package p
    JOIN rpg.phb_class c ON c.id = p.class_id
    WHERE c.slug = 'ranger' AND p.slug = 'a'), (SELECT id FROM rpg.phb_item WHERE slug = 'longbow'), NULL, NULL, 1, 3),
  ((SELECT p.id FROM rpg.phb_class_starting_package p
    JOIN rpg.phb_class c ON c.id = p.class_id
    WHERE c.slug = 'ranger' AND p.slug = 'a'), (SELECT id FROM rpg.phb_item WHERE slug = 'aljava'), NULL, NULL, 1, 4),
  ((SELECT p.id FROM rpg.phb_class_starting_package p
    JOIN rpg.phb_class c ON c.id = p.class_id
    WHERE c.slug = 'ranger' AND p.slug = 'a'), (SELECT id FROM rpg.phb_item WHERE slug = 'kit-de-aventureiro'), NULL, NULL, 1, 5),
  ((SELECT p.id FROM rpg.phb_class_starting_package p
    JOIN rpg.phb_class c ON c.id = p.class_id
    WHERE c.slug = 'ranger' AND p.slug = 'a'), NULL, NULL, 7, 1, 6),
  ((SELECT p.id FROM rpg.phb_class_starting_package p
    JOIN rpg.phb_class c ON c.id = p.class_id
    WHERE c.slug = 'ranger' AND p.slug = 'b'), NULL, NULL, 150, 1, 1),
  ((SELECT p.id FROM rpg.phb_class_starting_package p
    JOIN rpg.phb_class c ON c.id = p.class_id
    WHERE c.slug = 'fighter' AND p.slug = 'a'), (SELECT id FROM rpg.phb_item WHERE slug = 'chain-mail'), NULL, NULL, 1, 1),
  ((SELECT p.id FROM rpg.phb_class_starting_package p
    JOIN rpg.phb_class c ON c.id = p.class_id
    WHERE c.slug = 'fighter' AND p.slug = 'a'), (SELECT id FROM rpg.phb_item WHERE slug = 'longsword'), NULL, NULL, 1, 2),
  ((SELECT p.id FROM rpg.phb_class_starting_package p
    JOIN rpg.phb_class c ON c.id = p.class_id
    WHERE c.slug = 'fighter' AND p.slug = 'a'), (SELECT id FROM rpg.phb_item WHERE slug = 'shield'), NULL, NULL, 1, 3),
  ((SELECT p.id FROM rpg.phb_class_starting_package p
    JOIN rpg.phb_class c ON c.id = p.class_id
    WHERE c.slug = 'fighter' AND p.slug = 'a'), (SELECT id FROM rpg.phb_item WHERE slug = 'light-crossbow'), NULL, NULL, 1, 4),
  ((SELECT p.id FROM rpg.phb_class_starting_package p
    JOIN rpg.phb_class c ON c.id = p.class_id
    WHERE c.slug = 'fighter' AND p.slug = 'a'), (SELECT id FROM rpg.phb_item WHERE slug = 'aljava'), NULL, NULL, 1, 5),
  ((SELECT p.id FROM rpg.phb_class_starting_package p
    JOIN rpg.phb_class c ON c.id = p.class_id
    WHERE c.slug = 'fighter' AND p.slug = 'a'), (SELECT id FROM rpg.phb_item WHERE slug = 'kit-de-aventureiro'), NULL, NULL, 1, 6),
  ((SELECT p.id FROM rpg.phb_class_starting_package p
    JOIN rpg.phb_class c ON c.id = p.class_id
    WHERE c.slug = 'fighter' AND p.slug = 'a'), NULL, NULL, 4, 1, 7),
  ((SELECT p.id FROM rpg.phb_class_starting_package p
    JOIN rpg.phb_class c ON c.id = p.class_id
    WHERE c.slug = 'fighter' AND p.slug = 'b'), NULL, NULL, 155, 1, 1),
  ((SELECT p.id FROM rpg.phb_class_starting_package p
    JOIN rpg.phb_class c ON c.id = p.class_id
    WHERE c.slug = 'rogue' AND p.slug = 'a'), (SELECT id FROM rpg.phb_item WHERE slug = 'leather'), NULL, NULL, 1, 1),
  ((SELECT p.id FROM rpg.phb_class_starting_package p
    JOIN rpg.phb_class c ON c.id = p.class_id
    WHERE c.slug = 'rogue' AND p.slug = 'a'), NULL, '2 Adagas', NULL, 1, 2),
  ((SELECT p.id FROM rpg.phb_class_starting_package p
    JOIN rpg.phb_class c ON c.id = p.class_id
    WHERE c.slug = 'rogue' AND p.slug = 'a'), (SELECT id FROM rpg.phb_item WHERE slug = 'shortsword'), NULL, NULL, 1, 3),
  ((SELECT p.id FROM rpg.phb_class_starting_package p
    JOIN rpg.phb_class c ON c.id = p.class_id
    WHERE c.slug = 'rogue' AND p.slug = 'a'), (SELECT id FROM rpg.phb_item WHERE slug = 'longsword'), NULL, NULL, 1, 4),
  ((SELECT p.id FROM rpg.phb_class_starting_package p
    JOIN rpg.phb_class c ON c.id = p.class_id
    WHERE c.slug = 'rogue' AND p.slug = 'a'), (SELECT id FROM rpg.phb_item WHERE slug = 'kit-de-assaltante'), NULL, NULL, 1, 5),
  ((SELECT p.id FROM rpg.phb_class_starting_package p
    JOIN rpg.phb_class c ON c.id = p.class_id
    WHERE c.slug = 'rogue' AND p.slug = 'a'), (SELECT id FROM rpg.phb_item WHERE slug = 'kit-de-aventureiro'), NULL, NULL, 1, 6),
  ((SELECT p.id FROM rpg.phb_class_starting_package p
    JOIN rpg.phb_class c ON c.id = p.class_id
    WHERE c.slug = 'rogue' AND p.slug = 'a'), NULL, NULL, 8, 1, 7),
  ((SELECT p.id FROM rpg.phb_class_starting_package p
    JOIN rpg.phb_class c ON c.id = p.class_id
    WHERE c.slug = 'rogue' AND p.slug = 'b'), NULL, NULL, 100, 1, 1),
  ((SELECT p.id FROM rpg.phb_class_starting_package p
    JOIN rpg.phb_class c ON c.id = p.class_id
    WHERE c.slug = 'wizard' AND p.slug = 'a'), NULL, '2 Adagas', NULL, 1, 1),
  ((SELECT p.id FROM rpg.phb_class_starting_package p
    JOIN rpg.phb_class c ON c.id = p.class_id
    WHERE c.slug = 'wizard' AND p.slug = 'a'), (SELECT id FROM rpg.phb_item WHERE slug = 'foco-arcano'), NULL, NULL, 1, 2),
  ((SELECT p.id FROM rpg.phb_class_starting_package p
    JOIN rpg.phb_class c ON c.id = p.class_id
    WHERE c.slug = 'wizard' AND p.slug = 'a'), (SELECT id FROM rpg.phb_item WHERE slug = 'kit-de-erudito'), NULL, NULL, 1, 3),
  ((SELECT p.id FROM rpg.phb_class_starting_package p
    JOIN rpg.phb_class c ON c.id = p.class_id
    WHERE c.slug = 'wizard' AND p.slug = 'a'), (SELECT id FROM rpg.phb_item WHERE slug = 'kit-de-aventureiro'), NULL, NULL, 1, 4),
  ((SELECT p.id FROM rpg.phb_class_starting_package p
    JOIN rpg.phb_class c ON c.id = p.class_id
    WHERE c.slug = 'wizard' AND p.slug = 'a'), NULL, NULL, 5, 1, 5),
  ((SELECT p.id FROM rpg.phb_class_starting_package p
    JOIN rpg.phb_class c ON c.id = p.class_id
    WHERE c.slug = 'wizard' AND p.slug = 'b'), NULL, NULL, 55, 1, 1),
  ((SELECT p.id FROM rpg.phb_class_starting_package p
    JOIN rpg.phb_class c ON c.id = p.class_id
    WHERE c.slug = 'monk' AND p.slug = 'a'), (SELECT id FROM rpg.phb_item WHERE slug = 'shortsword'), NULL, NULL, 1, 1),
  ((SELECT p.id FROM rpg.phb_class_starting_package p
    JOIN rpg.phb_class c ON c.id = p.class_id
    WHERE c.slug = 'monk' AND p.slug = 'a'), (SELECT id FROM rpg.phb_item WHERE slug = 'dart'), NULL, NULL, 10, 2),
  ((SELECT p.id FROM rpg.phb_class_starting_package p
    JOIN rpg.phb_class c ON c.id = p.class_id
    WHERE c.slug = 'monk' AND p.slug = 'a'), (SELECT id FROM rpg.phb_item WHERE slug = 'kit-de-aventureiro'), NULL, NULL, 1, 3),
  ((SELECT p.id FROM rpg.phb_class_starting_package p
    JOIN rpg.phb_class c ON c.id = p.class_id
    WHERE c.slug = 'monk' AND p.slug = 'a'), NULL, NULL, 5, 1, 4),
  ((SELECT p.id FROM rpg.phb_class_starting_package p
    JOIN rpg.phb_class c ON c.id = p.class_id
    WHERE c.slug = 'monk' AND p.slug = 'b'), NULL, NULL, 50, 1, 1),
  ((SELECT p.id FROM rpg.phb_class_starting_package p
    JOIN rpg.phb_class c ON c.id = p.class_id
    WHERE c.slug = 'paladin' AND p.slug = 'a'), (SELECT id FROM rpg.phb_item WHERE slug = 'chain-mail'), NULL, NULL, 1, 1),
  ((SELECT p.id FROM rpg.phb_class_starting_package p
    JOIN rpg.phb_class c ON c.id = p.class_id
    WHERE c.slug = 'paladin' AND p.slug = 'a'), (SELECT id FROM rpg.phb_item WHERE slug = 'longsword'), NULL, NULL, 1, 2),
  ((SELECT p.id FROM rpg.phb_class_starting_package p
    JOIN rpg.phb_class c ON c.id = p.class_id
    WHERE c.slug = 'paladin' AND p.slug = 'a'), (SELECT id FROM rpg.phb_item WHERE slug = 'shield'), NULL, NULL, 1, 3),
  ((SELECT p.id FROM rpg.phb_class_starting_package p
    JOIN rpg.phb_class c ON c.id = p.class_id
    WHERE c.slug = 'paladin' AND p.slug = 'a'), NULL, '6 Azagaias', NULL, 1, 4),
  ((SELECT p.id FROM rpg.phb_class_starting_package p
    JOIN rpg.phb_class c ON c.id = p.class_id
    WHERE c.slug = 'paladin' AND p.slug = 'a'), (SELECT id FROM rpg.phb_item WHERE slug = 'kit-de-sacerdote'), NULL, NULL, 1, 5),
  ((SELECT p.id FROM rpg.phb_class_starting_package p
    JOIN rpg.phb_class c ON c.id = p.class_id
    WHERE c.slug = 'paladin' AND p.slug = 'a'), (SELECT id FROM rpg.phb_item WHERE slug = 'simbolo-sagrado'), NULL, NULL, 1, 6),
  ((SELECT p.id FROM rpg.phb_class_starting_package p
    JOIN rpg.phb_class c ON c.id = p.class_id
    WHERE c.slug = 'paladin' AND p.slug = 'a'), NULL, NULL, 7, 1, 7),
  ((SELECT p.id FROM rpg.phb_class_starting_package p
    JOIN rpg.phb_class c ON c.id = p.class_id
    WHERE c.slug = 'paladin' AND p.slug = 'b'), NULL, NULL, 150, 1, 1);
