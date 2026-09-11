-- seed-mode: truncate-scoped (phb_effect CTE; re-seed via truncate)
-- Mesa patrulheiro: core + subclases (Hunter/Gloom/Fey/Beastborne/Beast Master).

-- Marca do Predador (gratuita) — concentração
WITH cls AS (SELECT id FROM rpg.phb_class WHERE slug = 'ranger'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'start_concentration'::rpg.effect_kind, 'class'::rpg.effect_owner_kind, cls.id,
         'on_table_action'::rpg.effect_trigger, 'hunters-mark-free', 1, 1,
         'Marca do Predador (gratuita)'
  FROM cls
  RETURNING id
)
INSERT INTO rpg.phb_effect_spell (effect_id, spell_id)
SELECT ins.id, sp.id
FROM ins
CROSS JOIN (SELECT id FROM rpg.phb_spell WHERE slug = 'marca-do-predador') sp;

WITH cls AS (SELECT id FROM rpg.phb_class WHERE slug = 'ranger'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_note'::rpg.effect_kind, 'class'::rpg.effect_owner_kind, cls.id,
         'on_table_action'::rpg.effect_trigger, 'hunters-mark-free', 1, 2,
         'Marca do Predador (gratuita)'
  FROM cls
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Inimigo Favorito: Marca do Predador conjurada sem espaço; concentração iniciada. Cause o dado extra no acerto pela ficha.'
FROM ins;

-- Incansável
WITH cls AS (SELECT id FROM rpg.phb_class WHERE slug = 'ranger'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'temp_hp'::rpg.effect_kind, 'class'::rpg.effect_owner_kind, cls.id,
         'on_table_action'::rpg.effect_trigger, 'tireless', 10, 1,
         'Incansável'
  FROM cls
  RETURNING id
)
INSERT INTO rpg.phb_effect_dice (effect_id, die)
SELECT id, '1d8' FROM ins;

WITH cls AS (SELECT id FROM rpg.phb_class WHERE slug = 'ranger'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e
  JOIN cls ON cls.id = e.owner_id
  WHERE e.action_slug = 'tireless' AND e.kind = 'temp_hp'
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'ability_mod'::rpg.effect_amount_formula, NULL FROM fx;

WITH cls AS (SELECT id FROM rpg.phb_class WHERE slug = 'ranger'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e
  JOIN cls ON cls.id = e.owner_id
  WHERE e.action_slug = 'tireless' AND e.kind = 'temp_hp'
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Incansável: você ganha {total} PV temporários ({expression}) — aplicados na ficha. Descanso Curto reduz Exaustão em 1.'
FROM fx;

-- Véu da Natureza
WITH cls AS (SELECT id FROM rpg.phb_class WHERE slug = 'ranger'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_note'::rpg.effect_kind, 'class'::rpg.effect_owner_kind, cls.id,
         'on_table_action'::rpg.effect_trigger, 'natures-veil', 14, 1,
         'Véu da Natureza'
  FROM cls
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Véu da Natureza: Ação Bônus — você fica Invisível até o fim do seu próximo turno.'
FROM ins;

-- Hunter — Defesa do Caçador Superior
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'hunter'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_note'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'hunter-defense', 15, 1,
         'Defesa do Caçador Superior'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Defesa do Caçador Superior: Reação — você tem Resistência ao dano que desencadeou esta reação até o fim do turno atual (mesa).'
FROM ins;

-- Gloom Stalker — Esquiva Sombria
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'gloom-stalker'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_note'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'gloom-stalker-dodge', 15, 1,
         'Esquiva Sombria'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Esquiva Sombria: Reação — imponha Desvantagem ao ataque (se ainda não tiver sido resolvido) e teleporte até 9 m para um espaço sem luz intensa que você possa ver (mesa).'
FROM ins;

-- Fey Wanderer — Reforços Feéricos
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'fey-wanderer'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_note'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'fey-reinforcements', 11, 1,
         'Reforços Feéricos'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Reforços Feéricos: Convocar Feérico sem espaço e sem Concentração (duração 1 minuto nesta conjuração).'
FROM ins;

-- Fey Wanderer — Andarilho Nebuloso
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'fey-wanderer'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_note'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'misty-wanderer', 15, 1,
         'Andarilho Nebuloso'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Andarilho Nebuloso: Passo Nebuloso sem espaço; pode levar uma criatura voluntária a 1,5 m.'
FROM ins;

-- Beastborne — Aspecto Bestial
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'beastborne'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'set_tracker'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'set-bestial-aspect', 3, 1,
         'Aspecto Bestial'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id, 'Defina o nível de Aspecto Bestial (0–5) na ficha.'
FROM ins;

-- Beastborne — Uivo Feral
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'beastborne'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_roll'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'feral-howl', 7, 1,
         'Uivo Feral'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'dice_1d4'::rpg.effect_amount_formula, NULL FROM ins;

-- Beast Master — Companheiro Primal
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'beast-master'),
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

WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'beast-master'),
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

WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'beast-master'),
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
