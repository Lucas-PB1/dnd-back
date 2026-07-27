-- Seed Valda species
-- Gerado de docs/sources/valda-spire-of-secrets/extracted.json

INSERT INTO rpg.phb_species (
  slug, name, creature_type, size, speed, description, source_meta
)
VALUES (
  'geppettin',
  'Geppettin',
  'Construct',
  'Small or Medium (Marionette construction only for Medium)',
  '30 feet',
  'Ever a joy to children, geppettin resemble living playthings made of wood, cloth, or porcelain. Though easily mistaken for puppets, geppettin aren’t manipulated by a just-out-of-sight puppeteer; they are animated, sentient, and independent.

As a species, the geppettin are an oddity. Though rare, they are numerous enough and share enough similarities that they may be counted as an actual species, and not merely freak mishaps of magic. While there might be dedicated creators of geppettin, as there are with golems, many geppettin come to life on their own.

Geppettin are often shorter than halflings. Their physical features vary greatly from type to type, but they often resemble Humanoids. Despite being made of somewhat flimsy materials, sentience grants them an odd hardiness. They never hunger and rarely tire. Most find some form of work or profession in entertainment, but a few find fantastic success as spies and assassins.

As Constructs, geppettin don’t age, and mature as soon as they become sentient.',
  '{"editionSlug":"valda-spire-2024-en","book":"Valda''s Spire of Secrets: Player Pack","language":"en","citationSlug":"valda-spire-2024-en:player-pack","source":"valda-spire-player-pack"}'::jsonb
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  creature_type = EXCLUDED.creature_type,
  size = EXCLUDED.size,
  speed = EXCLUDED.speed,
  description = EXCLUDED.description,
  source_meta = EXCLUDED.source_meta;

INSERT INTO rpg.phb_species (
  slug, name, creature_type, size, speed, description, source_meta
)
VALUES (
  'mandrake',
  'Mandrake',
  'Plant',
  'Medium',
  '30 feet',
  'With a skin of thick bark and leaves growing at their extremities, you could be forgiven for believing that mandrakes are simply bizarre plants, treants, or animated trees. The truth is far stranger: mandrakes are a bizarre midway between animal and plant. A ruby ichor pumps through their root-veins, and they can equally eat living things or bask in sunlight for nourishment. Depending on the season in which they are harvested, a mandrake might resemble a spry, leafy sapling or thick, woody tree.

Common folks have long held misconceptions about mandrakes—believing them categorically to be wailing babies—but druids know them as the green emissaries who stand between the realms of animals and plants, making peace for all parties. In druidic lore, mandrakes are bespoke creations of a primordial goddess of nature, intended to act as delegates of her will.

Today, mandrakes are rare and make their homes in the forests near where villages and cities meet the true wilds. They live for hundreds of years, growing wider and more gnarled with age.

Martin Kirby-Jackson',
  '{"editionSlug":"valda-spire-2024-en","book":"Valda''s Spire of Secrets: Player Pack","language":"en","citationSlug":"valda-spire-2024-en:player-pack","source":"valda-spire-player-pack"}'::jsonb
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  creature_type = EXCLUDED.creature_type,
  size = EXCLUDED.size,
  speed = EXCLUDED.speed,
  description = EXCLUDED.description,
  source_meta = EXCLUDED.source_meta;
