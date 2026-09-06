-- Seed Valdas firearms (items + weapons + property links)

INSERT INTO rpg.phb_item (slug, item_type, name, cost, weight, description, properties)
VALUES (
  'blunderbuss',
  'weapon'::rpg.item_type,
  'Bacamarte',
  '{"text":"750 PO"}'::jsonb,
  '15 lb.',
  'Esta distinta arma de fogo de curto alcance apresenta um cano dramaticamente alargado projetado para lançar tiros em um spray amplo.',
  '{"propertyIds":["ammunition","heavy","loading","two-handed"],"masteryId":"scatter","range":{"normal":20,"max":60},"ammoType":"shot","era":"renaissance","source":"valdas-gunslinger","editionSlug":"valdas-spire-2024-en","citationSlug":"valdas-spire-2024-en:gunslinger"}'::jsonb
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
  'Escopeta de Cano Duplo',
  '{"text":"175 PO"}'::jsonb,
  '8 lb.',
  'Um design clássico com dois canos carregados, trocando capacidade e alcance de munição por confiabilidade e poder de fogo.',
  '{"propertyIds":["ammunition","firearm","recoil","reload","two-handed"],"masteryId":"scatter","range":{"normal":20,"max":60},"ammoType":"shell","era":"industrial","source":"valdas-gunslinger","editionSlug":"valdas-spire-2024-en","citationSlug":"valdas-spire-2024-en:gunslinger","reload":2}'::jsonb
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
  'Rifle de Caça',
  '{"text":"150 PO"}'::jsonb,
  '8 lb.',
  'Projetados para caça de grande porte, os rifles de caça são lentos, mas precisos, exigindo ação de ferrolho entre os tiros.',
  '{"propertyIds":["ammunition","firearm","reload","two-handed"],"masteryId":"sighted","range":{"normal":80,"max":320},"ammoType":"bullet","era":"industrial","source":"valdas-gunslinger","editionSlug":"valdas-spire-2024-en","citationSlug":"valdas-spire-2024-en:gunslinger","reload":4}'::jsonb
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
  'Pistola de Salão',
  '{"text":"75 PO"}'::jsonb,
  '1 lb.',
  'A menor arma de fogo utilizável; pode ser enfiado em uma meia ou escondido em uma manga.',
  '{"propertyIds":["ammunition","firearm","light","reload"],"masteryId":"vex","range":{"normal":30,"max":120},"ammoType":"bullet","era":"industrial","source":"valdas-gunslinger","editionSlug":"valdas-spire-2024-en","citationSlug":"valdas-spire-2024-en:gunslinger","reload":2}'::jsonb
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
  'Revólver',
  '{"text":"125 PO"}'::jsonb,
  '3 lb.',
  'Uma pistola icônica que armazena seis balas em um cilindro giratório; favorecido por pistoleiros.',
  '{"propertyIds":["ammunition","firearm","recoil","reload"],"masteryId":"slow","range":{"normal":30,"max":120},"ammoType":"bullet","era":"industrial","source":"valdas-gunslinger","editionSlug":"valdas-spire-2024-en","citationSlug":"valdas-spire-2024-en:gunslinger","reload":6}'::jsonb
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
  'Canhão',
  '{"text":"1500 PO"}'::jsonb,
  '225 lb.',
  'Canhões de carregamento pela boca de cano liso, comuns em navios piratas e fortificações.',
  '{"propertyIds":["ammunition","firearm","heavy","loading","two-handed"],"masteryId":"explode","range":{"normal":100,"max":400},"ammoType":"cannonball","era":"industrial","source":"valdas-gunslinger","editionSlug":"valdas-spire-2024-en","citationSlug":"valdas-spire-2024-en:gunslinger"}'::jsonb
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
  'Metralhadora Gatling',
  '{"text":"750 PO"}'::jsonb,
  '125 lb.',
  'Gira e dispara seis ou mais barris em sucessão; incômodo e assustador.',
  '{"propertyIds":["ammunition","firearm","heavy","reload","two-handed"],"masteryId":"automatic","range":{"normal":60,"max":240},"ammoType":"bullet","era":"industrial","source":"valdas-gunslinger","editionSlug":"valdas-spire-2024-en","citationSlug":"valdas-spire-2024-en:gunslinger","reload":40}'::jsonb
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
  '{"text":"600 PO"}'::jsonb,
  '6 lb.',
  'Compartimentado para balas de grande calibre; concentra o chute máximo em um único tiro.',
  '{"propertyIds":["ammunition","firearm","heavy","recoil","reload"],"masteryId":"slow","range":{"normal":30,"max":120},"ammoType":"bullet","era":"industrial","source":"valdas-gunslinger","editionSlug":"valdas-spire-2024-en","citationSlug":"valdas-spire-2024-en:gunslinger","reload":6}'::jsonb
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
  'Pistola Sinalizadora',
  '{"text":"100 PO"}'::jsonb,
  '1 lb.',
  'Uma ferramenta de sobrevivência que dispara um único sinalizador incandescente para sinais de socorro ou defesa de última hora.',
  '{"propertyIds":["ammunition","firearm","loading"],"masteryId":"slow","range":{"normal":30,"max":120},"ammoType":"flare","era":"modern","source":"valdas-gunslinger","editionSlug":"valdas-spire-2024-en","citationSlug":"valdas-spire-2024-en:gunslinger"}'::jsonb
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
  'Pistola',
  '{"text":"125 PO"}'::jsonb,
  '3 lb.',
  'Portátil e confiável com um carregador generoso; ir para autodefesa.',
  '{"propertyIds":["ammunition","firearm","light","reload"],"masteryId":"vex","range":{"normal":30,"max":120},"ammoType":"bullet","era":"modern","source":"valdas-gunslinger","editionSlug":"valdas-spire-2024-en","citationSlug":"valdas-spire-2024-en:gunslinger","reload":10}'::jsonb
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
  'Rifle de Assalto',
  '{"text":"300 PO"}'::jsonb,
  '7 lb.',
  'Alta cadência de tiro com balística de rifle; flexível e formidável.',
  '{"propertyIds":["ammunition","firearm","reload","two-handed"],"masteryId":"automatic","range":{"normal":80,"max":320},"ammoType":"bullet","era":"modern","source":"valdas-gunslinger","editionSlug":"valdas-spire-2024-en","citationSlug":"valdas-spire-2024-en:gunslinger","reload":20}'::jsonb
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
  'Escopeta de Ação por Bomba',
  '{"text":"550 PO"}'::jsonb,
  '7 lb.',
  'Aperto deslizante distinto no cano que é ''bombeado'' para armazenar uma nova rodada.',
  '{"propertyIds":["ammunition","firearm","heavy","recoil","reload","two-handed"],"masteryId":"scatter","range":{"normal":20,"max":60},"ammoType":"shell","era":"modern","source":"valdas-gunslinger","editionSlug":"valdas-spire-2024-en","citationSlug":"valdas-spire-2024-en:gunslinger","reload":8}'::jsonb
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
  'Rifle de Precisão',
  '{"text":"450 PO"}'::jsonb,
  '8 lb.',
  'Instrumento de precisão de longo alcance para tiros distantes e quase invisíveis.',
  '{"propertyIds":["ammunition","firearm","heavy","loading","two-handed"],"masteryId":"sighted","range":{"normal":100,"max":400},"ammoType":"bullet","era":"modern","source":"valdas-gunslinger","editionSlug":"valdas-spire-2024-en","citationSlug":"valdas-spire-2024-en:gunslinger"}'::jsonb
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
  'Submetralhadora',
  '{"text":"250 PO"}'::jsonb,
  '6 lb.',
  'Ígneos são cartuchos mais leves e fáceis de controlar como uma alternativa às armas automáticas maiores.',
  '{"propertyIds":["ammunition","firearm","light","reload"],"masteryId":"automatic","range":{"normal":20,"max":60},"ammoType":"bullet","era":"modern","source":"valdas-gunslinger","editionSlug":"valdas-spire-2024-en","citationSlug":"valdas-spire-2024-en:gunslinger","reload":16}'::jsonb
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
