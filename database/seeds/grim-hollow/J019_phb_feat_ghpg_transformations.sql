-- Grim Hollow Cap. 6 — transformações (shell catálogo; benefícios em J048–J059)

INSERT INTO rpg.phb_feat (slug, name, category, repeatable, prerequisite, source_citation_id)
VALUES
(
  'gh-transformation-aberrant-horror',
  'Horror Aberrante',
  'gh-transformation',
  FALSE,
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-6-transformations')
),
(
  'gh-transformation-fey',
  'Fada',
  'gh-transformation',
  FALSE,
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-6-transformations')
),
(
  'gh-transformation-fiend',
  'Corruptor',
  'gh-transformation',
  FALSE,
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-6-transformations')
),
(
  'gh-transformation-hag',
  'Bruxa',
  'gh-transformation',
  FALSE,
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-6-transformations')
),
(
  'gh-transformation-lich',
  'Lich',
  'gh-transformation',
  FALSE,
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-6-transformations')
),
(
  'gh-transformation-lycanthrope',
  'Licantropo',
  'gh-transformation',
  FALSE,
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-6-transformations')
),
(
  'gh-transformation-ooze',
  'Gosma',
  'gh-transformation',
  FALSE,
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-6-transformations')
),
(
  'gh-transformation-primordial',
  'Primordial',
  'gh-transformation',
  FALSE,
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-6-transformations')
),
(
  'gh-transformation-seraph',
  'Serafim',
  'gh-transformation',
  FALSE,
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-6-transformations')
),
(
  'gh-transformation-shadowsteel-ghoul',
  'Carniçal de Aço Sombrio',
  'gh-transformation',
  FALSE,
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-6-transformations')
),
(
  'gh-transformation-specter',
  'Espectro',
  'gh-transformation',
  FALSE,
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-6-transformations')
),
(
  'gh-transformation-vampire',
  'Vampiro',
  'gh-transformation',
  FALSE,
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-6-transformations')
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  prerequisite = EXCLUDED.prerequisite,
  source_citation_id = EXCLUDED.source_citation_id;
