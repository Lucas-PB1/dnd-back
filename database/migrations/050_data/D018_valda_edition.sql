-- Valda's Spire of Secrets: Player Pack — edição + citação

INSERT INTO rpg.phb_edition (slug, label, book, language, extracted_at, notes)
VALUES (
  'valda-spire-2024-en',
  'Valda Spire 2024',
  'Valda''s Spire of Secrets: Player Pack',
  'pt',
  NOW(),
  'Mage Hand Press — Player Pack traduzido para PT-BR do catálogo Grimoire (regras 2024)'
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
  'valda-spire-2024-en:player-pack',
  (SELECT id FROM rpg.phb_edition WHERE slug = 'valda-spire-2024-en'),
  1,
  'Valda''s Spire of Secrets: Pacote do Jogador',
  NOW()
)
ON CONFLICT (slug) DO UPDATE SET
  chapter = EXCLUDED.chapter,
  chapter_title = EXCLUDED.chapter_title,
  extracted_at = EXCLUDED.extracted_at;
