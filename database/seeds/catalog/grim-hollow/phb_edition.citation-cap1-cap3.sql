-- Grim Hollow — citações Cap. 3, 4 e 6 (backgrounds + feats + transformations)

INSERT INTO rpg.phb_source_citation (slug, edition_id, chapter, chapter_title, extracted_at)
VALUES
  (
    'grim-hollow-players-guide-2024-en:chapter-3-backgrounds',
    (SELECT id FROM rpg.phb_edition WHERE slug = 'grim-hollow-players-guide-2024-en'),
    3,
    'Grim Hollow — Capítulo 3: Antecedentes',
    NOW()
  ),
  (
    'grim-hollow-players-guide-2024-en:chapter-4-character-feats',
    (SELECT id FROM rpg.phb_edition WHERE slug = 'grim-hollow-players-guide-2024-en'),
    4,
    'Grim Hollow — Capítulo 4: Talentos de Personagem',
    NOW()
  ),
  (
    'grim-hollow-players-guide-2024-en:chapter-6-transformations',
    (SELECT id FROM rpg.phb_edition WHERE slug = 'grim-hollow-players-guide-2024-en'),
    6,
    'Grim Hollow — Capítulo 6: Transformações',
    NOW()
  )
ON CONFLICT (slug) DO UPDATE SET
  edition_id = EXCLUDED.edition_id,
  chapter = EXCLUDED.chapter,
  chapter_title = EXCLUDED.chapter_title,
  extracted_at = EXCLUDED.extracted_at;

UPDATE rpg.phb_edition SET notes = 'Grim Hollow — heranças, antecedentes PHB 2024, talentos, equipamento avançado e transformações; textos em PT-BR onde disponível'
WHERE slug = 'grim-hollow-players-guide-2024-en';
