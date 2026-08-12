-- Opções de subclasse Eldritch Hunt (create wizard)
-- Círculo da Simbiose: Poderes Enxertados (1 pick L3)
-- Sabujo de Sangue: Golpes de Sangue (3 no L3 + 1 nos L5/9/13/17)

-- —— Grafted Powers ——
INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, label, unlock_level, value_type, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'circle-of-symbiosis'),
  'graftedPowers',
  'Poderes Enxertados',
  3,
  'catalog'::rpg.option_value_type,
  1
)
ON CONFLICT (scope, owner_id, option_key) DO UPDATE SET
  label = EXCLUDED.label,
  unlock_level = EXCLUDED.unlock_level,
  value_type = EXCLUDED.value_type,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES
  (
    'subclass'::rpg.option_scope,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'circle-of-symbiosis'),
    'graftedPowers',
    'bear-back',
    'Costas de Urso',
    1
  ),
  (
    'subclass'::rpg.option_scope,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'circle-of-symbiosis'),
    'graftedPowers',
    'deer-head',
    'Cabeça de Cervo',
    2
  ),
  (
    'subclass'::rpg.option_scope,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'circle-of-symbiosis'),
    'graftedPowers',
    'goat-hooves',
    'Cascos de Bode',
    3
  )
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

-- —— Blood Strike slots ——
INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, label, unlock_level, value_type, sort_order)
SELECT
  'subclass'::rpg.option_scope,
  s.id,
  v.option_key,
  v.label,
  v.unlock_level,
  'catalog'::rpg.option_value_type,
  v.sort_order
FROM rpg.phb_subclass s
CROSS JOIN (VALUES
  ('bloodStrike1', 'Golpe de Sangue 1', 3, 1),
  ('bloodStrike2', 'Golpe de Sangue 2', 3, 2),
  ('bloodStrike3', 'Golpe de Sangue 3', 3, 3),
  ('bloodStrike4', 'Golpe de Sangue 4', 5, 4),
  ('bloodStrike5', 'Golpe de Sangue 5', 9, 5),
  ('bloodStrike6', 'Golpe de Sangue 6', 13, 6),
  ('bloodStrike7', 'Golpe de Sangue 7', 17, 7)
) AS v(option_key, label, unlock_level, sort_order)
WHERE s.slug = 'blood-hound'
ON CONFLICT (scope, owner_id, option_key) DO UPDATE SET
  label = EXCLUDED.label,
  unlock_level = EXCLUDED.unlock_level,
  value_type = EXCLUDED.value_type,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
SELECT
  'subclass'::rpg.option_scope,
  s.id,
  k.option_key,
  v.value_id,
  v.label,
  v.sort_order
FROM rpg.phb_subclass s
CROSS JOIN (VALUES
  ('bloodStrike1'),
  ('bloodStrike2'),
  ('bloodStrike3'),
  ('bloodStrike4'),
  ('bloodStrike5'),
  ('bloodStrike6'),
  ('bloodStrike7')
) AS k(option_key)
CROSS JOIN (VALUES
  ('bewitching-strike', 'Golpe Enfeitiçante', 1),
  ('bloodboil-strike', 'Golpe Ferver-Sangue', 2),
  ('bloodshard-strike', 'Golpe Estilhaço-Sangue', 3),
  ('constraining-strike', 'Golpe Constritor', 4),
  ('exiling-strike', 'Golpe do Exílio', 5),
  ('hunting-strike', 'Golpe da Caça', 6),
  ('shadowblood-strike', 'Golpe Sangue-Sombra', 7),
  ('thunderblood-strike', 'Golpe Sangue-Trovão', 8),
  ('withering-strike', 'Golpe Definhante', 9)
) AS v(value_id, label, sort_order)
WHERE s.slug = 'blood-hound'
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

-- —— Blade of Radiance L13: 2 truques da lista de Clérigo ——
INSERT INTO rpg.phb_option_def (
  scope, owner_id, option_key, label, unlock_level, value_type, spell_max_level, sort_order
)
VALUES
  (
    'subclass'::rpg.option_scope,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'blade-of-radiance'),
    'holyRevelationCantrip1',
    'Revelações Santas — Truque 1',
    13,
    'spell'::rpg.option_value_type,
    0,
    1
  ),
  (
    'subclass'::rpg.option_scope,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'blade-of-radiance'),
    'holyRevelationCantrip2',
    'Revelações Santas — Truque 2',
    13,
    'spell'::rpg.option_value_type,
    0,
    2
  )
ON CONFLICT (scope, owner_id, option_key) DO UPDATE SET
  label = EXCLUDED.label,
  unlock_level = EXCLUDED.unlock_level,
  value_type = EXCLUDED.value_type,
  spell_max_level = EXCLUDED.spell_max_level,
  sort_order = EXCLUDED.sort_order;
