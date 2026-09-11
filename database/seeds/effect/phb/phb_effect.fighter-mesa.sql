-- seed-mode: truncate-scoped (phb_effect CTE; re-seed via truncate)
-- Mesa guerreiro: core + tipados (mind / manobra / blood / psi / precaução).

WITH cls AS (SELECT id FROM rpg.phb_class WHERE slug = 'fighter'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'heal'::rpg.effect_kind, 'class'::rpg.effect_owner_kind, cls.id,
         'on_table_action'::rpg.effect_trigger, 'second-wind', 1, 1,
         'Recuperar Fôlego'
  FROM cls
  RETURNING id
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'dice_1d10_plus_level'::rpg.effect_amount_formula, NULL FROM ins;

WITH cls AS (SELECT id FROM rpg.phb_class WHERE slug = 'fighter'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_note'::rpg.effect_kind, 'class'::rpg.effect_owner_kind, cls.id,
         'on_table_action'::rpg.effect_trigger, 'second-wind', 5, 2,
         'Ajuste Tático'
  FROM cls
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
       'Ajuste Tático: mova-se até metade do Deslocamento sem provocar AO.'
FROM ins;

WITH cls AS (SELECT id FROM rpg.phb_class WHERE slug = 'fighter'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_note'::rpg.effect_kind, 'class'::rpg.effect_owner_kind, cls.id,
         'on_table_action'::rpg.effect_trigger, 'action-surge', 2, 1,
         'Surto de Ação'
  FROM cls
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
       'Surto de Ação: execute uma ação adicional (exceto Usar Magia).'
FROM ins;

WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'eldritch-knight'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_note'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'action-surge', 15, 2,
         'Investida Mística'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
       'Investida Mística: teleporte até 9 m antes ou depois da ação adicional.'
FROM ins;

WITH cls AS (SELECT id FROM rpg.phb_class WHERE slug = 'fighter'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, resource_slug,
    unlock_level, sort_order, label
  )
  SELECT 'check_boost'::rpg.effect_kind, 'class'::rpg.effect_owner_kind, cls.id,
         'on_table_action'::rpg.effect_trigger, 'tactical-mind', 'secondWind',
         2, 1, 'Mente Tática'
  FROM cls
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id, 'Mente Tática: sucesso; uso de Recuperar Fôlego gasto'
FROM ins;

WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'battle-master'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'catalog_maneuver'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'use-maneuver', 3, 1,
         'Usar Manobra'
  FROM sc
  RETURNING id
)
SELECT 1 FROM ins;

WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'blood-hound'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'strike_self_cost'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'blood-strike', 3, 1,
         'Golpe de Sangue'
  FROM sc
  RETURNING id
)
SELECT 1 FROM ins;

WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'psi-warrior'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_note'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'psi:mental-guard', 10, 1,
         'Resguardo Mental'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
       'Resguardo Mental: encerre em você todos os efeitos que causam Amedrontado ou Enfeitiçado.'
FROM ins;

WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'psi-warrior'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_roll'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'psi:protective-field', 3, 1,
         'Campo Protetor'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'schedule_die_plus_flat'::rpg.effect_amount_formula, NULL FROM ins;

WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'psi-warrior'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e
  JOIN sc ON sc.id = e.owner_id
  WHERE e.owner_kind = 'subclass'
    AND e.action_slug = 'psi:protective-field'
    AND e.kind = 'table_roll'
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id, 'Campo Protetor: reduza {total} do dano recebido (Reação).'
FROM fx;

WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'psi-warrior'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_note'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'psi:telekinetic-movement', 3, 1,
         'Movimento Telecinético'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
       'Movimento Telecinético: mova o objeto solto ou criatura voluntária conforme a característica.'
FROM ins;

WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'psi-warrior'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_note'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'psi:psychic-leap', 7, 1,
         'Salto com Impulsão Psíquica'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
       'Salto com Impulsão Psíquica: Deslocamento de Voo igual ao dobro do seu Deslocamento até o fim do turno.'
FROM ins;

WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'psi-warrior'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_note'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'psi:energy-bulwark', 15, 1,
         'Baluarte de Energia'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
       'Baluarte de Energia: conceda Cobertura Parcial por 1 minuto a até o modificador de INT em criaturas (mínimo 1).'
FROM ins;

WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'psi-warrior'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_note'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'psi:telekinetic-master', 18, 1,
         'Mestre Telecinético'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
       'Mestre Telecinético: conjure Telecinese sem espaço/componentes; INT é o atributo de conjuração.'
FROM ins;
