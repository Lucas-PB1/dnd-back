-- Lâmina Arcana (spellblade) — escolhas: ASI, atributo de conjuração, 2 truques.

INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, label, value_type, sort_order)
VALUES
  (
    'feat'::rpg.option_scope,
    (SELECT id FROM rpg.phb_feat WHERE slug = 'spellblade'),
    'abilityIncrease',
    'Aumento de atributo (+1)',
    'ability',
    1
  ),
  (
    'feat'::rpg.option_scope,
    (SELECT id FROM rpg.phb_feat WHERE slug = 'spellblade'),
    'castingAbility',
    'Atributo de conjuração',
    'catalog',
    2
  ),
  (
    'feat'::rpg.option_scope,
    (SELECT id FROM rpg.phb_feat WHERE slug = 'spellblade'),
    'cantrip1',
    'Truque de lâmina 1',
    'catalog',
    3
  ),
  (
    'feat'::rpg.option_scope,
    (SELECT id FROM rpg.phb_feat WHERE slug = 'spellblade'),
    'cantrip2',
    'Truque de lâmina 2',
    'catalog',
    4
  )
ON CONFLICT (scope, owner_id, option_key) DO NOTHING;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
SELECT
  'feat'::rpg.option_scope,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'spellblade'),
  v.option_key,
  v.value_id,
  v.label,
  v.sort_order
FROM (
  VALUES
    ('abilityIncrease', 'inteligencia', 'Inteligência', 1),
    ('abilityIncrease', 'sabedoria', 'Sabedoria', 2),
    ('abilityIncrease', 'carisma', 'Carisma', 3),
    ('castingAbility', 'inteligencia', 'Inteligência', 1),
    ('castingAbility', 'sabedoria', 'Sabedoria', 2),
    ('castingAbility', 'carisma', 'Carisma', 3),
    ('cantrip1', 'arc-blade', 'Lâmina Relâmpago', 1),
    ('cantrip1', 'burning-blade', 'Lâmina Ardente', 2),
    ('cantrip1', 'frigid-blade', 'Lâmina Gélida', 3),
    ('cantrip1', 'golpe-certeiro', 'Golpe Certeiro', 4),
    ('cantrip2', 'arc-blade', 'Lâmina Relâmpago', 1),
    ('cantrip2', 'burning-blade', 'Lâmina Ardente', 2),
    ('cantrip2', 'frigid-blade', 'Lâmina Gélida', 3),
    ('cantrip2', 'golpe-certeiro', 'Golpe Certeiro', 4)
) AS v(option_key, value_id, label, sort_order)
ON CONFLICT (scope, owner_id, option_key, value_id) DO NOTHING;
