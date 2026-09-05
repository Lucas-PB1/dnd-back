-- GH heritage traits — defs Cap. 1 (grants → effects/E010_heritage.sql)
-- Grants: SSOT em effects/E010_heritage.sql

-- born-lucky @1× → gh-born-lucky
INSERT INTO rpg.phb_resource_definition (slug, name, scope, heritage_trait_id, min_level)
SELECT
  'gh-born-lucky',
  'Nascido Sob a Sorte',
  'heritage'::rpg.resource_scope,
  ht.id,
  1
FROM rpg.phb_heritage_trait ht
WHERE ht.slug = 'born-lucky'
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  scope = EXCLUDED.scope,
  heritage_trait_id = EXCLUDED.heritage_trait_id;


-- centered-edge @1× → gh-centered-edge
INSERT INTO rpg.phb_resource_definition (slug, name, scope, heritage_trait_id, min_level)
SELECT
  'gh-centered-edge',
  'Fio Centrado',
  'heritage'::rpg.resource_scope,
  ht.id,
  1
FROM rpg.phb_heritage_trait ht
WHERE ht.slug = 'centered-edge'
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  scope = EXCLUDED.scope,
  heritage_trait_id = EXCLUDED.heritage_trait_id;


-- damage-immunity @2× → gh-damage-immunity-x2
INSERT INTO rpg.phb_resource_definition (slug, name, scope, heritage_trait_id, min_level)
SELECT
  'gh-damage-immunity-x2',
  'Imunidade a Dano (aprimorado)',
  'heritage'::rpg.resource_scope,
  ht.id,
  1
FROM rpg.phb_heritage_trait ht
WHERE ht.slug = 'damage-immunity'
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  scope = EXCLUDED.scope,
  heritage_trait_id = EXCLUDED.heritage_trait_id;


-- determined-hearing @2× → gh-determined-hearing-x2
INSERT INTO rpg.phb_resource_definition (slug, name, scope, heritage_trait_id, min_level)
SELECT
  'gh-determined-hearing-x2',
  'Audição Determinada (aprimorado)',
  'heritage'::rpg.resource_scope,
  ht.id,
  1
FROM rpg.phb_heritage_trait ht
WHERE ht.slug = 'determined-hearing'
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  scope = EXCLUDED.scope,
  heritage_trait_id = EXCLUDED.heritage_trait_id;


-- ethereal-focus @1× → gh-ethereal-focus
INSERT INTO rpg.phb_resource_definition (slug, name, scope, heritage_trait_id, min_level)
SELECT
  'gh-ethereal-focus',
  'Foco Etéreo',
  'heritage'::rpg.resource_scope,
  ht.id,
  1
FROM rpg.phb_heritage_trait ht
WHERE ht.slug = 'ethereal-focus'
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  scope = EXCLUDED.scope,
  heritage_trait_id = EXCLUDED.heritage_trait_id;


-- expert-improviser @1× → gh-expert-improviser
INSERT INTO rpg.phb_resource_definition (slug, name, scope, heritage_trait_id, min_level)
SELECT
  'gh-expert-improviser',
  'Improvisador Expert',
  'heritage'::rpg.resource_scope,
  ht.id,
  1
FROM rpg.phb_heritage_trait ht
WHERE ht.slug = 'expert-improviser'
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  scope = EXCLUDED.scope,
  heritage_trait_id = EXCLUDED.heritage_trait_id;


-- extended-fortification @2× → gh-extended-fortification-x2
INSERT INTO rpg.phb_resource_definition (slug, name, scope, heritage_trait_id, min_level)
SELECT
  'gh-extended-fortification-x2',
  'Fortificação Estendida (aprimorado)',
  'heritage'::rpg.resource_scope,
  ht.id,
  1
FROM rpg.phb_heritage_trait ht
WHERE ht.slug = 'extended-fortification'
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  scope = EXCLUDED.scope,
  heritage_trait_id = EXCLUDED.heritage_trait_id;


-- focused-edge @1× → gh-focused-edge
INSERT INTO rpg.phb_resource_definition (slug, name, scope, heritage_trait_id, min_level)
SELECT
  'gh-focused-edge',
  'Fio Concentrado',
  'heritage'::rpg.resource_scope,
  ht.id,
  1
FROM rpg.phb_heritage_trait ht
WHERE ht.slug = 'focused-edge'
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  scope = EXCLUDED.scope,
  heritage_trait_id = EXCLUDED.heritage_trait_id;


-- focused-ruthlessness @1× → gh-focused-ruthlessness
INSERT INTO rpg.phb_resource_definition (slug, name, scope, heritage_trait_id, min_level)
SELECT
  'gh-focused-ruthlessness',
  'Crueldade Concentrada',
  'heritage'::rpg.resource_scope,
  ht.id,
  1
FROM rpg.phb_heritage_trait ht
WHERE ht.slug = 'focused-ruthlessness'
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  scope = EXCLUDED.scope,
  heritage_trait_id = EXCLUDED.heritage_trait_id;


-- immutable-mind @2× → gh-immutable-mind-x2
INSERT INTO rpg.phb_resource_definition (slug, name, scope, heritage_trait_id, min_level)
SELECT
  'gh-immutable-mind-x2',
  'Mente Inabalável (aprimorado)',
  'heritage'::rpg.resource_scope,
  ht.id,
  1
FROM rpg.phb_heritage_trait ht
WHERE ht.slug = 'immutable-mind'
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  scope = EXCLUDED.scope,
  heritage_trait_id = EXCLUDED.heritage_trait_id;


-- incomparable-roar @1× → gh-incomparable-roar
INSERT INTO rpg.phb_resource_definition (slug, name, scope, heritage_trait_id, min_level)
SELECT
  'gh-incomparable-roar',
  'Rugido Incomparável',
  'heritage'::rpg.resource_scope,
  ht.id,
  1
FROM rpg.phb_heritage_trait ht
WHERE ht.slug = 'incomparable-roar'
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  scope = EXCLUDED.scope,
  heritage_trait_id = EXCLUDED.heritage_trait_id;


-- infectious-bravery @2× → gh-infectious-bravery-x2
INSERT INTO rpg.phb_resource_definition (slug, name, scope, heritage_trait_id, min_level)
SELECT
  'gh-infectious-bravery-x2',
  'Coragem Contagiante (aprimorado)',
  'heritage'::rpg.resource_scope,
  ht.id,
  1
FROM rpg.phb_heritage_trait ht
WHERE ht.slug = 'infectious-bravery'
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  scope = EXCLUDED.scope,
  heritage_trait_id = EXCLUDED.heritage_trait_id;


-- moving-insight @1× → gh-moving-insight
INSERT INTO rpg.phb_resource_definition (slug, name, scope, heritage_trait_id, min_level)
SELECT
  'gh-moving-insight',
  'Intuição em Movimento',
  'heritage'::rpg.resource_scope,
  ht.id,
  1
FROM rpg.phb_heritage_trait ht
WHERE ht.slug = 'moving-insight'
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  scope = EXCLUDED.scope,
  heritage_trait_id = EXCLUDED.heritage_trait_id;


-- pack-leader @1× → gh-pack-leader
INSERT INTO rpg.phb_resource_definition (slug, name, scope, heritage_trait_id, min_level)
SELECT
  'gh-pack-leader',
  'Líder de Matilha',
  'heritage'::rpg.resource_scope,
  ht.id,
  1
FROM rpg.phb_heritage_trait ht
WHERE ht.slug = 'pack-leader'
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  scope = EXCLUDED.scope,
  heritage_trait_id = EXCLUDED.heritage_trait_id;


-- phase-shift @1× → gh-phase-shift
INSERT INTO rpg.phb_resource_definition (slug, name, scope, heritage_trait_id, min_level)
SELECT
  'gh-phase-shift',
  'Mudança de Fase',
  'heritage'::rpg.resource_scope,
  ht.id,
  1
FROM rpg.phb_heritage_trait ht
WHERE ht.slug = 'phase-shift'
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  scope = EXCLUDED.scope,
  heritage_trait_id = EXCLUDED.heritage_trait_id;


-- poison-indemnity @2× → gh-poison-indemnity-x2
INSERT INTO rpg.phb_resource_definition (slug, name, scope, heritage_trait_id, min_level)
SELECT
  'gh-poison-indemnity-x2',
  'Indenização ao Veneno (aprimorado)',
  'heritage'::rpg.resource_scope,
  ht.id,
  1
FROM rpg.phb_heritage_trait ht
WHERE ht.slug = 'poison-indemnity'
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  scope = EXCLUDED.scope,
  heritage_trait_id = EXCLUDED.heritage_trait_id;


-- potent-breath @1× → potentBreath
INSERT INTO rpg.phb_resource_definition (slug, name, scope, heritage_trait_id, min_level)
SELECT
  'potentBreath',
  'Sopro Potente',
  'heritage'::rpg.resource_scope,
  ht.id,
  1
FROM rpg.phb_heritage_trait ht
WHERE ht.slug = 'potent-breath'
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  scope = EXCLUDED.scope,
  heritage_trait_id = EXCLUDED.heritage_trait_id;


-- potent-breath @2× → gh-potent-breath-x2
INSERT INTO rpg.phb_resource_definition (slug, name, scope, heritage_trait_id, min_level)
SELECT
  'gh-potent-breath-x2',
  'Sopro Potente (aprimorado)',
  'heritage'::rpg.resource_scope,
  ht.id,
  1
FROM rpg.phb_heritage_trait ht
WHERE ht.slug = 'potent-breath'
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  scope = EXCLUDED.scope,
  heritage_trait_id = EXCLUDED.heritage_trait_id;


-- protective-cover @2× → gh-protective-cover-x2
INSERT INTO rpg.phb_resource_definition (slug, name, scope, heritage_trait_id, min_level)
SELECT
  'gh-protective-cover-x2',
  'Cobertura Protetora (aprimorado)',
  'heritage'::rpg.resource_scope,
  ht.id,
  1
FROM rpg.phb_heritage_trait ht
WHERE ht.slug = 'protective-cover'
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  scope = EXCLUDED.scope,
  heritage_trait_id = EXCLUDED.heritage_trait_id;


-- resolute-sight @2× → gh-resolute-sight-x2
INSERT INTO rpg.phb_resource_definition (slug, name, scope, heritage_trait_id, min_level)
SELECT
  'gh-resolute-sight-x2',
  'Visão Resoluta (aprimorado)',
  'heritage'::rpg.resource_scope,
  ht.id,
  1
FROM rpg.phb_heritage_trait ht
WHERE ht.slug = 'resolute-sight'
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  scope = EXCLUDED.scope,
  heritage_trait_id = EXCLUDED.heritage_trait_id;


-- shared-fleetness @2× → gh-shared-fleetness-x2
INSERT INTO rpg.phb_resource_definition (slug, name, scope, heritage_trait_id, min_level)
SELECT
  'gh-shared-fleetness-x2',
  'Agilidade Compartilhada (aprimorado)',
  'heritage'::rpg.resource_scope,
  ht.id,
  1
FROM rpg.phb_heritage_trait ht
WHERE ht.slug = 'shared-fleetness'
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  scope = EXCLUDED.scope,
  heritage_trait_id = EXCLUDED.heritage_trait_id;


-- slip-free @2× → gh-slip-free-x2
INSERT INTO rpg.phb_resource_definition (slug, name, scope, heritage_trait_id, min_level)
SELECT
  'gh-slip-free-x2',
  'Libertação Ágil (aprimorado)',
  'heritage'::rpg.resource_scope,
  ht.id,
  1
FROM rpg.phb_heritage_trait ht
WHERE ht.slug = 'slip-free'
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  scope = EXCLUDED.scope,
  heritage_trait_id = EXCLUDED.heritage_trait_id;


-- smoker @2× → gh-smoker-x2
INSERT INTO rpg.phb_resource_definition (slug, name, scope, heritage_trait_id, min_level)
SELECT
  'gh-smoker-x2',
  'Fumante (aprimorado)',
  'heritage'::rpg.resource_scope,
  ht.id,
  1
FROM rpg.phb_heritage_trait ht
WHERE ht.slug = 'smoker'
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  scope = EXCLUDED.scope,
  heritage_trait_id = EXCLUDED.heritage_trait_id;


-- spirit-s-strength @2× → gh-spirit-s-strength-x2
INSERT INTO rpg.phb_resource_definition (slug, name, scope, heritage_trait_id, min_level)
SELECT
  'gh-spirit-s-strength-x2',
  'Força do Espírito (aprimorado)',
  'heritage'::rpg.resource_scope,
  ht.id,
  1
FROM rpg.phb_heritage_trait ht
WHERE ht.slug = 'spirit-s-strength'
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  scope = EXCLUDED.scope,
  heritage_trait_id = EXCLUDED.heritage_trait_id;


-- stalwart-edge @1× → gh-stalwart-edge
INSERT INTO rpg.phb_resource_definition (slug, name, scope, heritage_trait_id, min_level)
SELECT
  'gh-stalwart-edge',
  'Fio Inabalável',
  'heritage'::rpg.resource_scope,
  ht.id,
  1
FROM rpg.phb_heritage_trait ht
WHERE ht.slug = 'stalwart-edge'
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  scope = EXCLUDED.scope,
  heritage_trait_id = EXCLUDED.heritage_trait_id;


-- stand-fast @2× → gh-stand-fast-x2
INSERT INTO rpg.phb_resource_definition (slug, name, scope, heritage_trait_id, min_level)
SELECT
  'gh-stand-fast-x2',
  'Firmeza (aprimorado)',
  'heritage'::rpg.resource_scope,
  ht.id,
  1
FROM rpg.phb_heritage_trait ht
WHERE ht.slug = 'stand-fast'
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  scope = EXCLUDED.scope,
  heritage_trait_id = EXCLUDED.heritage_trait_id;


-- strength-of-life @2× → gh-strength-of-life-x2
INSERT INTO rpg.phb_resource_definition (slug, name, scope, heritage_trait_id, min_level)
SELECT
  'gh-strength-of-life-x2',
  'Força da Vida (aprimorado)',
  'heritage'::rpg.resource_scope,
  ht.id,
  1
FROM rpg.phb_heritage_trait ht
WHERE ht.slug = 'strength-of-life'
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  scope = EXCLUDED.scope,
  heritage_trait_id = EXCLUDED.heritage_trait_id;


-- supreme-slip @2× → gh-supreme-slip-x2
INSERT INTO rpg.phb_resource_definition (slug, name, scope, heritage_trait_id, min_level)
SELECT
  'gh-supreme-slip-x2',
  'Escorregão Supremo (aprimorado)',
  'heritage'::rpg.resource_scope,
  ht.id,
  1
FROM rpg.phb_heritage_trait ht
WHERE ht.slug = 'supreme-slip'
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  scope = EXCLUDED.scope,
  heritage_trait_id = EXCLUDED.heritage_trait_id;


-- swift-strike @2× → gh-swift-strike-x2
INSERT INTO rpg.phb_resource_definition (slug, name, scope, heritage_trait_id, min_level)
SELECT
  'gh-swift-strike-x2',
  'Golpe Rápido (aprimorado)',
  'heritage'::rpg.resource_scope,
  ht.id,
  1
FROM rpg.phb_heritage_trait ht
WHERE ht.slug = 'swift-strike'
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  scope = EXCLUDED.scope,
  heritage_trait_id = EXCLUDED.heritage_trait_id;


-- vigorous @2× → gh-vigorous-x2
INSERT INTO rpg.phb_resource_definition (slug, name, scope, heritage_trait_id, min_level)
SELECT
  'gh-vigorous-x2',
  'Vigoroso (aprimorado)',
  'heritage'::rpg.resource_scope,
  ht.id,
  1
FROM rpg.phb_heritage_trait ht
WHERE ht.slug = 'vigorous'
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  scope = EXCLUDED.scope,
  heritage_trait_id = EXCLUDED.heritage_trait_id;


-- wall-walker @2× → gh-wall-walker-x2
INSERT INTO rpg.phb_resource_definition (slug, name, scope, heritage_trait_id, min_level)
SELECT
  'gh-wall-walker-x2',
  'Caminhante de Paredes (aprimorado)',
  'heritage'::rpg.resource_scope,
  ht.id,
  1
FROM rpg.phb_heritage_trait ht
WHERE ht.slug = 'wall-walker'
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  scope = EXCLUDED.scope,
  heritage_trait_id = EXCLUDED.heritage_trait_id;


