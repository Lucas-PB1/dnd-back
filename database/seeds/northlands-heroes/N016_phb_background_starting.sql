-- Pacotes iniciais dos antecedentes Northlands
-- Opção B = equipment_gold_option (50 PO) em N012.

INSERT INTO rpg.phb_starting_package (source, owner_id, slug, label, gold, sort_order)
VALUES
  ('background', (SELECT id FROM rpg.phb_background WHERE slug = 'dancing-bear-guide'), 'a', 'A', 8, 1),
  ('background', (SELECT id FROM rpg.phb_background WHERE slug = 'doomed'), 'a', 'A', 8, 1),
  ('background', (SELECT id FROM rpg.phb_background WHERE slug = 'former-captive'), 'a', 'A', 6, 1),
  ('background', (SELECT id FROM rpg.phb_background WHERE slug = 'ice-nomad'), 'a', 'A', 8, 1),
  ('background', (SELECT id FROM rpg.phb_background WHERE slug = 'northlands-reaver'), 'a', 'A', 5, 1),
  ('background', (SELECT id FROM rpg.phb_background WHERE slug = 'preordained-hero'), 'a', 'A', 20, 1),
  ('background', (SELECT id FROM rpg.phb_background WHERE slug = 'seafarer'), 'a', 'A', 12, 1),
  ('background', (SELECT id FROM rpg.phb_background WHERE slug = 'seer'), 'a', 'A', 0, 1),
  ('background', (SELECT id FROM rpg.phb_background WHERE slug = 'shipwright'), 'a', 'A', 14, 1)
ON CONFLICT (source, owner_id, slug) DO UPDATE SET
  label = EXCLUDED.label,
  gold = EXCLUDED.gold,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_starting_item (package_id, item_id, choice_text, gold_amount, quantity, sort_order)
SELECT p.id, i.item_id, i.choice_text, i.gold_amount, i.quantity, i.sort_order
FROM rpg.phb_starting_package p
JOIN rpg.phb_background b ON b.id = p.owner_id
CROSS JOIN (
  VALUES
    ((SELECT id FROM rpg.phb_item WHERE slug = 'estojo-mapa-ou-pergaminho'), NULL::text, NULL::int, 1, 1),
    ((SELECT id FROM rpg.phb_item WHERE slug = 'mapa'), NULL::text, NULL::int, 1, 2),
    ((SELECT id FROM rpg.phb_item WHERE slug = 'armadilha-de-caca'), NULL::text, NULL::int, 1, 3),
    ((SELECT id FROM rpg.phb_item WHERE slug = 'tenda'), NULL::text, NULL::int, 1, 4),
    ((SELECT id FROM rpg.phb_item WHERE slug = 'roupas-viagem'), NULL::text, NULL::int, 1, 5)
) AS i(item_id, choice_text, gold_amount, quantity, sort_order)
WHERE p.source = 'background' AND b.slug = 'dancing-bear-guide' AND p.slug = 'a'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_starting_item si
    WHERE si.package_id = p.id AND si.sort_order = i.sort_order
  );

INSERT INTO rpg.phb_starting_item (package_id, item_id, choice_text, gold_amount, quantity, sort_order)
SELECT p.id, i.item_id, i.choice_text, i.gold_amount, i.quantity, i.sort_order
FROM rpg.phb_starting_package p
JOIN rpg.phb_background b ON b.id = p.owner_id
CROSS JOIN (
  VALUES
    ((SELECT id FROM rpg.phb_item WHERE slug = 'livro'), 'Livro (História das Lendas das Terras do Norte)', NULL::int, 1, 1),
    ((SELECT id FROM rpg.phb_item WHERE slug = 'lanterna-coberta'), NULL::text, NULL::int, 1, 2),
    ((SELECT id FROM rpg.phb_item WHERE slug = 'tenda'), NULL::text, NULL::int, 1, 3),
    ((SELECT id FROM rpg.phb_item WHERE slug = 'roupas-viagem'), NULL::text, NULL::int, 1, 4)
) AS i(item_id, choice_text, gold_amount, quantity, sort_order)
WHERE p.source = 'background' AND b.slug = 'doomed' AND p.slug = 'a'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_starting_item si
    WHERE si.package_id = p.id AND si.sort_order = i.sort_order
  );

INSERT INTO rpg.phb_starting_item (package_id, item_id, choice_text, gold_amount, quantity, sort_order)
SELECT p.id, i.item_id, i.choice_text, i.gold_amount, i.quantity, i.sort_order
FROM rpg.phb_starting_package p
JOIN rpg.phb_background b ON b.id = p.owner_id
CROSS JOIN (
  VALUES
    ((SELECT id FROM rpg.phb_item WHERE slug = 'saco-de-dormir'), NULL::text, NULL::int, 1, 1),
    (NULL::bigint, 'Rações (5 dias)', NULL::int, 1, 2),
    ((SELECT id FROM rpg.phb_item WHERE slug = 'ferramentas-de-funileiro'), NULL::text, NULL::int, 1, 3),
    ((SELECT id FROM rpg.phb_item WHERE slug = 'roupas-viagem'), NULL::text, NULL::int, 1, 4),
    ((SELECT id FROM rpg.phb_item WHERE slug = 'cantil-cheio'), NULL::text, NULL::int, 1, 5)
) AS i(item_id, choice_text, gold_amount, quantity, sort_order)
WHERE p.source = 'background' AND b.slug = 'former-captive' AND p.slug = 'a'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_starting_item si
    WHERE si.package_id = p.id AND si.sort_order = i.sort_order
  );

INSERT INTO rpg.phb_starting_item (package_id, item_id, choice_text, gold_amount, quantity, sort_order)
SELECT p.id, i.item_id, i.choice_text, i.gold_amount, i.quantity, i.sort_order
FROM rpg.phb_starting_package p
JOIN rpg.phb_background b ON b.id = p.owner_id
CROSS JOIN (
  VALUES
    ((SELECT id FROM rpg.phb_item WHERE slug = 'saco-de-dormir'), NULL::text, NULL::int, 1, 1),
    ((SELECT id FROM rpg.phb_item WHERE slug = 'corda'), NULL::text, NULL::int, 1, 2),
    (NULL::bigint, 'Esquis ou Raquetes de Neve', NULL::int, 1, 3),
    ((SELECT id FROM rpg.phb_item WHERE slug = 'tenda'), NULL::text, NULL::int, 1, 4),
    ((SELECT id FROM rpg.phb_item WHERE slug = 'roupas-viagem'), NULL::text, NULL::int, 1, 5)
) AS i(item_id, choice_text, gold_amount, quantity, sort_order)
WHERE p.source = 'background' AND b.slug = 'ice-nomad' AND p.slug = 'a'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_starting_item si
    WHERE si.package_id = p.id AND si.sort_order = i.sort_order
  );

INSERT INTO rpg.phb_starting_item (package_id, item_id, choice_text, gold_amount, quantity, sort_order)
SELECT p.id, i.item_id, i.choice_text, i.gold_amount, i.quantity, i.sort_order
FROM rpg.phb_starting_package p
JOIN rpg.phb_background b ON b.id = p.owner_id
CROSS JOIN (
  VALUES
    ((SELECT id FROM rpg.phb_item WHERE slug = 'handaxe'), NULL::text, NULL::int, 1, 1),
    ((SELECT id FROM rpg.phb_item WHERE slug = 'longbow'), NULL::text, NULL::int, 1, 2),
    ((SELECT id FROM rpg.phb_item WHERE slug = 'flechas'), NULL::text, NULL::int, 1, 3),
    ((SELECT id FROM rpg.phb_item WHERE slug = 'roupas-viagem'), NULL::text, NULL::int, 1, 4),
    ((SELECT id FROM rpg.phb_item WHERE slug = 'aljava'), NULL::text, NULL::int, 1, 5)
) AS i(item_id, choice_text, gold_amount, quantity, sort_order)
WHERE p.source = 'background' AND b.slug = 'northlands-reaver' AND p.slug = 'a'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_starting_item si
    WHERE si.package_id = p.id AND si.sort_order = i.sort_order
  );

INSERT INTO rpg.phb_starting_item (package_id, item_id, choice_text, gold_amount, quantity, sort_order)
SELECT p.id, i.item_id, i.choice_text, i.gold_amount, i.quantity, i.sort_order
FROM rpg.phb_starting_package p
JOIN rpg.phb_background b ON b.id = p.owner_id
CROSS JOIN (
  VALUES
    (NULL::bigint, 'Kit de Jogos (o mesmo da proficiência)', NULL::int, 1, 1),
    ((SELECT id FROM rpg.phb_item WHERE slug = 'roupas-finas'), NULL::text, NULL::int, 1, 2),
    ((SELECT id FROM rpg.phb_item WHERE slug = 'handaxe'), NULL::text, NULL::int, 1, 3),
    ((SELECT id FROM rpg.phb_item WHERE slug = 'shortbow'), NULL::text, NULL::int, 1, 4),
    ((SELECT id FROM rpg.phb_item WHERE slug = 'flechas'), NULL::text, NULL::int, 1, 5),
    ((SELECT id FROM rpg.phb_item WHERE slug = 'aljava'), NULL::text, NULL::int, 1, 6),
    ((SELECT id FROM rpg.phb_item WHERE slug = 'roupas-viagem'), NULL::text, NULL::int, 1, 7)
) AS i(item_id, choice_text, gold_amount, quantity, sort_order)
WHERE p.source = 'background' AND b.slug = 'preordained-hero' AND p.slug = 'a'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_starting_item si
    WHERE si.package_id = p.id AND si.sort_order = i.sort_order
  );

INSERT INTO rpg.phb_starting_item (package_id, item_id, choice_text, gold_amount, quantity, sort_order)
SELECT p.id, i.item_id, i.choice_text, i.gold_amount, i.quantity, i.sort_order
FROM rpg.phb_starting_package p
JOIN rpg.phb_background b ON b.id = p.owner_id
CROSS JOIN (
  VALUES
    ((SELECT id FROM rpg.phb_item WHERE slug = 'handaxe'), NULL::text, NULL::int, 1, 1),
    ((SELECT id FROM rpg.phb_item WHERE slug = 'mapa'), NULL::text, NULL::int, 1, 2),
    ((SELECT id FROM rpg.phb_item WHERE slug = 'shortbow'), NULL::text, NULL::int, 1, 3),
    ((SELECT id FROM rpg.phb_item WHERE slug = 'flechas'), NULL::text, NULL::int, 1, 4),
    ((SELECT id FROM rpg.phb_item WHERE slug = 'aljava'), NULL::text, NULL::int, 1, 5),
    ((SELECT id FROM rpg.phb_item WHERE slug = 'roupas-viagem'), NULL::text, NULL::int, 1, 6)
) AS i(item_id, choice_text, gold_amount, quantity, sort_order)
WHERE p.source = 'background' AND b.slug = 'seafarer' AND p.slug = 'a'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_starting_item si
    WHERE si.package_id = p.id AND si.sort_order = i.sort_order
  );

INSERT INTO rpg.phb_starting_item (package_id, item_id, choice_text, gold_amount, quantity, sort_order)
SELECT p.id, i.item_id, i.choice_text, i.gold_amount, i.quantity, i.sort_order
FROM rpg.phb_starting_package p
JOIN rpg.phb_background b ON b.id = p.owner_id
CROSS JOIN (
  VALUES
    ((SELECT id FROM rpg.phb_item WHERE slug = 'vela'), NULL::text, NULL::int, 2, 1),
    ((SELECT id FROM rpg.phb_item WHERE slug = 'cristal'), NULL::text, NULL::int, 1, 2),
    ((SELECT id FROM rpg.phb_item WHERE slug = 'roupas-finas'), NULL::text, NULL::int, 1, 3),
    ((SELECT id FROM rpg.phb_item WHERE slug = 'frasco'), NULL::text, NULL::int, 1, 4),
    ((SELECT id FROM rpg.phb_item WHERE slug = 'oleo'), NULL::text, NULL::int, 1, 5),
    (NULL::bigint, 'Bolsas (2)', NULL::int, 2, 6)
) AS i(item_id, choice_text, gold_amount, quantity, sort_order)
WHERE p.source = 'background' AND b.slug = 'seer' AND p.slug = 'a'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_starting_item si
    WHERE si.package_id = p.id AND si.sort_order = i.sort_order
  );

INSERT INTO rpg.phb_starting_item (package_id, item_id, choice_text, gold_amount, quantity, sort_order)
SELECT p.id, i.item_id, i.choice_text, i.gold_amount, i.quantity, i.sort_order
FROM rpg.phb_starting_package p
JOIN rpg.phb_background b ON b.id = p.owner_id
CROSS JOIN (
  VALUES
    ((SELECT id FROM rpg.phb_item WHERE slug = 'ferramentas-de-carpinteiro'), NULL::text, NULL::int, 1, 1),
    ((SELECT id FROM rpg.phb_item WHERE slug = 'corda'), NULL::text, NULL::int, 1, 2),
    ((SELECT id FROM rpg.phb_item WHERE slug = 'roupas-viagem'), NULL::text, NULL::int, 1, 3)
) AS i(item_id, choice_text, gold_amount, quantity, sort_order)
WHERE p.source = 'background' AND b.slug = 'shipwright' AND p.slug = 'a'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_starting_item si
    WHERE si.package_id = p.id AND si.sort_order = i.sort_order
  );
