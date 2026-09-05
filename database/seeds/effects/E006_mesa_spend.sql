DELETE FROM rpg.phb_effect
WHERE trigger IN ('on_resource_spend', 'on_table_action')
  AND (
    resource_slug IN (
      'adrenalineSurge',
      'healingHands',
      'werekin-shift-aspect',
      'gh-focused-edge',
      'enduring-wyrd'
    )
    OR action_slug IN ('brittle-bone-armor', 'marauders-reprisal')
  );

WITH sp AS (SELECT id FROM rpg.phb_species WHERE slug = 'orc'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, resource_slug, unlock_level, sort_order, label
  )
  SELECT 'temp_hp'::rpg.effect_kind, 'species'::rpg.effect_owner_kind, sp.id,
         'on_resource_spend'::rpg.effect_trigger, 'adrenalineSurge', 1, 1,
         'Pico de Adrenalina'
  FROM sp
  RETURNING id
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'proficiency_bonus'::rpg.effect_amount_formula, NULL FROM ins;

WITH sp AS (SELECT id FROM rpg.phb_species WHERE slug = 'orc'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e
  JOIN sp ON sp.id = e.owner_id
  WHERE e.owner_kind = 'species' AND e.resource_slug = 'adrenalineSurge'
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id, 'Pico de Adrenalina: PV temp. (PB) aplicados na ficha.'
FROM fx;

WITH sp AS (SELECT id FROM rpg.phb_species WHERE slug = 'aasimar'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, resource_slug, unlock_level, sort_order, label
  )
  SELECT 'heal'::rpg.effect_kind, 'species'::rpg.effect_owner_kind, sp.id,
         'on_resource_spend'::rpg.effect_trigger, 'healingHands', 1, 1,
         'Mãos Curativas'
  FROM sp
  RETURNING id
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'dice_pb_d4'::rpg.effect_amount_formula, NULL FROM ins;

WITH sp AS (SELECT id FROM rpg.phb_species WHERE slug = 'aasimar'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e
  JOIN sp ON sp.id = e.owner_id
  WHERE e.owner_kind = 'species' AND e.resource_slug = 'healingHands'
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Mãos Curativas: PV curados (PBd4). Toque na sua ficha; se o alvo for outro, ajuste manualmente.'
FROM fx;

WITH sp AS (SELECT id FROM rpg.phb_species WHERE slug = 'werekin'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, resource_slug, unlock_level, sort_order, label
  )
  SELECT 'temp_hp'::rpg.effect_kind, 'species'::rpg.effect_owner_kind, sp.id,
         'on_resource_spend'::rpg.effect_trigger, 'werekin-shift-aspect', 1, 1,
         'Mudar Aspecto — Força Bestial'
  FROM sp
  RETURNING id
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'proficiency_bonus_times_2'::rpg.effect_amount_formula, NULL FROM ins;

WITH sp AS (SELECT id FROM rpg.phb_species WHERE slug = 'werekin'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e
  JOIN sp ON sp.id = e.owner_id
  WHERE e.owner_kind = 'species' AND e.resource_slug = 'werekin-shift-aspect'
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Mudar Aspecto — Força Bestial: PV temp. (2× PB). Ignore se não for Força Bestial.'
FROM fx;

WITH ht AS (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'focused-edge'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, resource_slug, unlock_level, sort_order, label
  )
  SELECT 'temp_hp'::rpg.effect_kind, 'heritage'::rpg.effect_owner_kind, ht.id,
         'on_resource_spend'::rpg.effect_trigger, 'gh-focused-edge', 1, 1,
         'Fio Concentrado'
  FROM ht
  RETURNING id
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'dice_pb_d6'::rpg.effect_amount_formula, NULL FROM ins;

WITH ht AS (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'focused-edge'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e
  JOIN ht ON ht.id = e.owner_id
  WHERE e.owner_kind = 'heritage' AND e.resource_slug = 'gh-focused-edge'
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id, 'Fio Concentrado: PV temp. (PBd6) aplicados na ficha.'
FROM fx;

WITH th AS (SELECT id FROM rpg.phb_character_thread WHERE slug = 'fatebound'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, resource_slug, unlock_level, sort_order, label
  )
  SELECT 'temp_hp'::rpg.effect_kind, 'character_thread'::rpg.effect_owner_kind, th.id,
         'on_resource_spend'::rpg.effect_trigger, 'enduring-wyrd', 1, 1,
         'Wyrd Duradouro'
  FROM th
  RETURNING id
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'proficiency_bonus'::rpg.effect_amount_formula, NULL FROM ins;

WITH th AS (SELECT id FROM rpg.phb_character_thread WHERE slug = 'fatebound'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e
  JOIN th ON th.id = e.owner_id
  WHERE e.owner_kind = 'character_thread' AND e.resource_slug = 'enduring-wyrd'
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id, 'Wyrd Duradouro: PV temp. (PB) aplicados na ficha.'
FROM fx;

WITH c AS (SELECT id FROM rpg.phb_class WHERE slug = 'wizard'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'temp_hp'::rpg.effect_kind, 'class'::rpg.effect_owner_kind, c.id,
         'on_table_action'::rpg.effect_trigger, 'brittle-bone-armor', 1, 1,
         'Armadura de Osso Frágil'
  FROM c
  RETURNING id
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'level_times_2'::rpg.effect_amount_formula, NULL FROM ins;

WITH c AS (SELECT id FROM rpg.phb_class WHERE slug = 'fighter'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'temp_hp'::rpg.effect_kind, 'class'::rpg.effect_owner_kind, c.id,
         'on_table_action'::rpg.effect_trigger, 'marauders-reprisal', 1, 1,
         'Represália do Saqueador'
  FROM c
  RETURNING id
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'level_div_2'::rpg.effect_amount_formula, NULL FROM ins;
