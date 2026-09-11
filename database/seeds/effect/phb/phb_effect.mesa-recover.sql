-- seed-mode: truncate-scoped (phb_effect CTE; re-seed via truncate)
-- Mesa: recover_resource após gasto na economy (padrão feat: botão + effect).

WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'berserker'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, resource_slug,
    unlock_level, sort_order, label
  )
  SELECT 'recover_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'restore-intimidating-presence',
         'intimidating-presence', 14, 1,
         'Restaurar Presença Intimidante'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'fixed'::rpg.effect_amount_formula, 1 FROM ins;

WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'berserker'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e
  JOIN sc ON sc.id = e.owner_id
  WHERE e.owner_kind = 'subclass'
    AND e.action_slug = 'restore-intimidating-presence'
    AND e.kind = 'recover_resource'
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id, 'Restaurou Presença Intimidante gastando 1 uso de Fúria.'
FROM fx;

WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'zealot'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, resource_slug,
    unlock_level, sort_order, label
  )
  SELECT 'recover_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'restore-zealous-presence',
         'zealous-presence', 10, 1,
         'Restaurar Presença Zelosa'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'fixed'::rpg.effect_amount_formula, 1 FROM ins;

WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'zealot'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e
  JOIN sc ON sc.id = e.owner_id
  WHERE e.owner_kind = 'subclass'
    AND e.action_slug = 'restore-zealous-presence'
    AND e.kind = 'recover_resource'
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id, 'Restaurou Presença Zelosa gastando 1 uso de Fúria.'
FROM fx;

WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'pathofthe-primal-spirit'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, resource_slug,
    unlock_level, sort_order, label
  )
  SELECT 'recover_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'shape-of-the-wild-rage-recover',
         'shape-of-the-wild', 14, 1,
         'Restaurar Forma do Selvagem'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'fixed'::rpg.effect_amount_formula, 1 FROM ins;

WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'pathofthe-primal-spirit'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e
  JOIN sc ON sc.id = e.owner_id
  WHERE e.owner_kind = 'subclass'
    AND e.action_slug = 'shape-of-the-wild-rage-recover'
    AND e.kind = 'recover_resource'
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id, 'Restaurou Forma do Selvagem gastando 1 uso de Fúria.'
FROM fx;

WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'warrior-of-the-street'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, resource_slug,
    unlock_level, sort_order, label
  )
  SELECT 'recover_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'recover-knockout',
         'street-knockout', 17, 1,
         'Recuperar K.O.'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'fixed'::rpg.effect_amount_formula, 1 FROM ins;

WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'warrior-of-the-street'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e
  JOIN sc ON sc.id = e.owner_id
  WHERE e.owner_kind = 'subclass'
    AND e.action_slug = 'recover-knockout'
    AND e.kind = 'recover_resource'
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id, 'Recuperar K.O.: gaste 5 Foco para recuperar 1 uso de K.O. (sem ação).'
FROM fx;

WITH c AS (SELECT id FROM rpg.phb_class WHERE slug = 'wizard'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, resource_slug,
    unlock_level, sort_order, label
  )
  SELECT 'recover_resource'::rpg.effect_kind, 'class'::rpg.effect_owner_kind, c.id,
         'on_table_action'::rpg.effect_trigger, 'red-renewal',
         'sangromancy-dice', 14, 1,
         'Renovação Rubra — Dados de Sangromancia'
  FROM c
  RETURNING id
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'level_div_2'::rpg.effect_amount_formula, NULL FROM ins;

WITH c AS (SELECT id FROM rpg.phb_class WHERE slug = 'wizard'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e
  JOIN c ON c.id = e.owner_id
  WHERE e.owner_kind = 'class'
    AND e.action_slug = 'red-renewal'
    AND e.kind = 'recover_resource'
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Recuperados dados de Sangromancia (metade do nível). Recupere também o mesmo número de Dados de Vida gastos.'
FROM fx;
