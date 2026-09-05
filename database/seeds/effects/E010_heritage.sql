-- Heritage GH Cap. 1 — grant_resource (SSOT; C072 só defs)
-- 31 efeitos; min_trait_takes em phb_effect

WITH ht AS (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'born-lucky'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'gh-born-lucky'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, min_trait_takes, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'heritage'::rpg.effect_owner_kind, ht.id,
         'on_build'::rpg.effect_trigger, 1, 1, 1,
         'Nascido Sob a Sorte'
  FROM ht
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'proficiency_bonus'::rpg.resource_max_formula, NULL,
       FALSE, FALSE, TRUE
FROM ins CROSS JOIN rd;

WITH ht AS (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'centered-edge'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'gh-centered-edge'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, min_trait_takes, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'heritage'::rpg.effect_owner_kind, ht.id,
         'on_build'::rpg.effect_trigger, 1, 2, 1,
         'Fio Centrado'
  FROM ht
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'proficiency_bonus'::rpg.resource_max_formula, NULL,
       FALSE, FALSE, TRUE
FROM ins CROSS JOIN rd;

WITH ht AS (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'damage-immunity'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'gh-damage-immunity-x2'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, min_trait_takes, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'heritage'::rpg.effect_owner_kind, ht.id,
         'on_build'::rpg.effect_trigger, 1, 3, 2,
         'Imunidade a Dano (aprimorado)'
  FROM ht
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, TRUE, FALSE
FROM ins CROSS JOIN rd;

WITH ht AS (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'determined-hearing'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'gh-determined-hearing-x2'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, min_trait_takes, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'heritage'::rpg.effect_owner_kind, ht.id,
         'on_build'::rpg.effect_trigger, 1, 4, 2,
         'Audição Determinada (aprimorado)'
  FROM ht
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE
FROM ins CROSS JOIN rd;

WITH ht AS (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'ethereal-focus'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'gh-ethereal-focus'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, min_trait_takes, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'heritage'::rpg.effect_owner_kind, ht.id,
         'on_build'::rpg.effect_trigger, 1, 5, 1,
         'Foco Etéreo'
  FROM ht
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE
FROM ins CROSS JOIN rd;

WITH ht AS (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'expert-improviser'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'gh-expert-improviser'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, min_trait_takes, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'heritage'::rpg.effect_owner_kind, ht.id,
         'on_build'::rpg.effect_trigger, 1, 6, 1,
         'Improvisador Expert'
  FROM ht
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE
FROM ins CROSS JOIN rd;

WITH ht AS (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'extended-fortification'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'gh-extended-fortification-x2'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, min_trait_takes, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'heritage'::rpg.effect_owner_kind, ht.id,
         'on_build'::rpg.effect_trigger, 1, 7, 2,
         'Fortificação Estendida (aprimorado)'
  FROM ht
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE
FROM ins CROSS JOIN rd;

WITH ht AS (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'focused-edge'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'gh-focused-edge'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, min_trait_takes, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'heritage'::rpg.effect_owner_kind, ht.id,
         'on_build'::rpg.effect_trigger, 1, 8, 1,
         'Fio Concentrado'
  FROM ht
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'proficiency_bonus'::rpg.resource_max_formula, NULL,
       FALSE, FALSE, TRUE
FROM ins CROSS JOIN rd;

WITH ht AS (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'focused-ruthlessness'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'gh-focused-ruthlessness'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, min_trait_takes, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'heritage'::rpg.effect_owner_kind, ht.id,
         'on_build'::rpg.effect_trigger, 1, 9, 1,
         'Crueldade Concentrada'
  FROM ht
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'proficiency_bonus'::rpg.resource_max_formula, NULL,
       FALSE, FALSE, TRUE
FROM ins CROSS JOIN rd;

WITH ht AS (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'immutable-mind'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'gh-immutable-mind-x2'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, min_trait_takes, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'heritage'::rpg.effect_owner_kind, ht.id,
         'on_build'::rpg.effect_trigger, 1, 10, 2,
         'Mente Inabalável (aprimorado)'
  FROM ht
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE
FROM ins CROSS JOIN rd;

WITH ht AS (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'incomparable-roar'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'gh-incomparable-roar'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, min_trait_takes, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'heritage'::rpg.effect_owner_kind, ht.id,
         'on_build'::rpg.effect_trigger, 1, 11, 1,
         'Rugido Incomparável'
  FROM ht
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE
FROM ins CROSS JOIN rd;

WITH ht AS (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'infectious-bravery'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'gh-infectious-bravery-x2'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, min_trait_takes, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'heritage'::rpg.effect_owner_kind, ht.id,
         'on_build'::rpg.effect_trigger, 1, 12, 2,
         'Coragem Contagiante (aprimorado)'
  FROM ht
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'proficiency_bonus'::rpg.resource_max_formula, NULL,
       FALSE, FALSE, TRUE
FROM ins CROSS JOIN rd;

WITH ht AS (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'moving-insight'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'gh-moving-insight'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, min_trait_takes, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'heritage'::rpg.effect_owner_kind, ht.id,
         'on_build'::rpg.effect_trigger, 1, 13, 1,
         'Intuição em Movimento'
  FROM ht
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'proficiency_bonus'::rpg.resource_max_formula, NULL,
       FALSE, FALSE, TRUE
FROM ins CROSS JOIN rd;

WITH ht AS (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'pack-leader'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'gh-pack-leader'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, min_trait_takes, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'heritage'::rpg.effect_owner_kind, ht.id,
         'on_build'::rpg.effect_trigger, 1, 14, 1,
         'Líder de Matilha'
  FROM ht
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'proficiency_bonus'::rpg.resource_max_formula, NULL,
       FALSE, FALSE, TRUE
FROM ins CROSS JOIN rd;

WITH ht AS (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'phase-shift'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'gh-phase-shift'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, min_trait_takes, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'heritage'::rpg.effect_owner_kind, ht.id,
         'on_build'::rpg.effect_trigger, 1, 15, 1,
         'Mudança de Fase'
  FROM ht
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'proficiency_bonus'::rpg.resource_max_formula, NULL,
       FALSE, FALSE, TRUE
FROM ins CROSS JOIN rd;

WITH ht AS (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'poison-indemnity'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'gh-poison-indemnity-x2'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, min_trait_takes, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'heritage'::rpg.effect_owner_kind, ht.id,
         'on_build'::rpg.effect_trigger, 1, 16, 2,
         'Indenização ao Veneno (aprimorado)'
  FROM ht
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE
FROM ins CROSS JOIN rd;

WITH ht AS (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'potent-breath'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'potentBreath'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, min_trait_takes, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'heritage'::rpg.effect_owner_kind, ht.id,
         'on_build'::rpg.effect_trigger, 1, 17, 1,
         'Sopro Potente'
  FROM ht
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'proficiency_bonus'::rpg.resource_max_formula, NULL,
       FALSE, FALSE, TRUE
FROM ins CROSS JOIN rd;

WITH ht AS (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'potent-breath'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'gh-potent-breath-x2'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, min_trait_takes, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'heritage'::rpg.effect_owner_kind, ht.id,
         'on_build'::rpg.effect_trigger, 1, 18, 2,
         'Sopro Potente (aprimorado)'
  FROM ht
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'proficiency_bonus'::rpg.resource_max_formula, NULL,
       FALSE, FALSE, TRUE
FROM ins CROSS JOIN rd;

WITH ht AS (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'protective-cover'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'gh-protective-cover-x2'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, min_trait_takes, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'heritage'::rpg.effect_owner_kind, ht.id,
         'on_build'::rpg.effect_trigger, 1, 19, 2,
         'Cobertura Protetora (aprimorado)'
  FROM ht
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'proficiency_bonus'::rpg.resource_max_formula, NULL,
       FALSE, FALSE, TRUE
FROM ins CROSS JOIN rd;

WITH ht AS (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'resolute-sight'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'gh-resolute-sight-x2'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, min_trait_takes, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'heritage'::rpg.effect_owner_kind, ht.id,
         'on_build'::rpg.effect_trigger, 1, 20, 2,
         'Visão Resoluta (aprimorado)'
  FROM ht
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE
FROM ins CROSS JOIN rd;

WITH ht AS (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'shared-fleetness'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'gh-shared-fleetness-x2'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, min_trait_takes, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'heritage'::rpg.effect_owner_kind, ht.id,
         'on_build'::rpg.effect_trigger, 1, 21, 2,
         'Agilidade Compartilhada (aprimorado)'
  FROM ht
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE
FROM ins CROSS JOIN rd;

WITH ht AS (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'slip-free'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'gh-slip-free-x2'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, min_trait_takes, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'heritage'::rpg.effect_owner_kind, ht.id,
         'on_build'::rpg.effect_trigger, 1, 22, 2,
         'Libertação Ágil (aprimorado)'
  FROM ht
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE
FROM ins CROSS JOIN rd;

WITH ht AS (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'smoker'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'gh-smoker-x2'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, min_trait_takes, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'heritage'::rpg.effect_owner_kind, ht.id,
         'on_build'::rpg.effect_trigger, 1, 23, 2,
         'Fumante (aprimorado)'
  FROM ht
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE
FROM ins CROSS JOIN rd;

WITH ht AS (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'spirit-s-strength'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'gh-spirit-s-strength-x2'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, min_trait_takes, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'heritage'::rpg.effect_owner_kind, ht.id,
         'on_build'::rpg.effect_trigger, 1, 24, 2,
         'Força do Espírito (aprimorado)'
  FROM ht
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE
FROM ins CROSS JOIN rd;

WITH ht AS (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'stalwart-edge'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'gh-stalwart-edge'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, min_trait_takes, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'heritage'::rpg.effect_owner_kind, ht.id,
         'on_build'::rpg.effect_trigger, 1, 25, 1,
         'Fio Inabalável'
  FROM ht
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'proficiency_bonus'::rpg.resource_max_formula, NULL,
       FALSE, FALSE, TRUE
FROM ins CROSS JOIN rd;

WITH ht AS (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'stand-fast'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'gh-stand-fast-x2'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, min_trait_takes, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'heritage'::rpg.effect_owner_kind, ht.id,
         'on_build'::rpg.effect_trigger, 1, 26, 2,
         'Firmeza (aprimorado)'
  FROM ht
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE
FROM ins CROSS JOIN rd;

WITH ht AS (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'strength-of-life'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'gh-strength-of-life-x2'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, min_trait_takes, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'heritage'::rpg.effect_owner_kind, ht.id,
         'on_build'::rpg.effect_trigger, 1, 27, 2,
         'Força da Vida (aprimorado)'
  FROM ht
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE
FROM ins CROSS JOIN rd;

WITH ht AS (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'supreme-slip'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'gh-supreme-slip-x2'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, min_trait_takes, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'heritage'::rpg.effect_owner_kind, ht.id,
         'on_build'::rpg.effect_trigger, 1, 28, 2,
         'Escorregão Supremo (aprimorado)'
  FROM ht
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE
FROM ins CROSS JOIN rd;

WITH ht AS (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'swift-strike'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'gh-swift-strike-x2'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, min_trait_takes, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'heritage'::rpg.effect_owner_kind, ht.id,
         'on_build'::rpg.effect_trigger, 1, 29, 2,
         'Golpe Rápido (aprimorado)'
  FROM ht
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'proficiency_bonus'::rpg.resource_max_formula, NULL,
       FALSE, FALSE, TRUE
FROM ins CROSS JOIN rd;

WITH ht AS (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'vigorous'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'gh-vigorous-x2'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, min_trait_takes, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'heritage'::rpg.effect_owner_kind, ht.id,
         'on_build'::rpg.effect_trigger, 1, 30, 2,
         'Vigoroso (aprimorado)'
  FROM ht
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE
FROM ins CROSS JOIN rd;

WITH ht AS (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'wall-walker'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'gh-wall-walker-x2'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, min_trait_takes, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'heritage'::rpg.effect_owner_kind, ht.id,
         'on_build'::rpg.effect_trigger, 1, 31, 2,
         'Caminhante de Paredes (aprimorado)'
  FROM ht
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'proficiency_bonus'::rpg.resource_max_formula, NULL,
       FALSE, FALSE, TRUE
FROM ins CROSS JOIN rd;

