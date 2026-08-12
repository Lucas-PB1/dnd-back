-- Greater Blessings — ASI (abilityIncrease) + magias fixas

-- ASI por greater blessing
INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, label, value_type, sort_order)
SELECT 'feat'::rpg.option_scope, f.id, 'abilityIncrease', 'Aumento de atributo (+1)', 'ability', 1
FROM rpg.phb_feat f
WHERE f.slug IN (
  'greater-blessing-of-baldur',
  'greater-blessing-of-boreas',
  'greater-blessing-of-freyr-and-freyja',
  'greater-blessing-of-jormungandr',
  'greater-blessing-of-loki',
  'greater-blessing-of-sif',
  'greater-blessing-of-thor',
  'greater-blessing-of-wotan'
)
ON CONFLICT (scope, owner_id, option_key) DO NOTHING;

-- Baldur: DEX | CON
INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
SELECT 'feat'::rpg.option_scope, f.id, 'abilityIncrease', v.value_id, v.label, v.sort_order
FROM rpg.phb_feat f
CROSS JOIN (VALUES
  ('destreza', 'Destreza', 1),
  ('constituicao', 'Constituição', 2)
) AS v(value_id, label, sort_order)
WHERE f.slug = 'greater-blessing-of-baldur'
ON CONFLICT (scope, owner_id, option_key, value_id) DO NOTHING;

-- Boreas: FOR | CON
INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
SELECT 'feat'::rpg.option_scope, f.id, 'abilityIncrease', v.value_id, v.label, v.sort_order
FROM rpg.phb_feat f
CROSS JOIN (VALUES
  ('forca', 'Força', 1),
  ('constituicao', 'Constituição', 2)
) AS v(value_id, label, sort_order)
WHERE f.slug = 'greater-blessing-of-boreas'
ON CONFLICT (scope, owner_id, option_key, value_id) DO NOTHING;

-- Freyr: SAB | CAR
INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
SELECT 'feat'::rpg.option_scope, f.id, 'abilityIncrease', v.value_id, v.label, v.sort_order
FROM rpg.phb_feat f
CROSS JOIN (VALUES
  ('sabedoria', 'Sabedoria', 1),
  ('carisma', 'Carisma', 2)
) AS v(value_id, label, sort_order)
WHERE f.slug = 'greater-blessing-of-freyr-and-freyja'
ON CONFLICT (scope, owner_id, option_key, value_id) DO NOTHING;

-- Jormungandr: FOR | CAR
INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
SELECT 'feat'::rpg.option_scope, f.id, 'abilityIncrease', v.value_id, v.label, v.sort_order
FROM rpg.phb_feat f
CROSS JOIN (VALUES
  ('forca', 'Força', 1),
  ('carisma', 'Carisma', 2)
) AS v(value_id, label, sort_order)
WHERE f.slug = 'greater-blessing-of-jormungandr'
ON CONFLICT (scope, owner_id, option_key, value_id) DO NOTHING;

-- Loki: INT | CAR
INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
SELECT 'feat'::rpg.option_scope, f.id, 'abilityIncrease', v.value_id, v.label, v.sort_order
FROM rpg.phb_feat f
CROSS JOIN (VALUES
  ('inteligencia', 'Inteligência', 1),
  ('carisma', 'Carisma', 2)
) AS v(value_id, label, sort_order)
WHERE f.slug = 'greater-blessing-of-loki'
ON CONFLICT (scope, owner_id, option_key, value_id) DO NOTHING;

-- Sif: DEX | CON
INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
SELECT 'feat'::rpg.option_scope, f.id, 'abilityIncrease', v.value_id, v.label, v.sort_order
FROM rpg.phb_feat f
CROSS JOIN (VALUES
  ('destreza', 'Destreza', 1),
  ('constituicao', 'Constituição', 2)
) AS v(value_id, label, sort_order)
WHERE f.slug = 'greater-blessing-of-sif'
ON CONFLICT (scope, owner_id, option_key, value_id) DO NOTHING;

-- Thor: FOR | CON
INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
SELECT 'feat'::rpg.option_scope, f.id, 'abilityIncrease', v.value_id, v.label, v.sort_order
FROM rpg.phb_feat f
CROSS JOIN (VALUES
  ('forca', 'Força', 1),
  ('constituicao', 'Constituição', 2)
) AS v(value_id, label, sort_order)
WHERE f.slug = 'greater-blessing-of-thor'
ON CONFLICT (scope, owner_id, option_key, value_id) DO NOTHING;

-- Wotan: INT | SAB | CAR
INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
SELECT 'feat'::rpg.option_scope, f.id, 'abilityIncrease', v.value_id, v.label, v.sort_order
FROM rpg.phb_feat f
CROSS JOIN (VALUES
  ('inteligencia', 'Inteligência', 1),
  ('sabedoria', 'Sabedoria', 2),
  ('carisma', 'Carisma', 3)
) AS v(value_id, label, sort_order)
WHERE f.slug = 'greater-blessing-of-wotan'
ON CONFLICT (scope, owner_id, option_key, value_id) DO NOTHING;

-- Magias fixas greater
INSERT INTO rpg.phb_spell_grant (origin_type, origin_id, spell_id, unlock_level)
VALUES
  (
    'feat'::rpg.spell_grant_origin,
    (SELECT id FROM rpg.phb_feat WHERE slug = 'greater-blessing-of-freyr-and-freyja'),
    (SELECT id FROM rpg.phb_spell WHERE slug = 'curar-ferimentos'),
    1
  ),
  (
    'feat'::rpg.spell_grant_origin,
    (SELECT id FROM rpg.phb_feat WHERE slug = 'greater-blessing-of-loki'),
    (SELECT id FROM rpg.phb_spell WHERE slug = 'alterar-se'),
    1
  ),
  (
    'feat'::rpg.spell_grant_origin,
    (SELECT id FROM rpg.phb_feat WHERE slug = 'greater-blessing-of-wotan'),
    (SELECT id FROM rpg.phb_spell WHERE slug = 'augurio'),
    1
  )
ON CONFLICT (origin_type, origin_id, spell_id, unlock_level) DO NOTHING;
