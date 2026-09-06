-- Edição Steinhardt's Guide to the Eldritch Hunt (Player Pack) + citação Subclasses

INSERT INTO rpg.phb_edition (slug, label, book, language, extracted_at, notes)
VALUES (
  'steinhardt-eldritch-hunt-2024-en',
  'Steinhardt Eldritch Hunt 2024',
  'Steinhardt''s Guide to the Eldritch Hunt: Player Pack',
  'pt',
  NOW(),
  'Morrus / Steinhardt — subclasses do Player Pack; textos traduzidos para PT-BR (regras 2024)'
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
    'steinhardt-eldritch-hunt-2024-en:player-pack',
    (SELECT id FROM rpg.phb_edition WHERE slug = 'steinhardt-eldritch-hunt-2024-en'),
    1,
    'Steinhardt''s Guide to the Eldritch Hunt: Pacote do Jogador — Subclasses',
    NOW()
  )
ON CONFLICT (slug) DO UPDATE SET
  edition_id = EXCLUDED.edition_id,
  chapter = EXCLUDED.chapter,
  chapter_title = EXCLUDED.chapter_title,
  extracted_at = EXCLUDED.extracted_at;
