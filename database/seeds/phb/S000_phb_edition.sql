-- Edição canônica PHB 2024 (bootstrap de catálogo — não fica em migration)

INSERT INTO rpg.phb_edition (slug, label, book, language, extracted_at)
VALUES (
  'phb-2024-pt',
  'PHB 2024 PT-BR',
  'Livro do Jogador 2024',
  'pt-BR',
  NOW()
)
ON CONFLICT (slug) DO UPDATE SET
  label = EXCLUDED.label,
  book = EXCLUDED.book,
  language = EXCLUDED.language;
