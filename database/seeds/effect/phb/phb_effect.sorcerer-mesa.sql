-- seed-mode: truncate-scoped (phb_effect CTE; re-seed via truncate)
-- Mesa feiticeiro: Fonte de Magia + subclasses PHB.

-- Restauração Feiticeira
WITH cls AS (SELECT id FROM rpg.phb_class WHERE slug = 'sorcerer'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, resource_slug,
    unlock_level, sort_order, label
  )
  SELECT 'recover_resource'::rpg.effect_kind, 'class'::rpg.effect_owner_kind, cls.id,
         'on_table_action'::rpg.effect_trigger, 'sorcerous-restoration', 'sorceryPoints',
         5, 1, 'Restauração Feiticeira'
  FROM cls
  RETURNING id
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'level_div_2'::rpg.effect_amount_formula, NULL FROM ins;

WITH cls AS (SELECT id FROM rpg.phb_class WHERE slug = 'sorcerer'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e
  JOIN cls ON cls.id = e.owner_id
  WHERE e.action_slug = 'sorcerous-restoration'
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Restauração Feiticeira: recuperou {total} Pontos de Feitiçaria no Descanso Curto (1×/DL).'
FROM fx;

-- Marés do Caos
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'wild-magic'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_note'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'tides-of-chaos', 3, 1,
         'Marés do Caos'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Marés do Caos: Vantagem em um Teste de D20. Recarrega ao conjurar com espaço ou no DL.'
FROM ins;

-- Distorcer a Sorte
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'wild-magic'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_note'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'bend-luck', 6, 1,
         'Distorcer a Sorte'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Distorcer a Sorte: Reação — ±1d4 ao Teste de D20 de outra criatura (1 SP).'
FROM ins;

-- Bastião da Lei
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'clockwork'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_note'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'bastion-of-law', 6, 1,
         'Bastião da Lei'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Bastião da Lei: gastou {total} PF → {total}d8 de proteção a aliado a 9 m.'
FROM ins;

-- Alma Heróica
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'heroic-sorcery'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'temp_hp'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'heroic-soul', 3, 1,
         'Alma Heróica'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_dice (effect_id, die)
SELECT id, '1d6' FROM ins;

WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'heroic-sorcery'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e
  JOIN sc ON sc.id = e.owner_id
  WHERE e.action_slug = 'heroic-soul' AND e.kind = 'temp_hp'
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Alma Heróica: {total} PV temporários ({expression}) aplicados na ficha.'
FROM fx;

-- Manobra Mística / Implosão
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'heroic-sorcery'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_note'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'mystical-maneuver', 14, 1,
         'Manobra Mística'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Manobra Mística: 2 SP após acertar → +2d8 e Cegar / Ruinoso / Ferimento.'
FROM ins;

WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'aberrant'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_note'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'warp-implosion', 18, 1,
         'Implosão de Distorção'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Implosão de Distorção: teleporte e dano espacial (1×/DL).'
FROM ins;
