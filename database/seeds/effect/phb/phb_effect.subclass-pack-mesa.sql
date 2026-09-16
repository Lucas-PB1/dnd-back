-- seed-mode: truncate-scoped (phb_effect CTE; re-seed via truncate)
-- Mesa subclass de pack: apply de ficha (cura / PV temp. / recover / clear). Combate fica fora.

-- GH Trapper — Regeneração da Armadura (1d10 + CON)
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'trapper-guild'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'heal'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'armor-regen', 15, 1,
         'Regeneração da Armadura'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_dice (effect_id, die)
SELECT id, '1d10' FROM ins;

WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'trapper-guild'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e
  JOIN sc ON sc.id = e.owner_id
  WHERE e.owner_kind = 'subclass' AND e.action_slug = 'armor-regen'
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'ability_mod'::rpg.effect_amount_formula, NULL FROM fx;

WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'trapper-guild'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e
  JOIN sc ON sc.id = e.owner_id
  WHERE e.owner_kind = 'subclass' AND e.action_slug = 'armor-regen'
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Regeneração da Armadura: recupere {total} PV ({expression}). Aplique na ficha.'
FROM fx;

-- GH Devourer — Colher Porção
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'devourer-guild'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, resource_slug,
    unlock_level, sort_order, label
  )
  SELECT 'recover_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'harvest-portion',
         'devourer-portion', 3, 1, 'Colher Porção'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'fixed'::rpg.effect_amount_formula, 1 FROM ins;

WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'devourer-guild'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e
  JOIN sc ON sc.id = e.owner_id
  WHERE e.owner_kind = 'subclass' AND e.action_slug = 'harvest-portion'
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id, 'Colheu 1 porção de monstro (cadáver elegível).'
FROM fx;

-- GH Carver — Determinação Inabalável (você incluso)
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'carver-guild'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'clear_condition'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'true-grit', 7, 1,
         'Determinação Inabalável'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_condition (effect_id, condition_slug, pending_kind)
SELECT id, 'frightened'::rpg.condition_slug, NULL FROM ins;

WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'carver-guild'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e
  JOIN sc ON sc.id = e.owner_id
  WHERE e.owner_kind = 'subclass' AND e.action_slug = 'true-grit'
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Determinação Inabalável: encerre Amedrontado em você (ou declare outro alvo a 18 m na mesa).'
FROM fx;

-- GH Inquisition — Escudo Mágico
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'inquisition-domain'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'temp_hp'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'spell-shield', 3, 1,
         'Escudo Mágico'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'dice_1d10_plus_level'::rpg.effect_amount_formula, NULL FROM ins;

WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'inquisition-domain'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e
  JOIN sc ON sc.id = e.owner_id
  WHERE e.owner_kind = 'subclass' AND e.action_slug = 'spell-shield'
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Escudo Mágico: {total} PV temporários ({expression}) na ficha (ajuste se for aliado). Enquanto durarem: Vantagem em salvaguardas vs magias e Resistência a dano de magias (10 min).'
FROM fx;

-- GSB Círculo Inquebrável — Recuperação Selvagem
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'the-unbroken-circle'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'heal'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'wild-recovery', 3, 1,
         'Recuperação Selvagem'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'dice_2d6_plus_flat'::rpg.effect_amount_formula, NULL FROM ins;

WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'the-unbroken-circle'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e
  JOIN sc ON sc.id = e.owner_id
  WHERE e.owner_kind = 'subclass'
    AND e.action_slug = 'wild-recovery'
    AND e.kind = 'heal'
    AND e.unlock_level = 3
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Recuperação Selvagem: recupere {total} PV ({expression}). Aplique na ficha.'
FROM fx;

WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'the-unbroken-circle'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'heal'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'wild-recovery', v.unlock_level, v.sort_order,
         'Recuperação Selvagem (+1d6)'
  FROM sc
  CROSS JOIN (VALUES (10, 2), (14, 3)) AS v(unlock_level, sort_order)
  RETURNING id
)
INSERT INTO rpg.phb_effect_dice (effect_id, die)
SELECT id, '1d6' FROM ins;

-- GSB Arauto Couatl — Proteção Pacífica (dado + CAR; faces de mesa d6 até haver schedule)
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'couatl-herald'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'temp_hp'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'peaceful-ward', 3, 1,
         'Proteção Pacífica'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_dice (effect_id, die)
SELECT id, '1d6' FROM ins;

WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'couatl-herald'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e
  JOIN sc ON sc.id = e.owner_id
  WHERE e.owner_kind = 'subclass' AND e.action_slug = 'peaceful-ward'
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'ability_mod'::rpg.effect_amount_formula, NULL FROM fx;

WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'couatl-herald'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e
  JOIN sc ON sc.id = e.owner_id
  WHERE e.owner_kind = 'subclass' AND e.action_slug = 'peaceful-ward'
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Proteção Pacífica: {total} PV temporários ({expression}). Ajuste se o dado da tabela de Guerreiro for outro.'
FROM fx;

-- GSB Coreografia — Dança Inspiradora
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'college-of-choreography'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'temp_hp'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'inspirational-dance', 3, 1,
         'Dança Inspiradora'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'schedule_die_plus_flat'::rpg.effect_amount_formula, NULL FROM ins;

WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'college-of-choreography'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e
  JOIN sc ON sc.id = e.owner_id
  WHERE e.owner_kind = 'subclass' AND e.action_slug = 'inspirational-dance'
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Dança Inspiradora: {total} PV temporários ({expression}) na ficha — ajuste se for aliado. O aliado pode usar Reação para mover ou Esquivar.'
FROM fx;

-- GSB Glaciar — Fortaleza Gelada
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'path-of-the-glacier'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'temp_hp'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, v.action_slug, 6, v.sort_order, v.label
  FROM sc
  CROSS JOIN (VALUES
    ('cold-fortress-entry', 1, 'Fortaleza Gelada (entrada)'),
    ('cold-fortress-renew', 1, 'Fortaleza Gelada (renovar)')
  ) AS v(action_slug, sort_order, label)
  RETURNING id, action_slug
)
INSERT INTO rpg.phb_effect_dice (effect_id, die)
SELECT id, '1d12' FROM ins;

WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'path-of-the-glacier'),
fx AS (
  SELECT e.id, e.action_slug FROM rpg.phb_effect e
  JOIN sc ON sc.id = e.owner_id
  WHERE e.owner_kind = 'subclass'
    AND e.action_slug IN ('cold-fortress-entry', 'cold-fortress-renew')
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'ability_mod'::rpg.effect_amount_formula, NULL FROM fx;

WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'path-of-the-glacier'),
fx AS (
  SELECT e.id, e.action_slug FROM rpg.phb_effect e
  JOIN sc ON sc.id = e.owner_id
  WHERE e.owner_kind = 'subclass'
    AND e.action_slug IN ('cold-fortress-entry', 'cold-fortress-renew')
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  CASE action_slug
    WHEN 'cold-fortress-renew' THEN
      'Fortaleza Gelada: {total} PV temporários ({expression}). Gaste 1 Dado de Vida na mesa.'
    ELSE
      'Fortaleza Gelada: {total} PV temporários ({expression}) ao entrar em Fúria sem armadura.'
  END
FROM fx;
