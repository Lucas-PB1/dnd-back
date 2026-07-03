-- Seed rpg.phb_background_starting_item
-- Gerado automaticamente — não editar à mão

INSERT INTO rpg.phb_background_starting_item (package_id, item_id, choice_text, quantity, sort_order)
VALUES
  ((SELECT p.id FROM rpg.phb_background_starting_package p
    JOIN rpg.phb_background b ON b.id = p.background_id
    WHERE b.slug = 'acolyte' AND p.slug = 'a'), (SELECT id FROM rpg.phb_item WHERE slug = 'suprimentos-de-caligrafo'), NULL, 1, 1),
  ((SELECT p.id FROM rpg.phb_background_starting_package p
    JOIN rpg.phb_background b ON b.id = p.background_id
    WHERE b.slug = 'acolyte' AND p.slug = 'a'), (SELECT id FROM rpg.phb_item WHERE slug = 'livro'), NULL, 1, 2),
  ((SELECT p.id FROM rpg.phb_background_starting_package p
    JOIN rpg.phb_background b ON b.id = p.background_id
    WHERE b.slug = 'acolyte' AND p.slug = 'a'), (SELECT id FROM rpg.phb_item WHERE slug = 'simbolo-sagrado'), NULL, 1, 3),
  ((SELECT p.id FROM rpg.phb_background_starting_package p
    JOIN rpg.phb_background b ON b.id = p.background_id
    WHERE b.slug = 'acolyte' AND p.slug = 'a'), (SELECT id FROM rpg.phb_item WHERE slug = 'pergaminho'), NULL, 1, 4),
  ((SELECT p.id FROM rpg.phb_background_starting_package p
    JOIN rpg.phb_background b ON b.id = p.background_id
    WHERE b.slug = 'acolyte' AND p.slug = 'a'), (SELECT id FROM rpg.phb_item WHERE slug = 'tunica'), NULL, 1, 5),
  ((SELECT p.id FROM rpg.phb_background_starting_package p
    JOIN rpg.phb_background b ON b.id = p.background_id
    WHERE b.slug = 'wanderer' AND p.slug = 'a'), NULL, '2 Adagas', 1, 1),
  ((SELECT p.id FROM rpg.phb_background_starting_package p
    JOIN rpg.phb_background b ON b.id = p.background_id
    WHERE b.slug = 'wanderer' AND p.slug = 'a'), (SELECT id FROM rpg.phb_item WHERE slug = 'ferramentas-de-ladrao'), NULL, 1, 2),
  ((SELECT p.id FROM rpg.phb_background_starting_package p
    JOIN rpg.phb_background b ON b.id = p.background_id
    WHERE b.slug = 'wanderer' AND p.slug = 'a'), NULL, 'Kit de Jogos (qualquer um)', 1, 3),
  ((SELECT p.id FROM rpg.phb_background_starting_package p
    JOIN rpg.phb_background b ON b.id = p.background_id
    WHERE b.slug = 'wanderer' AND p.slug = 'a'), NULL, '2 Algibeiras', 1, 4),
  ((SELECT p.id FROM rpg.phb_background_starting_package p
    JOIN rpg.phb_background b ON b.id = p.background_id
    WHERE b.slug = 'wanderer' AND p.slug = 'a'), (SELECT id FROM rpg.phb_item WHERE slug = 'roupas-viagem'), NULL, 1, 5),
  ((SELECT p.id FROM rpg.phb_background_starting_package p
    JOIN rpg.phb_background b ON b.id = p.background_id
    WHERE b.slug = 'wanderer' AND p.slug = 'a'), (SELECT id FROM rpg.phb_item WHERE slug = 'saco-de-dormir'), NULL, 1, 6),
  ((SELECT p.id FROM rpg.phb_background_starting_package p
    JOIN rpg.phb_background b ON b.id = p.background_id
    WHERE b.slug = 'artisan' AND p.slug = 'a'), NULL, 'Ferramentas de Artesão (a mesma que acima)', 1, 1),
  ((SELECT p.id FROM rpg.phb_background_starting_package p
    JOIN rpg.phb_background b ON b.id = p.background_id
    WHERE b.slug = 'artisan' AND p.slug = 'a'), NULL, '2 Algibeiras', 1, 2),
  ((SELECT p.id FROM rpg.phb_background_starting_package p
    JOIN rpg.phb_background b ON b.id = p.background_id
    WHERE b.slug = 'artisan' AND p.slug = 'a'), (SELECT id FROM rpg.phb_item WHERE slug = 'roupas-viagem'), NULL, 1, 3),
  ((SELECT p.id FROM rpg.phb_background_starting_package p
    JOIN rpg.phb_background b ON b.id = p.background_id
    WHERE b.slug = 'entertainer' AND p.slug = 'a'), NULL, 'Instrumento Musical (o mesmo que acima)', 1, 1),
  ((SELECT p.id FROM rpg.phb_background_starting_package p
    JOIN rpg.phb_background b ON b.id = p.background_id
    WHERE b.slug = 'entertainer' AND p.slug = 'a'), (SELECT id FROM rpg.phb_item WHERE slug = 'espelho'), NULL, 1, 2),
  ((SELECT p.id FROM rpg.phb_background_starting_package p
    JOIN rpg.phb_background b ON b.id = p.background_id
    WHERE b.slug = 'entertainer' AND p.slug = 'a'), NULL, '2 Fantasias', 1, 3),
  ((SELECT p.id FROM rpg.phb_background_starting_package p
    JOIN rpg.phb_background b ON b.id = p.background_id
    WHERE b.slug = 'entertainer' AND p.slug = 'a'), (SELECT id FROM rpg.phb_item WHERE slug = 'perfume'), NULL, 1, 4),
  ((SELECT p.id FROM rpg.phb_background_starting_package p
    JOIN rpg.phb_background b ON b.id = p.background_id
    WHERE b.slug = 'entertainer' AND p.slug = 'a'), (SELECT id FROM rpg.phb_item WHERE slug = 'roupas-viagem'), NULL, 1, 5),
  ((SELECT p.id FROM rpg.phb_background_starting_package p
    JOIN rpg.phb_background b ON b.id = p.background_id
    WHERE b.slug = 'charlatan' AND p.slug = 'a'), (SELECT id FROM rpg.phb_item WHERE slug = 'kit-de-falsificacao'), NULL, 1, 1),
  ((SELECT p.id FROM rpg.phb_background_starting_package p
    JOIN rpg.phb_background b ON b.id = p.background_id
    WHERE b.slug = 'charlatan' AND p.slug = 'a'), (SELECT id FROM rpg.phb_item WHERE slug = 'roupas-fantasia'), NULL, 1, 2),
  ((SELECT p.id FROM rpg.phb_background_starting_package p
    JOIN rpg.phb_background b ON b.id = p.background_id
    WHERE b.slug = 'charlatan' AND p.slug = 'a'), (SELECT id FROM rpg.phb_item WHERE slug = 'roupas-finas'), NULL, 1, 3),
  ((SELECT p.id FROM rpg.phb_background_starting_package p
    JOIN rpg.phb_background b ON b.id = p.background_id
    WHERE b.slug = 'criminal' AND p.slug = 'a'), NULL, '2 Adagas', 1, 1),
  ((SELECT p.id FROM rpg.phb_background_starting_package p
    JOIN rpg.phb_background b ON b.id = p.background_id
    WHERE b.slug = 'criminal' AND p.slug = 'a'), (SELECT id FROM rpg.phb_item WHERE slug = 'ferramentas-de-ladrao'), NULL, 1, 2),
  ((SELECT p.id FROM rpg.phb_background_starting_package p
    JOIN rpg.phb_background b ON b.id = p.background_id
    WHERE b.slug = 'criminal' AND p.slug = 'a'), NULL, '2 Algibeiras', 1, 3),
  ((SELECT p.id FROM rpg.phb_background_starting_package p
    JOIN rpg.phb_background b ON b.id = p.background_id
    WHERE b.slug = 'criminal' AND p.slug = 'a'), (SELECT id FROM rpg.phb_item WHERE slug = 'pe-de-cabra'), NULL, 1, 4),
  ((SELECT p.id FROM rpg.phb_background_starting_package p
    JOIN rpg.phb_background b ON b.id = p.background_id
    WHERE b.slug = 'criminal' AND p.slug = 'a'), (SELECT id FROM rpg.phb_item WHERE slug = 'roupas-viagem'), NULL, 1, 5),
  ((SELECT p.id FROM rpg.phb_background_starting_package p
    JOIN rpg.phb_background b ON b.id = p.background_id
    WHERE b.slug = 'hermit' AND p.slug = 'a'), (SELECT id FROM rpg.phb_item WHERE slug = 'quarterstaff'), NULL, 1, 1),
  ((SELECT p.id FROM rpg.phb_background_starting_package p
    JOIN rpg.phb_background b ON b.id = p.background_id
    WHERE b.slug = 'hermit' AND p.slug = 'a'), (SELECT id FROM rpg.phb_item WHERE slug = 'kit-de-herbalismo'), NULL, 1, 2),
  ((SELECT p.id FROM rpg.phb_background_starting_package p
    JOIN rpg.phb_background b ON b.id = p.background_id
    WHERE b.slug = 'hermit' AND p.slug = 'a'), (SELECT id FROM rpg.phb_item WHERE slug = 'lampada'), NULL, 1, 3),
  ((SELECT p.id FROM rpg.phb_background_starting_package p
    JOIN rpg.phb_background b ON b.id = p.background_id
    WHERE b.slug = 'hermit' AND p.slug = 'a'), (SELECT id FROM rpg.phb_item WHERE slug = 'livro'), NULL, 1, 4),
  ((SELECT p.id FROM rpg.phb_background_starting_package p
    JOIN rpg.phb_background b ON b.id = p.background_id
    WHERE b.slug = 'hermit' AND p.slug = 'a'), (SELECT id FROM rpg.phb_item WHERE slug = 'oleo'), NULL, 1, 5),
  ((SELECT p.id FROM rpg.phb_background_starting_package p
    JOIN rpg.phb_background b ON b.id = p.background_id
    WHERE b.slug = 'hermit' AND p.slug = 'a'), (SELECT id FROM rpg.phb_item WHERE slug = 'roupas-viagem'), NULL, 1, 6),
  ((SELECT p.id FROM rpg.phb_background_starting_package p
    JOIN rpg.phb_background b ON b.id = p.background_id
    WHERE b.slug = 'hermit' AND p.slug = 'a'), (SELECT id FROM rpg.phb_item WHERE slug = 'saco-de-dormir'), NULL, 1, 7),
  ((SELECT p.id FROM rpg.phb_background_starting_package p
    JOIN rpg.phb_background b ON b.id = p.background_id
    WHERE b.slug = 'scribe' AND p.slug = 'a'), (SELECT id FROM rpg.phb_item WHERE slug = 'suprimentos-de-caligrafo'), NULL, 1, 1),
  ((SELECT p.id FROM rpg.phb_background_starting_package p
    JOIN rpg.phb_background b ON b.id = p.background_id
    WHERE b.slug = 'scribe' AND p.slug = 'a'), (SELECT id FROM rpg.phb_item WHERE slug = 'lampada'), NULL, 1, 2),
  ((SELECT p.id FROM rpg.phb_background_starting_package p
    JOIN rpg.phb_background b ON b.id = p.background_id
    WHERE b.slug = 'scribe' AND p.slug = 'a'), (SELECT id FROM rpg.phb_item WHERE slug = 'oleo'), NULL, 1, 3),
  ((SELECT p.id FROM rpg.phb_background_starting_package p
    JOIN rpg.phb_background b ON b.id = p.background_id
    WHERE b.slug = 'scribe' AND p.slug = 'a'), (SELECT id FROM rpg.phb_item WHERE slug = 'pergaminho'), NULL, 1, 4),
  ((SELECT p.id FROM rpg.phb_background_starting_package p
    JOIN rpg.phb_background b ON b.id = p.background_id
    WHERE b.slug = 'scribe' AND p.slug = 'a'), (SELECT id FROM rpg.phb_item WHERE slug = 'roupas-finas'), NULL, 1, 5),
  ((SELECT p.id FROM rpg.phb_background_starting_package p
    JOIN rpg.phb_background b ON b.id = p.background_id
    WHERE b.slug = 'farmer' AND p.slug = 'a'), (SELECT id FROM rpg.phb_item WHERE slug = 'sickle'), NULL, 1, 1),
  ((SELECT p.id FROM rpg.phb_background_starting_package p
    JOIN rpg.phb_background b ON b.id = p.background_id
    WHERE b.slug = 'farmer' AND p.slug = 'a'), (SELECT id FROM rpg.phb_item WHERE slug = 'ferramentas-de-carpinteiro'), NULL, 1, 2),
  ((SELECT p.id FROM rpg.phb_background_starting_package p
    JOIN rpg.phb_background b ON b.id = p.background_id
    WHERE b.slug = 'farmer' AND p.slug = 'a'), (SELECT id FROM rpg.phb_item WHERE slug = 'kit-de-curandeiro'), NULL, 1, 3),
  ((SELECT p.id FROM rpg.phb_background_starting_package p
    JOIN rpg.phb_background b ON b.id = p.background_id
    WHERE b.slug = 'farmer' AND p.slug = 'a'), (SELECT id FROM rpg.phb_item WHERE slug = 'balde'), NULL, 1, 4),
  ((SELECT p.id FROM rpg.phb_background_starting_package p
    JOIN rpg.phb_background b ON b.id = p.background_id
    WHERE b.slug = 'farmer' AND p.slug = 'a'), (SELECT id FROM rpg.phb_item WHERE slug = 'pa'), NULL, 1, 5),
  ((SELECT p.id FROM rpg.phb_background_starting_package p
    JOIN rpg.phb_background b ON b.id = p.background_id
    WHERE b.slug = 'guard' AND p.slug = 'a'), (SELECT id FROM rpg.phb_item WHERE slug = 'spear'), NULL, 1, 1),
  ((SELECT p.id FROM rpg.phb_background_starting_package p
    JOIN rpg.phb_background b ON b.id = p.background_id
    WHERE b.slug = 'guard' AND p.slug = 'a'), (SELECT id FROM rpg.phb_item WHERE slug = 'light-crossbow'), NULL, 1, 2),
  ((SELECT p.id FROM rpg.phb_background_starting_package p
    JOIN rpg.phb_background b ON b.id = p.background_id
    WHERE b.slug = 'guard' AND p.slug = 'a'), NULL, '20 Virotes', 1, 3),
  ((SELECT p.id FROM rpg.phb_background_starting_package p
    JOIN rpg.phb_background b ON b.id = p.background_id
    WHERE b.slug = 'guard' AND p.slug = 'a'), NULL, 'Kit de Jogo (o mesmo que acima)', 1, 4),
  ((SELECT p.id FROM rpg.phb_background_starting_package p
    JOIN rpg.phb_background b ON b.id = p.background_id
    WHERE b.slug = 'guard' AND p.slug = 'a'), (SELECT id FROM rpg.phb_item WHERE slug = 'aljava'), NULL, 1, 5),
  ((SELECT p.id FROM rpg.phb_background_starting_package p
    JOIN rpg.phb_background b ON b.id = p.background_id
    WHERE b.slug = 'guard' AND p.slug = 'a'), (SELECT id FROM rpg.phb_item WHERE slug = 'grilhoes'), NULL, 1, 6),
  ((SELECT p.id FROM rpg.phb_background_starting_package p
    JOIN rpg.phb_background b ON b.id = p.background_id
    WHERE b.slug = 'guard' AND p.slug = 'a'), (SELECT id FROM rpg.phb_item WHERE slug = 'lanterna-coberta'), NULL, 1, 7),
  ((SELECT p.id FROM rpg.phb_background_starting_package p
    JOIN rpg.phb_background b ON b.id = p.background_id
    WHERE b.slug = 'guard' AND p.slug = 'a'), (SELECT id FROM rpg.phb_item WHERE slug = 'roupas-viagem'), NULL, 1, 8),
  ((SELECT p.id FROM rpg.phb_background_starting_package p
    JOIN rpg.phb_background b ON b.id = p.background_id
    WHERE b.slug = 'guide' AND p.slug = 'a'), (SELECT id FROM rpg.phb_item WHERE slug = 'shortbow'), NULL, 1, 1),
  ((SELECT p.id FROM rpg.phb_background_starting_package p
    JOIN rpg.phb_background b ON b.id = p.background_id
    WHERE b.slug = 'guide' AND p.slug = 'a'), NULL, '20 Flechas', 1, 2),
  ((SELECT p.id FROM rpg.phb_background_starting_package p
    JOIN rpg.phb_background b ON b.id = p.background_id
    WHERE b.slug = 'guide' AND p.slug = 'a'), (SELECT id FROM rpg.phb_item WHERE slug = 'ferramentas-de-cartografo'), NULL, 1, 3),
  ((SELECT p.id FROM rpg.phb_background_starting_package p
    JOIN rpg.phb_background b ON b.id = p.background_id
    WHERE b.slug = 'guide' AND p.slug = 'a'), (SELECT id FROM rpg.phb_item WHERE slug = 'aljava'), NULL, 1, 4),
  ((SELECT p.id FROM rpg.phb_background_starting_package p
    JOIN rpg.phb_background b ON b.id = p.background_id
    WHERE b.slug = 'guide' AND p.slug = 'a'), (SELECT id FROM rpg.phb_item WHERE slug = 'roupas-viagem'), NULL, 1, 5),
  ((SELECT p.id FROM rpg.phb_background_starting_package p
    JOIN rpg.phb_background b ON b.id = p.background_id
    WHERE b.slug = 'guide' AND p.slug = 'a'), (SELECT id FROM rpg.phb_item WHERE slug = 'saco-de-dormir'), NULL, 1, 6),
  ((SELECT p.id FROM rpg.phb_background_starting_package p
    JOIN rpg.phb_background b ON b.id = p.background_id
    WHERE b.slug = 'guide' AND p.slug = 'a'), (SELECT id FROM rpg.phb_item WHERE slug = 'tenda'), NULL, 1, 7),
  ((SELECT p.id FROM rpg.phb_background_starting_package p
    JOIN rpg.phb_background b ON b.id = p.background_id
    WHERE b.slug = 'sailor' AND p.slug = 'a'), (SELECT id FROM rpg.phb_item WHERE slug = 'dagger'), NULL, 1, 1),
  ((SELECT p.id FROM rpg.phb_background_starting_package p
    JOIN rpg.phb_background b ON b.id = p.background_id
    WHERE b.slug = 'sailor' AND p.slug = 'a'), (SELECT id FROM rpg.phb_item WHERE slug = 'ferramentas-de-navegador'), NULL, 1, 2),
  ((SELECT p.id FROM rpg.phb_background_starting_package p
    JOIN rpg.phb_background b ON b.id = p.background_id
    WHERE b.slug = 'sailor' AND p.slug = 'a'), (SELECT id FROM rpg.phb_item WHERE slug = 'corda'), NULL, 1, 3),
  ((SELECT p.id FROM rpg.phb_background_starting_package p
    JOIN rpg.phb_background b ON b.id = p.background_id
    WHERE b.slug = 'sailor' AND p.slug = 'a'), (SELECT id FROM rpg.phb_item WHERE slug = 'roupas-viagem'), NULL, 1, 4),
  ((SELECT p.id FROM rpg.phb_background_starting_package p
    JOIN rpg.phb_background b ON b.id = p.background_id
    WHERE b.slug = 'merchant' AND p.slug = 'a'), (SELECT id FROM rpg.phb_item WHERE slug = 'ferramentas-de-navegador'), NULL, 1, 1),
  ((SELECT p.id FROM rpg.phb_background_starting_package p
    JOIN rpg.phb_background b ON b.id = p.background_id
    WHERE b.slug = 'merchant' AND p.slug = 'a'), NULL, '2 Algibeiras', 1, 2),
  ((SELECT p.id FROM rpg.phb_background_starting_package p
    JOIN rpg.phb_background b ON b.id = p.background_id
    WHERE b.slug = 'merchant' AND p.slug = 'a'), (SELECT id FROM rpg.phb_item WHERE slug = 'roupas-viagem'), NULL, 1, 3),
  ((SELECT p.id FROM rpg.phb_background_starting_package p
    JOIN rpg.phb_background b ON b.id = p.background_id
    WHERE b.slug = 'noble' AND p.slug = 'a'), NULL, 'Kit de Jogos (o mesmo que acima)', 1, 1),
  ((SELECT p.id FROM rpg.phb_background_starting_package p
    JOIN rpg.phb_background b ON b.id = p.background_id
    WHERE b.slug = 'noble' AND p.slug = 'a'), (SELECT id FROM rpg.phb_item WHERE slug = 'perfume'), NULL, 1, 2),
  ((SELECT p.id FROM rpg.phb_background_starting_package p
    JOIN rpg.phb_background b ON b.id = p.background_id
    WHERE b.slug = 'noble' AND p.slug = 'a'), (SELECT id FROM rpg.phb_item WHERE slug = 'roupas-finas'), NULL, 1, 3),
  ((SELECT p.id FROM rpg.phb_background_starting_package p
    JOIN rpg.phb_background b ON b.id = p.background_id
    WHERE b.slug = 'sage' AND p.slug = 'a'), (SELECT id FROM rpg.phb_item WHERE slug = 'quarterstaff'), NULL, 1, 1),
  ((SELECT p.id FROM rpg.phb_background_starting_package p
    JOIN rpg.phb_background b ON b.id = p.background_id
    WHERE b.slug = 'sage' AND p.slug = 'a'), (SELECT id FROM rpg.phb_item WHERE slug = 'suprimentos-de-caligrafo'), NULL, 1, 2),
  ((SELECT p.id FROM rpg.phb_background_starting_package p
    JOIN rpg.phb_background b ON b.id = p.background_id
    WHERE b.slug = 'sage' AND p.slug = 'a'), (SELECT id FROM rpg.phb_item WHERE slug = 'livro'), NULL, 1, 3),
  ((SELECT p.id FROM rpg.phb_background_starting_package p
    JOIN rpg.phb_background b ON b.id = p.background_id
    WHERE b.slug = 'sage' AND p.slug = 'a'), (SELECT id FROM rpg.phb_item WHERE slug = 'pergaminho'), NULL, 1, 4),
  ((SELECT p.id FROM rpg.phb_background_starting_package p
    JOIN rpg.phb_background b ON b.id = p.background_id
    WHERE b.slug = 'sage' AND p.slug = 'a'), (SELECT id FROM rpg.phb_item WHERE slug = 'tunica'), NULL, 1, 5),
  ((SELECT p.id FROM rpg.phb_background_starting_package p
    JOIN rpg.phb_background b ON b.id = p.background_id
    WHERE b.slug = 'soldier' AND p.slug = 'a'), (SELECT id FROM rpg.phb_item WHERE slug = 'spear'), NULL, 1, 1),
  ((SELECT p.id FROM rpg.phb_background_starting_package p
    JOIN rpg.phb_background b ON b.id = p.background_id
    WHERE b.slug = 'soldier' AND p.slug = 'a'), (SELECT id FROM rpg.phb_item WHERE slug = 'shortbow'), NULL, 1, 2),
  ((SELECT p.id FROM rpg.phb_background_starting_package p
    JOIN rpg.phb_background b ON b.id = p.background_id
    WHERE b.slug = 'soldier' AND p.slug = 'a'), NULL, '20 Flechas', 1, 3),
  ((SELECT p.id FROM rpg.phb_background_starting_package p
    JOIN rpg.phb_background b ON b.id = p.background_id
    WHERE b.slug = 'soldier' AND p.slug = 'a'), (SELECT id FROM rpg.phb_item WHERE slug = 'kit-de-curandeiro'), NULL, 1, 4),
  ((SELECT p.id FROM rpg.phb_background_starting_package p
    JOIN rpg.phb_background b ON b.id = p.background_id
    WHERE b.slug = 'soldier' AND p.slug = 'a'), NULL, 'Kit de Jogo (o mesmo que acima)', 1, 5),
  ((SELECT p.id FROM rpg.phb_background_starting_package p
    JOIN rpg.phb_background b ON b.id = p.background_id
    WHERE b.slug = 'soldier' AND p.slug = 'a'), (SELECT id FROM rpg.phb_item WHERE slug = 'aljava'), NULL, 1, 6),
  ((SELECT p.id FROM rpg.phb_background_starting_package p
    JOIN rpg.phb_background b ON b.id = p.background_id
    WHERE b.slug = 'soldier' AND p.slug = 'a'), (SELECT id FROM rpg.phb_item WHERE slug = 'roupas-viagem'), NULL, 1, 7);
