-- Mastery Pull (Northlands Cap. 5) + armas mundanas novas

INSERT INTO rpg.phb_weapon_mastery (slug, name, description)
VALUES (
  'pull',
  'Puxar',
  'Se você atingir uma criatura com esta arma, pode puxá-la 1,5 metro na sua direção se ela for Grande ou menor. Ao fazer isso, você também pode se mover 1,5 metro para trás sem provocar Ataques de Oportunidade, e esse movimento não gasta seu Deslocamento normal.'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description;

-- —— Itens ——
INSERT INTO rpg.phb_item (slug, item_type, name, cost, weight, description, properties)
VALUES
  (
    'seax',
    'weapon'::rpg.item_type,
    'Seax',
    '{"text":"1 PO"}'::jsonb,
    '1 kg',
    'Faca de combate pesada demais para arremesso; lâmina longa capaz de furar couro e malha.',
    '{"propertyIds":["finesse","light"],"masteryId":"graze","source":"northlands-heroes"}'::jsonb
  ),
  (
    'snaerispear',
    'weapon'::rpg.item_type,
    'Snaerispear',
    '{"text":"5 PO"}'::jsonb,
    '1 kg',
    'Lança curta estilo dardo; a correia de arremesso permite 1d8 de dano ao arremessar (corpo a corpo: 1d6).',
    '{"propertyIds":["finesse","thrown"],"masteryId":"slow","range":{"normal":9,"max":27},"thrownDamage":"1d8","source":"northlands-heroes"}'::jsonb
  ),
  (
    'atgeir',
    'weapon'::rpg.item_type,
    'Atgeir',
    '{"text":"25 PO"}'::jsonb,
    '3,5 kg',
    'Arma de haste com grande lâmina de um gume; usada para empurrar inimigos após o golpe (mastery Puxar).',
    '{"propertyIds":["heavy","reach","two-handed"],"masteryId":"pull","source":"northlands-heroes"}'::jsonb
  ),
  (
    'bearded-axe',
    'weapon'::rpg.item_type,
    'Machado Barbudo',
    '{"text":"30 PO"}'::jsonb,
    '3 kg',
    'O “barbicho” na base da lâmina aumenta a aresta de corte sem peso excessivo.',
    '{"propertyIds":["heavy","versatile"],"masteryId":"cleave","versatileDamage":"1d12","source":"northlands-heroes"}'::jsonb
  ),
  (
    'breidox',
    'weapon'::rpg.item_type,
    'Breidox',
    '{"text":"45 PO"}'::jsonb,
    '5,5 kg',
    'Essencialmente um machado grande de haste mais longa, feito para cortar atrás de muralhas de escudos.',
    '{"propertyIds":["heavy","reach","two-handed"],"masteryId":"topple","source":"northlands-heroes"}'::jsonb
  ),
  (
    'bryntroll',
    'weapon'::rpg.item_type,
    'Bryntroll',
    '{"text":"35 PO"}'::jsonb,
    '3,5 kg',
    'Lâmina de corte maciça na ponta de uma haste longa; pensada para perfurar a pele de gigantes.',
    '{"propertyIds":["heavy","reach","two-handed"],"masteryId":"slow","source":"northlands-heroes"}'::jsonb
  ),
  (
    'ulfberht-blade',
    'weapon'::rpg.item_type,
    'Lâmina Ulfberht',
    '{"text":"350 PO"}'::jsonb,
    '1,5 kg',
    'Espada lendária de aço excepcional. Mastery principal: Resvalar (a fonte também cita Drenar — use Resvalar no sistema; Drenar na mesa se o MJ permitir dual).',
    '{"propertyIds":["versatile"],"masteryId":"graze","versatileDamage":"1d10","secondaryMasteryId":"sap","source":"northlands-heroes"}'::jsonb
  )
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  cost = EXCLUDED.cost,
  weight = EXCLUDED.weight,
  description = EXCLUDED.description,
  properties = EXCLUDED.properties,
  item_type = EXCLUDED.item_type;

-- —— Weapon rows ——
INSERT INTO rpg.phb_weapon (item_id, category, damage, damage_type, mastery_id)
VALUES
  ((SELECT id FROM rpg.phb_item WHERE slug = 'seax'), 'simple'::rpg.weapon_category, '1d4', 'Perfurante', (SELECT id FROM rpg.phb_weapon_mastery WHERE slug = 'graze')),
  ((SELECT id FROM rpg.phb_item WHERE slug = 'snaerispear'), 'simple'::rpg.weapon_category, '1d6', 'Perfurante', (SELECT id FROM rpg.phb_weapon_mastery WHERE slug = 'slow')),
  ((SELECT id FROM rpg.phb_item WHERE slug = 'atgeir'), 'martial'::rpg.weapon_category, '1d10', 'Perfurante', (SELECT id FROM rpg.phb_weapon_mastery WHERE slug = 'pull')),
  ((SELECT id FROM rpg.phb_item WHERE slug = 'bearded-axe'), 'martial'::rpg.weapon_category, '1d10', 'Cortante', (SELECT id FROM rpg.phb_weapon_mastery WHERE slug = 'cleave')),
  ((SELECT id FROM rpg.phb_item WHERE slug = 'breidox'), 'martial'::rpg.weapon_category, '1d10', 'Cortante', (SELECT id FROM rpg.phb_weapon_mastery WHERE slug = 'topple')),
  ((SELECT id FROM rpg.phb_item WHERE slug = 'bryntroll'), 'martial'::rpg.weapon_category, '1d10', 'Cortante', (SELECT id FROM rpg.phb_weapon_mastery WHERE slug = 'slow')),
  ((SELECT id FROM rpg.phb_item WHERE slug = 'ulfberht-blade'), 'martial'::rpg.weapon_category, '1d8', 'Cortante', (SELECT id FROM rpg.phb_weapon_mastery WHERE slug = 'graze'))
ON CONFLICT (item_id) DO UPDATE SET
  category = EXCLUDED.category,
  damage = EXCLUDED.damage,
  damage_type = EXCLUDED.damage_type,
  mastery_id = EXCLUDED.mastery_id;

-- —— Property links ——
INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id)
SELECT w.item_id, p.id
FROM rpg.phb_weapon w
JOIN rpg.phb_item i ON i.id = w.item_id
CROSS JOIN rpg.phb_weapon_property p
WHERE (i.slug, p.slug) IN (
  ('seax', 'finesse'),
  ('seax', 'light'),
  ('snaerispear', 'finesse'),
  ('snaerispear', 'thrown'),
  ('atgeir', 'heavy'),
  ('atgeir', 'reach'),
  ('atgeir', 'two-handed'),
  ('bearded-axe', 'heavy'),
  ('bearded-axe', 'versatile'),
  ('breidox', 'heavy'),
  ('breidox', 'reach'),
  ('breidox', 'two-handed'),
  ('bryntroll', 'heavy'),
  ('bryntroll', 'reach'),
  ('bryntroll', 'two-handed'),
  ('ulfberht-blade', 'versatile')
)
ON CONFLICT DO NOTHING;
