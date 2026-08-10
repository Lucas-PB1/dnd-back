-- Edição DMG 2024 PT (itens mágicos Cap. 7)

INSERT INTO rpg.phb_edition (slug, label, book, language, extracted_at, notes)
VALUES (
  'dmg-2024-pt',
  'DMG 2024 PT',
  'Livro do Mestre 2024 (comunidade PT)',
  'pt',
  NOW(),
  'Itens mágicos A–Z — Cap. 7; seed D010+'
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
  'dmg-2024-pt:ch7:itens-magicos',
  (SELECT id FROM rpg.phb_edition WHERE slug = 'dmg-2024-pt'),
  7,
  'Itens Mágicos A–Z',
  NOW()
)
ON CONFLICT (slug) DO UPDATE SET
  edition_id = EXCLUDED.edition_id,
  chapter = EXCLUDED.chapter,
  chapter_title = EXCLUDED.chapter_title,
  extracted_at = EXCLUDED.extracted_at;
