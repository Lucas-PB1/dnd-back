-- seed-mode: truncate-scoped (phb_effect CTE; re-seed via truncate)
-- Mesa magia: cura/PV temp. na ficha do conjurador (ajuste se for aliado).

WITH sp AS (SELECT id FROM rpg.phb_spell WHERE slug = 'curar-ferimentos'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'heal'::rpg.effect_kind, 'spell'::rpg.effect_owner_kind, sp.id,
         'on_cast'::rpg.effect_trigger, 1, 1, 'Curar Ferimentos'
  FROM sp
  RETURNING id
)
INSERT INTO rpg.phb_effect_dice (effect_id, die)
SELECT id, '2d8' FROM ins;

WITH sp AS (SELECT id FROM rpg.phb_spell WHERE slug = 'curar-ferimentos'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e
  JOIN sp ON sp.id = e.owner_id
  WHERE e.kind = 'heal' AND e.owner_kind = 'spell' AND e.trigger = 'on_cast'
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'ability_mod'::rpg.effect_amount_formula, NULL FROM fx;

WITH sp AS (SELECT id FROM rpg.phb_spell WHERE slug = 'curar-ferimentos'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e
  JOIN sp ON sp.id = e.owner_id
  WHERE e.kind = 'heal' AND e.owner_kind = 'spell' AND e.trigger = 'on_cast'
)
INSERT INTO rpg.phb_effect_spell (effect_id, option_key)
SELECT id, 'upcast_dice:2' FROM fx;

WITH sp AS (SELECT id FROM rpg.phb_spell WHERE slug = 'curar-ferimentos'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e
  JOIN sp ON sp.id = e.owner_id
  WHERE e.kind = 'heal' AND e.owner_kind = 'spell' AND e.trigger = 'on_cast'
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Curar Ferimentos: {total} PV ({expression}; ajuste se for aliado).'
FROM fx;

WITH sp AS (SELECT id FROM rpg.phb_spell WHERE slug = 'palavra-curativa'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'heal'::rpg.effect_kind, 'spell'::rpg.effect_owner_kind, sp.id,
         'on_cast'::rpg.effect_trigger, 1, 1, 'Palavra Curativa'
  FROM sp
  RETURNING id
)
INSERT INTO rpg.phb_effect_dice (effect_id, die)
SELECT id, '2d4' FROM ins;

WITH sp AS (SELECT id FROM rpg.phb_spell WHERE slug = 'palavra-curativa'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e
  JOIN sp ON sp.id = e.owner_id
  WHERE e.kind = 'heal' AND e.owner_kind = 'spell' AND e.trigger = 'on_cast'
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'ability_mod'::rpg.effect_amount_formula, NULL FROM fx;

WITH sp AS (SELECT id FROM rpg.phb_spell WHERE slug = 'palavra-curativa'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e
  JOIN sp ON sp.id = e.owner_id
  WHERE e.kind = 'heal' AND e.owner_kind = 'spell' AND e.trigger = 'on_cast'
)
INSERT INTO rpg.phb_effect_spell (effect_id, option_key)
SELECT id, 'upcast_dice:1' FROM fx;

WITH sp AS (SELECT id FROM rpg.phb_spell WHERE slug = 'palavra-curativa'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e
  JOIN sp ON sp.id = e.owner_id
  WHERE e.kind = 'heal' AND e.owner_kind = 'spell' AND e.trigger = 'on_cast'
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Palavra Curativa: {total} PV ({expression}; ajuste se for aliado).'
FROM fx;

WITH sp AS (SELECT id FROM rpg.phb_spell WHERE slug = 'vitalidade-vazia'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'temp_hp'::rpg.effect_kind, 'spell'::rpg.effect_owner_kind, sp.id,
         'on_cast'::rpg.effect_trigger, 1, 1, 'Vitalidade Vazia'
  FROM sp
  RETURNING id
)
INSERT INTO rpg.phb_effect_dice (effect_id, die)
SELECT id, '2d4' FROM ins;

WITH sp AS (SELECT id FROM rpg.phb_spell WHERE slug = 'vitalidade-vazia'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e
  JOIN sp ON sp.id = e.owner_id
  WHERE e.kind = 'temp_hp' AND e.owner_kind = 'spell' AND e.trigger = 'on_cast'
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'fixed'::rpg.effect_amount_formula, 4 FROM fx;

WITH sp AS (SELECT id FROM rpg.phb_spell WHERE slug = 'vitalidade-vazia'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e
  JOIN sp ON sp.id = e.owner_id
  WHERE e.kind = 'temp_hp' AND e.owner_kind = 'spell' AND e.trigger = 'on_cast'
)
INSERT INTO rpg.phb_effect_spell (effect_id, option_key)
SELECT id, 'upcast_flat:5' FROM fx;

WITH sp AS (SELECT id FROM rpg.phb_spell WHERE slug = 'vitalidade-vazia'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e
  JOIN sp ON sp.id = e.owner_id
  WHERE e.kind = 'temp_hp' AND e.owner_kind = 'spell' AND e.trigger = 'on_cast'
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Vitalidade Vazia: {total} PV temporários ({expression}).'
FROM fx;
