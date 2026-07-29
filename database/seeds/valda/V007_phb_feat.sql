-- Seed Valda feats
-- Gerado de docs/sources/valda-spire-of-secrets/extracted.json

INSERT INTO rpg.phb_feat (
  slug, name, category_id, repeatable, prerequisite, source_citation_id
)
VALUES (
  'brutal-grip',
  'Empunhadura Brutal',
  (SELECT id FROM rpg.phb_feat_category WHERE slug = 'general'),
  FALSE,
  'Nível 4+, Força 13+',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valda-spire-2024-en:player-pack')
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  category_id = EXCLUDED.category_id,
  prerequisite = EXCLUDED.prerequisite,
  source_citation_id = EXCLUDED.source_citation_id;

INSERT INTO rpg.phb_feat (
  slug, name, category_id, repeatable, prerequisite, source_citation_id
)
VALUES (
  'field-commander',
  'Comandante de Campo',
  (SELECT id FROM rpg.phb_feat_category WHERE slug = 'general'),
  FALSE,
  'Nível 4+, Carisma 13+',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valda-spire-2024-en:player-pack')
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  category_id = EXCLUDED.category_id,
  prerequisite = EXCLUDED.prerequisite,
  source_citation_id = EXCLUDED.source_citation_id;

INSERT INTO rpg.phb_feat (
  slug, name, category_id, repeatable, prerequisite, source_citation_id
)
VALUES (
  'focused-critical',
  'Crítico Focado',
  (SELECT id FROM rpg.phb_feat_category WHERE slug = 'general'),
  FALSE,
  'Nível 4+',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valda-spire-2024-en:player-pack')
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  category_id = EXCLUDED.category_id,
  prerequisite = EXCLUDED.prerequisite,
  source_citation_id = EXCLUDED.source_citation_id;

INSERT INTO rpg.phb_feat (
  slug, name, category_id, repeatable, prerequisite, source_citation_id
)
VALUES (
  'iron-hero',
  'Herói de Ferro',
  (SELECT id FROM rpg.phb_feat_category WHERE slug = 'general'),
  FALSE,
  'Nível 4+',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valda-spire-2024-en:player-pack')
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  category_id = EXCLUDED.category_id,
  prerequisite = EXCLUDED.prerequisite,
  source_citation_id = EXCLUDED.source_citation_id;
