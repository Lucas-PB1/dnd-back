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

-- Feitiçaria Inata (fallback SP)
WITH cls AS (SELECT id FROM rpg.phb_class WHERE slug = 'sorcerer'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'resource_fallback_spend'::rpg.effect_kind, 'class'::rpg.effect_owner_kind, cls.id,
         'on_table_action'::rpg.effect_trigger, 'innate-sorcery', 1, 1,
         'Feitiçaria Inata'
  FROM cls
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Feitiçaria Inata: usa o pool ou 2 PF (L7+) antes do resolveSpendPlan.'
FROM ins;

-- Asas de Dragão (fallback SP)
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'draconic'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'resource_fallback_spend'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'dragon-wings', 14, 1,
         'Asas de Dragão'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Asas de Dragão: usa o pool ou 3 PF para restaurar o uso.'
FROM ins;

-- Fonte de Magia (converter slot ↔ PF)
WITH cls AS (SELECT id FROM rpg.phb_class WHERE slug = 'sorcerer'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'convert_spell_points'::rpg.effect_kind, 'class'::rpg.effect_owner_kind, cls.id,
         'on_table_action'::rpg.effect_trigger, v.action_slug, 2, 1, v.label
  FROM cls
  CROSS JOIN (VALUES
    ('convert-slot-1-to-points', 'Converter Slot 1º → PF'),
    ('convert-slot-2-to-points', 'Converter Slot 2º → PF'),
    ('convert-slot-3-to-points', 'Converter Slot 3º → PF'),
    ('convert-slot-4-to-points', 'Converter Slot 4º → PF'),
    ('convert-slot-5-to-points', 'Converter Slot 5º → PF'),
    ('convert-points-to-slot-1', 'Criar Slot 1º (2 PF)'),
    ('convert-points-to-slot-2', 'Criar Slot 2º (3 PF)'),
    ('convert-points-to-slot-3', 'Criar Slot 3º (5 PF)'),
    ('convert-points-to-slot-4', 'Criar Slot 4º (6 PF)'),
    ('convert-points-to-slot-5', 'Criar Slot 5º (7 PF)')
  ) AS v(action_slug, label)
  RETURNING id
)
SELECT 1 FROM ins;

-- Metamagia (mesa)
WITH cls AS (SELECT id FROM rpg.phb_class WHERE slug = 'sorcerer'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'catalog_metamagic'::rpg.effect_kind, 'class'::rpg.effect_owner_kind, cls.id,
         'on_table_action'::rpg.effect_trigger, 'use-metamagic', 2, 1,
         'Metamagia (mesa)'
  FROM cls
  RETURNING id
)
SELECT 1 FROM ins;
