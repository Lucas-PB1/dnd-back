-- Grim Hollow — citação Cap. 2 (subclasses)

INSERT INTO rpg.phb_source_citation (slug, edition_id, chapter, chapter_title, extracted_at)
VALUES (
  'grim-hollow-players-guide-2024-en:chapter-2-character-classes',
  (SELECT id FROM rpg.phb_edition WHERE slug = 'grim-hollow-players-guide-2024-en'),
  2,
  'Grim Hollow — Capítulo 2: Classes e Subclasses',
  NOW()
)
ON CONFLICT (slug) DO UPDATE SET
  edition_id = EXCLUDED.edition_id,
  chapter = EXCLUDED.chapter,
  chapter_title = EXCLUDED.chapter_title,
  extracted_at = EXCLUDED.extracted_at;

UPDATE rpg.phb_edition SET notes = 'Grim Hollow — heranças, subclasses, antecedentes, talentos, equipamento avançado e transformações; textos em PT-BR onde disponível'
WHERE slug = 'grim-hollow-players-guide-2024-en';
