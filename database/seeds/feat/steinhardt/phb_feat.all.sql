-- Talentos Steinhardt Eldritch Hunt Player Pack (origem + gerais)

INSERT INTO rpg.phb_feat (
  slug, name, category, repeatable, prerequisite, source_citation_id
)
VALUES
  (
    'faithful',
    'Fiel',
    'origin',
    FALSE,
    NULL,
    (SELECT id FROM rpg.phb_source_citation WHERE slug = 'steinhardt-eldritch-hunt-2024-en:player-pack')
  ),
  (
    'grizzled',
    'Curtido',
    'origin',
    FALSE,
    NULL,
    (SELECT id FROM rpg.phb_source_citation WHERE slug = 'steinhardt-eldritch-hunt-2024-en:player-pack')
  ),
  (
    'brutalizer',
    'Brutalizador',
    'general',
    FALSE,
    'Nível 4+; Força 16+',
    (SELECT id FROM rpg.phb_source_citation WHERE slug = 'steinhardt-eldritch-hunt-2024-en:player-pack')
  ),
  (
    'cannoneer',
    'Canhoneiro',
    'general',
    FALSE,
    'Nível 8+; Força 18+',
    (SELECT id FROM rpg.phb_source_citation WHERE slug = 'steinhardt-eldritch-hunt-2024-en:player-pack')
  )
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  repeatable = EXCLUDED.repeatable,
  prerequisite = EXCLUDED.prerequisite,
  source_citation_id = EXCLUDED.source_citation_id;
