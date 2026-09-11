-- seed-mode: truncate-scoped (phb_effect CTE; re-seed via truncate)
-- Mesa mago: Recuperação Arcana + escolas + Sábio dos Mísseis.

-- Recuperação Arcana (slots 1º–5º)
WITH cls AS (SELECT id FROM rpg.phb_class WHERE slug = 'wizard'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'recover_spell_slot'::rpg.effect_kind, 'class'::rpg.effect_owner_kind, cls.id,
         'on_table_action'::rpg.effect_trigger, v.action_slug, 1, v.slot_level,
         'Recuperação Arcana (Slot ' || v.slot_level || 'º)'
  FROM cls
  CROSS JOIN (VALUES
    ('arcane-recovery-1', 1),
    ('arcane-recovery-2', 2),
    ('arcane-recovery-3', 3),
    ('arcane-recovery-4', 4),
    ('arcane-recovery-5', 5)
  ) AS v(action_slug, slot_level)
  RETURNING id, action_slug
)
INSERT INTO rpg.phb_effect_spell (effect_id, option_key, spell_level)
SELECT id, 'fixed_slot',
  CASE action_slug
    WHEN 'arcane-recovery-1' THEN 1
    WHEN 'arcane-recovery-2' THEN 2
    WHEN 'arcane-recovery-3' THEN 3
    WHEN 'arcane-recovery-4' THEN 4
    ELSE 5
  END
FROM ins;

WITH cls AS (SELECT id FROM rpg.phb_class WHERE slug = 'wizard'),
fx AS (
  SELECT e.id, e.action_slug FROM rpg.phb_effect e
  JOIN cls ON cls.id = e.owner_id
  WHERE e.action_slug LIKE 'arcane-recovery-%' AND e.kind = 'recover_spell_slot'
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Recuperação Arcana: recuperou 1 Slot de ' ||
  CASE action_slug
    WHEN 'arcane-recovery-1' THEN '1'
    WHEN 'arcane-recovery-2' THEN '2'
    WHEN 'arcane-recovery-3' THEN '3'
    WHEN 'arcane-recovery-4' THEN '4'
    ELSE '5'
  END || 'º círculo durante o descanso curto.'
FROM fx;

-- Dominância de Magias
WITH cls AS (SELECT id FROM rpg.phb_class WHERE slug = 'wizard'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_note'::rpg.effect_kind, 'class'::rpg.effect_owner_kind, cls.id,
         'on_table_action'::rpg.effect_trigger, 'spell-mastery', 18, 1,
         'Dominância de Magias'
  FROM cls
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Dominância de Magias: 1 magia de 1º círculo e 1 de 2º círculo preparadas podem ser conjuradas sem consumir espaço de magia.'
FROM ins;

-- Proteção Arcana
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'abjurer'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'temp_hp'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'arcane-ward', 3, 1,
         'Proteção Arcana'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'level_times_2'::rpg.effect_amount_formula, NULL FROM ins;

WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'abjurer'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e
  JOIN sc ON sc.id = e.owner_id
  WHERE e.action_slug = 'arcane-ward' AND e.kind = 'temp_hp'
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Proteção Arcana: barreira com {total} PV aplicados na ficha como PV temp. Absorve dano e recarrega ao conjurar Abjuração — ajuste se a Proteção for menor que o tempHp atual.'
FROM fx;

-- Recarregar Proteção Arcana
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'abjurer'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_note'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'arcane-ward-recharge', 3, 1,
         'Recarregar Proteção Arcana'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Recarregar Proteção: Ação Bônus — gaste 1 espaço de magia; a Proteção recupera PV iguais ao dobro do círculo do espaço.'
FROM ins;

-- Proteção Projetada
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'abjurer'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_note'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'projected-ward', 6, 1,
         'Proteção Projetada'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Proteção Projetada: Reação — quando uma criatura à sua vista a até 9 m sofrer dano, sua Proteção Arcana pode absorvê-lo no lugar dela.'
FROM ins;

-- Rompe-Magia
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'abjurer'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_note'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'spell-breaker', 10, 1,
         'Rompe-Magia'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'proficiency_bonus'::rpg.effect_amount_formula, NULL FROM ins;

WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'abjurer'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e
  JOIN sc ON sc.id = e.owner_id
  WHERE e.action_slug = 'spell-breaker' AND e.kind = 'table_note'
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Rompe-Magia: Dissipar Magia como Ação Bônus; some +{total} (PB) ao teste. Contramagia e Dissipar sempre preparadas; se falharem ao interromper, o espaço não é gasto.'
FROM fx;

-- Presságio
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'diviner'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_roll'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'portent', 3, 1,
         'Presságio'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'portent_d20_count'::rpg.effect_amount_formula, NULL FROM ins;

WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'diviner'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e
  JOIN sc ON sc.id = e.owner_id
  WHERE e.action_slug = 'portent' AND e.kind = 'table_roll'
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Presságio: rolagens de portento guardadas para hoje: [{expression}]. Use para substituir qualquer d20 seu ou de uma criatura.'
FROM fx;

-- O Terceiro Olho
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'diviner'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_note'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'third-eye', 10, 1,
         'O Terceiro Olho'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'O Terceiro Olho: Ação Bônus — escolha Compreensão Superior, Ver o Invisível (sem espaço) ou Visão no Escuro 36 m até o próximo descanso. 1× por Descanso Curto ou Longo.'
FROM ins;

-- Esculpir Magias
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'evoker'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_note'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'sculpt-spells', 6, 1,
         'Esculpir Magias'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Esculpir Magias: escolha até 1 + nível da magia aliados na área de Evocação. Eles passam automaticamente na salvaguarda e não sofrem dano.'
FROM ins;

-- Sobrecarga
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'evoker'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_note'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'overchannel', 14, 1,
         'Sobrecarga'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Sobrecarga: ao conjurar magia de Mago com dano (espaço 1º–5º), pode causar dano máximo. 1ª vez no dia sem custo; usos seguintes antes do Descanso Longo causam 2d12 Necrótico por círculo (+1d12 por uso extra), ignorando Resistência/Imunidade.'
FROM ins;

-- Ilusão Aprimorada
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'illusionist'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_note'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'improved-illusions', 3, 1,
         'Ilusão Aprimorada'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Ilusão Aprimorada: conjure truques de Ilusão e Imagem Silenciosa como Ação Bônus sem componentes V e com o dobro do alcance.'
FROM ins;

-- Criaturas Espectrais
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'illusionist'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_note'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'spectral-summon', 6, 1,
         'Criaturas Espectrais'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Criaturas Espectrais: Ação — Convocar Feérico ou Invocar Fera (versão Ilusão) sem espaço; PV da criatura pela metade. Recupera no Descanso Longo.'
FROM ins;

-- Autoimagem Ilusória
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'illusionist'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_note'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'illusory-self', 10, 1,
         'Autoimagem Ilusória'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Autoimagem Ilusória: Reação ao ser atingido — o ataque erra. Restaure no Descanso Curto/Longo ou gastando um espaço de 2º+ (sem ação).'
FROM ins;

-- Realidade Ilusória
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'illusionist'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_note'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'illusory-reality', 14, 1,
         'Realidade Ilusória'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Realidade Ilusória: Ação Bônus — enquanto uma Ilusão conjurada com espaço estiver ativa, torne real 1 objeto inanimado não mágico dela por 1 minuto (não causa dano nem condições).'
FROM ins;
