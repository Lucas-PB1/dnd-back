-- Seed rpg.phb_source_citation
-- Gerado automaticamente — não editar à mão

INSERT INTO rpg.phb_source_citation (slug, edition_id, chapter, chapter_title, pdf_path, pdf_pages, extracted_at)
VALUES
  ('phb-2024-pt:ch4:177-185', (SELECT id FROM rpg.phb_edition WHERE slug = 'phb-2024-pt'), 4, 'Origens dos Personagens', 'doc/livro-jogador.pdf', ARRAY[177, 185]::integer[], '2026-06-25T23:29:50.537Z'::timestamptz),
  ('phb-2024-pt:ch3:55-182', (SELECT id FROM rpg.phb_edition WHERE slug = 'phb-2024-pt'), 3, 'Classes de Personagem', 'doc/livro-jogador.pdf', ARRAY[55, 182]::integer[], '2026-06-25T01:13:29.372Z'::timestamptz),
  ('phb-2024-pt:ch5:205-217', (SELECT id FROM rpg.phb_edition WHERE slug = 'phb-2024-pt'), 5, 'Talentos', 'doc/livro-jogador.pdf', ARRAY[205, 217]::integer[], '2026-06-25T01:46:09.796Z'::timestamptz),
  ('phb-2024-pt:ch7:241-349', (SELECT id FROM rpg.phb_edition WHERE slug = 'phb-2024-pt'), 7, 'Magias', 'doc/livro-jogador.pdf', ARRAY[241, 349]::integer[], '2026-06-25T01:53:01.484Z'::timestamptz);
