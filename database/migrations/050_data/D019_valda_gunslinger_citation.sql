-- Valda Gunslinger — citação (reusa edição valda-spire-2024-en)

INSERT INTO rpg.phb_edition (slug, label, book, language, extracted_at, notes)
VALUES (
  'valda-spire-2024-en',
  'Valda Spire 2024',
  'Valda''s Spire of Secrets',
  'pt',
  NOW(),
  'Mage Hand Press — Classe Pistoleiro traduzida para PT-BR do catálogo Grimoire (regras 2024)'
)
ON CONFLICT (slug) DO UPDATE SET
  label = EXCLUDED.label,
  language = EXCLUDED.language,
  notes = EXCLUDED.notes,
  extracted_at = EXCLUDED.extracted_at;

INSERT INTO rpg.phb_source_citation (
  slug, edition_id, chapter, chapter_title, extracted_at
)
VALUES (
  'valda-spire-2024-en:gunslinger',
  (SELECT id FROM rpg.phb_edition WHERE slug = 'valda-spire-2024-en'),
  2,
  'Valda''s Spire of Secrets: A Classe Pistoleiro',
  NOW()
)
ON CONFLICT (slug) DO UPDATE SET
  chapter = EXCLUDED.chapter,
  chapter_title = EXCLUDED.chapter_title,
  extracted_at = EXCLUDED.extracted_at;
