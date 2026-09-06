-- seed-mode: truncate-scoped (phb_effect CTE; re-seed via truncate)
-- Class resources — grant_resource (SSOT; S068/G021/J030 class grants → DELETE)
-- PHB S068 + gunslinger risk + monster-hunter grave-strike

-- —— Bárbaro — Fúria ——
WITH cls AS (SELECT id FROM rpg.phb_class WHERE slug = 'barbarian'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'rage' AND class_id = (SELECT id FROM cls)),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'class'::rpg.effect_owner_kind, cls.id,
         'on_build'::rpg.effect_trigger, v.unlock_level, v.sort_order, 'Fúria'
  FROM cls CROSS JOIN (VALUES
    (1, 1), (3, 2), (6, 3), (12, 4), (17, 5)
  ) AS v(unlock_level, sort_order)
  RETURNING id, unlock_level
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula,
       CASE ins.unlock_level
         WHEN 1 THEN 2 WHEN 3 THEN 3 WHEN 6 THEN 4 WHEN 12 THEN 5 ELSE 6
       END,
       TRUE, FALSE, TRUE
FROM ins CROSS JOIN rd;

-- —— Guerreiro — Recuperar Fôlego ——
WITH cls AS (SELECT id FROM rpg.phb_class WHERE slug = 'fighter'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'secondWind' AND class_id = (SELECT id FROM cls)),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'class'::rpg.effect_owner_kind, cls.id,
         'on_build'::rpg.effect_trigger, v.unlock_level, v.sort_order, 'Recuperar Fôlego'
  FROM cls CROSS JOIN (VALUES
    (1, 1), (4, 2), (10, 3)
  ) AS v(unlock_level, sort_order)
  RETURNING id, unlock_level
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula,
       CASE ins.unlock_level WHEN 1 THEN 2 WHEN 4 THEN 3 ELSE 4 END,
       TRUE, FALSE, TRUE
FROM ins CROSS JOIN rd;

-- —— Guerreiro — Surto de Ação ——
WITH cls AS (SELECT id FROM rpg.phb_class WHERE slug = 'fighter'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'actionSurge' AND class_id = (SELECT id FROM cls)),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'class'::rpg.effect_owner_kind, cls.id,
         'on_build'::rpg.effect_trigger, v.unlock_level, v.sort_order, 'Surto de Ação'
  FROM cls CROSS JOIN (VALUES
    (2, 10), (17, 11)
  ) AS v(unlock_level, sort_order)
  RETURNING id, unlock_level
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula,
       CASE ins.unlock_level WHEN 2 THEN 1 ELSE 2 END,
       FALSE, TRUE, TRUE
FROM ins CROSS JOIN rd;

-- —— Guerreiro — Indomável ——
WITH cls AS (SELECT id FROM rpg.phb_class WHERE slug = 'fighter'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'indomitable' AND class_id = (SELECT id FROM cls)),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'class'::rpg.effect_owner_kind, cls.id,
         'on_build'::rpg.effect_trigger, v.unlock_level, v.sort_order, 'Indomável'
  FROM cls CROSS JOIN (VALUES
    (9, 20), (13, 21), (17, 22)
  ) AS v(unlock_level, sort_order)
  RETURNING id, unlock_level
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula,
       CASE ins.unlock_level WHEN 9 THEN 1 WHEN 13 THEN 2 ELSE 3 END,
       FALSE, FALSE, TRUE
FROM ins CROSS JOIN rd;

-- —— Monge — Pontos de Foco ——
WITH cls AS (SELECT id FROM rpg.phb_class WHERE slug = 'monk'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'focusPoints' AND class_id = (SELECT id FROM cls)),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'class'::rpg.effect_owner_kind, cls.id,
         'on_build'::rpg.effect_trigger, 2, 1, 'Pontos de Foco'
  FROM cls
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'level'::rpg.resource_max_formula, NULL,
       FALSE, TRUE, TRUE
FROM ins CROSS JOIN rd;

-- —— Bardo — Inspiração ——
WITH cls AS (SELECT id FROM rpg.phb_class WHERE slug = 'bard'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'bardicInspiration' AND class_id = (SELECT id FROM cls)),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'class'::rpg.effect_owner_kind, cls.id,
         'on_build'::rpg.effect_trigger, 1, 1, 'Inspiração de Bardo'
  FROM cls
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'charisma_mod'::rpg.resource_max_formula, NULL,
       FALSE, FALSE, TRUE
FROM ins CROSS JOIN rd;

-- —— Ladino — Golpe de Sorte ——
WITH cls AS (SELECT id FROM rpg.phb_class WHERE slug = 'rogue'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'strokeOfLuck' AND class_id = (SELECT id FROM cls)),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'class'::rpg.effect_owner_kind, cls.id,
         'on_build'::rpg.effect_trigger, 20, 1, 'Golpe de Sorte'
  FROM cls
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, TRUE, TRUE
FROM ins CROSS JOIN rd;

-- —— Clérigo / Paladino — Canalizar Divindade ——
WITH rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'channelDivinity'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'class'::rpg.effect_owner_kind, c.id,
         'on_build'::rpg.effect_trigger, 2, 1, 'Canalizar Divindade'
  FROM rpg.phb_class c
  WHERE c.slug IN ('cleric', 'paladin')
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 0,
       TRUE, FALSE, TRUE
FROM ins CROSS JOIN rd;

-- —— Clérigo — Intervenção Divina ——
WITH cls AS (SELECT id FROM rpg.phb_class WHERE slug = 'cleric'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'divineIntervention' AND class_id = (SELECT id FROM cls)),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'class'::rpg.effect_owner_kind, cls.id,
         'on_build'::rpg.effect_trigger, 10, 10, 'Intervenção Divina'
  FROM cls
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE
FROM ins CROSS JOIN rd;

-- —— Paladino — Mãos Consagradas ——
WITH cls AS (SELECT id FROM rpg.phb_class WHERE slug = 'paladin'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'layOnHands' AND class_id = (SELECT id FROM cls)),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'class'::rpg.effect_owner_kind, cls.id,
         'on_build'::rpg.effect_trigger, 1, 1, 'Mãos Consagradas'
  FROM cls
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 0,
       FALSE, FALSE, TRUE
FROM ins CROSS JOIN rd;

-- —— Patrulheiro — Inimigo Favorito ——
WITH cls AS (SELECT id FROM rpg.phb_class WHERE slug = 'ranger'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'favoredEnemy' AND class_id = (SELECT id FROM cls)),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'class'::rpg.effect_owner_kind, cls.id,
         'on_build'::rpg.effect_trigger, 1, 1, 'Inimigo Favorito'
  FROM cls
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'proficiency_bonus'::rpg.resource_max_formula, NULL,
       FALSE, FALSE, TRUE
FROM ins CROSS JOIN rd;

-- —— Patrulheiro — Incansável ——
WITH cls AS (SELECT id FROM rpg.phb_class WHERE slug = 'ranger'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'tireless' AND class_id = (SELECT id FROM cls)),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'class'::rpg.effect_owner_kind, cls.id,
         'on_build'::rpg.effect_trigger, 10, 10, 'Incansável'
  FROM cls
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'wisdom_mod'::rpg.resource_max_formula, NULL,
       FALSE, FALSE, TRUE
FROM ins CROSS JOIN rd;

-- —— Patrulheiro — Véu da Natureza ——
WITH cls AS (SELECT id FROM rpg.phb_class WHERE slug = 'ranger'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'naturesVeil' AND class_id = (SELECT id FROM cls)),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'class'::rpg.effect_owner_kind, cls.id,
         'on_build'::rpg.effect_trigger, 14, 14, 'Véu da Natureza'
  FROM cls
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'wisdom_mod'::rpg.resource_max_formula, NULL,
       FALSE, FALSE, TRUE
FROM ins CROSS JOIN rd;

-- —— Bruxo — Astúcia Mágica ——
WITH cls AS (SELECT id FROM rpg.phb_class WHERE slug = 'warlock'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'magical-cunning' AND class_id = (SELECT id FROM cls)),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'class'::rpg.effect_owner_kind, cls.id,
         'on_build'::rpg.effect_trigger, 2, 1, 'Astúcia Mágica'
  FROM cls
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE
FROM ins CROSS JOIN rd;

-- —— Feiticeiro — Pontos de Feitiçaria ——
WITH cls AS (SELECT id FROM rpg.phb_class WHERE slug = 'sorcerer'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'sorceryPoints' AND class_id = (SELECT id FROM cls)),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'class'::rpg.effect_owner_kind, cls.id,
         'on_build'::rpg.effect_trigger, 2, 1, 'Pontos de Feitiçaria'
  FROM cls
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'level'::rpg.resource_max_formula, NULL,
       FALSE, FALSE, TRUE
FROM ins CROSS JOIN rd;

-- —— Feiticeiro — Feitiçaria Inata ——
WITH cls AS (SELECT id FROM rpg.phb_class WHERE slug = 'sorcerer'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'innate-sorcery' AND class_id = (SELECT id FROM cls)),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'class'::rpg.effect_owner_kind, cls.id,
         'on_build'::rpg.effect_trigger, 1, 2, 'Feitiçaria Inata'
  FROM cls
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 2,
       FALSE, FALSE, TRUE
FROM ins CROSS JOIN rd;

-- —— Feiticeiro — Restauração Feiticeira ——
WITH cls AS (SELECT id FROM rpg.phb_class WHERE slug = 'sorcerer'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'sorcerous-restoration' AND class_id = (SELECT id FROM cls)),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'class'::rpg.effect_owner_kind, cls.id,
         'on_build'::rpg.effect_trigger, 5, 5, 'Restauração Feiticeira'
  FROM cls
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE
FROM ins CROSS JOIN rd;

-- —— Druida — Forma Selvagem ——
WITH cls AS (SELECT id FROM rpg.phb_class WHERE slug = 'druid'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'wildShape' AND class_id = (SELECT id FROM cls)),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'class'::rpg.effect_owner_kind, cls.id,
         'on_build'::rpg.effect_trigger, v.unlock_level, v.sort_order, 'Forma Selvagem'
  FROM cls CROSS JOIN (VALUES
    (2, 1), (6, 2), (17, 3)
  ) AS v(unlock_level, sort_order)
  RETURNING id, unlock_level
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula,
       CASE ins.unlock_level WHEN 2 THEN 2 WHEN 6 THEN 3 ELSE 4 END,
       TRUE, FALSE, TRUE
FROM ins CROSS JOIN rd;

-- —— Gunslinger — Risco ——
WITH cls AS (SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'risk' AND class_id = (SELECT id FROM cls)),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'class'::rpg.effect_owner_kind, cls.id,
         'on_build'::rpg.effect_trigger, v.unlock_level, v.sort_order, 'Risco'
  FROM cls CROSS JOIN (VALUES
    (2, 1), (6, 2), (14, 3)
  ) AS v(unlock_level, sort_order)
  RETURNING id, unlock_level
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula,
       CASE ins.unlock_level WHEN 2 THEN 4 WHEN 6 THEN 5 ELSE 6 END,
       FALSE, TRUE, TRUE
FROM ins CROSS JOIN rd;

-- —— Monster Hunter — Grave Strike (classe) ——
WITH cls AS (SELECT id FROM rpg.phb_class WHERE slug = 'monster-hunter'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'grave-strike'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'class'::rpg.effect_owner_kind, cls.id,
         'on_build'::rpg.effect_trigger, 20, 1, 'Grave Strike'
  FROM cls
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'intelligence_mod'::rpg.resource_max_formula, NULL,
       FALSE, FALSE, TRUE
FROM ins CROSS JOIN rd;
