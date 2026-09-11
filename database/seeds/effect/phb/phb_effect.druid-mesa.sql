-- seed-mode: truncate-scoped (phb_effect CTE; re-seed via truncate)
-- Mesa druida: Forma Selvagem + círculos.

-- Forma Selvagem
WITH cls AS (SELECT id FROM rpg.phb_class WHERE slug = 'druid'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_note'::rpg.effect_kind, 'class'::rpg.effect_owner_kind, cls.id,
         'on_table_action'::rpg.effect_trigger, 'wild-shape', 2, 1,
         'Forma Selvagem'
  FROM cls
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Forma Selvagem: gastou 1 uso para assumir besta ou Companheiro Selvagem.'
FROM ins;

-- Recuperação Natural (slots 1–5)
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'land'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'recover_spell_slot'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, v.action_slug, v.unlock_level, v.slot_level,
         'Recuperação Natural (Slot ' || v.slot_level || 'º)'
  FROM sc
  CROSS JOIN (VALUES
    ('natural-recovery-1', 6, 1),
    ('natural-recovery-2', 6, 2),
    ('natural-recovery-3', 6, 3),
    ('natural-recovery-4', 8, 4),
    ('natural-recovery-5', 10, 5)
  ) AS v(action_slug, unlock_level, slot_level)
  RETURNING id, action_slug
)
INSERT INTO rpg.phb_effect_spell (effect_id, option_key, spell_level)
SELECT id, 'fixed_slot',
  CASE action_slug
    WHEN 'natural-recovery-1' THEN 1
    WHEN 'natural-recovery-2' THEN 2
    WHEN 'natural-recovery-3' THEN 3
    WHEN 'natural-recovery-4' THEN 4
    ELSE 5
  END
FROM ins;

WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'land'),
fx AS (
  SELECT e.id, e.action_slug FROM rpg.phb_effect e
  JOIN sc ON sc.id = e.owner_id
  WHERE e.action_slug LIKE 'natural-recovery-%'
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Recuperação Natural: recuperou 1 Slot de ' ||
  CASE action_slug
    WHEN 'natural-recovery-1' THEN '1'
    WHEN 'natural-recovery-2' THEN '2'
    WHEN 'natural-recovery-3' THEN '3'
    WHEN 'natural-recovery-4' THEN '4'
    ELSE '5'
  END || 'º círculo no Descanso Curto (marque ± natural-recovery).'
FROM fx;

-- Auxílio da Terra
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'land'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_roll'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'land-aid', 3, 1,
         'Auxílio da Terra — Dano'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_dice (effect_id, die)
SELECT id, '2d6' FROM ins;

WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'land'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'heal'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'land-aid', 3, 2,
         'Auxílio da Terra — Cura'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_dice (effect_id, die)
SELECT id, '2d6' FROM ins;

WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'land'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e
  JOIN sc ON sc.id = e.owner_id
  WHERE e.action_slug = 'land-aid' AND e.kind = 'table_roll'
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Auxílio da Terra: Esfera 3 m — {total} Necrótico ({expression}) ou metade; cura aliado na área.'
FROM fx;

-- Santuário Natural / Passo Lunar / outros notes
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'land'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_note'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'nature-sanctuary', 14, 1,
         'Santuário Natural'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Santuário Natural: cubo 4,5 m — Cobertura Parcial e Resistência de Proteção Natural.'
FROM ins;

WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'moon'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_note'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'lunar-step', 10, 1,
         'Passo Lunar'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Passo Lunar: teleporte 9 m; Vantagem no próximo ataque neste turno.'
FROM ins;

-- Ira do Mar / Manifestação / Forma da Cidade / Distorção
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'sea'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_roll'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, v.action_slug, v.unlock_level, 1, v.label
  FROM sc
  CROSS JOIN (VALUES
    ('wrath-of-the-sea', 3, 'Ira do Mar'),
    ('ocean-manifestation', 14, 'Manifestação Oceânica')
  ) AS v(action_slug, unlock_level, label)
  RETURNING id, action_slug
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'ability_mod'::rpg.effect_amount_formula, NULL FROM ins;

WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'circle-of-the-city'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_note'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, v.action_slug, v.unlock_level, 1, v.label
  FROM sc
  CROSS JOIN (VALUES
    ('city-shape', 3, 'Forma da Cidade'),
    ('wall-warp', 10, 'Distorção de Muro')
  ) AS v(action_slug, unlock_level, label)
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id, 'Declare efeito na mesa conforme a característica.'
FROM ins;

-- Estrelas: guia / presságio
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'stars'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_note'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'stellar-guidance', 3, 1,
         'Mapa Estelar (Raio Guia)'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id, 'Mapa Estelar: conjure Raio Guia sem espaço.'
FROM ins;

WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'stars'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_roll'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'cosmic-omen', 6, 1,
         'Presságio Cósmico'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_dice (effect_id, die)
SELECT id, '1d6' FROM ins;
