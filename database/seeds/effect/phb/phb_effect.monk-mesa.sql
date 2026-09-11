-- seed-mode: truncate-scoped (phb_effect CTE; re-seed via truncate)
-- Mesa monge: core + Open Hand / Mercy / Elements / Shadow / Street.

-- Torrente de Golpes
WITH cls AS (SELECT id FROM rpg.phb_class WHERE slug = 'monk'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_note'::rpg.effect_kind, 'class'::rpg.effect_owner_kind, cls.id,
         'on_table_action'::rpg.effect_trigger, 'flurry-of-blows', 2, 1,
         'Torrente de Golpes'
  FROM cls
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Torrente de Golpes: gaste 1 Foco para fazer 2 Ataques Desarmados como Ação Bônus (3 no nv. 10+; dado de Artes Marciais cada).'
FROM ins;

-- Defesa Paciente
WITH cls AS (SELECT id FROM rpg.phb_class WHERE slug = 'monk'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_note'::rpg.effect_kind, 'class'::rpg.effect_owner_kind, cls.id,
         'on_table_action'::rpg.effect_trigger, 'patient-defense', 2, 1,
         'Defesa Paciente'
  FROM cls
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Defesa Paciente: gaste 1 Foco para usar Esquivar e Desengajar como Ação Bônus (Desengajar é gratuito sem gastar Foco).'
FROM ins;

-- Passos do Vento
WITH cls AS (SELECT id FROM rpg.phb_class WHERE slug = 'monk'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_note'::rpg.effect_kind, 'class'::rpg.effect_owner_kind, cls.id,
         'on_table_action'::rpg.effect_trigger, 'step-of-the-wind', 2, 1,
         'Passos do Vento'
  FROM cls
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Passos do Vento: gaste 1 Foco para usar Disparar e Desengajar como Ação Bônus; distância de salto dobra neste turno.'
FROM ins;

-- Golpe Atordoante
WITH cls AS (SELECT id FROM rpg.phb_class WHERE slug = 'monk'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'feature_dc'::rpg.effect_kind, 'class'::rpg.effect_owner_kind, cls.id,
         'on_table_action'::rpg.effect_trigger, 'stunning-strike', 5, 1,
         'Golpe Atordoante — CD'
  FROM cls
  RETURNING id
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'eight_plus_mod_plus_pb'::rpg.effect_amount_formula, NULL FROM ins;

WITH cls AS (SELECT id FROM rpg.phb_class WHERE slug = 'monk'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_note'::rpg.effect_kind, 'class'::rpg.effect_owner_kind, cls.id,
         'on_table_action'::rpg.effect_trigger, 'stunning-strike', 5, 2,
         'Golpe Atordoante'
  FROM cls
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Golpe Atordoante: no acerto, gaste 1 Foco; o alvo faz salvaguarda de Constituição CD {saveDc}. Falha = Atordoado até o fim do seu próximo turno; sucesso = metade do Deslocamento e Vantagem no seu próximo ataque contra ele.'
FROM ins;

-- Open Hand — Técnica da Mão Espalmada
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'open-hand'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'feature_dc'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'open-hand-technique', 3, 1,
         'Técnica da Mão Espalmada — CD'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'eight_plus_mod_plus_pb'::rpg.effect_amount_formula, NULL FROM ins;

WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'open-hand'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_note'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'open-hand-technique', 3, 2,
         'Técnica da Mão Espalmada'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Técnica da Mão Espalmada: ao acertar com a Torrente de Golpes, cada ataque pode impor Caído (Destreza CD {saveDc}), empurrar 4,5 m (Força CD {saveDc}) ou impedir Reações até o início do próximo turno do alvo.'
FROM ins;

-- Open Hand — Integridade Corporal
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'open-hand'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'heal'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'wholeness-of-body', 6, 1,
         'Integridade Corporal'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'schedule_die_plus_flat'::rpg.effect_amount_formula, NULL FROM ins;

WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'open-hand'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e
  JOIN sc ON sc.id = e.owner_id
  WHERE e.action_slug = 'wholeness-of-body' AND e.kind = 'heal'
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Integridade Corporal: Ação Bônus — recupere {total} PV ({expression}; +PV na ficha). Usos = mod. de Sabedoria (mín. 1)/DL.'
FROM fx;

-- Open Hand — Palma Vibrante
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'open-hand'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'feature_dc'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'vibrating-palm', 17, 1,
         'Palma Vibrante — CD'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'eight_plus_mod_plus_pb'::rpg.effect_amount_formula, NULL FROM ins;

WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'open-hand'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_note'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'vibrating-palm', 17, 2,
         'Palma Vibrante'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Palma Vibrante: no acerto desarmado, gaste 4 Foco para iniciar vibrações (duração = nível de Monge em dias; 1 alvo). Encerrar: Constituição CD {saveDc} → 10d12 Energético (metade no sucesso). Pode encerrar inofensivamente sem ação.'
FROM ins;

-- Elements — Sintonia Elemental
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'elements'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'feature_dc'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'elemental-attunement', 3, 1,
         'Sintonia Elemental — CD'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'eight_plus_mod_plus_pb'::rpg.effect_amount_formula, NULL FROM ins;

WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'elements'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_note'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'elemental-attunement', 3, 2,
         'Sintonia Elemental'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Sintonia Elemental: no início do turno, gaste 1 Foco (10 min ou até Incapacitado). Ataques Desarmados: dano elemental à escolha; alcance +3 m; no acerto, Força CD {saveDc} ou mover o alvo 3 m.'
FROM ins;

-- Elements — Explosão Elemental
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'elements'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'feature_dc'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'elemental-blast', 6, 1,
         'Explosão Elemental — CD'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'eight_plus_mod_plus_pb'::rpg.effect_amount_formula, NULL FROM ins;

WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'elements'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_roll'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'elemental-blast', 6, 2,
         'Explosão Elemental — Dano'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'dice_3d_schedule'::rpg.effect_amount_formula, NULL FROM ins;

WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'elements'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_note'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'elemental-blast', 6, 3,
         'Explosão Elemental'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Explosão Elemental: Usar Magia, gaste 2 Foco. Esfera 6 m centrada a até 36 m. Destreza CD {saveDc} → {total} ({expression}) ou metade no sucesso.'
FROM ins;

-- Mercy — Mão de Cura
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'mercy'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'heal'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'hand-of-healing', 3, 1,
         'Mão de Cura'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'schedule_die_plus_flat'::rpg.effect_amount_formula, NULL FROM ins;

WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'mercy'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e
  JOIN sc ON sc.id = e.owner_id
  WHERE e.action_slug = 'hand-of-healing' AND e.kind = 'heal'
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Mão de Cura: Usar Magia, gaste 1 Foco — cure {total} PV ({expression}; ajuste se for aliado). Na Torrente, pode substituir 1 ataque desarmado por esta cura sem gastar Foco da cura. Nv. 6+: remove condição (Toque de Médico).'
FROM fx;

-- Mercy — Mão de Dolo
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'mercy'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_roll'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'hand-of-harm', 3, 1,
         'Mão de Dolo'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'schedule_die_plus_flat'::rpg.effect_amount_formula, NULL FROM ins;

WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'mercy'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e
  JOIN sc ON sc.id = e.owner_id
  WHERE e.action_slug = 'hand-of-harm' AND e.kind = 'table_roll'
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Mão de Dolo: 1×/turno no acerto desarmado, gaste 1 Foco para +{total} Necrótico ({expression}). Nv. 6+: também pode impor Envenenado.'
FROM fx;

-- Mercy — Torrente de Cura e Dolo
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'mercy'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_note'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'flurry-of-healing-and-harm', 11, 1,
         'Torrente de Cura e Dolo'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Torrente de Cura e Dolo: nesta Torrente, cada ataque desarmado pode ser substituído por Mão de Cura sem gastar Foco da cura; e 1×/turno Mão de Dolo sem gastar Foco do dolo. Usos = mod. de Sabedoria (mín. 1)/DL.'
FROM ins;

-- Mercy — Mão da Misericórdia Final (outlier: 5 Foco + heal + note)
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'mercy'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, resource_slug,
    unlock_level, sort_order, label
  )
  SELECT 'spend_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'hand-of-ultimate-mercy', 'focusPoints',
         17, 1, 'Mão da Misericórdia Final — Foco'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'fixed'::rpg.effect_amount_formula, 5 FROM ins;

WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'mercy'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'heal'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'hand-of-ultimate-mercy', 17, 2,
         'Mão da Misericórdia Final — Cura'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_dice (effect_id, die)
SELECT id, '4d10' FROM ins;

WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'mercy'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e
  JOIN sc ON sc.id = e.owner_id
  WHERE e.action_slug = 'hand-of-ultimate-mercy' AND e.kind = 'heal'
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'ability_mod'::rpg.effect_amount_formula, NULL FROM fx;

WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'mercy'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_note'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'hand-of-ultimate-mercy', 17, 3,
         'Mão da Misericórdia Final'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Mão da Misericórdia Final: Usar Magia, toque cadáver (≤24 h), gaste 5 Foco + 1 uso. Revive com {total} PV ({expression}); remove Atordoado/Cego/Envenenado/Paralisado/Surdo. 1×/DL.'
FROM ins;

-- Shadow — Artes das Sombras
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'shadow'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_note'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'shadow-arts', 3, 1,
         'Artes das Sombras — Escuridão'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Artes das Sombras: gaste 1 Foco para conjurar Escuridão sem componentes. Você vê na área; no início de cada turno pode mover a área até 18 m.'
FROM ins;

-- Shadow — Passo da Sombra
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'shadow'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_note'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'shadow-step', 6, 1,
         'Passo da Sombra'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Passo da Sombra: em Meia-luz ou Escuridão, Ação Bônus — teleporte até 18 m para espaço desocupado sob Meia-luz/Escuridão à vista. Vantagem no próximo ataque corpo a corpo neste turno.'
FROM ins;

-- Shadow — Passo Aprimorado
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'shadow'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_note'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'improved-shadow-step', 11, 1,
         'Passo da Sombra Aprimorado'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Passo da Sombra Aprimorado: ao usar Passo da Sombra, gaste 1 Foco para ignorar o requisito de Meia-luz/Escuridão e faça 1 Ataque Desarmado imediatamente após o teleporte.'
FROM ins;

-- Shadow — Manto da Sombra
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'shadow'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_note'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'cloak-of-shadows', 17, 1,
         'Manto da Sombra'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Manto da Sombra: em Meia-luz/Escuridão, Usar Magia, gaste 3 Foco (1 min ou até Incapacitado / terminar turno em Luz Plena). Invisível; atravessa espaços ocupados; Torrente sem gastar Foco.'
FROM ins;

-- Street — Combinação
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'warrior-of-the-street'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_note'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'street-combo', 3, 1,
         'Combinação'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Combinação: no acerto desarmado com dano, gaste 1 Foco. Até o fim do turno: +2 nas jogadas de ataque desarmado; +2 por acerto sucessivo (máx. +6). Reseta se sofrer dano ou errar.'
FROM ins;

-- Street — Explosão de Energia
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'warrior-of-the-street'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'feature_dc'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'energy-burst', 6, 1,
         'Explosão de Energia — CD'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'eight_plus_mod_plus_pb'::rpg.effect_amount_formula, NULL FROM ins;

WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'warrior-of-the-street'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_roll'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'energy-burst', 6, 2,
         'Explosão de Energia — Dano'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'dice_2d_schedule'::rpg.effect_amount_formula, NULL FROM ins;

WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'warrior-of-the-street'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_note'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'energy-burst', 6, 3,
         'Explosão de Energia'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Explosão de Energia: na ação Atacar, gaste 1 Foco para substituir 1 ataque. Alvo a até 18 m: Destreza CD {saveDc} → {total} Energético ({expression}) ou metade no sucesso.'
FROM ins;

-- Street — Quebrador de Guarda
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'warrior-of-the-street'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_note'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'guard-breaker', 6, 1,
         'Quebrador de Guarda'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'ability_mod'::rpg.effect_amount_formula, NULL FROM ins;

WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'warrior-of-the-street'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e
  JOIN sc ON sc.id = e.owner_id
  WHERE e.action_slug = 'guard-breaker' AND e.kind = 'table_note'
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Quebrador de Guarda: ao errar Ataque Desarmado, gaste 1 Foco — o alvo ainda sofre {total} de dano (mod. de Destreza). Este erro não reseta o bônus de Combinação.'
FROM fx;

-- Street — Corte Superior
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'warrior-of-the-street'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_note'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'uppercut', 6, 1,
         'Corte Superior'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Corte Superior: no acerto desarmado com dano, gaste 1 Foco — empurre o alvo até 1,5 m e imponha Caído se for Grande ou menor.'
FROM ins;

-- Street — Traço Aéreo
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'warrior-of-the-street'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_note'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'air-dash', 11, 1,
         'Traço Aéreo'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Traço Aéreo: no seu turno (sem ação), gaste 1 Foco — Deslocamento de Voo igual ao seu Deslocamento até o fim do próximo turno; Vantagem no próximo ataque corpo a corpo neste turno.'
FROM ins;

-- Street — K.O.
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'warrior-of-the-street'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_roll'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'knockout', 17, 1,
         'K.O.'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'dice_3d_schedule'::rpg.effect_amount_formula, NULL FROM ins;

WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'warrior-of-the-street'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e
  JOIN sc ON sc.id = e.owner_id
  WHERE e.action_slug = 'knockout' AND e.kind = 'table_roll'
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'K.O.: 1×/turno no acerto desarmado — +{total} Energético ({expression}). Se o alvo ficar com ≤100 PV após o ataque, Inconsciente 10 min. 1×/Descanso Curto ou Longo (ou recupere com Gambito: 5 Foco).'
FROM fx;
