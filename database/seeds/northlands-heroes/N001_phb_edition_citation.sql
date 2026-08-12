-- Edição Northlands Worldbook (Heroes of the Sagas) + citação Cap. 4

INSERT INTO rpg.phb_edition (slug, label, book, language, extracted_at, notes)
VALUES (
  'northlands-heroes-2024-en',
  'Northlands Heroes 2024',
  'Northlands Worldbook: Heroes of the Sagas',
  'pt',
  NOW(),
  'Kobold Press / Northlands — Cap. 4 Heroes of the Sagas; textos traduzidos para PT-BR (regras 2024)'
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
VALUES
  (
    'northlands-heroes-2024-en:heroes-of-the-sagas',
    (SELECT id FROM rpg.phb_edition WHERE slug = 'northlands-heroes-2024-en'),
    4,
    'Northlands Worldbook: Heróis das Sagas',
    NOW()
  ),
  (
    'northlands-heroes-2024-en:magic-and-miscellany',
    (SELECT id FROM rpg.phb_edition WHERE slug = 'northlands-heroes-2024-en'),
    5,
    'Northlands Worldbook: Magic and Miscellany',
    NOW()
  )
ON CONFLICT (slug) DO UPDATE SET
  edition_id = EXCLUDED.edition_id,
  chapter = EXCLUDED.chapter,
  chapter_title = EXCLUDED.chapter_title,
  extracted_at = EXCLUDED.extracted_at;
