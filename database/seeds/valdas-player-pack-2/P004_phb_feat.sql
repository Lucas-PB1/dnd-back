-- Seed Valdas Player Pack 2 feats

INSERT INTO rpg.phb_feat (
  slug, name, category_id, repeatable, prerequisite, source_citation_id
)
VALUES (
  'familiar-keeper',
  'Guardião de Familiar',
  (SELECT id FROM rpg.phb_feat_category WHERE slug = 'general'),
  FALSE,
  'Nível 4+',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valdas-spire-2024-en:player-pack-2')
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
  'flex-caster',
  'Conjurador Flexível',
  (SELECT id FROM rpg.phb_feat_category WHERE slug = 'general'),
  FALSE,
  'Nível 4+; Traço Conjuração',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valdas-spire-2024-en:player-pack-2')
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
  'magitechnician',
  'Magitécnico',
  (SELECT id FROM rpg.phb_feat_category WHERE slug = 'general'),
  FALSE,
  'Nível 4+',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valdas-spire-2024-en:player-pack-2')
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
  'metabolistic-magic',
  'Magia Metabólica',
  (SELECT id FROM rpg.phb_feat_category WHERE slug = 'general'),
  FALSE,
  'Nível 4+, Traço Conjuração ou Magia de Pacto',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valdas-spire-2024-en:player-pack-2')
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
  'pyromaniac',
  'Piromaníaco',
  (SELECT id FROM rpg.phb_feat_category WHERE slug = 'general'),
  FALSE,
  'Nível 4+',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valdas-spire-2024-en:player-pack-2')
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
  'shock-trooper',
  'Tropa de Choque',
  (SELECT id FROM rpg.phb_feat_category WHERE slug = 'general'),
  FALSE,
  'Nível 4+, Força ou Destreza 13+',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valdas-spire-2024-en:player-pack-2')
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
  'showman',
  'Showman',
  (SELECT id FROM rpg.phb_feat_category WHERE slug = 'general'),
  FALSE,
  'Nível 4+, Carisma 13+',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valdas-spire-2024-en:player-pack-2')
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
  'spellblade',
  'Lâmina Arcana',
  (SELECT id FROM rpg.phb_feat_category WHERE slug = 'general'),
  FALSE,
  'Nível 4+; Inteligência, Sabedoria ou Carisma 13+',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valdas-spire-2024-en:player-pack-2')
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  category_id = EXCLUDED.category_id,
  prerequisite = EXCLUDED.prerequisite,
  source_citation_id = EXCLUDED.source_citation_id;
