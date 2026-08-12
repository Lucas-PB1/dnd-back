-- Talentos de origem Northlands (Heroes of the Sagas)

INSERT INTO rpg.phb_feat (
  slug, name, category, repeatable, prerequisite, source_citation_id
)
VALUES
  (
    'blessing-of-baldur',
    'Bênção de Baldur',
    'origin',
    FALSE,
    NULL,
    (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:heroes-of-the-sagas')
  ),
  (
    'blessing-of-boreas',
    'Bênção de Boreas',
    'origin',
    FALSE,
    NULL,
    (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:heroes-of-the-sagas')
  ),
  (
    'blessing-of-eir',
    'Bênção de Eir',
    'origin',
    FALSE,
    NULL,
    (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:heroes-of-the-sagas')
  ),
  (
    'blessing-of-freyr-and-freyja',
    'Bênção de Freyr e Freyja',
    'origin',
    FALSE,
    NULL,
    (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:heroes-of-the-sagas')
  ),
  (
    'blessing-of-jormungandr',
    'Bênção de Jormungandr',
    'origin',
    FALSE,
    NULL,
    (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:heroes-of-the-sagas')
  ),
  (
    'blessing-of-loki',
    'Bênção de Loki',
    'origin',
    FALSE,
    NULL,
    (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:heroes-of-the-sagas')
  ),
  (
    'blessing-of-sif',
    'Bênção de Sif',
    'origin',
    FALSE,
    NULL,
    (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:heroes-of-the-sagas')
  ),
  (
    'blessing-of-thor',
    'Bênção de Thor',
    'origin',
    FALSE,
    NULL,
    (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:heroes-of-the-sagas')
  ),
  (
    'blessing-of-volund',
    'Bênção de Volund',
    'origin',
    FALSE,
    NULL,
    (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:heroes-of-the-sagas')
  ),
  (
    'blessing-of-wotan',
    'Bênção de Wotan',
    'origin',
    FALSE,
    NULL,
    (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:heroes-of-the-sagas')
  ),
  (
    'brewer',
    'Cervejeiro',
    'origin',
    FALSE,
    NULL,
    (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:heroes-of-the-sagas')
  ),
  (
    'cold-plunge-training',
    'Treino de Mergulho Gelado',
    'origin',
    FALSE,
    NULL,
    (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:heroes-of-the-sagas')
  ),
  (
    'fisher',
    'Pescador',
    'origin',
    FALSE,
    NULL,
    (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:heroes-of-the-sagas')
  ),
  (
    'norn-touched',
    'Tocado pelas Nornas',
    'origin',
    FALSE,
    NULL,
    (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:heroes-of-the-sagas')
  ),
  (
    'northern-raider',
    'Saqueador do Norte',
    'origin',
    FALSE,
    NULL,
    (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:heroes-of-the-sagas')
  ),
  (
    'sea-wolf',
    'Lobo do Mar',
    'origin',
    FALSE,
    NULL,
    (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:heroes-of-the-sagas')
  ),
  (
    'snowrunner',
    'Corredor da Neve',
    'origin',
    FALSE,
    NULL,
    (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:heroes-of-the-sagas')
  ),
  (
    'well-versed',
    'Versado nas Sagas',
    'origin',
    FALSE,
    NULL,
    (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:heroes-of-the-sagas')
  )
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  repeatable = EXCLUDED.repeatable,
  prerequisite = EXCLUDED.prerequisite,
  source_citation_id = EXCLUDED.source_citation_id;
