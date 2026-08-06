-- Edição Valdas + citações (Player Pack e Gunslinger)
-- Absorve o que era D018/D019 (edição + citações Valdas).

INSERT INTO rpg.phb_edition (slug, label, book, language, extracted_at, notes)
VALUES (
  'valdas-spire-2024-en',
  'Valdas Spire 2024',
  'Valdas Spire of Secrets: Player Pack',
  'pt',
  NOW(),
  'Mage Hand Press — conteúdo traduzido para PT-BR do catálogo Grimoire (regras 2024)'
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
    'valdas-spire-2024-en:player-pack',
    (SELECT id FROM rpg.phb_edition WHERE slug = 'valdas-spire-2024-en'),
    1,
    'Valdas Spire of Secrets: Pacote do Jogador',
    NOW()
  ),
  (
    'valdas-spire-2024-en:gunslinger',
    (SELECT id FROM rpg.phb_edition WHERE slug = 'valdas-spire-2024-en'),
    2,
    'Valdas Spire of Secrets: A Classe do Pistoleiro',
    NOW()
  )
ON CONFLICT (slug) DO UPDATE SET
  edition_id = EXCLUDED.edition_id,
  chapter = EXCLUDED.chapter,
  chapter_title = EXCLUDED.chapter_title,
  extracted_at = EXCLUDED.extracted_at;
