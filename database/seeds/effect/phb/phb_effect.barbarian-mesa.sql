-- seed-mode: truncate-scoped (phb_effect CTE; re-seed via truncate)
-- Mesa bárbaro: kinds genéricos (toggle / roll / dc / companion / recover).

-- Fúria (toggle)
WITH c AS (SELECT id FROM rpg.phb_class WHERE slug = 'barbarian'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'toggle_combat_flag'::rpg.effect_kind, 'class'::rpg.effect_owner_kind, c.id,
         'on_table_action'::rpg.effect_trigger, 'toggle-rage', 1, 1, 'Fúria'
  FROM c
  RETURNING id
)
INSERT INTO rpg.phb_effect_combat_flag (effect_id, flag, spend_on_enter, force_enter)
SELECT id, 'rage', true, false FROM ins;

-- Surto Árvore do Mundo ao entrar em Fúria
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'world-tree'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'temp_hp'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'toggle-rage', 3, 2,
         'Surto de Vitalidade'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'level'::rpg.effect_amount_formula, NULL FROM ins;

-- Imprudente
WITH c AS (SELECT id FROM rpg.phb_class WHERE slug = 'barbarian'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'toggle_combat_flag'::rpg.effect_kind, 'class'::rpg.effect_owner_kind, c.id,
         'on_table_action'::rpg.effect_trigger, 'toggle-reckless', 2, 1,
         'Ataque Imprudente'
  FROM c
  RETURNING id
)
INSERT INTO rpg.phb_effect_combat_flag (effect_id, flag, spend_on_enter, force_enter)
SELECT id, 'reckless', false, false FROM ins;

-- Fúria Persistente
WITH c AS (SELECT id FROM rpg.phb_class WHERE slug = 'barbarian'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, resource_slug,
    unlock_level, sort_order, label
  )
  SELECT 'recover_resource_to_max'::rpg.effect_kind, 'class'::rpg.effect_owner_kind, c.id,
         'on_table_action'::rpg.effect_trigger, 'recover-all-rage', 'rage', 15, 1,
         'Fúria Persistente'
  FROM c
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Fúria Persistente: recuperou todos os usos de rage (marque 1×/Descanso Longo na mesa).'
FROM ins;

-- Frenesi
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'berserker'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_roll'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'frenzy', 3, 1, 'Frenesi'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'rage_bonus_d6'::rpg.effect_amount_formula, NULL FROM ins;

WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'berserker'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e
  JOIN sc ON sc.id = e.owner_id
  WHERE e.action_slug = 'frenzy' AND e.kind = 'table_roll'
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Frenesi: com Fúria + Imprudente, +{total} ({expression}) no 1º acerto FOR deste turno (mesmo tipo da arma).'
FROM fx;

-- Presença Intimidante CD
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'berserker'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'feature_dc'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'intimidating-presence', 14, 1,
         'Presença Intimidante'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'eight_plus_mod_plus_pb'::rpg.effect_amount_formula, NULL FROM ins;

WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'berserker'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e
  JOIN sc ON sc.id = e.owner_id
  WHERE e.action_slug = 'intimidating-presence' AND e.kind = 'feature_dc'
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Presença Intimidante: Ação Bônus — criaturas escolhidas em Emanação 9 m, CD de SAB ou Amedrontadas 1 min. Restaure o uso gastando 1 Fúria.'
FROM fx;

-- Concentração Fanática
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'zealot'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_roll'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'fanatical-focus', 6, 1,
         'Concentração Fanática'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'rage_bonus'::rpg.effect_amount_formula, NULL FROM ins;

WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'zealot'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e
  JOIN sc ON sc.id = e.owner_id
  WHERE e.action_slug = 'fanatical-focus' AND e.kind = 'table_roll'
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Concentração Fanática: 1×/Fúria — ao falhar salvaguarda, rerrole com +{total} (bônus de Fúria).'
FROM fx;

-- Campeão dos Deuses
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'zealot'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, resource_slug,
    unlock_level, sort_order, label
  )
  SELECT 'heal_from_dice_pool'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'champion-of-the-gods',
         'divine-fury-dice', 3, 1, 'Campeão dos Deuses'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_dice (effect_id, die)
SELECT id, '1d12' FROM ins;

WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'zealot'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e
  JOIN sc ON sc.id = e.owner_id
  WHERE e.action_slug = 'champion-of-the-gods' AND e.kind = 'heal_from_dice_pool'
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Campeão dos Deuses: Ação Bônus — recupere {total} PV ({expression}). Aplique na ficha.'
FROM fx;

-- Águia Coração Selvagem
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'wild-heart'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_note'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'wild-heart-eagle', 3, 1,
         'Águia'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Águia: com Fúria, Ação Bônus para Correr e Desengajar (também ao ativar a Fúria).'
FROM ins;

-- Força Revigorante
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'world-tree'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'temp_hp'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'revitalizing-strength', 3, 1,
         'Força Revigorante'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'rage_bonus_d6'::rpg.effect_amount_formula, NULL FROM ins;

-- Ramos da Árvore
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'world-tree'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'feature_dc'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'branches-of-the-tree', 6, 1,
         'Ramos da Árvore'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'eight_plus_mod_plus_pb'::rpg.effect_amount_formula, NULL FROM ins;

-- Magia indiscutível
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'path-of-the-muscle-wizard'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'toggle_combat_flag'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'undeniable-magic-rage', 3, 1,
         'Magia indiscutível'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_combat_flag (effect_id, flag, spend_on_enter, force_enter)
SELECT id, 'rage', false, true FROM ins;

WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'path-of-the-muscle-wizard'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e
  JOIN sc ON sc.id = e.owner_id
  WHERE e.action_slug = 'undeniable-magic-rage'
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Magia indiscutível: Reação — entre em Fúria até o fim do seu próximo turno sem gastar uso (não estende).'
FROM fx;

-- Cantrips / muscle rolls
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'path-of-the-muscle-wizard'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_note'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'cantrip-mage-hand', 3, 1,
         'Mãos Mágicas'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Mãos Mágicas: no acerto FOR, empurre o alvo (Grande ou menor) 1,5 m (3 m se Fúria).'
FROM ins;

WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'path-of-the-muscle-wizard'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_note'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'cantrip-shocking-grasp', 3, 1,
         'Toque Chocante'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Toque Chocante: o alvo não pode fazer OA (até fim do turno; com Fúria até o início do seu próximo turno).'
FROM ins;

WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'path-of-the-muscle-wizard'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_roll'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'cantrip-sure-strike', 3, 1,
         'Ataque Certeiro'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_dice (effect_id, die)
SELECT id, '1d6' FROM ins;

WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'path-of-the-muscle-wizard'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e
  JOIN sc ON sc.id = e.owner_id
  WHERE e.action_slug = 'cantrip-sure-strike' AND e.kind = 'table_roll'
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'half_level_if_rage'::rpg.effect_amount_formula, NULL FROM fx;

WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'path-of-the-muscle-wizard'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e
  JOIN sc ON sc.id = e.owner_id
  WHERE e.action_slug = 'cantrip-sure-strike' AND e.kind = 'table_roll'
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Ataque Certeiro: +{total} ({expression}) no acerto FOR (Fúria: +metade do nível).'
FROM fx;

WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'path-of-the-muscle-wizard'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_roll'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'burning-hands-slap', 6, 1,
         'Mãos Flamejantes'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_dice (effect_id, die)
SELECT id, '1d8' FROM ins;

WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'path-of-the-muscle-wizard'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e
  JOIN sc ON sc.id = e.owner_id
  WHERE e.action_slug = 'burning-hands-slap' AND e.kind = 'table_roll'
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'ability_mod'::rpg.effect_amount_formula, NULL FROM fx;

WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'path-of-the-muscle-wizard'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_roll'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'i-cast-fist', 14, 1,
         'Eu lancei o punho'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_dice (effect_id, die)
SELECT id, '6d6' FROM ins;

WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'path-of-the-muscle-wizard'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e
  JOIN sc ON sc.id = e.owner_id
  WHERE e.action_slug = 'i-cast-fist' AND e.kind = 'table_roll'
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'ability_mod'::rpg.effect_amount_formula, NULL FROM fx;

-- Companheiro / Forma do Selvagem
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'pathofthe-primal-spirit'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'sync_companion'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'primal-companion-summon', 3, 1,
         'Invocar Companheiro Primal'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_companion (effect_id, restore_hp)
SELECT id, false FROM ins;

WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'pathofthe-primal-spirit'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'sync_companion'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'primal-companion-restore', 3, 1,
         'Restaurar Companheiro Primal'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_companion (effect_id, restore_hp)
SELECT id, true FROM ins;

WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'pathofthe-primal-spirit'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'companion_command'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'primal-companion', 3, 1,
         'Companheiro Primal'
  FROM sc
  RETURNING id
);

WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'pathofthe-primal-spirit'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'sync_companion'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'shape-of-the-wild', 14, 1,
         'Forma do Selvagem'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_companion (effect_id, restore_hp)
SELECT id, true FROM ins;

WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'pathofthe-primal-spirit'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'sync_companion'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'shape-of-the-wild-action', 14, 1,
         'Forma do Selvagem'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_companion (effect_id, restore_hp)
SELECT id, true FROM ins;
