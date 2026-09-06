-- Grim Hollow — citação Cap. 7 (Spells & Curses)

INSERT INTO rpg.phb_source_citation (slug, edition_id, chapter, chapter_title, extracted_at)
VALUES (
  'grim-hollow-players-guide-2024-en:chapter-7-spells-curses',
  (SELECT id FROM rpg.phb_edition WHERE slug = 'grim-hollow-players-guide-2024-en'),
  7,
  'Grim Hollow — Capítulo 7: Magias e Maldições',
  NOW()
)
ON CONFLICT (slug) DO UPDATE SET
  edition_id = EXCLUDED.edition_id,
  chapter = EXCLUDED.chapter,
  chapter_title = EXCLUDED.chapter_title,
  extracted_at = EXCLUDED.extracted_at;
