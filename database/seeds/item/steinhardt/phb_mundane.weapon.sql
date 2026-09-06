-- Armas mundanas + munição Eldritch Hunt
-- Slugs luyarnha-* evitam colisão com Valdas (blunderbuss / cannon).

INSERT INTO rpg.phb_item (slug, item_type, name, cost, weight, description, properties)
VALUES
  (
    'luyarnha-blunderbuss',
    'weapon'::rpg.item_type,
    'Bacamarte de Luyarnha',
    '{"text":"20 PO"}'::jsonb,
    '4,5 kg',
    'Arma de fogo simples de cano largo usada por caçadores e manikins de Luyarnha. Dispara em cone (Fogo Espalhado) e tem cano duplo.',
    '{"propertyIds":["ammunition","barrel","blaring","spread-fire","twinned-barrel","two-handed"],"masteryId":"topple","range":{"normal":6,"max":6},"ammoType":"bullet","barrelCapacity":2,"source":"steinhardt-eldritch-hunt","editionSlug":"steinhardt-eldritch-hunt-2024-en","citationSlug":"steinhardt-eldritch-hunt-2024-en:player-pack"}'::jsonb
  ),
  (
    'flintlock',
    'weapon'::rpg.item_type,
    'Pederneira',
    '{"text":"8 PO"}'::jsonb,
    '1,5 kg',
    'Pistola de pederneira leve, comum entre caçadores urbanos de Luyarnha.',
    '{"propertyIds":["ammunition","barrel","blaring","light"],"masteryId":"sap","range":{"normal":30,"max":96},"ammoType":"bullet","barrelCapacity":1,"source":"steinhardt-eldritch-hunt","editionSlug":"steinhardt-eldritch-hunt-2024-en","citationSlug":"steinhardt-eldritch-hunt-2024-en:player-pack"}'::jsonb
  ),
  (
    'scythe',
    'weapon'::rpg.item_type,
    'Foice',
    '{"text":"5 PO"}'::jsonb,
    '3 kg',
    'Lâmina curva de haste longa, usada tanto na colheita quanto na caça.',
    '{"propertyIds":["finesse","reach","two-handed"],"masteryId":"cleave","source":"steinhardt-eldritch-hunt","editionSlug":"steinhardt-eldritch-hunt-2024-en","citationSlug":"steinhardt-eldritch-hunt-2024-en:player-pack"}'::jsonb
  ),
  (
    'cleaver',
    'weapon'::rpg.item_type,
    'Cutelo',
    '{"text":"3 PO"}'::jsonb,
    '2 kg',
    'Lâmina pesada de açougueiro, versátil nas mãos de um caçador.',
    '{"propertyIds":["heavy","versatile"],"masteryId":"graze","versatileDamage":"1d12","source":"steinhardt-eldritch-hunt","editionSlug":"steinhardt-eldritch-hunt-2024-en","citationSlug":"steinhardt-eldritch-hunt-2024-en:player-pack"}'::jsonb
  ),
  (
    'luyarnha-cannon',
    'weapon'::rpg.item_type,
    'Canhão de Luyarnha',
    '{"text":"500 PO"}'::jsonb,
    '40 kg',
    'Peça de artilharia portátil (ainda pesada) usada na defesa da cidade e por canhoneiros da caça. Exige Força (Artilharia) e recarga com ação.',
    '{"propertyIds":["artillery","booming","two-handed"],"masteryId":"push","range":{"normal":36,"max":72},"ammoType":"cannonball","source":"steinhardt-eldritch-hunt","editionSlug":"steinhardt-eldritch-hunt-2024-en","citationSlug":"steinhardt-eldritch-hunt-2024-en:player-pack"}'::jsonb
  ),
  (
    'luyarnha-cannonball',
    'gear'::rpg.item_type,
    'Bala de Canhão (Luyarnha)',
    '{"text":"3 PO"}'::jsonb,
    '4,5 kg',
    'Munição para Canhão de Luyarnha (1 unidade). Inclui armazenamento em saco.',
    '{"ammunition":true,"amount":1,"storageSlug":"saco","ammoFor":["luyarnha-cannon"],"source":"steinhardt-eldritch-hunt","editionSlug":"steinhardt-eldritch-hunt-2024-en","citationSlug":"steinhardt-eldritch-hunt-2024-en:player-pack"}'::jsonb
  ),
  (
    'explosive-cannonball',
    'gear'::rpg.item_type,
    'Bala de Canhão Explosiva',
    '{"text":"30 PO"}'::jsonb,
    '5,5 kg',
    'Munição (Bala de Canhão), Mundana. Uma criatura atingida sofre o dano normal da arma, e cada criatura a até 3 m dela deve ser bem-sucedida numa salvaguarda de Destreza (CD 8 + seu modificador de Força + seu Bônus de Proficiência) ou sofrer 2d8 de dano Ígneo. Em erro, a munição não detona. Após atingir um alvo, a munição é destruída.',
    '{"ammunition":true,"amount":1,"storageSlug":"saco","ammoFor":["luyarnha-cannon"],"source":"steinhardt-eldritch-hunt","editionSlug":"steinhardt-eldritch-hunt-2024-en","citationSlug":"steinhardt-eldritch-hunt-2024-en:player-pack"}'::jsonb
  )
ON CONFLICT (slug) DO UPDATE SET
  item_type = EXCLUDED.item_type,
  name = EXCLUDED.name,
  cost = EXCLUDED.cost,
  weight = EXCLUDED.weight,
  description = EXCLUDED.description,
  properties = EXCLUDED.properties;

INSERT INTO rpg.phb_weapon (item_id, category, damage, damage_type, mastery_id)
VALUES
  ((SELECT id FROM rpg.phb_item WHERE slug = 'luyarnha-blunderbuss'), 'simple'::rpg.weapon_category, '2d4', 'Perfurante', (SELECT id FROM rpg.phb_weapon_mastery WHERE slug = 'topple')),
  ((SELECT id FROM rpg.phb_item WHERE slug = 'flintlock'), 'simple'::rpg.weapon_category, '1d8', 'Perfurante', (SELECT id FROM rpg.phb_weapon_mastery WHERE slug = 'sap')),
  ((SELECT id FROM rpg.phb_item WHERE slug = 'scythe'), 'martial'::rpg.weapon_category, '1d10', 'Cortante', (SELECT id FROM rpg.phb_weapon_mastery WHERE slug = 'cleave')),
  ((SELECT id FROM rpg.phb_item WHERE slug = 'cleaver'), 'martial'::rpg.weapon_category, '1d8', 'Cortante', (SELECT id FROM rpg.phb_weapon_mastery WHERE slug = 'graze')),
  ((SELECT id FROM rpg.phb_item WHERE slug = 'luyarnha-cannon'), 'martial'::rpg.weapon_category, '3d10', 'Contundente', (SELECT id FROM rpg.phb_weapon_mastery WHERE slug = 'push'))
ON CONFLICT (item_id) DO UPDATE SET
  category = EXCLUDED.category,
  damage = EXCLUDED.damage,
  damage_type = EXCLUDED.damage_type,
  mastery_id = EXCLUDED.mastery_id;

-- Property links
INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id)
SELECT i.id, p.id
FROM (
  VALUES
    ('luyarnha-blunderbuss', 'ammunition'),
    ('luyarnha-blunderbuss', 'barrel'),
    ('luyarnha-blunderbuss', 'blaring'),
    ('luyarnha-blunderbuss', 'spread-fire'),
    ('luyarnha-blunderbuss', 'twinned-barrel'),
    ('luyarnha-blunderbuss', 'two-handed'),
    ('flintlock', 'ammunition'),
    ('flintlock', 'barrel'),
    ('flintlock', 'blaring'),
    ('flintlock', 'light'),
    ('scythe', 'finesse'),
    ('scythe', 'reach'),
    ('scythe', 'two-handed'),
    ('cleaver', 'heavy'),
    ('cleaver', 'versatile'),
    ('luyarnha-cannon', 'artillery'),
    ('luyarnha-cannon', 'booming'),
    ('luyarnha-cannon', 'two-handed')
) AS v(item_slug, prop_slug)
JOIN rpg.phb_item i ON i.slug = v.item_slug
JOIN rpg.phb_weapon_property p ON p.slug = v.prop_slug
ON CONFLICT DO NOTHING;
