-- Seed Valda firearm ammunition

INSERT INTO rpg.phb_item (slug, item_type, name, cost, weight, description, properties)
VALUES (
  'bullets',
  'gear'::rpg.item_type,
  'Bullets (10)',
  '{"text":"3 GP"}'::jsonb,
  '1 lb.',
  'Firearm ammunition (bullets). Destroyed upon use.',
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
  'Cannonballs (5)',
  '{"text":"25 GP"}'::jsonb,
  '10 lb.',
  'Firearm ammunition (cannonballs). Destroyed upon use.',
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
  'Flares (5)',
  '{"text":"5 GP"}'::jsonb,
  '5 lb.',
  'Firearm ammunition (flares). Destroyed upon use.',
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
  'Shells (10)',
  '{"text":"5 GP"}'::jsonb,
  '1 lb.',
  'Firearm ammunition (shells). Destroyed upon use.',
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
  'Shot (10)',
  '{"text":"1 GP"}'::jsonb,
  '2 lb.',
  'Firearm ammunition (shot). Destroyed upon use.',
  '{"magic":false,"ammunition":true,"amount":10,"source":"valda-gunslinger","citationSlug":"valda-spire-2024-en:gunslinger"}'::jsonb
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  cost = EXCLUDED.cost,
  weight = EXCLUDED.weight,
  description = EXCLUDED.description,
  properties = EXCLUDED.properties;
