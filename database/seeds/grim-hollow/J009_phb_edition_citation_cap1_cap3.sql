-- Grim Hollow — citações Cap. 1 e Cap. 3

INSERT INTO rpg.phb_source_citation (slug, edition_id, chapter, chapter_title, extracted_at)
VALUES
  (
    'grim-hollow-players-guide-2024-en:chapter-1-heritages-traits',
    (SELECT id FROM rpg.phb_edition WHERE slug = 'grim-hollow-players-guide-2024-en'),
    1,
    'Grim Hollow — Capítulo 1: Heranças e traços',
    NOW()
  ),
  (
    'grim-hollow-players-guide-2024-en:chapter-3-backgrounds',
    (SELECT id FROM rpg.phb_edition WHERE slug = 'grim-hollow-players-guide-2024-en'),
    3,
    'Grim Hollow — Capítulo 3: Antecedentes',
    NOW()
  )
ON CONFLICT (slug) DO UPDATE SET
  edition_id = EXCLUDED.edition_id,
  chapter = EXCLUDED.chapter,
  chapter_title = EXCLUDED.chapter_title,
  extracted_at = EXCLUDED.extracted_at;

UPDATE rpg.phb_edition SET notes = 'Grim Hollow — heranças, antecedentes avançados, armas e equipamento; textos em PT-BR onde disponível'
WHERE slug = 'grim-hollow-players-guide-2024-en';
