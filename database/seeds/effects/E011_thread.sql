-- Character Threads NL — grant_resource (SSOT; N040 só defs)

WITH t AS (SELECT id FROM rpg.phb_character_thread WHERE slug = 'bloodsworn'),
rd AS (
  SELECT id FROM rpg.phb_resource_definition
  WHERE slug = 'wrath' AND scope = 'character_thread'::rpg.resource_scope
    AND thread_slug = 'bloodsworn'
),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'character_thread'::rpg.effect_owner_kind, t.id,
         'on_build'::rpg.effect_trigger, 1, 1,
         'Ira'
  FROM t
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE
FROM ins CROSS JOIN rd;

WITH t AS (SELECT id FROM rpg.phb_character_thread WHERE slug = 'bloodsworn'),
rd AS (
  SELECT id FROM rpg.phb_resource_definition
  WHERE slug = 'tenacity' AND scope = 'character_thread'::rpg.resource_scope
    AND thread_slug = 'bloodsworn'
),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'character_thread'::rpg.effect_owner_kind, t.id,
         'on_build'::rpg.effect_trigger, 1, 2,
         'Tenacidade'
  FROM t
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE
FROM ins CROSS JOIN rd;

WITH t AS (SELECT id FROM rpg.phb_character_thread WHERE slug = 'cursemarked'),
rd AS (
  SELECT id FROM rpg.phb_resource_definition
  WHERE slug = 'cursemarked-greater-sacrifice' AND scope = 'character_thread'::rpg.resource_scope
    AND thread_slug = 'cursemarked'
),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'character_thread'::rpg.effect_owner_kind, t.id,
         'on_build'::rpg.effect_trigger, 1, 3,
         'Grande Sacrifício'
  FROM t
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE
FROM ins CROSS JOIN rd;

WITH t AS (SELECT id FROM rpg.phb_character_thread WHERE slug = 'explorer'),
rd AS (
  SELECT id FROM rpg.phb_resource_definition
  WHERE slug = 'traversal-expert' AND scope = 'character_thread'::rpg.resource_scope
    AND thread_slug = 'explorer'
),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'character_thread'::rpg.effect_owner_kind, t.id,
         'on_build'::rpg.effect_trigger, 1, 4,
         'Especialista em Travessia'
  FROM t
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, TRUE, TRUE
FROM ins CROSS JOIN rd;

WITH t AS (SELECT id FROM rpg.phb_character_thread WHERE slug = 'explorer'),
rd AS (
  SELECT id FROM rpg.phb_resource_definition
  WHERE slug = 'scouts-awareness' AND scope = 'character_thread'::rpg.resource_scope
    AND thread_slug = 'explorer'
),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'character_thread'::rpg.effect_owner_kind, t.id,
         'on_build'::rpg.effect_trigger, 1, 5,
         'Alerta do Batedor'
  FROM t
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE
FROM ins CROSS JOIN rd;

WITH t AS (SELECT id FROM rpg.phb_character_thread WHERE slug = 'explorer'),
rd AS (
  SELECT id FROM rpg.phb_resource_definition
  WHERE slug = 'wayfarers-steps' AND scope = 'character_thread'::rpg.resource_scope
    AND thread_slug = 'explorer'
),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'character_thread'::rpg.effect_owner_kind, t.id,
         'on_build'::rpg.effect_trigger, 1, 6,
         'Passos do Viajante'
  FROM t
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE
FROM ins CROSS JOIN rd;

WITH t AS (SELECT id FROM rpg.phb_character_thread WHERE slug = 'fatebound'),
rd AS (
  SELECT id FROM rpg.phb_resource_definition
  WHERE slug = 'fates-blessing' AND scope = 'character_thread'::rpg.resource_scope
    AND thread_slug = 'fatebound'
),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'character_thread'::rpg.effect_owner_kind, t.id,
         'on_build'::rpg.effect_trigger, 1, 7,
         'Bênção do Destino'
  FROM t
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE
FROM ins CROSS JOIN rd;

WITH t AS (SELECT id FROM rpg.phb_character_thread WHERE slug = 'fatebound'),
rd AS (
  SELECT id FROM rpg.phb_resource_definition
  WHERE slug = 'strength-of-wyrd' AND scope = 'character_thread'::rpg.resource_scope
    AND thread_slug = 'fatebound'
),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'character_thread'::rpg.effect_owner_kind, t.id,
         'on_build'::rpg.effect_trigger, 1, 8,
         'Força do Wyrd'
  FROM t
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'proficiency_bonus'::rpg.resource_max_formula, NULL,
       FALSE, FALSE, TRUE
FROM ins CROSS JOIN rd;

WITH t AS (SELECT id FROM rpg.phb_character_thread WHERE slug = 'fatebound'),
rd AS (
  SELECT id FROM rpg.phb_resource_definition
  WHERE slug = 'enduring-wyrd' AND scope = 'character_thread'::rpg.resource_scope
    AND thread_slug = 'fatebound'
),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'character_thread'::rpg.effect_owner_kind, t.id,
         'on_build'::rpg.effect_trigger, 1, 9,
         'Wyrd Duradouro'
  FROM t
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, TRUE, TRUE
FROM ins CROSS JOIN rd;

WITH t AS (SELECT id FROM rpg.phb_character_thread WHERE slug = 'fatebound'),
rd AS (
  SELECT id FROM rpg.phb_resource_definition
  WHERE slug = 'doom-delayed' AND scope = 'character_thread'::rpg.resource_scope
    AND thread_slug = 'fatebound'
),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'character_thread'::rpg.effect_owner_kind, t.id,
         'on_build'::rpg.effect_trigger, 1, 10,
         'Ruína Adiada'
  FROM t
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE
FROM ins CROSS JOIN rd;

WITH t AS (SELECT id FROM rpg.phb_character_thread WHERE slug = 'fatebound'),
rd AS (
  SELECT id FROM rpg.phb_resource_definition
  WHERE slug = 'last-act-of-fate' AND scope = 'character_thread'::rpg.resource_scope
    AND thread_slug = 'fatebound'
),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'character_thread'::rpg.effect_owner_kind, t.id,
         'on_build'::rpg.effect_trigger, 1, 11,
         'Último Ato do Destino'
  FROM t
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, FALSE
FROM ins CROSS JOIN rd;

WITH t AS (SELECT id FROM rpg.phb_character_thread WHERE slug = 'fatebound'),
rd AS (
  SELECT id FROM rpg.phb_resource_definition
  WHERE slug = 'glorious-end' AND scope = 'character_thread'::rpg.resource_scope
    AND thread_slug = 'fatebound'
),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'character_thread'::rpg.effect_owner_kind, t.id,
         'on_build'::rpg.effect_trigger, 1, 12,
         'Fim Glorioso'
  FROM t
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, FALSE
FROM ins CROSS JOIN rd;

WITH t AS (SELECT id FROM rpg.phb_character_thread WHERE slug = 'herald'),
rd AS (
  SELECT id FROM rpg.phb_resource_definition
  WHERE slug = 'enthralling-speaker' AND scope = 'character_thread'::rpg.resource_scope
    AND thread_slug = 'herald'
),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'character_thread'::rpg.effect_owner_kind, t.id,
         'on_build'::rpg.effect_trigger, 1, 13,
         'Orador Cativante'
  FROM t
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE
FROM ins CROSS JOIN rd;

WITH t AS (SELECT id FROM rpg.phb_character_thread WHERE slug = 'herald'),
rd AS (
  SELECT id FROM rpg.phb_resource_definition
  WHERE slug = 'persuasive-words' AND scope = 'character_thread'::rpg.resource_scope
    AND thread_slug = 'herald'
),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'character_thread'::rpg.effect_owner_kind, t.id,
         'on_build'::rpg.effect_trigger, 1, 14,
         'Palavras Persuasivas'
  FROM t
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'charisma_mod'::rpg.resource_max_formula, NULL,
       FALSE, FALSE, TRUE
FROM ins CROSS JOIN rd;

WITH t AS (SELECT id FROM rpg.phb_character_thread WHERE slug = 'legend-hunter'),
rd AS (
  SELECT id FROM rpg.phb_resource_definition
  WHERE slug = 'reliable-senses' AND scope = 'character_thread'::rpg.resource_scope
    AND thread_slug = 'legend-hunter'
),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'character_thread'::rpg.effect_owner_kind, t.id,
         'on_build'::rpg.effect_trigger, 1, 15,
         'Sentidos Confiáveis'
  FROM t
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE
FROM ins CROSS JOIN rd;

WITH t AS (SELECT id FROM rpg.phb_character_thread WHERE slug = 'legend-hunter'),
rd AS (
  SELECT id FROM rpg.phb_resource_definition
  WHERE slug = 'finish-the-fight' AND scope = 'character_thread'::rpg.resource_scope
    AND thread_slug = 'legend-hunter'
),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'character_thread'::rpg.effect_owner_kind, t.id,
         'on_build'::rpg.effect_trigger, 1, 16,
         'Terminar a Luta'
  FROM t
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE
FROM ins CROSS JOIN rd;

WITH t AS (SELECT id FROM rpg.phb_character_thread WHERE slug = 'sworn-huskarl'),
rd AS (
  SELECT id FROM rpg.phb_resource_definition
  WHERE slug = 'jarls-authority' AND scope = 'character_thread'::rpg.resource_scope
    AND thread_slug = 'sworn-huskarl'
),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'character_thread'::rpg.effect_owner_kind, t.id,
         'on_build'::rpg.effect_trigger, 1, 17,
         'Autoridade do Jarl'
  FROM t
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE
FROM ins CROSS JOIN rd;

WITH t AS (SELECT id FROM rpg.phb_character_thread WHERE slug = 'sworn-huskarl'),
rd AS (
  SELECT id FROM rpg.phb_resource_definition
  WHERE slug = 'extreme-loyalty' AND scope = 'character_thread'::rpg.resource_scope
    AND thread_slug = 'sworn-huskarl'
),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'character_thread'::rpg.effect_owner_kind, t.id,
         'on_build'::rpg.effect_trigger, 1, 18,
         'Lealdade Extrema'
  FROM t
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE
FROM ins CROSS JOIN rd;

