-- Edição The Griffon's Saddlebag: Book One (Part II) + citação

INSERT INTO rpg.phb_edition (slug, label, book, language, extracted_at, notes)
VALUES (
  'griffons-saddlebag-book-one-2024-en',
  'Griffon''s Saddlebag: Livro Um 2024',
  'Griffon''s Saddlebag: Livro Um',
  'pt',
  NOW(),
  'Griffon''s Saddlebag: Livro Um — Parte II: Opções de Personagem; textos em PT-BR (regras 2024)'
)
ON CONFLICT (slug) DO UPDATE SET
  label = EXCLUDED.label,
  book = EXCLUDED.book,
  language = EXCLUDED.language,
  notes = EXCLUDED.notes,
  extracted_at = EXCLUDED.extracted_at;

INSERT INTO rpg.phb_source_citation (
  slug, edition_id, chapter, chapter_title, extracted_at
)
VALUES (
  'griffons-saddlebag-book-one-2024-en:part-ii-character-options',
  (SELECT id FROM rpg.phb_edition WHERE slug = 'griffons-saddlebag-book-one-2024-en'),
  2,
  'Griffon''s Saddlebag: Livro Um — Parte II: Opções de Personagem',
  NOW()
)
ON CONFLICT (slug) DO UPDATE SET
  edition_id = EXCLUDED.edition_id,
  chapter = EXCLUDED.chapter,
  chapter_title = EXCLUDED.chapter_title,
  extracted_at = EXCLUDED.extracted_at;
