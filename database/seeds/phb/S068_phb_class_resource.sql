-- Definições de recurso de classe (grants → effects/E009_class.sql)

INSERT INTO rpg.phb_resource_definition (slug, name, scope, species_id, class_id, min_level)
VALUES
  (
    'actionSurge',
    'Surto de Ação',
    'class'::rpg.resource_scope,
    NULL,
    (SELECT id FROM rpg.phb_class WHERE slug = 'fighter'),
    2
  ),
  (
    'secondWind',
    'Recuperar Fôlego',
    'class'::rpg.resource_scope,
    NULL,
    (SELECT id FROM rpg.phb_class WHERE slug = 'fighter'),
    1
  ),
  (
    'indomitable',
    'Indomável',
    'class'::rpg.resource_scope,
    NULL,
    (SELECT id FROM rpg.phb_class WHERE slug = 'fighter'),
    9
  ),
  (
    'bardicInspiration',
    'Inspiração de Bardo',
    'class'::rpg.resource_scope,
    NULL,
    (SELECT id FROM rpg.phb_class WHERE slug = 'bard'),
    1
  ),
  (
    'strokeOfLuck',
    'Golpe de Sorte',
    'class'::rpg.resource_scope,
    NULL,
    (SELECT id FROM rpg.phb_class WHERE slug = 'rogue'),
    20
  ),
  (
    'layOnHands',
    'Mãos Consagradas',
    'class'::rpg.resource_scope,
    NULL,
    (SELECT id FROM rpg.phb_class WHERE slug = 'paladin'),
    1
  ),
  (
    'favoredEnemy',
    'Inimigo Favorito',
    'class'::rpg.resource_scope,
    NULL,
    (SELECT id FROM rpg.phb_class WHERE slug = 'ranger'),
    1
  ),
  (
    'tireless',
    'Incansável',
    'class'::rpg.resource_scope,
    NULL,
    (SELECT id FROM rpg.phb_class WHERE slug = 'ranger'),
    10
  ),
  (
    'naturesVeil',
    'Véu da Natureza',
    'class'::rpg.resource_scope,
    NULL,
    (SELECT id FROM rpg.phb_class WHERE slug = 'ranger'),
    14
  ),
  (
    'divineIntervention',
    'Intervenção Divina',
    'class'::rpg.resource_scope,
    NULL,
    (SELECT id FROM rpg.phb_class WHERE slug = 'cleric'),
    10
  ),
  (
    'magical-cunning',
    'Astúcia Mágica',
    'class'::rpg.resource_scope,
    NULL,
    (SELECT id FROM rpg.phb_class WHERE slug = 'warlock'),
    2
  ),
  (
    'sorceryPoints',
    'Pontos de Feitiçaria',
    'class'::rpg.resource_scope,
    NULL,
    (SELECT id FROM rpg.phb_class WHERE slug = 'sorcerer'),
    2
  ),
  (
    'innate-sorcery',
    'Feitiçaria Inata',
    'class'::rpg.resource_scope,
    NULL,
    (SELECT id FROM rpg.phb_class WHERE slug = 'sorcerer'),
    1
  ),
  (
    'sorcerous-restoration',
    'Restauração Feiticeira',
    'class'::rpg.resource_scope,
    NULL,
    (SELECT id FROM rpg.phb_class WHERE slug = 'sorcerer'),
    5
  )
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  scope = EXCLUDED.scope,
  class_id = EXCLUDED.class_id,
  min_level = EXCLUDED.min_level;

-- Druida — Forma Selvagem (definição; grant em E009)
INSERT INTO rpg.phb_resource_definition (slug, name, scope, species_id, class_id, min_level)
VALUES (
  'wildShape',
  'Forma Selvagem',
  'class'::rpg.resource_scope,
  NULL,
  (SELECT id FROM rpg.phb_class WHERE slug = 'druid'),
  2
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  scope = EXCLUDED.scope,
  class_id = EXCLUDED.class_id,
  min_level = EXCLUDED.min_level;
