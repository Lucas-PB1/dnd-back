-- seed-mode: truncate-scoped (phb_effect CTE; re-seed via truncate)
-- Mesa bardo: core + colégios + Skald (Bragi).

-- Conceder Inspiração
WITH cls AS (SELECT id FROM rpg.phb_class WHERE slug = 'bard'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_roll'::rpg.effect_kind, 'class'::rpg.effect_owner_kind, cls.id,
         'on_table_action'::rpg.effect_trigger, 'grant-inspiration', 1, 1,
         'Conceder Inspiração'
  FROM cls
  RETURNING id
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'schedule_die_plus_flat'::rpg.effect_amount_formula, NULL FROM ins;

WITH cls AS (SELECT id FROM rpg.phb_class WHERE slug = 'bard'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e
  JOIN cls ON cls.id = e.owner_id
  WHERE e.action_slug = 'grant-inspiration' AND e.kind = 'table_roll'
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Inspiração de Bardo ({expression}): concedida como Ação Bônus a uma criatura voluntária a até 18 m por 1 hora. Ela pode adicionar o dado a um teste de habilidade, ataque ou salvaguarda.'
FROM fx;

-- Inspiração Superior
WITH cls AS (SELECT id FROM rpg.phb_class WHERE slug = 'bard'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, resource_slug,
    unlock_level, sort_order, label
  )
  SELECT 'recover_resource'::rpg.effect_kind, 'class'::rpg.effect_owner_kind, cls.id,
         'on_table_action'::rpg.effect_trigger, 'superior-inspiration', 'bardicInspiration',
         18, 1, 'Inspiração Superior'
  FROM cls
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Inspiração Superior: ao rolar iniciativa sem usos de Inspiração de Bardo restantes, recupere 1 uso.'
FROM ins;

-- Lore — Palavras de Interrupção
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'lore'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_roll'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'cutting-words', 3, 1,
         'Palavras de Interrupção'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'schedule_die_plus_flat'::rpg.effect_amount_formula, NULL FROM ins;

WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'lore'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e
  JOIN sc ON sc.id = e.owner_id
  WHERE e.action_slug = 'cutting-words' AND e.kind = 'table_roll'
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Palavras de Interrupção: Reação gasta 1 Inspiração para subtrair {total} ({expression}) de uma jogada de ataque, teste de habilidade ou dano de um inimigo visível a até 18 m.'
FROM fx;

-- Lore — Perícia Inigualável
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'lore'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_roll'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'peerless-skill', 14, 1,
         'Perícia Inigualável'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'schedule_die_plus_flat'::rpg.effect_amount_formula, NULL FROM ins;

WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'lore'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e
  JOIN sc ON sc.id = e.owner_id
  WHERE e.action_slug = 'peerless-skill' AND e.kind = 'table_roll'
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Perícia Inigualável: após falhar teste ou ataque, some +{total} ({expression}) ao d20. Se ainda falhar, devolva o uso de Inspiração (± na Economia).'
FROM fx;

-- Glamour — Manto de Inspiração
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'glamour'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'temp_hp'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'mantle-of-inspiration', 3, 1,
         'Manto de Inspiração'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'schedule_die_double_plus_flat'::rpg.effect_amount_formula, NULL FROM ins;

WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'glamour'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e
  JOIN sc ON sc.id = e.owner_id
  WHERE e.action_slug = 'mantle-of-inspiration' AND e.kind = 'temp_hp'
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Manto de Inspiração: gaste 1 Inspiração para conceder {total} PV temporários ({expression}) a até mod. de Carisma criaturas a 18 m. Cada uma pode usar a Reação para mover-se seu Deslocamento sem provocar OA. Total aplicado na ficha — ajuste se distribuir.'
FROM fx;

-- Glamour — Manto de Majestade
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'glamour'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_note'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'mantle-of-majesty', 6, 1,
         'Manto de Majestade'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Manto de Majestade: Ação Bônus — conjure Comando sem espaço e assuma aparência sobrenatural por 1 minuto (Concentração). Enquanto durar, Comando como Ação Bônus sem espaço; Enfeitiçados por você falham automaticamente no save. Restaurar uso: espaço 3+ (mesa).'
FROM ins;

-- Glamour — Majestade Inquebrável
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'glamour'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'feature_dc'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'unbreakable-majesty', 14, 1,
         'Majestade Inquebrável — CD'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'eight_plus_mod_plus_pb'::rpg.effect_amount_formula, NULL FROM ins;

WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'glamour'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_note'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'unbreakable-majesty', 14, 2,
         'Majestade Inquebrável'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Majestade Inquebrável: Ação Bônus — presença 1 minuto. Quando uma criatura o acerta pela 1ª vez no turno dela, CD {saveDc} de CAR ou o ataque falha. Recupera em Descanso Curto ou Longo.'
FROM ins;

-- Dança — Ataque Desarmado
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'dance'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_roll'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'unarmed-dance', 3, 1,
         'Dança Virtuosa (Ataque Desarmado)'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'schedule_die_plus_flat'::rpg.effect_amount_formula, NULL FROM ins;

WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'dance'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e
  JOIN sc ON sc.id = e.owner_id
  WHERE e.action_slug = 'unarmed-dance' AND e.kind = 'table_roll'
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Ataque Desarmado (Dança): usa Destreza no ataque; dano Contundente {total} ({expression} = dado de Inspiração + DES, sem gastar uso).'
FROM fx;

-- Dança — Movimento Coordenado
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'dance'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_roll'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'coordinated-movement', 6, 1,
         'Movimento Coordenado'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'schedule_die_plus_flat'::rpg.effect_amount_formula, NULL FROM ins;

WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'dance'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e
  JOIN sc ON sc.id = e.owner_id
  WHERE e.action_slug = 'coordinated-movement' AND e.kind = 'table_roll'
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Movimento Coordenado: na iniciativa, gaste 1 Inspiração — você e aliados a 9 m que possam ver/ouvir você somam +{total} ({expression}) à iniciativa.'
FROM fx;

-- Dança — Movimento Inspirador
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'dance'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_note'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'agile-response', 6, 1,
         'Movimento Inspirador'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Movimento Inspirador: Reação quando um inimigo à sua vista encerra o turno a até 1,5 m. Gaste 1 Inspiração de Bardo para se mover até metade do Deslocamento; um aliado a até 9 m também pode (própria Reação). Nenhum movimento provoca Ataques de Oportunidade.'
FROM ins;

-- Valor — Inspiração em Combate
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'valor'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_roll'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'combat-inspiration', 3, 1,
         'Inspiração em Combate'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'schedule_die_plus_flat'::rpg.effect_amount_formula, NULL FROM ins;

WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'valor'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e
  JOIN sc ON sc.id = e.owner_id
  WHERE e.action_slug = 'combat-inspiration' AND e.kind = 'table_roll'
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Inspiração em Combate ({expression}): a criatura com Inspiração de Bardo pode rolar o dado e somar à rolagem de dano da arma ou usar a Reação para somar o dado à sua CA contra um ataque.'
FROM fx;

-- Máscaras — Habilidade de Virtuoso
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'college-of-masks'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_note'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'virtuoso-skill', 6, 1,
         'Habilidade de Virtuoso'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Habilidade de Virtuoso: 1×/turno, ao fazer um Teste d20, faça-o com Carisma se ainda não usar esse atributo.'
FROM ins;

-- Máscaras — Anjo
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'college-of-masks'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug,
    requires_option_key, requires_option_value,
    unlock_level, sort_order, label
  )
  SELECT 'table_roll'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'persona-angel',
         'equipped_persona_mask', 'persona-mask-angel',
         3, 1, 'Máscara — Anjo'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'schedule_die_plus_flat'::rpg.effect_amount_formula, NULL FROM ins;

WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'college-of-masks'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e
  JOIN sc ON sc.id = e.owner_id
  WHERE e.action_slug = 'persona-angel' AND e.kind = 'table_roll'
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Anjo: +{total} Radiante ({expression}) no dano (1×/turno; 1 Inspiração).'
FROM fx;

-- Máscaras — Diabo
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'college-of-masks'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug,
    requires_option_key, requires_option_value,
    unlock_level, sort_order, label
  )
  SELECT 'temp_hp'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'persona-devil',
         'equipped_persona_mask', 'persona-mask-devil',
         3, 1, 'Máscara — Diabo'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'schedule_die_double_plus_flat'::rpg.effect_amount_formula, NULL FROM ins;

WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'college-of-masks'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e
  JOIN sc ON sc.id = e.owner_id
  WHERE e.action_slug = 'persona-devil' AND e.kind = 'temp_hp'
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Diabo: Reação — {total} Fogo ({expression}) ao agressor a 9 m; {total} PV temp. aplicados na ficha.'
FROM fx;

-- Máscaras — Dragão
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'college-of-masks'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug,
    requires_option_key, requires_option_value,
    unlock_level, sort_order, label
  )
  SELECT 'feature_dc'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'persona-dragon',
         'equipped_persona_mask', 'persona-mask-dragon',
         3, 1, 'Máscara — Dragão — CD'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'eight_plus_mod_plus_pb'::rpg.effect_amount_formula, NULL FROM ins;

WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'college-of-masks'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug,
    requires_option_key, requires_option_value,
    unlock_level, sort_order, label
  )
  SELECT 'table_roll'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'persona-dragon',
         'equipped_persona_mask', 'persona-mask-dragon',
         3, 2, 'Máscara — Dragão — Dano'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'schedule_die_double_plus_flat'::rpg.effect_amount_formula, NULL FROM ins;

WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'college-of-masks'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e
  JOIN sc ON sc.id = e.owner_id
  WHERE e.action_slug = 'persona-dragon' AND e.kind = 'table_roll'
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Dragão: cone 4,5 m — CD {saveDc} de DES; {total} Fogo ({expression}) ou metade no sucesso.'
FROM fx;

-- Máscaras — Gladiador
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'college-of-masks'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug,
    requires_option_key, requires_option_value,
    unlock_level, sort_order, label
  )
  SELECT 'table_note'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'persona-gladiator',
         'equipped_persona_mask', 'persona-mask-gladiator',
         3, 1, 'Máscara — Gladiador'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Gladiador: Ação Bônus — ataque com arma ou Ataque Desarmado (1 Inspiração).'
FROM ins;

-- Máscaras — Bobão
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'college-of-masks'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug,
    requires_option_key, requires_option_value,
    unlock_level, sort_order, label
  )
  SELECT 'table_note'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'persona-jester',
         'equipped_persona_mask', 'persona-mask-jester',
         3, 1, 'Máscara — Bobão'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Bobão: Ação Bônus — mova metade do Deslocamento sem OA e conjure Escárnio Vicioso (1 Inspiração).'
FROM ins;

-- Máscaras — Vestir
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'college-of-masks'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'set_tracker'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'set-persona-masks', 3, 1,
         'Vestir Máscaras de Persona'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id, 'Defina as máscaras equipadas na ficha.'
FROM ins;

-- Skald — Runa da Fala de Bragi (Vitalidade)
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'skald'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'temp_hp'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'bragi-rune', 6, 1,
         'Runa da Fala de Bragi — Vitalidade'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'schedule_die_plus_flat'::rpg.effect_amount_formula, NULL FROM ins;

WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'skald'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e
  JOIN sc ON sc.id = e.owner_id
  WHERE e.action_slug = 'bragi-rune' AND e.kind = 'temp_hp'
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Vitalidade: {total} PV temp. ({expression}) em você e até 3 aliados a 9 m — total aplicado na ficha (ajuste se distribuir). Escárnio/Eloquência: declare na mesa e ignore estes PV temp. se não for Vitalidade.'
FROM fx;
