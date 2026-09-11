-- seed-mode: truncate-scoped (phb_effect CTE; re-seed via truncate)
-- Mesa ladino: Soulknife + subclasses.

-- Aptidão Reforçada / Golpe Teleguiado
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'soulknife'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, resource_slug,
    unlock_level, sort_order, label
  )
  SELECT 'check_boost'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, v.action_slug, 'soulknife-psi-dice',
         v.unlock_level, 1, v.label
  FROM sc
  CROSS JOIN (VALUES
    ('psi-bolstered-knack', 3, 'Aptidão Reforçada Psiquicamente'),
    ('guided-strike', 9, 'Golpes Teleguiados')
  ) AS v(action_slug, unlock_level, label)
  RETURNING id, action_slug
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  CASE action_slug
    WHEN 'psi-bolstered-knack' THEN 'Some o dado psi ao teste; gasta só se sucesso.'
    ELSE 'Some o dado psi ao ataque que errou; gasta só se acertar.'
  END
FROM ins;

-- Sussurros Psíquicos
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'soulknife'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_roll'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'psychic-whispers', 3, 1,
         'Sussurros Psíquicos'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'schedule_die_plus_flat'::rpg.effect_amount_formula, NULL FROM ins;

-- Teleporte Psíquico
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'soulknife'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_roll'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'psychic-teleport', 9, 1,
         'Teleporte Psíquico'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'schedule_die_plus_flat'::rpg.effect_amount_formula, NULL FROM ins;

-- Véu / Rasgar Mente
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'soulknife'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_note'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, v.action_slug, v.unlock_level, 1, v.label
  FROM sc
  CROSS JOIN (VALUES
    ('psychic-veil', 13, 'Véu Psíquico'),
    ('rend-mind', 17, 'Rasgar Mente')
  ) AS v(action_slug, unlock_level, label)
  RETURNING id, action_slug
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  CASE action_slug
    WHEN 'psychic-veil' THEN 'Véu Psíquico: Invisível por 1 h ou até causar dano/forçar salvaguarda.'
    ELSE 'Rasgar Mente: salvaguarda SAB CD {saveDc}; falha = Atordoado.'
  END
FROM ins;

WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'soulknife'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'feature_dc'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'rend-mind', 17, 2,
         'Rasgar Mente — CD'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'eight_plus_mod_plus_pb'::rpg.effect_amount_formula, NULL FROM ins;

-- Ladrão de Magias
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'arcane-trickster'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'feature_dc'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'spell-thief', 17, 1,
         'Ladrão de Magias — CD'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'eight_plus_mod_plus_pb'::rpg.effect_amount_formula, NULL FROM ins;

WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'arcane-trickster'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_note'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'spell-thief', 17, 2,
         'Ladrão de Magias'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Ladrão de Magias: salvaguarda INT CD {saveDc}; falha nega a magia e permite prepará-la.'
FROM ins;

-- Arachnoid
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'arachnoid-stalker'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'feature_dc'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'arachnoid-web', 3, 1,
         'Correia — CD'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'eight_plus_mod_plus_pb'::rpg.effect_amount_formula, NULL FROM ins;

WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'arachnoid-stalker'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_note'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'arachnoid-web', 3, 2,
         'Correia / Teia'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Correia: puxar-se, balançar ou prender; CD {saveDc} quando houver salvaguarda.'
FROM ins;

-- Usar Dispositivo Mágico
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'thief'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_roll'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'magic-device-charge', 13, 1,
         'Usar Dispositivo Mágico — Cargas'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_dice (effect_id, die)
SELECT id, '1d6' FROM ins;

WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'thief'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e
  JOIN sc ON sc.id = e.owner_id
  WHERE e.action_slug = 'magic-device-charge' AND e.kind = 'table_roll'
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Usar Dispositivo Mágico: 6 = propriedade não gasta cargas; senão gasta normalmente.'
FROM fx;
