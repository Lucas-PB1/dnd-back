-- Subclass resources — grant_resource (SSOT; grants removidos dos packs)
-- 148 efeitos gerados de phb_resource_grant

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'aberrant'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'warp-implosion'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 18, 1,
         'Implosão de Distorção'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'ancients'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'undying-sentinel'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 15, 2,
         'Sentinela Imortal'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'ancients'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'elder-champion'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 20, 3,
         'Campeão Ancestral'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'arachnoid-stalker'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'arachnoid-web'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 3, 4,
         'Teia'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 2,
       TRUE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'arcane-trickster'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'spell-thief'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 17, 5,
         'Ladrão de Magias'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'archfey'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'fey-steps'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 3, 6,
         'Passos Feéricos'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'charisma_mod'::rpg.resource_max_formula, NULL,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'archfey'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'beguiling-defenses'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 10, 7,
         'Defesas Sedutoras'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'astral-domain'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'planar-reach'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 3, 8,
         'Alcance Planar'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'wisdom_mod'::rpg.resource_max_formula, NULL,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'astral-griffon-patron'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'astral-clarity'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 10, 9,
         'Clareza Astral'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'charisma_mod'::rpg.resource_max_formula, NULL,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'battle-master'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'superiority-dice'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 3, 10,
         'Superioridade em Combate'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'superiority_dice_count'::rpg.resource_max_formula, NULL,
       FALSE, TRUE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'battle-master'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'know-your-enemy'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 7, 11,
         'Conheça Seu Inimigo'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'berserker'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'intimidating-presence'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 14, 12,
         'Presença Intimidante'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'blade-of-radiance'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'divine-points'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 3, 13,
         'Pontos Divinos'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'wisdom_mod'::rpg.resource_max_formula, NULL,
       FALSE, TRUE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'blade-of-radiance'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'final-judgement-spirits'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 17, 14,
         'Espíritos Divinos'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'blood-hound'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'blood-strike'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 3, 15,
         'Golpe de Sangue'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'constitution_mod'::rpg.resource_max_formula, NULL,
       FALSE, TRUE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'celestial'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'healing-light'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 3, 16,
         'Luz Medicinal'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'level_plus_one'::rpg.resource_max_formula, NULL,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'celestial'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'searing-vengeance'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 14, 17,
         'Vingança Calcinante'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'circle-of-fenris'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'children-of-great-wolf'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 14, 18,
         'Filhos do Grande Lobo'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'circle-of-the-city'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'wall-warp'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 10, 19,
         'Distorção de Muro'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'circleof-blood'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'blood-boon'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 6, 20,
         'Dádiva de Sangue'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'wisdom_mod'::rpg.resource_max_formula, NULL,
       TRUE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'circleof-blood'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'exsanguinate'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 14, 21,
         'Exsanguinar'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'circleof-entropy'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'shake-the-earth'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 10, 22,
         'Sacudir a Terra'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'circleof-entropy'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'shake-the-earth'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 14, 23,
         'Sacudir a Terra'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, TRUE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'clockwork'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'restore-balance'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 3, 24,
         'Restaurar Equilíbrio'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'charisma_mod'::rpg.resource_max_formula, NULL,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'clockwork'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'order-trance'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 14, 25,
         'Transe da Ordem'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'clockwork'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'clockwork-cavalcade'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 18, 26,
         'Cavalgada Mecânica'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'college-of-masks'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'virtuoso-skill'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 6, 27,
         'Habilidade de Virtuoso'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'charisma_mod'::rpg.resource_max_formula, NULL,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'collegeof-fools'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'gallows-humor'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 6, 28,
         'Humor da Forca'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, TRUE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'collegeof-fools'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'last-laugh'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 14, 29,
         'Última Risada'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'collegeof-requiems'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'dual-death'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 14, 30,
         'Dupla Morte'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'couatl-herald'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'mercy-dice'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 3, 31,
         'Dados de Misericórdia'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 5,
       FALSE, TRUE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'devotion'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'holy-nimbus'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 20, 32,
         'Resplendor Sagrado'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'devourer-guild'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'devourer-portion'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 3, 33,
         'Porções de Monstro'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'intelligence_mod'::rpg.resource_max_formula, NULL,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'diviner'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'third-eye'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 10, 34,
         'O Terceiro Olho'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, TRUE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'draconic'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'dragon-wings'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 14, 35,
         'Asas de Dragão'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'draconic'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'dragon-companion'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 18, 36,
         'Companheiro Dracônico'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'dragon-domain'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'chromatic-affinity'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 3, 37,
         'Afinidade Cromática'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'wisdom_mod'::rpg.resource_max_formula, NULL,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'dragon-domain'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'legendary-aspect'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 17, 38,
         'Aspecto Lendário'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 3,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'dungeoneer'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'dungeon-precautions'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 7, 39,
         'Precauções na Masmorra'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 5,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'fey-wanderer'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'fey-reinforcements'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 11, 40,
         'Reforços Feéricos'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'fey-wanderer'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'misty-wanderer'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 15, 41,
         'Andarilho Nebuloso'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'wisdom_mod'::rpg.resource_max_formula, NULL,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'fiend'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'dark-ones-luck'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 6, 42,
         'A Sorte do Próprio Tenebroso'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'charisma_mod'::rpg.resource_max_formula, NULL,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'fiend'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'hurl-through-hell'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 14, 43,
         'Lançar no Inferno'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'future-you-patron'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'happened-this-way'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 3, 44,
         'Aconteceu assim'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, TRUE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'future-you-patron'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'fewer-scars'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 6, 45,
         'Menos cicatrizes'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 2,
       TRUE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'future-you-patron'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'grandfather-paradox'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 14, 46,
         'Paradoxo do Avô'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'glamour'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'mantle-of-majesty'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 6, 47,
         'Manto de Majestade'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'glamour'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'unbreakable-majesty'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 14, 48,
         'Majestade Inquebrável'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, TRUE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'gloom-stalker'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'dread-strike'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 3, 49,
         'Emboscador das Sombras'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'wisdom_mod'::rpg.resource_max_formula, NULL,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'glory'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'glorious-defense'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 15, 50,
         'Defesa Gloriosa'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'charisma_mod'::rpg.resource_max_formula, NULL,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'glory'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'living-legend'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 20, 51,
         'Lenda Viva'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'great-old-one'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'clairvoyant-competitor'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 6, 52,
         'Combatente Clarividente'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, TRUE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'green-reaper'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'envenomed-attack'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 3, 53,
         'Ataque Envenenado'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'wisdom_mod'::rpg.resource_max_formula, NULL,
       FALSE, TRUE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'green-reaper'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'poison-control'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 7, 54,
         'Controle de Veneno'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'wisdom_mod'::rpg.resource_max_formula, NULL,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'illusionist'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'spectral-summon'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 6, 55,
         'Criaturas Espectrais'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'illusionist'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'illusory-self'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 10, 56,
         'Autoimagem Ilusória'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, TRUE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'inquisition-domain'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'witch-hunters-strike'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 3, 57,
         'Golpe do Caçador de Bruxas'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'wisdom_mod'::rpg.resource_max_formula, NULL,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'inquisition-domain'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'rebuke-invoker'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 6, 58,
         'Repreender Invocador'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'wisdom_mod'::rpg.resource_max_formula, NULL,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'land'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'natural-recovery'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 6, 59,
         'Recuperação Natural'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'light'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'warding-flare'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 3, 60,
         'Labareda Protetora'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'wisdom_mod'::rpg.resource_max_formula, NULL,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'light'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'warding-flare'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 6, 61,
         'Labareda Protetora'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'wisdom_mod'::rpg.resource_max_formula, NULL,
       FALSE, TRUE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'light'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'corona-of-light'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 17, 62,
         'Coroa de Luz'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'wisdom_mod'::rpg.resource_max_formula, NULL,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'magic-missile-mage'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'magic-missile-free'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 3, 63,
         'Mísseis Mágicos Gratuitos'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'intelligence_mod'::rpg.resource_max_formula, NULL,
       TRUE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'magic-missile-mage'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'missile-shield'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 10, 64,
         'Escudo de Mísseis'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'magic-missile-mage'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'giga-missile'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 14, 65,
         'Giga-Míssil'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'materializer'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'cube-detonation'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 3, 66,
         'Detonação de Cubo'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'intelligence_mod'::rpg.resource_max_formula, NULL,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'materializer'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'rematerialize'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 14, 67,
         'Rematerializar'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'mercy'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'hand-of-harm-flurry'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 11, 68,
         'Torrente de Cura e Dolo'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'wisdom_mod'::rpg.resource_max_formula, NULL,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'mercy'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'hand-of-ultimate-mercy'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 17, 69,
         'Mão da Misericórdia Final'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'moon'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'lunar-step'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 10, 70,
         'Passo Lunar'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'wisdom_mod'::rpg.resource_max_formula, NULL,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'nornbound'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'norn-skeins'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 3, 71,
         'Fios (Skeins)'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 2,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'oath-of-revelry'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'reveler'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 15, 72,
         'Folião'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'charisma_mod'::rpg.resource_max_formula, NULL,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'oath-of-revelry'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'party-animal'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 20, 73,
         'Animal de Festa'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'oath-of-the-eldritch-hunt'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'perfect-hunter'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 20, 74,
         'Caçador Perfeito'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'oath-of-the-hearth'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'burning-spirit'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 20, 75,
         'Espírito Flamejante'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'oath-of-valhalla'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'spirit-of-the-valkyrie'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 20, 76,
         'Espírito da Valquíria'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'oathof-pestilence'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'plaguebringer'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 20, 77,
         'Portador da Peste'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'oathof-slaughter'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'blood-knight'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 20, 78,
         'Cavaleiro de Sangue'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'oathof-zeal'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'apocalyptic-revelation'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 20, 79,
         'Revelação Apocalíptica'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'open-hand'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'wholeness-of-body'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 6, 80,
         'Integridade Corporal'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'wisdom_mod'::rpg.resource_max_formula, NULL,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'osteomancer'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'brittle-bone-armor'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 3, 81,
         'Armadura de Osso Frágil'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'osteomancer'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'bone-puppetry'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 6, 82,
         'Marionetismo Ósseo'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'intelligence_mod'::rpg.resource_max_formula, NULL,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'path-of-the-glacier'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'glacier-rage-extension'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 3, 83,
         'Extensão de Fúria'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'constitution_mod'::rpg.resource_max_formula, NULL,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'pathofthe-primal-spirit'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'beast-kinship'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 6, 84,
         'Parentesco a Feras'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 2,
       FALSE, TRUE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'pathofthe-primal-spirit'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'skinrider-trance'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 10, 85,
         'Transe do Cavaleiro da Pele'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'pathofthe-primal-spirit'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'shape-of-the-wild'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 14, 86,
         'Forma do Selvagem'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, TRUE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'primordial-archer'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'elemental-arrows'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 3, 87,
         'Flechas Elementais'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'wisdom_mod'::rpg.resource_max_formula, NULL,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'primordial-archer'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'herbal-lore'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 3, 88,
         'Conhecimento Herbal'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, TRUE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'primordial-archer'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'primordial-magic'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 15, 89,
         'Magia Primordial'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'wisdom_mod'::rpg.resource_max_formula, NULL,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'psi-warrior'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'psi-energy-dice'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 3, 90,
         'Poder Psiônico'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'psi_energy_dice_count'::rpg.resource_max_formula, NULL,
       TRUE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'psi-warrior'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'telekinetic-movement'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 3, 91,
         'Movimento Telecinético'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, TRUE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'psi-warrior'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'psychic-leap'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 7, 92,
         'Salto com Impulsão Psíquica'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, TRUE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'psi-warrior'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'energy-bulwark'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 15, 93,
         'Baluarte de Energia'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'psi-warrior'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'telekinetic-master'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 18, 94,
         'Mestre Telecinético'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'purification-domain'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'purify-with-fire'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 3, 95,
         'Purificar com Fogo'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'proficiency_bonus'::rpg.resource_max_formula, NULL,
       FALSE, TRUE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'runetagger'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'rune-points'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 3, 96,
         'Pontos de Runa'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 4,
       FALSE, TRUE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'sangromancer'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'sangromancy-dice'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 3, 97,
         'Dados de Sangromancia'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'level_plus_one'::rpg.resource_max_formula, NULL,
       TRUE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'sangromancer'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'red-renewal'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 14, 98,
         'Renovação Rubra'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'sanguine-thief'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'steal-blood'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 3, 99,
         'Roubar Sangue'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'intelligence_mod'::rpg.resource_max_formula, NULL,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'sanguine-thief'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'stolen-power'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 3, 100,
         'Poder Roubado (Dados de Sangromancia)'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 2,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'sanguine-thief'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'stolen-power'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 5, 101,
         'Poder Roubado (Dados de Sangromancia)'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 3,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'sanguine-thief'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'stolen-power'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 7, 102,
         'Poder Roubado (Dados de Sangromancia)'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 4,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'sanguine-thief'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'stolen-power'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 9, 103,
         'Poder Roubado (Dados de Sangromancia)'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 5,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'sanguine-thief'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'stolen-power'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 11, 104,
         'Poder Roubado (Dados de Sangromancia)'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 6,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'sanguine-thief'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'bloodstitch'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 13, 105,
         'Costura Sangrenta'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, TRUE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'sanguine-thief'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'stolen-power'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 13, 106,
         'Poder Roubado (Dados de Sangromancia)'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 7,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'sanguine-thief'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'stolen-power'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 15, 107,
         'Poder Roubado (Dados de Sangromancia)'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 8,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'sanguine-thief'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'bloody-exit'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 17, 108,
         'Saída Sanguinária'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, TRUE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'sanguine-thief'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'stolen-power'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 17, 109,
         'Poder Roubado (Dados de Sangromancia)'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 9,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'sanguine-thief'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'stolen-power'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 19, 110,
         'Poder Roubado (Dados de Sangromancia)'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 10,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'skald'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'battle-sagas'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 14, 111,
         'Sagas de Batalha'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, TRUE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'soulknife'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'psychic-whispers'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 3, 112,
         'Sussurros Psíquicos'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'soulknife'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'soulknife-psi-dice'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 3, 113,
         'Poder Psiônico'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'psi_energy_dice_count'::rpg.resource_max_formula, NULL,
       TRUE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'soulknife'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'psychic-veil'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 13, 114,
         'Véu Psíquico'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'soulknife'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'rend-mind'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 17, 115,
         'Rasgar Mente'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'spirit-caller'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'spirit-guidance'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 3, 116,
         'Orientação Espiritual'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'charisma_mod'::rpg.resource_max_formula, NULL,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'spirit-caller'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'spirit-aura'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 6, 117,
         'Aura Espiritual'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 2,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'spirit-caller'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'spirit-secrets'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 14, 118,
         'Segredos Espirituais'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'charisma_mod'::rpg.resource_max_formula, NULL,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'stars'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'stellar-guidance'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 3, 119,
         'Mapa Estelar'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'wisdom_mod'::rpg.resource_max_formula, NULL,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'stars'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'cosmic-omen'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 6, 120,
         'Presságio Cósmico'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'wisdom_mod'::rpg.resource_max_formula, NULL,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'the-coven'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'hags-eye'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 3, 121,
         'Olho da Bruxa'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'charisma_mod'::rpg.resource_max_formula, NULL,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'the-coven'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'hags-guile'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 6, 122,
         'Astúcia da Bruxa'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'charisma_mod'::rpg.resource_max_formula, NULL,
       FALSE, TRUE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'the-coven'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'hags-visage'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 10, 123,
         'Semblante da Bruxa'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'the-coven'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'hags-craft'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 14, 124,
         'Ofício da Bruxa'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'the-first-vampire-patron'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'creature-of-the-night'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 6, 125,
         'Criatura da Noite'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'charisma_mod'::rpg.resource_max_formula, NULL,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'the-first-vampire-patron'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'eldritch-appetite'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 10, 126,
         'Apetite Eldritch'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'the-first-vampire-patron'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'eternal-night'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 14, 127,
         'Eterna Noite'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'torturer-conclave'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'torturer-technique'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 3, 128,
         'Técnica do Torturador'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 12,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'torturer-conclave'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'veil-of-pain'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 11, 129,
         'Véu de Dor'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'wisdom_mod'::rpg.resource_max_formula, NULL,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'trapper-guild'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'trapper-phase-leap'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 15, 130,
         'Salto de Fase'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 3,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'trapper-guild'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'trapper-regen-dice'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 15, 131,
         'Dados de Regeneração (Armadura)'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 6,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'trapper-guild'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'trapper-rapid-tinker'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 18, 132,
         'Engenho Rápido'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 2,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'trickery'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'tricksters-blessing'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 3, 133,
         'Bênção do Trapaceiro'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'trickster'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'context-switch'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 3, 134,
         'Troca de Contexto'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'charisma_mod'::rpg.resource_max_formula, NULL,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'trickster'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'harbinger-of-chaos'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 14, 135,
         'Arauto do Caos'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, TRUE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'vengeance'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'avenging-angel'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 20, 136,
         'Anjo Vingador'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'vermin-lord'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'swarming-strikes'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 3, 137,
         'Golpes do Enxame'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'proficiency_bonus'::rpg.resource_max_formula, NULL,
       FALSE, TRUE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'vermin-lord'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'verminkin'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 3, 138,
         'Verminata'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, TRUE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'viking'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'marauders-reprisal'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 15, 139,
         'Represália do Saqueador'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'proficiency_bonus'::rpg.resource_max_formula, NULL,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'viking'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'unstoppable-assault'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 18, 140,
         'Assalto Imparável'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'war'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'war-priest'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 3, 141,
         'Sacerdote da Guerra'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'wisdom_mod'::rpg.resource_max_formula, NULL,
       FALSE, TRUE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'warrior-of-the-street'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'street-knockout'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 17, 142,
         'K.O.'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, TRUE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'wild-magic'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'tides-of-chaos'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 3, 143,
         'Marés do Caos'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'wild-magic'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'controlled-surge'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 18, 144,
         'Surto Controlado'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'winter-trapper'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'magic-snare'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 11, 145,
         'Armadilha Mágica'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'wisdom_mod'::rpg.resource_max_formula, NULL,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'zealot'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'divine-fury-dice'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 3, 146,
         'Campeão dos Deuses'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'zealot_healing_dice_count'::rpg.resource_max_formula, NULL,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'zealot'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'zealous-presence'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 10, 147,
         'Presença Zelosa'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'zealot'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'rage-of-the-gods'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 14, 148,
         'Fúria dos Deuses'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;
