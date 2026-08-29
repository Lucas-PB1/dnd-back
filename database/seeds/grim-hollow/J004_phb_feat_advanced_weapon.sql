-- Talentos Grim Hollow — Proficiência em Armas Avançadas (Cap. 4)

INSERT INTO rpg.phb_feat (
  slug, name, category, repeatable, prerequisite, source_citation_id
)
VALUES (
  'advanced-weapon-proficiency',
  'Proficiência em Armas Avançadas',
  'fighting-style',
  FALSE,
  'Característica de Estilo de Luta (ou nível 8+ como talento Geral)',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-4-character-feats')
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  prerequisite = EXCLUDED.prerequisite,
  source_citation_id = EXCLUDED.source_citation_id;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description)
VALUES
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'advanced-weapon-proficiency'),
    1,
    'Proficiência com Armas',
    'Você tem proficiência com armas Avançadas e pode usar as propriedades de maestria dessas armas.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'advanced-weapon-proficiency'),
    2,
    'Especial',
    'Este talento pode ser escolhido como talento Geral por personagens de nível 8 ou superior.'
  )
ON CONFLICT (feat_id, sort_order) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description;

INSERT INTO rpg.phb_fighting_style (slug, name, description)
VALUES (
  'advanced-weapon-proficiency',
  'Proficiência em Armas Avançadas',
  'Você tem proficiência com armas Avançadas e pode usar as propriedades de maestria dessas armas.'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description;
