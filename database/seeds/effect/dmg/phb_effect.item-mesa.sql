-- seed-mode: truncate-scoped (phb_effect CTE; re-seed via truncate)
-- Mesa item: poções que mexem em PV / condições na ficha. Charges = spend-resource no POST item/table-action.

-- Poção de Cura — 2d4 + 2 PV
WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'pocao-de-cura'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'heal'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_table_action'::rpg.effect_trigger, 'item-pocao-de-cura-usar', 1, 1,
         'Poção de Cura'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_dice (effect_id, die)
SELECT id, '2d4' FROM ins;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'pocao-de-cura'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e
  JOIN owner ON owner.id = e.owner_id
  WHERE e.owner_kind = 'item' AND e.action_slug = 'item-pocao-de-cura-usar'
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'fixed'::rpg.effect_amount_formula, 2 FROM fx;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'pocao-de-cura'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e
  JOIN owner ON owner.id = e.owner_id
  WHERE e.owner_kind = 'item' AND e.action_slug = 'item-pocao-de-cura-usar'
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Poção de Cura: {total} PV ({expression}). Aplique nesta ficha; aliado: ajuste PV na mesa.'
FROM fx;

-- Poção de Heroísmo — 10 PV temp.
WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'pocao-de-heroismo'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'temp_hp'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_table_action'::rpg.effect_trigger, 'item-pocao-de-heroismo-usar', 1, 1,
         'Poção de Heroísmo'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'fixed'::rpg.effect_amount_formula, 10 FROM ins;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'pocao-de-heroismo'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e
  JOIN owner ON owner.id = e.owner_id
  WHERE e.owner_kind = 'item' AND e.action_slug = 'item-pocao-de-heroismo-usar'
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Poção de Heroísmo: 10 PV temporários (1 hora). Bênção: declare na mesa (sem concentração).'
FROM fx;

-- Poção da Saúde — Cego, Envenenado, Paralisado, Surdo
WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'pocao-da-saude'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'clear_condition'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_table_action'::rpg.effect_trigger, 'item-pocao-da-saude-usar', 1, 1,
         'Poção da Saúde — Cego'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_condition (effect_id, condition_slug, pending_kind)
SELECT id, 'blinded'::rpg.condition_slug, NULL FROM ins;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'pocao-da-saude'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'clear_condition'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_table_action'::rpg.effect_trigger, 'item-pocao-da-saude-usar', 1, 2,
         'Poção da Saúde — Envenenado'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_condition (effect_id, condition_slug, pending_kind)
SELECT id, 'poisoned'::rpg.condition_slug, NULL FROM ins;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'pocao-da-saude'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'clear_condition'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_table_action'::rpg.effect_trigger, 'item-pocao-da-saude-usar', 1, 3,
         'Poção da Saúde — Paralisado'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_condition (effect_id, condition_slug, pending_kind)
SELECT id, 'paralyzed'::rpg.condition_slug, NULL FROM ins;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'pocao-da-saude'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'clear_condition'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_table_action'::rpg.effect_trigger, 'item-pocao-da-saude-usar', 1, 4,
         'Poção da Saúde — Surdo'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_condition (effect_id, condition_slug, pending_kind)
SELECT id, 'deafened'::rpg.condition_slug, NULL FROM ins;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'pocao-da-saude'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e
  JOIN owner ON owner.id = e.owner_id
  WHERE e.owner_kind = 'item' AND e.action_slug = 'item-pocao-da-saude-usar'
    AND e.kind = 'clear_condition'
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Poção da Saúde: encerra Cego, Envenenado, Paralisado e Surdo nesta ficha. Contágio mágico: declare na mesa.'
FROM fx;
