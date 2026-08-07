-- Seed Valdas Player Pack 2 feats

INSERT INTO rpg.phb_feat (
  slug, name, category, repeatable, prerequisite, source_citation_id
)
VALUES (
  'familiar-keeper',
  'Guardião de Familiar',
  'general',
  FALSE,
  'Nível 4+',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valdas-spire-2024-en:player-pack-2')
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
  'flex-caster',
  'Conjurador Flexível',
  'general',
  FALSE,
  'Nível 4+; Traço Conjuração',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valdas-spire-2024-en:player-pack-2')
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
  'magitechnician',
  'Magitécnico',
  'general',
  FALSE,
  'Nível 4+',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valdas-spire-2024-en:player-pack-2')
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
  'metabolistic-magic',
  'Magia Metabólica',
  'general',
  FALSE,
  'Nível 4+, Traço Conjuração ou Magia de Pacto',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valdas-spire-2024-en:player-pack-2')
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
  'pyromaniac',
  'Piromaníaco',
  'general',
  FALSE,
  'Nível 4+',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valdas-spire-2024-en:player-pack-2')
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
  'shock-trooper',
  'Tropa de Choque',
  'general',
  FALSE,
  'Nível 4+, Força ou Destreza 13+',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valdas-spire-2024-en:player-pack-2')
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
  'showman',
  'Showman',
  'general',
  FALSE,
  'Nível 4+, Carisma 13+',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valdas-spire-2024-en:player-pack-2')
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
  'spellblade',
  'Lâmina Arcana',
  'general',
  FALSE,
  'Nível 4+; Inteligência, Sabedoria ou Carisma 13+',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valdas-spire-2024-en:player-pack-2')
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  prerequisite = EXCLUDED.prerequisite,
  source_citation_id = EXCLUDED.source_citation_id;
