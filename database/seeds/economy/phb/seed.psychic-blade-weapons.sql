-- Lâminas Psíquicas (Adaga Espiritual) — armas de catálogo, não hardcode no domain.
-- Regra: armas/ataques concedidos por classe/subclasse entram em phb_item + phb_weapon
-- (e properties/mastery); o resolve só carrega por slug. Ver conventions do rpg-catalog-model.

INSERT INTO rpg.phb_item (slug, item_type, name, cost, weight, description, properties)
VALUES
  (
    'psychic-blade',
    'weapon'::rpg.item_type,
    'Lâmina Psíquica',
    NULL,
    '—',
    'Adaga Espiritual: manifesta uma lâmina de energia psíquica (Acuidade, Arremesso 18/36 m, maestria Afligir). Não é item de inventário permanente — some após o ataque; na mesa aparece como card de ataque.',
    '{"propertyIds":["finesse","thrown"],"masteryId":"vex","range":{"normal":18,"max":36},"grantedBySubclass":"soulknife"}'::jsonb
  ),
  (
    'psychic-blade-bonus',
    'weapon'::rpg.item_type,
    'Lâmina Psíquica (adicional)',
    NULL,
    '—',
    'Adaga Espiritual: segunda lâmina como Ação Bônus (1d4 Psíquico). Use o card na ficha com Furtivo/Golpe Astuto.',
    '{"propertyIds":["finesse","thrown","light"],"masteryId":"vex","range":{"normal":18,"max":36},"grantedBySubclass":"soulknife","bonusActionBlade":true}'::jsonb
  )
ON CONFLICT (slug) DO UPDATE SET
  item_type = EXCLUDED.item_type,
  name = EXCLUDED.name,
  cost = EXCLUDED.cost,
  weight = EXCLUDED.weight,
  description = EXCLUDED.description,
  properties = EXCLUDED.properties,
  updated_at = NOW();

INSERT INTO rpg.phb_weapon (item_id, category, damage, damage_type, mastery_id)
VALUES
  (
    (SELECT id FROM rpg.phb_item WHERE slug = 'psychic-blade'),
    'simple'::rpg.weapon_category,
    '1d6',
    'Psíquico',
    (SELECT id FROM rpg.phb_weapon_mastery WHERE slug = 'vex')
  ),
  (
    (SELECT id FROM rpg.phb_item WHERE slug = 'psychic-blade-bonus'),
    'simple'::rpg.weapon_category,
    '1d4',
    'Psíquico',
    (SELECT id FROM rpg.phb_weapon_mastery WHERE slug = 'vex')
  )
ON CONFLICT (item_id) DO UPDATE SET
  category = EXCLUDED.category,
  damage = EXCLUDED.damage,
  damage_type = EXCLUDED.damage_type,
  mastery_id = EXCLUDED.mastery_id;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id)
SELECT i.id, p.id
FROM (VALUES
  ('psychic-blade', 'finesse'),
  ('psychic-blade', 'thrown'),
  ('psychic-blade-bonus', 'finesse'),
  ('psychic-blade-bonus', 'thrown'),
  ('psychic-blade-bonus', 'light')
) AS v(item_slug, prop_slug)
JOIN rpg.phb_item i ON i.slug = v.item_slug
JOIN rpg.phb_weapon_property p ON p.slug = v.prop_slug
ON CONFLICT DO NOTHING;
