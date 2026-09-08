-- Recursos jogáveis — Steinhardt Eldritch Hunt subclasses
-- Grants: SSOT em effects/E007 (species) / E012 (subclass) / E013 (item) / E00* feats

INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
VALUES
  (
    'blood-strike',
    'Golpe de Sangue',
    'subclass'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'blood-hound'),
    3
  ),
  (
    'torturer-technique',
    'Técnica do Torturador',
    'subclass'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'torturer-conclave'),
    3
  ),
  (
    'veil-of-pain',
    'Véu de Dor',
    'subclass'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'torturer-conclave'),
    11
  ),
  (
    'divine-points',
    'Pontos Divinos',
    'subclass'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'blade-of-radiance'),
    3
  ),
  (
    'perfect-hunter',
    'Caçador Perfeito',
    'subclass'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'oath-of-the-eldritch-hunt'),
    20
  ),
  (
    'brittle-bone-armor',
    'Armadura de Osso Frágil',
    'subclass'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'osteomancer'),
    3
  ),
  (
    'bone-puppetry',
    'Marionetismo Ósseo',
    'subclass'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'osteomancer'),
    6
  ),
  (
    'final-judgement-spirits',
    'Espíritos Divinos',
    'subclass'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'blade-of-radiance'),
    17
  )
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  scope = EXCLUDED.scope,
  subclass_id = EXCLUDED.subclass_id,
  min_level = EXCLUDED.min_level;

-- Blood Strike: regras = 1 + CON; seed usa constitution_mod;
-- runtime em resource-max-formulas.ts aplica +1 para resourceSlug blood-strike.


-- Torturer: 6 técnicas × 2 usos = pool compartilhado 12 (SSOT aproximado; 1 gasto = 1 uso de técnica)













