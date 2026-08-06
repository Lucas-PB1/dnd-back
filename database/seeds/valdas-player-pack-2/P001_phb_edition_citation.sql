-- Citation Valdas Player Pack 2 (edição já existe em valdas/V001)

INSERT INTO rpg.phb_source_citation (
  slug, edition_id, chapter, chapter_title, extracted_at
)
VALUES
  (
    'valdas-spire-2024-en:player-pack-2',
    (SELECT id FROM rpg.phb_edition WHERE slug = 'valdas-spire-2024-en'),
    3,
    'Valdas Spire of Secrets: Pacote do Jogador 2',
    NOW()
  )
ON CONFLICT (slug) DO UPDATE SET
  edition_id = EXCLUDED.edition_id,
  chapter = EXCLUDED.chapter,
  chapter_title = EXCLUDED.chapter_title,
  extracted_at = EXCLUDED.extracted_at;
