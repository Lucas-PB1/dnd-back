-- Pacotes iniciais dos antecedentes Eldritch Hunt
-- Caçador / Inquisidor: opção B = equipment_gold_option (50 PO) em H012.
-- Marcado para a Morte: opção B = Marca Sacrificial + 50 PO (pacote 'b').

INSERT INTO rpg.phb_starting_package (source, owner_id, slug, label, gold, sort_order)
VALUES
  ('background', (SELECT id FROM rpg.phb_background WHERE slug = 'beast-hunter'), 'a', 'A', 30, 1),
  ('background', (SELECT id FROM rpg.phb_background WHERE slug = 'inquisitor'), 'a', 'A', 10, 1),
  ('background', (SELECT id FROM rpg.phb_background WHERE slug = 'marked-for-death'), 'a', 'A', 40, 1),
  ('background', (SELECT id FROM rpg.phb_background WHERE slug = 'marked-for-death'), 'b', 'B', 50, 2)
ON CONFLICT (source, owner_id, slug) DO UPDATE SET
  label = EXCLUDED.label,
  gold = EXCLUDED.gold,
  sort_order = EXCLUDED.sort_order;

-- Caçador de Bestas A: Roupas de Viagem, Kit de Curandeiro, Kit de Herbalismo,
-- 20 balas, Adaga, Sinalizador, Frasco, 30 PO
INSERT INTO rpg.phb_starting_item (package_id, item_id, choice_text, gold_amount, quantity, sort_order)
SELECT p.id, i.item_id, i.choice_text, i.gold_amount, i.quantity, i.sort_order
FROM rpg.phb_starting_package p
JOIN rpg.phb_background b ON b.id = p.owner_id
CROSS JOIN (
  VALUES
    ((SELECT id FROM rpg.phb_item WHERE slug = 'roupas-viagem'), NULL::text, NULL::int, 1, 1),
    ((SELECT id FROM rpg.phb_item WHERE slug = 'kit-de-curandeiro'), NULL, NULL, 1, 2),
    ((SELECT id FROM rpg.phb_item WHERE slug = 'kit-de-herbalismo'), NULL, NULL, 1, 3),
    ((SELECT id FROM rpg.phb_item WHERE slug = 'balas-arma-de-fogo'), NULL, NULL, 2, 4),
    ((SELECT id FROM rpg.phb_item WHERE slug = 'dagger'), NULL, NULL, 1, 5),
    ((SELECT id FROM rpg.phb_item WHERE slug = 'flare'), NULL, NULL, 1, 6),
    ((SELECT id FROM rpg.phb_item WHERE slug = 'frasco'), NULL, NULL, 1, 7)
) AS i(item_id, choice_text, gold_amount, quantity, sort_order)
WHERE p.source = 'background' AND b.slug = 'beast-hunter' AND p.slug = 'a'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_starting_item si
    WHERE si.package_id = p.id AND si.sort_order = i.sort_order
  );

-- Inquisidor A: Livro (oração), Símbolo Sagrado, Algemas, Roupas de Viagem,
-- Ferramentas de Tortura, 10 PO
INSERT INTO rpg.phb_starting_item (package_id, item_id, choice_text, gold_amount, quantity, sort_order)
SELECT p.id, i.item_id, i.choice_text, i.gold_amount, i.quantity, i.sort_order
FROM rpg.phb_starting_package p
JOIN rpg.phb_background b ON b.id = p.owner_id
CROSS JOIN (
  VALUES
    ((SELECT id FROM rpg.phb_item WHERE slug = 'livro'), 'Livro (oração)', NULL::int, 1, 1),
    ((SELECT id FROM rpg.phb_item WHERE slug = 'simbolo-sagrado'), NULL, NULL, 1, 2),
    ((SELECT id FROM rpg.phb_item WHERE slug = 'algemas'), NULL, NULL, 1, 3),
    ((SELECT id FROM rpg.phb_item WHERE slug = 'roupas-viagem'), NULL, NULL, 1, 4),
    ((SELECT id FROM rpg.phb_item WHERE slug = 'torture-tools'), NULL, NULL, 1, 5)
) AS i(item_id, choice_text, gold_amount, quantity, sort_order)
WHERE p.source = 'background' AND b.slug = 'inquisitor' AND p.slug = 'a'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_starting_item si
    WHERE si.package_id = p.id AND si.sort_order = i.sort_order
  );

-- Marcado para a Morte A: Adaga, Sinalizador, Papel (50), Marca Sacrificial,
-- Roupas de Viagem, 40 PO
INSERT INTO rpg.phb_starting_item (package_id, item_id, choice_text, gold_amount, quantity, sort_order)
SELECT p.id, i.item_id, i.choice_text, i.gold_amount, i.quantity, i.sort_order
FROM rpg.phb_starting_package p
JOIN rpg.phb_background b ON b.id = p.owner_id
CROSS JOIN (
  VALUES
    ((SELECT id FROM rpg.phb_item WHERE slug = 'dagger'), NULL::text, NULL::int, 1, 1),
    ((SELECT id FROM rpg.phb_item WHERE slug = 'flare'), NULL, NULL, 1, 2),
    ((SELECT id FROM rpg.phb_item WHERE slug = 'papel'), NULL, NULL, 50, 3),
    ((SELECT id FROM rpg.phb_item WHERE slug = 'sacrificial-brand'), NULL, NULL, 1, 4),
    ((SELECT id FROM rpg.phb_item WHERE slug = 'roupas-viagem'), NULL, NULL, 1, 5)
) AS i(item_id, choice_text, gold_amount, quantity, sort_order)
WHERE p.source = 'background' AND b.slug = 'marked-for-death' AND p.slug = 'a'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_starting_item si
    WHERE si.package_id = p.id AND si.sort_order = i.sort_order
  );

-- Marcado para a Morte B: Marca Sacrificial, 50 PO
INSERT INTO rpg.phb_starting_item (package_id, item_id, choice_text, gold_amount, quantity, sort_order)
SELECT p.id, i.item_id, i.choice_text, i.gold_amount, i.quantity, i.sort_order
FROM rpg.phb_starting_package p
JOIN rpg.phb_background b ON b.id = p.owner_id
CROSS JOIN (
  VALUES
    ((SELECT id FROM rpg.phb_item WHERE slug = 'sacrificial-brand'), NULL::text, NULL::int, 1, 1)
) AS i(item_id, choice_text, gold_amount, quantity, sort_order)
WHERE p.source = 'background' AND b.slug = 'marked-for-death' AND p.slug = 'b'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_starting_item si
    WHERE si.package_id = p.id AND si.sort_order = i.sort_order
  );
