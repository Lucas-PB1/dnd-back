-- seed-mode: truncate-scoped (phb_effect CTE; re-seed via truncate)
-- Mesa paladino: core + juramentos (Devotion/Glory/Ancients/Vengeance/Revelry).

-- Mãos Consagradas (cura variável via amount no handler)
WITH cls AS (SELECT id FROM rpg.phb_class WHERE slug = 'paladin'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'heal'::rpg.effect_kind, 'class'::rpg.effect_owner_kind, cls.id,
         'on_table_action'::rpg.effect_trigger, 'lay-on-hands', 1, 1,
         'Mãos Consagradas'
  FROM cls
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Mãos Consagradas: cure {total} PV (reserva de 5 × nível).'
FROM ins;

-- Curar Veneno
WITH cls AS (SELECT id FROM rpg.phb_class WHERE slug = 'paladin'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_note'::rpg.effect_kind, 'class'::rpg.effect_owner_kind, cls.id,
         'on_table_action'::rpg.effect_trigger, 'cure-poison', 1, 1,
         'Mãos Consagradas — Curar Veneno'
  FROM cls
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Mãos Consagradas: gaste 5 PV da reserva para remover a condição Envenenado.'
FROM ins;

-- Sentido Divino
WITH cls AS (SELECT id FROM rpg.phb_class WHERE slug = 'paladin'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_note'::rpg.effect_kind, 'class'::rpg.effect_owner_kind, cls.id,
         'on_table_action'::rpg.effect_trigger, 'divine-sense', 3, 1,
         'Sentido Divino'
  FROM cls
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Sentido Divino: até o fim do próximo turno, saiba a posição de Celestiais, Corruptores e Mortos-vivos em 18 m (1 uso de Canalizar Divindade).'
FROM ins;

-- Repudiar Inimigos — CD
WITH cls AS (SELECT id FROM rpg.phb_class WHERE slug = 'paladin'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'feature_dc'::rpg.effect_kind, 'class'::rpg.effect_owner_kind, cls.id,
         'on_table_action'::rpg.effect_trigger, 'abjure-enemies', 9, 1,
         'Repudiar Inimigos — CD'
  FROM cls
  RETURNING id
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'eight_plus_mod_plus_pb'::rpg.effect_amount_formula, NULL FROM ins;

WITH cls AS (SELECT id FROM rpg.phb_class WHERE slug = 'paladin'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_note'::rpg.effect_kind, 'class'::rpg.effect_owner_kind, cls.id,
         'on_table_action'::rpg.effect_trigger, 'abjure-enemies', 9, 2,
         'Repudiar Inimigos'
  FROM cls
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Repudiar Inimigos: criaturas escolhidas fazem salvaguarda de Sabedoria CD {saveDc}; na falha ficam Amedrontadas e com Deslocamento 0.'
FROM ins;

-- Canalizar Divindade do Juramento — Devoção
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'devotion'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'feature_dc'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'oath-channel', 3, 1,
         'Arma Sagrada — CD'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'eight_plus_mod_plus_pb'::rpg.effect_amount_formula, NULL FROM ins;

WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'devotion'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_note'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'oath-channel', 3, 2,
         'Arma Sagrada'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Arma Sagrada: ao Atacar, imbuir arma corpo a corpo por 10 min — +mod. de Carisma (mín. +1) no ataque, dano pode ser Radiante, Luz Plena 6 m / Fraca +6 m (1 uso de Canalizar Divindade; CD {saveDc} quando houver salvaguarda).'
FROM ins;

-- Glória — Destruição Inspiradora
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'glory'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'temp_hp'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'inspiring-smite', 3, 1,
         'Destruição Inspiradora'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'dice_2d8_plus_level'::rpg.effect_amount_formula, NULL FROM ins;

WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'glory'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e
  JOIN sc ON sc.id = e.owner_id
  WHERE e.action_slug = 'inspiring-smite' AND e.kind = 'temp_hp'
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Destruição Inspiradora: {total} PV temporários ({expression}) para distribuir entre você e criaturas a até 9 m. Total aplicado na ficha — ajuste se dividir na mesa. (1 uso de Canalizar Divindade).'
FROM fx;

-- Glória — Atleta Inigualável
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'glory'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_note'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'peerless-athlete', 3, 1,
         'Atleta Inigualável'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Atleta Inigualável: por 1 h, Vantagem em Força (Atletismo) e Destreza (Acrobacia); Saltos Longos e em Altura +3 m (custa movimento). (1 uso de Canalizar Divindade).'
FROM ins;

-- Glória — Defesa Gloriosa
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'glory'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_note'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'glorious-defense', 15, 1,
         'Defesa Gloriosa'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'ability_mod'::rpg.effect_amount_formula, NULL FROM ins;

WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'glory'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e
  JOIN sc ON sc.id = e.owner_id
  WHERE e.action_slug = 'glorious-defense' AND e.kind = 'table_note'
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Defesa Gloriosa (−1 uso): conceda +{total} CA ao alvo contra este ataque (mod. de Carisma, mín. +1). Se o ataque errar e o atacante estiver no alcance da sua arma, você pode atacar com uma arma como parte desta Reação (mesa).'
FROM fx;

-- Anciãos — Ira da Natureza
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'ancients'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'feature_dc'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'oath-channel', 3, 1,
         'A Ira da Natureza — CD'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'eight_plus_mod_plus_pb'::rpg.effect_amount_formula, NULL FROM ins;

WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'ancients'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_note'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'oath-channel', 3, 2,
         'A Ira da Natureza'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'A Ira da Natureza: ação Usar Magia — criaturas a até 4,5 m salvaguarda de Força CD {saveDc} ou Contidas por 1 min (1 uso de Canalizar Divindade).'
FROM ins;

-- Anciãos — Sentinela Imortal
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'ancients'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'survive_at_zero'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'undying-sentinel', 15, 1,
         'Sentinela Imortal'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Sentinela Imortal (−1 uso): defina seus PV atuais em {total} (1 + 3 × nível de Paladino, teto = PV máximos) e limpe salvaguardas contra morte. Ajuste o contador de PV na ficha.'
FROM ins;

-- Vingança — Voto de Inimizade
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'vengeance'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'feature_dc'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'oath-channel', 3, 1,
         'Voto de Inimizade — CD'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'eight_plus_mod_plus_pb'::rpg.effect_amount_formula, NULL FROM ins;

WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'vengeance'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_note'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'oath-channel', 3, 2,
         'Voto de Inimizade'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Voto de Inimizade: ao Atacar, escolha um alvo a até 9 m — Vantagem nos ataques contra ele por 1 min (1 uso de Canalizar Divindade; CD {saveDc} quando houver salvaguarda).'
FROM ins;

-- Folia — Conjurar Bebida
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'oath-of-revelry'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'feature_dc'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'oath-channel', 3, 1,
         'Conjurar Bebida — CD'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'eight_plus_mod_plus_pb'::rpg.effect_amount_formula, NULL FROM ins;

WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'oath-of-revelry'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_note'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'oath-channel', 3, 2,
         'Conjurar Bebida'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Conjurar Bebida: canecas (até mod. de Carisma) — beber concede PV temp. e Vantagem em salvaguardas por 1 min (1 uso de Canalizar Divindade; CD {saveDc} quando houver salvaguarda).'
FROM ins;

-- Folia — Folião
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'oath-of-revelry'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_note'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'reveler', 15, 1,
         'Folião'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Folião (−1 uso): conceda Vantagem a um Teste de D20 seu ou de um aliado a até 9 m. Se o teste ainda falhar, recupere este uso (mesa — use + no contador).'
FROM ins;
