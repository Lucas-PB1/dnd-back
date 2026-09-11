-- seed-mode: truncate-scoped (phb_effect CTE; re-seed via truncate)
-- Mesa bruxo: core + patronos (Arquifada/Celestial/Ínfero/Grande Antigo).

-- Astúcia Mágica
WITH cls AS (SELECT id FROM rpg.phb_class WHERE slug = 'warlock'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'recover_spell_slot'::rpg.effect_kind, 'class'::rpg.effect_owner_kind, cls.id,
         'on_table_action'::rpg.effect_trigger, 'magical-cunning', 2, 1,
         'Astúcia Mágica'
  FROM cls
  RETURNING id
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'pact_slots_recovery_count'::rpg.effect_amount_formula, NULL FROM ins;

WITH cls AS (SELECT id FROM rpg.phb_class WHERE slug = 'warlock'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e
  JOIN cls ON cls.id = e.owner_id
  WHERE e.action_slug = 'magical-cunning' AND e.kind = 'recover_spell_slot'
)
INSERT INTO rpg.phb_effect_spell (effect_id, option_key, spell_level)
SELECT id, 'pact_slot_level', NULL FROM fx;

WITH cls AS (SELECT id FROM rpg.phb_class WHERE slug = 'warlock'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e
  JOIN cls ON cls.id = e.owner_id
  WHERE e.action_slug = 'magical-cunning' AND e.kind = 'recover_spell_slot'
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Astúcia Mágica: recuperou {total} Slot(s) de Pacto do nível atual (1×/Descanso Longo).'
FROM fx;

-- Luz Medicinal
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'celestial'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, resource_slug,
    unlock_level, sort_order, label
  )
  SELECT 'heal_from_dice_pool'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'healing-light', 'healing-light',
         3, 1, 'Luz Medicinal'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_dice (effect_id, die)
SELECT id, '1d6' FROM ins;

WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'celestial'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e
  JOIN sc ON sc.id = e.owner_id
  WHERE e.action_slug = 'healing-light' AND e.kind = 'heal_from_dice_pool'
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Luz Medicinal: Ação Bônus gasta {expression} da reserva e restaura {total} PV a uma criatura visível a até 18 m.'
FROM fx;

-- A Sorte do Próprio Tenebroso
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'fiend'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, resource_slug,
    unlock_level, sort_order, label
  )
  SELECT 'spend_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'dark-ones-luck', 'dark-ones-luck',
         6, 1, 'A Sorte do Próprio Tenebroso — gasto'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'fixed'::rpg.effect_amount_formula, 1 FROM ins;

WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'fiend'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_roll'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'dark-ones-luck', 6, 2,
         'A Sorte do Próprio Tenebroso'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_dice (effect_id, die)
SELECT id, '1d10' FROM ins;

WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'fiend'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e
  JOIN sc ON sc.id = e.owner_id
  WHERE e.action_slug = 'dark-ones-luck' AND e.kind = 'table_roll'
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'A Sorte do Próprio Tenebroso: some +{total} ({expression}) ao teste de habilidade ou salvaguarda que você acabou de rolar.'
FROM fx;

-- Passos Feéricos
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'archfey'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_note'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'fey-step-effect', 3, 1,
         'Passos Feéricos'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Passos Feéricos (−1 uso): conjure Passo Nebuloso sem gastar espaço. Escolha o efeito na mesa: Provocante ou Revigorante (nv. 6+: também Desvanecedor ou Terrível).'
FROM ins;

-- Mente Desperta
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'great-old-one'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_note'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'awakened-mind', 3, 1,
         'Mente Desperta'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Mente Desperta: telepatia a 9 m. Magias Psíquicas: dano de Bruxo pode ser Psíquico; Encantamento/Ilusão sem V/S.'
FROM ins;

-- Resistência Ínfera
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'fiend'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_note'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'fiendish-resilience', 10, 1,
         'Resistência Ínfera'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Resistência Ínfera: após Descanso Curto ou Longo, escolha um tipo de dano (exceto Energético) para Resistência até escolher outro.'
FROM ins;

-- Lançar no Inferno
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'fiend'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_roll'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'hurl-through-hell', 14, 1,
         'Lançar no Inferno'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_dice (effect_id, die)
SELECT id, '8d10' FROM ins;

WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'fiend'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e
  JOIN sc ON sc.id = e.owner_id
  WHERE e.action_slug = 'hurl-through-hell' AND e.kind = 'table_roll'
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Lançar no Inferno: salvaguarda de Carisma; em falha, {total} Psíquico ({expression}) e Incapacitado até o fim do seu próximo turno. Pode recuperar o uso gastando um Slot de Pacto.'
FROM fx;

-- Vingança Calcinante
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'celestial'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_roll'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'searing-vengeance', 14, 1,
         'Vingança Calcinante'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'ability_mod'::rpg.effect_amount_formula, NULL FROM ins;

WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'celestial'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e
  JOIN sc ON sc.id = e.owner_id
  WHERE e.action_slug = 'searing-vengeance' AND e.kind = 'table_roll'
)
INSERT INTO rpg.phb_effect_dice (effect_id, die)
SELECT id, '2d8' FROM fx;

WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'celestial'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e
  JOIN sc ON sc.id = e.owner_id
  WHERE e.action_slug = 'searing-vengeance' AND e.kind = 'table_roll'
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Vingança Calcinante (−1 uso): aliado em salvaguarda contra morte recupera metade dos PV máximos; inimigos escolhidos sofrem {total} Radiante ({expression}) e ficam Cegos até o fim do seu próximo turno.'
FROM fx;

-- Defesas Sedutoras
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'archfey'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_note'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'beguiling-defenses', 10, 1,
         'Defesas Sedutoras'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Defesas Sedutoras (−1 uso): imune a Enfeitiçado. Reação após ser acertado: reduza o dano pela metade e force salvaguarda de Sabedoria; em falha, o atacante sofre dano Psíquico igual ao dano evitado. Recarrega em Descanso Longo ou ao gastar um Slot de Pacto.'
FROM ins;

-- Combatente Clarividente
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'great-old-one'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_note'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'clairvoyant-combatant', 6, 1,
         'Combatente Clarividente'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Combatente Clarividente (−1 uso): ao formar ligação telepática com Mente Desperta, o alvo faz salvaguarda de Sabedoria. Em falha, Desvantagem em ataques contra você e Vantagem nos seus ataques contra ele. Recarrega em Descanso Curto/Longo ou ao gastar um Slot de Pacto.'
FROM ins;

-- Invocar Arma de Pacto
WITH cls AS (SELECT id FROM rpg.phb_class WHERE slug = 'warlock'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'bind_pact_weapon'::rpg.effect_kind, 'class'::rpg.effect_owner_kind, cls.id,
         'on_table_action'::rpg.effect_trigger, 'invoke-pact-weapon', 1, 1,
         'Invocar Arma de Pacto'
  FROM cls
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Invocar Arma de Pacto: vincula e equipa arma corpo a corpo do inventário (Carisma no ataque/dano).'
FROM ins;
