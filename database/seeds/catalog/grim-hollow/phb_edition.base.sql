-- Grim Hollow Player's Guide — edição + citações Cap. 4 e 5

INSERT INTO rpg.phb_edition (slug, label, book, language, extracted_at, notes)
VALUES (
  'grim-hollow-players-guide-2024-en',
  'Grim Hollow Player''s Guide 2024',
  'Grim Hollow: Player''s Guide',
  'pt',
  NOW(),
  'Grim Hollow — armas avançadas, equipamento e talentos; textos em PT-BR'
)
ON CONFLICT (slug) DO UPDATE SET
  label = EXCLUDED.label,
  book = EXCLUDED.book,
  language = EXCLUDED.language,
  notes = EXCLUDED.notes,
  extracted_at = EXCLUDED.extracted_at;

INSERT INTO rpg.phb_source_citation (slug, edition_id, chapter, chapter_title, extracted_at)
VALUES
  (
    'grim-hollow-players-guide-2024-en:chapter-4-character-feats',
    (SELECT id FROM rpg.phb_edition WHERE slug = 'grim-hollow-players-guide-2024-en'),
    4,
    'Grim Hollow — Capítulo 4: Talentos de Personagem',
    NOW()
  ),
  (
    'grim-hollow-players-guide-2024-en:chapter-5-advanced-weapons-equipment',
    (SELECT id FROM rpg.phb_edition WHERE slug = 'grim-hollow-players-guide-2024-en'),
    5,
    'Grim Hollow — Capítulo 5: Armas e Equipamento Avançados',
    NOW()
  )
ON CONFLICT (slug) DO UPDATE SET
  edition_id = EXCLUDED.edition_id,
  chapter = EXCLUDED.chapter,
  chapter_title = EXCLUDED.chapter_title,
  extracted_at = EXCLUDED.extracted_at;
