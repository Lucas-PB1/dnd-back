-- Seed Valdas feats
-- Conteúdo canônico Valdas: Spire of Secrets

INSERT INTO rpg.phb_feat (
  slug, name, category, repeatable, prerequisite, source_citation_id
)
VALUES (
  'brutal-grip',
  'Empunhadura Brutal',
  'general',
  FALSE,
  'Nível 4+, Força 13+',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valdas-spire-2024-en:player-pack')
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  prerequisite = EXCLUDED.prerequisite,
  source_citation_id = EXCLUDED.source_citation_id;

INSERT INTO rpg.phb_feat (
  slug, name, category, repeatable, prerequisite, source_citation_id
)
VALUES (
  'field-commander',
  'Comandante de Campo',
  'general',
  FALSE,
  'Nível 4+, Carisma 13+',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valdas-spire-2024-en:player-pack')
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  prerequisite = EXCLUDED.prerequisite,
  source_citation_id = EXCLUDED.source_citation_id;

INSERT INTO rpg.phb_feat (
  slug, name, category, repeatable, prerequisite, source_citation_id
)
VALUES (
  'focused-critical',
  'Crítico Focado',
  'general',
  FALSE,
  'Nível 4+',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valdas-spire-2024-en:player-pack')
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  prerequisite = EXCLUDED.prerequisite,
  source_citation_id = EXCLUDED.source_citation_id;

INSERT INTO rpg.phb_feat (
  slug, name, category, repeatable, prerequisite, source_citation_id
)
VALUES (
  'iron-hero',
  'Herói de Ferro',
  'general',
  FALSE,
  'Nível 4+',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valdas-spire-2024-en:player-pack')
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  prerequisite = EXCLUDED.prerequisite,
  source_citation_id = EXCLUDED.source_citation_id;
