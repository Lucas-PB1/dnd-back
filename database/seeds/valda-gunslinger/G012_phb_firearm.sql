-- Seed Valda firearms (items + weapons + property links)

INSERT INTO rpg.phb_item (slug, item_type, name, cost, weight, description, properties)
VALUES (
  'blunderbuss',
  'weapon'::rpg.item_type,
  'Blunderbuss',
  '{"text":"750 GP"}'::jsonb,
  '15 lb.',
  'This distinctive short-range firearm features a dramatically flared muzzle designed to launch shot in a wide spray.',
  '{"propertyIds":["ammunition","heavy","loading","two-handed"],"masteryId":"scatter","range":{"normal":20,"max":60},"ammoType":"shot","era":"renaissance","source":"valda-gunslinger","editionSlug":"valda-spire-2024-en","citationSlug":"valda-spire-2024-en:gunslinger"}'::jsonb
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  cost = EXCLUDED.cost,
  weight = EXCLUDED.weight,
  description = EXCLUDED.description,
  properties = EXCLUDED.properties;

INSERT INTO rpg.phb_weapon (item_id, category, damage, damage_type, mastery_id)
VALUES (
  (SELECT id FROM rpg.phb_item WHERE slug = 'blunderbuss'),
  'martial'::rpg.weapon_category,
  '1d12',
  'Perfurante',
  (SELECT id FROM rpg.phb_weapon_mastery WHERE slug = 'scatter')
)
ON CONFLICT (item_id) DO UPDATE SET
  category = EXCLUDED.category,
  damage = EXCLUDED.damage,
  damage_type = EXCLUDED.damage_type,
  mastery_id = EXCLUDED.mastery_id;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id)
VALUES (
  (SELECT id FROM rpg.phb_item WHERE slug = 'blunderbuss'),
  (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'ammunition')
)
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id)
VALUES (
  (SELECT id FROM rpg.phb_item WHERE slug = 'blunderbuss'),
  (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'heavy')
)
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id)
VALUES (
  (SELECT id FROM rpg.phb_item WHERE slug = 'blunderbuss'),
  (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'loading')
)
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id)
VALUES (
  (SELECT id FROM rpg.phb_item WHERE slug = 'blunderbuss'),
  (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'two-handed')
)
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_item (slug, item_type, name, cost, weight, description, properties)
VALUES (
  'double-barrel-shotgun',
  'weapon'::rpg.item_type,
  'Double-Barrel Shotgun',
  '{"text":"175 GP"}'::jsonb,
  '8 lb.',
  'A classic design with two loaded barrels, trading ammo capacity and range for reliability and firepower.',
  '{"propertyIds":["ammunition","firearm","recoil","reload","two-handed"],"masteryId":"scatter","range":{"normal":20,"max":60},"ammoType":"shell","era":"industrial","source":"valda-gunslinger","editionSlug":"valda-spire-2024-en","citationSlug":"valda-spire-2024-en:gunslinger","reload":2}'::jsonb
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  cost = EXCLUDED.cost,
  weight = EXCLUDED.weight,
  description = EXCLUDED.description,
  properties = EXCLUDED.properties;

INSERT INTO rpg.phb_weapon (item_id, category, damage, damage_type, mastery_id)
VALUES (
  (SELECT id FROM rpg.phb_item WHERE slug = 'double-barrel-shotgun'),
  'simple'::rpg.weapon_category,
  '2d6',
  'Perfurante',
  (SELECT id FROM rpg.phb_weapon_mastery WHERE slug = 'scatter')
)
ON CONFLICT (item_id) DO UPDATE SET
  category = EXCLUDED.category,
  damage = EXCLUDED.damage,
  damage_type = EXCLUDED.damage_type,
  mastery_id = EXCLUDED.mastery_id;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id)
VALUES (
  (SELECT id FROM rpg.phb_item WHERE slug = 'double-barrel-shotgun'),
  (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'ammunition')
)
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id)
VALUES (
  (SELECT id FROM rpg.phb_item WHERE slug = 'double-barrel-shotgun'),
  (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'firearm')
)
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id)
VALUES (
  (SELECT id FROM rpg.phb_item WHERE slug = 'double-barrel-shotgun'),
  (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'recoil')
)
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id)
VALUES (
  (SELECT id FROM rpg.phb_item WHERE slug = 'double-barrel-shotgun'),
  (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'reload')
)
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id)
VALUES (
  (SELECT id FROM rpg.phb_item WHERE slug = 'double-barrel-shotgun'),
  (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'two-handed')
)
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_item (slug, item_type, name, cost, weight, description, properties)
VALUES (
  'hunting-rifle',
  'weapon'::rpg.item_type,
  'Hunting Rifle',
  '{"text":"150 GP"}'::jsonb,
  '8 lb.',
  'Designed for big game, Hunting Rifles are slow but accurate, requiring bolt action between shots.',
  '{"propertyIds":["ammunition","firearm","reload","two-handed"],"masteryId":"sighted","range":{"normal":80,"max":320},"ammoType":"bullet","era":"industrial","source":"valda-gunslinger","editionSlug":"valda-spire-2024-en","citationSlug":"valda-spire-2024-en:gunslinger","reload":4}'::jsonb
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  cost = EXCLUDED.cost,
  weight = EXCLUDED.weight,
  description = EXCLUDED.description,
  properties = EXCLUDED.properties;

INSERT INTO rpg.phb_weapon (item_id, category, damage, damage_type, mastery_id)
VALUES (
  (SELECT id FROM rpg.phb_item WHERE slug = 'hunting-rifle'),
  'simple'::rpg.weapon_category,
  '2d6',
  'Perfurante',
  (SELECT id FROM rpg.phb_weapon_mastery WHERE slug = 'sighted')
)
ON CONFLICT (item_id) DO UPDATE SET
  category = EXCLUDED.category,
  damage = EXCLUDED.damage,
  damage_type = EXCLUDED.damage_type,
  mastery_id = EXCLUDED.mastery_id;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id)
VALUES (
  (SELECT id FROM rpg.phb_item WHERE slug = 'hunting-rifle'),
  (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'ammunition')
)
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id)
VALUES (
  (SELECT id FROM rpg.phb_item WHERE slug = 'hunting-rifle'),
  (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'firearm')
)
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id)
VALUES (
  (SELECT id FROM rpg.phb_item WHERE slug = 'hunting-rifle'),
  (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'reload')
)
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id)
VALUES (
  (SELECT id FROM rpg.phb_item WHERE slug = 'hunting-rifle'),
  (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'two-handed')
)
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_item (slug, item_type, name, cost, weight, description, properties)
VALUES (
  'parlor-gun',
  'weapon'::rpg.item_type,
  'Parlor Gun',
  '{"text":"75 GP"}'::jsonb,
  '1 lb.',
  'The smallest usable firearm; can be tucked into a stocking or hidden down a sleeve.',
  '{"propertyIds":["ammunition","firearm","light","reload"],"masteryId":"vex","range":{"normal":30,"max":120},"ammoType":"bullet","era":"industrial","source":"valda-gunslinger","editionSlug":"valda-spire-2024-en","citationSlug":"valda-spire-2024-en:gunslinger","reload":2}'::jsonb
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  cost = EXCLUDED.cost,
  weight = EXCLUDED.weight,
  description = EXCLUDED.description,
  properties = EXCLUDED.properties;

INSERT INTO rpg.phb_weapon (item_id, category, damage, damage_type, mastery_id)
VALUES (
  (SELECT id FROM rpg.phb_item WHERE slug = 'parlor-gun'),
  'simple'::rpg.weapon_category,
  '2d4',
  'Perfurante',
  (SELECT id FROM rpg.phb_weapon_mastery WHERE slug = 'vex')
)
ON CONFLICT (item_id) DO UPDATE SET
  category = EXCLUDED.category,
  damage = EXCLUDED.damage,
  damage_type = EXCLUDED.damage_type,
  mastery_id = EXCLUDED.mastery_id;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id)
VALUES (
  (SELECT id FROM rpg.phb_item WHERE slug = 'parlor-gun'),
  (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'ammunition')
)
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id)
VALUES (
  (SELECT id FROM rpg.phb_item WHERE slug = 'parlor-gun'),
  (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'firearm')
)
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id)
VALUES (
  (SELECT id FROM rpg.phb_item WHERE slug = 'parlor-gun'),
  (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'light')
)
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id)
VALUES (
  (SELECT id FROM rpg.phb_item WHERE slug = 'parlor-gun'),
  (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'reload')
)
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_item (slug, item_type, name, cost, weight, description, properties)
VALUES (
  'revolver',
  'weapon'::rpg.item_type,
  'Revolver',
  '{"text":"125 GP"}'::jsonb,
  '3 lb.',
  'An iconic handgun storing six bullets in a rotating cylinder; favored by Gunslingers.',
  '{"propertyIds":["ammunition","firearm","recoil","reload"],"masteryId":"slow","range":{"normal":30,"max":120},"ammoType":"bullet","era":"industrial","source":"valda-gunslinger","editionSlug":"valda-spire-2024-en","citationSlug":"valda-spire-2024-en:gunslinger","reload":6}'::jsonb
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  cost = EXCLUDED.cost,
  weight = EXCLUDED.weight,
  description = EXCLUDED.description,
  properties = EXCLUDED.properties;

INSERT INTO rpg.phb_weapon (item_id, category, damage, damage_type, mastery_id)
VALUES (
  (SELECT id FROM rpg.phb_item WHERE slug = 'revolver'),
  'martial'::rpg.weapon_category,
  '2d6',
  'Perfurante',
  (SELECT id FROM rpg.phb_weapon_mastery WHERE slug = 'slow')
)
ON CONFLICT (item_id) DO UPDATE SET
  category = EXCLUDED.category,
  damage = EXCLUDED.damage,
  damage_type = EXCLUDED.damage_type,
  mastery_id = EXCLUDED.mastery_id;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id)
VALUES (
  (SELECT id FROM rpg.phb_item WHERE slug = 'revolver'),
  (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'ammunition')
)
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id)
VALUES (
  (SELECT id FROM rpg.phb_item WHERE slug = 'revolver'),
  (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'firearm')
)
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id)
VALUES (
  (SELECT id FROM rpg.phb_item WHERE slug = 'revolver'),
  (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'recoil')
)
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id)
VALUES (
  (SELECT id FROM rpg.phb_item WHERE slug = 'revolver'),
  (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'reload')
)
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_item (slug, item_type, name, cost, weight, description, properties)
VALUES (
  'cannon',
  'weapon'::rpg.item_type,
  'Cannon',
  '{"text":"1500 GP"}'::jsonb,
  '225 lb.',
  'Smoothbore muzzleloading Cannons common on pirate ships and fortifications.',
  '{"propertyIds":["ammunition","firearm","heavy","loading","two-handed"],"masteryId":"explode","range":{"normal":100,"max":400},"ammoType":"cannonball","era":"industrial","source":"valda-gunslinger","editionSlug":"valda-spire-2024-en","citationSlug":"valda-spire-2024-en:gunslinger"}'::jsonb
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  cost = EXCLUDED.cost,
  weight = EXCLUDED.weight,
  description = EXCLUDED.description,
  properties = EXCLUDED.properties;

INSERT INTO rpg.phb_weapon (item_id, category, damage, damage_type, mastery_id)
VALUES (
  (SELECT id FROM rpg.phb_item WHERE slug = 'cannon'),
  'martial'::rpg.weapon_category,
  '2d8',
  'Ígneo',
  (SELECT id FROM rpg.phb_weapon_mastery WHERE slug = 'explode')
)
ON CONFLICT (item_id) DO UPDATE SET
  category = EXCLUDED.category,
  damage = EXCLUDED.damage,
  damage_type = EXCLUDED.damage_type,
  mastery_id = EXCLUDED.mastery_id;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id)
VALUES (
  (SELECT id FROM rpg.phb_item WHERE slug = 'cannon'),
  (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'ammunition')
)
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id)
VALUES (
  (SELECT id FROM rpg.phb_item WHERE slug = 'cannon'),
  (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'firearm')
)
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id)
VALUES (
  (SELECT id FROM rpg.phb_item WHERE slug = 'cannon'),
  (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'heavy')
)
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id)
VALUES (
  (SELECT id FROM rpg.phb_item WHERE slug = 'cannon'),
  (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'loading')
)
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id)
VALUES (
  (SELECT id FROM rpg.phb_item WHERE slug = 'cannon'),
  (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'two-handed')
)
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_item (slug, item_type, name, cost, weight, description, properties)
VALUES (
  'gatling-gun',
  'weapon'::rpg.item_type,
  'Gatling Gun',
  '{"text":"750 GP"}'::jsonb,
  '125 lb.',
  'Rotates and fires six or more barrels in succession; cumbersome and terrifying.',
  '{"propertyIds":["ammunition","firearm","heavy","reload","two-handed"],"masteryId":"automatic","range":{"normal":60,"max":240},"ammoType":"bullet","era":"industrial","source":"valda-gunslinger","editionSlug":"valda-spire-2024-en","citationSlug":"valda-spire-2024-en:gunslinger","reload":40}'::jsonb
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  cost = EXCLUDED.cost,
  weight = EXCLUDED.weight,
  description = EXCLUDED.description,
  properties = EXCLUDED.properties;

INSERT INTO rpg.phb_weapon (item_id, category, damage, damage_type, mastery_id)
VALUES (
  (SELECT id FROM rpg.phb_item WHERE slug = 'gatling-gun'),
  'martial'::rpg.weapon_category,
  '2d6',
  'Perfurante',
  (SELECT id FROM rpg.phb_weapon_mastery WHERE slug = 'automatic')
)
ON CONFLICT (item_id) DO UPDATE SET
  category = EXCLUDED.category,
  damage = EXCLUDED.damage,
  damage_type = EXCLUDED.damage_type,
  mastery_id = EXCLUDED.mastery_id;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id)
VALUES (
  (SELECT id FROM rpg.phb_item WHERE slug = 'gatling-gun'),
  (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'ammunition')
)
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id)
VALUES (
  (SELECT id FROM rpg.phb_item WHERE slug = 'gatling-gun'),
  (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'firearm')
)
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id)
VALUES (
  (SELECT id FROM rpg.phb_item WHERE slug = 'gatling-gun'),
  (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'heavy')
)
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id)
VALUES (
  (SELECT id FROM rpg.phb_item WHERE slug = 'gatling-gun'),
  (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'reload')
)
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id)
VALUES (
  (SELECT id FROM rpg.phb_item WHERE slug = 'gatling-gun'),
  (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'two-handed')
)
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_item (slug, item_type, name, cost, weight, description, properties)
VALUES (
  'magnum',
  'weapon'::rpg.item_type,
  'Magnum',
  '{"text":"600 GP"}'::jsonb,
  '6 lb.',
  'Chambered for large-caliber bullets; packs maximum kick into a single shot.',
  '{"propertyIds":["ammunition","firearm","heavy","recoil","reload"],"masteryId":"slow","range":{"normal":30,"max":120},"ammoType":"bullet","era":"industrial","source":"valda-gunslinger","editionSlug":"valda-spire-2024-en","citationSlug":"valda-spire-2024-en:gunslinger","reload":6}'::jsonb
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  cost = EXCLUDED.cost,
  weight = EXCLUDED.weight,
  description = EXCLUDED.description,
  properties = EXCLUDED.properties;

INSERT INTO rpg.phb_weapon (item_id, category, damage, damage_type, mastery_id)
VALUES (
  (SELECT id FROM rpg.phb_item WHERE slug = 'magnum'),
  'martial'::rpg.weapon_category,
  '2d8',
  'Perfurante',
  (SELECT id FROM rpg.phb_weapon_mastery WHERE slug = 'slow')
)
ON CONFLICT (item_id) DO UPDATE SET
  category = EXCLUDED.category,
  damage = EXCLUDED.damage,
  damage_type = EXCLUDED.damage_type,
  mastery_id = EXCLUDED.mastery_id;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id)
VALUES (
  (SELECT id FROM rpg.phb_item WHERE slug = 'magnum'),
  (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'ammunition')
)
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id)
VALUES (
  (SELECT id FROM rpg.phb_item WHERE slug = 'magnum'),
  (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'firearm')
)
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id)
VALUES (
  (SELECT id FROM rpg.phb_item WHERE slug = 'magnum'),
  (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'heavy')
)
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id)
VALUES (
  (SELECT id FROM rpg.phb_item WHERE slug = 'magnum'),
  (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'recoil')
)
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id)
VALUES (
  (SELECT id FROM rpg.phb_item WHERE slug = 'magnum'),
  (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'reload')
)
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_item (slug, item_type, name, cost, weight, description, properties)
VALUES (
  'flare-gun',
  'weapon'::rpg.item_type,
  'Flare Gun',
  '{"text":"100 GP"}'::jsonb,
  '1 lb.',
  'A survival tool that fires a single white-hot flare for distress signals or last-ditch defense.',
  '{"propertyIds":["ammunition","firearm","loading"],"masteryId":"slow","range":{"normal":30,"max":120},"ammoType":"flare","era":"modern","source":"valda-gunslinger","editionSlug":"valda-spire-2024-en","citationSlug":"valda-spire-2024-en:gunslinger"}'::jsonb
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  cost = EXCLUDED.cost,
  weight = EXCLUDED.weight,
  description = EXCLUDED.description,
  properties = EXCLUDED.properties;

INSERT INTO rpg.phb_weapon (item_id, category, damage, damage_type, mastery_id)
VALUES (
  (SELECT id FROM rpg.phb_item WHERE slug = 'flare-gun'),
  'simple'::rpg.weapon_category,
  '2d6',
  'Ígneo',
  (SELECT id FROM rpg.phb_weapon_mastery WHERE slug = 'slow')
)
ON CONFLICT (item_id) DO UPDATE SET
  category = EXCLUDED.category,
  damage = EXCLUDED.damage,
  damage_type = EXCLUDED.damage_type,
  mastery_id = EXCLUDED.mastery_id;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id)
VALUES (
  (SELECT id FROM rpg.phb_item WHERE slug = 'flare-gun'),
  (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'ammunition')
)
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id)
VALUES (
  (SELECT id FROM rpg.phb_item WHERE slug = 'flare-gun'),
  (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'firearm')
)
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id)
VALUES (
  (SELECT id FROM rpg.phb_item WHERE slug = 'flare-gun'),
  (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'loading')
)
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_item (slug, item_type, name, cost, weight, description, properties)
VALUES (
  'handgun',
  'weapon'::rpg.item_type,
  'Handgun',
  '{"text":"125 GP"}'::jsonb,
  '3 lb.',
  'Portable and reliable with a generous magazine; go-to for self-defense.',
  '{"propertyIds":["ammunition","firearm","light","reload"],"masteryId":"vex","range":{"normal":30,"max":120},"ammoType":"bullet","era":"modern","source":"valda-gunslinger","editionSlug":"valda-spire-2024-en","citationSlug":"valda-spire-2024-en:gunslinger","reload":10}'::jsonb
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  cost = EXCLUDED.cost,
  weight = EXCLUDED.weight,
  description = EXCLUDED.description,
  properties = EXCLUDED.properties;

INSERT INTO rpg.phb_weapon (item_id, category, damage, damage_type, mastery_id)
VALUES (
  (SELECT id FROM rpg.phb_item WHERE slug = 'handgun'),
  'simple'::rpg.weapon_category,
  '2d4',
  'Perfurante',
  (SELECT id FROM rpg.phb_weapon_mastery WHERE slug = 'vex')
)
ON CONFLICT (item_id) DO UPDATE SET
  category = EXCLUDED.category,
  damage = EXCLUDED.damage,
  damage_type = EXCLUDED.damage_type,
  mastery_id = EXCLUDED.mastery_id;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id)
VALUES (
  (SELECT id FROM rpg.phb_item WHERE slug = 'handgun'),
  (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'ammunition')
)
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id)
VALUES (
  (SELECT id FROM rpg.phb_item WHERE slug = 'handgun'),
  (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'firearm')
)
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id)
VALUES (
  (SELECT id FROM rpg.phb_item WHERE slug = 'handgun'),
  (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'light')
)
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id)
VALUES (
  (SELECT id FROM rpg.phb_item WHERE slug = 'handgun'),
  (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'reload')
)
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_item (slug, item_type, name, cost, weight, description, properties)
VALUES (
  'assault-rifle',
  'weapon'::rpg.item_type,
  'Assault Rifle',
  '{"text":"300 GP"}'::jsonb,
  '7 lb.',
  'High rate of fire with rifle-grade ballistics; flexible and formidable.',
  '{"propertyIds":["ammunition","firearm","reload","two-handed"],"masteryId":"automatic","range":{"normal":80,"max":320},"ammoType":"bullet","era":"modern","source":"valda-gunslinger","editionSlug":"valda-spire-2024-en","citationSlug":"valda-spire-2024-en:gunslinger","reload":20}'::jsonb
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  cost = EXCLUDED.cost,
  weight = EXCLUDED.weight,
  description = EXCLUDED.description,
  properties = EXCLUDED.properties;

INSERT INTO rpg.phb_weapon (item_id, category, damage, damage_type, mastery_id)
VALUES (
  (SELECT id FROM rpg.phb_item WHERE slug = 'assault-rifle'),
  'martial'::rpg.weapon_category,
  '2d6',
  'Perfurante',
  (SELECT id FROM rpg.phb_weapon_mastery WHERE slug = 'automatic')
)
ON CONFLICT (item_id) DO UPDATE SET
  category = EXCLUDED.category,
  damage = EXCLUDED.damage,
  damage_type = EXCLUDED.damage_type,
  mastery_id = EXCLUDED.mastery_id;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id)
VALUES (
  (SELECT id FROM rpg.phb_item WHERE slug = 'assault-rifle'),
  (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'ammunition')
)
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id)
VALUES (
  (SELECT id FROM rpg.phb_item WHERE slug = 'assault-rifle'),
  (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'firearm')
)
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id)
VALUES (
  (SELECT id FROM rpg.phb_item WHERE slug = 'assault-rifle'),
  (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'reload')
)
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id)
VALUES (
  (SELECT id FROM rpg.phb_item WHERE slug = 'assault-rifle'),
  (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'two-handed')
)
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_item (slug, item_type, name, cost, weight, description, properties)
VALUES (
  'pump-shotgun',
  'weapon'::rpg.item_type,
  'Pump Shotgun',
  '{"text":"550 GP"}'::jsonb,
  '7 lb.',
  'Distinctive sliding grip on the barrel that is ''pumped'' to chamber a new round.',
  '{"propertyIds":["ammunition","firearm","heavy","recoil","reload","two-handed"],"masteryId":"scatter","range":{"normal":20,"max":60},"ammoType":"shell","era":"modern","source":"valda-gunslinger","editionSlug":"valda-spire-2024-en","citationSlug":"valda-spire-2024-en:gunslinger","reload":8}'::jsonb
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  cost = EXCLUDED.cost,
  weight = EXCLUDED.weight,
  description = EXCLUDED.description,
  properties = EXCLUDED.properties;

INSERT INTO rpg.phb_weapon (item_id, category, damage, damage_type, mastery_id)
VALUES (
  (SELECT id FROM rpg.phb_item WHERE slug = 'pump-shotgun'),
  'martial'::rpg.weapon_category,
  '2d8',
  'Perfurante',
  (SELECT id FROM rpg.phb_weapon_mastery WHERE slug = 'scatter')
)
ON CONFLICT (item_id) DO UPDATE SET
  category = EXCLUDED.category,
  damage = EXCLUDED.damage,
  damage_type = EXCLUDED.damage_type,
  mastery_id = EXCLUDED.mastery_id;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id)
VALUES (
  (SELECT id FROM rpg.phb_item WHERE slug = 'pump-shotgun'),
  (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'ammunition')
)
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id)
VALUES (
  (SELECT id FROM rpg.phb_item WHERE slug = 'pump-shotgun'),
  (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'firearm')
)
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id)
VALUES (
  (SELECT id FROM rpg.phb_item WHERE slug = 'pump-shotgun'),
  (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'heavy')
)
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id)
VALUES (
  (SELECT id FROM rpg.phb_item WHERE slug = 'pump-shotgun'),
  (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'recoil')
)
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id)
VALUES (
  (SELECT id FROM rpg.phb_item WHERE slug = 'pump-shotgun'),
  (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'reload')
)
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id)
VALUES (
  (SELECT id FROM rpg.phb_item WHERE slug = 'pump-shotgun'),
  (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'two-handed')
)
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_item (slug, item_type, name, cost, weight, description, properties)
VALUES (
  'sniper-rifle',
  'weapon'::rpg.item_type,
  'Sniper Rifle',
  '{"text":"450 GP"}'::jsonb,
  '8 lb.',
  'Instrument of ranged precision for distant, nearly invisible shots.',
  '{"propertyIds":["ammunition","firearm","heavy","loading","two-handed"],"masteryId":"sighted","range":{"normal":100,"max":400},"ammoType":"bullet","era":"modern","source":"valda-gunslinger","editionSlug":"valda-spire-2024-en","citationSlug":"valda-spire-2024-en:gunslinger"}'::jsonb
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  cost = EXCLUDED.cost,
  weight = EXCLUDED.weight,
  description = EXCLUDED.description,
  properties = EXCLUDED.properties;

INSERT INTO rpg.phb_weapon (item_id, category, damage, damage_type, mastery_id)
VALUES (
  (SELECT id FROM rpg.phb_item WHERE slug = 'sniper-rifle'),
  'martial'::rpg.weapon_category,
  '2d8',
  'Perfurante',
  (SELECT id FROM rpg.phb_weapon_mastery WHERE slug = 'sighted')
)
ON CONFLICT (item_id) DO UPDATE SET
  category = EXCLUDED.category,
  damage = EXCLUDED.damage,
  damage_type = EXCLUDED.damage_type,
  mastery_id = EXCLUDED.mastery_id;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id)
VALUES (
  (SELECT id FROM rpg.phb_item WHERE slug = 'sniper-rifle'),
  (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'ammunition')
)
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id)
VALUES (
  (SELECT id FROM rpg.phb_item WHERE slug = 'sniper-rifle'),
  (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'firearm')
)
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id)
VALUES (
  (SELECT id FROM rpg.phb_item WHERE slug = 'sniper-rifle'),
  (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'heavy')
)
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id)
VALUES (
  (SELECT id FROM rpg.phb_item WHERE slug = 'sniper-rifle'),
  (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'loading')
)
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id)
VALUES (
  (SELECT id FROM rpg.phb_item WHERE slug = 'sniper-rifle'),
  (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'two-handed')
)
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_item (slug, item_type, name, cost, weight, description, properties)
VALUES (
  'submachine-gun',
  'weapon'::rpg.item_type,
  'Submachine Gun',
  '{"text":"250 GP"}'::jsonb,
  '6 lb.',
  'Fires lighter, easier-to-control rounds as an alternative to larger automatic weapons.',
  '{"propertyIds":["ammunition","firearm","light","reload"],"masteryId":"automatic","range":{"normal":20,"max":60},"ammoType":"bullet","era":"modern","source":"valda-gunslinger","editionSlug":"valda-spire-2024-en","citationSlug":"valda-spire-2024-en:gunslinger","reload":16}'::jsonb
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  cost = EXCLUDED.cost,
  weight = EXCLUDED.weight,
  description = EXCLUDED.description,
  properties = EXCLUDED.properties;

INSERT INTO rpg.phb_weapon (item_id, category, damage, damage_type, mastery_id)
VALUES (
  (SELECT id FROM rpg.phb_item WHERE slug = 'submachine-gun'),
  'martial'::rpg.weapon_category,
  '2d4',
  'Perfurante',
  (SELECT id FROM rpg.phb_weapon_mastery WHERE slug = 'automatic')
)
ON CONFLICT (item_id) DO UPDATE SET
  category = EXCLUDED.category,
  damage = EXCLUDED.damage,
  damage_type = EXCLUDED.damage_type,
  mastery_id = EXCLUDED.mastery_id;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id)
VALUES (
  (SELECT id FROM rpg.phb_item WHERE slug = 'submachine-gun'),
  (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'ammunition')
)
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id)
VALUES (
  (SELECT id FROM rpg.phb_item WHERE slug = 'submachine-gun'),
  (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'firearm')
)
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id)
VALUES (
  (SELECT id FROM rpg.phb_item WHERE slug = 'submachine-gun'),
  (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'light')
)
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id)
VALUES (
  (SELECT id FROM rpg.phb_item WHERE slug = 'submachine-gun'),
  (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'reload')
)
ON CONFLICT DO NOTHING;
