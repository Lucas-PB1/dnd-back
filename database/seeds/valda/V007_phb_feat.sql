-- Seed Valda feats
-- Gerado de docs/sources/valda-spire-of-secrets/extracted.json

INSERT INTO rpg.phb_feat (
  slug, name, category_id, repeatable, prerequisite, source_citation_id
)
VALUES (
  'brutal-grip',
  'Brutal Grip',
  (SELECT id FROM rpg.phb_feat_category WHERE slug = 'general'),
  FALSE,
  'Level 4+, Strength 13+',
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
  'Field Commander',
  (SELECT id FROM rpg.phb_feat_category WHERE slug = 'general'),
  FALSE,
  'Level 4+, Charisma 13+',
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
  'Focused Critical',
  (SELECT id FROM rpg.phb_feat_category WHERE slug = 'general'),
  FALSE,
  'Level 4+',
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
  'Iron Hero',
  (SELECT id FROM rpg.phb_feat_category WHERE slug = 'general'),
  FALSE,
  'Level 4+',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valda-spire-2024-en:player-pack')
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  category_id = EXCLUDED.category_id,
  prerequisite = EXCLUDED.prerequisite,
  source_citation_id = EXCLUDED.source_citation_id;
