-- Seed Valda firearm ammunition

INSERT INTO rpg.phb_item (slug, item_type, name, cost, weight, description, properties)
VALUES (
  'bullets',
  'gear'::rpg.item_type,
  'Balas (10)',
  '{"text":"3 PO"}'::jsonb,
  '1 lb.',
  'Munição arma de fogo (balas). Destruído após uso.',
  '{"magic":false,"ammunition":true,"amount":10,"source":"valda-gunslinger","citationSlug":"valda-spire-2024-en:gunslinger"}'::jsonb
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  cost = EXCLUDED.cost,
  weight = EXCLUDED.weight,
  description = EXCLUDED.description,
  properties = EXCLUDED.properties;

INSERT INTO rpg.phb_item (slug, item_type, name, cost, weight, description, properties)
VALUES (
  'cannonballs',
  'gear'::rpg.item_type,
  'Bolas de Canhão (5)',
  '{"text":"25 PO"}'::jsonb,
  '10 lb.',
  'Munição arma de fogo (balas de canhão). Destruído após uso.',
  '{"magic":false,"ammunition":true,"amount":5,"source":"valda-gunslinger","citationSlug":"valda-spire-2024-en:gunslinger"}'::jsonb
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  cost = EXCLUDED.cost,
  weight = EXCLUDED.weight,
  description = EXCLUDED.description,
  properties = EXCLUDED.properties;

INSERT INTO rpg.phb_item (slug, item_type, name, cost, weight, description, properties)
VALUES (
  'flares',
  'gear'::rpg.item_type,
  'Sinalizadores (5)',
  '{"text":"5 PO"}'::jsonb,
  '5 lb.',
  'Munição arma de fogo (flares). Destruído após uso.',
  '{"magic":false,"ammunition":true,"amount":5,"source":"valda-gunslinger","citationSlug":"valda-spire-2024-en:gunslinger"}'::jsonb
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  cost = EXCLUDED.cost,
  weight = EXCLUDED.weight,
  description = EXCLUDED.description,
  properties = EXCLUDED.properties;

INSERT INTO rpg.phb_item (slug, item_type, name, cost, weight, description, properties)
VALUES (
  'shells',
  'gear'::rpg.item_type,
  'Cartuchos (10)',
  '{"text":"5 PO"}'::jsonb,
  '1 lb.',
  'Munição arma de fogo (cartuchos). Destruído após uso.',
  '{"magic":false,"ammunition":true,"amount":10,"source":"valda-gunslinger","citationSlug":"valda-spire-2024-en:gunslinger"}'::jsonb
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  cost = EXCLUDED.cost,
  weight = EXCLUDED.weight,
  description = EXCLUDED.description,
  properties = EXCLUDED.properties;

INSERT INTO rpg.phb_item (slug, item_type, name, cost, weight, description, properties)
VALUES (
  'shot',
  'gear'::rpg.item_type,
  'Chumbos (10)',
  '{"text":"1 PO"}'::jsonb,
  '2 lb.',
  'Munição arma de fogo (tiro). Destruído após uso.',
  '{"magic":false,"ammunition":true,"amount":10,"source":"valda-gunslinger","citationSlug":"valda-spire-2024-en:gunslinger"}'::jsonb
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  cost = EXCLUDED.cost,
  weight = EXCLUDED.weight,
  description = EXCLUDED.description,
  properties = EXCLUDED.properties;
