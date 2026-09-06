-- seed-mode: truncate-scoped (phb_effect CTE; re-seed via truncate)
-- Transformações GH Cap. 6 — grant_resource (SSOT; J061 só defs)
-- Gerado por scripts/generate-ghpg-cap6-economy-seeds.mjs

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-aberrant-horror'),
rd AS (
  SELECT id FROM rpg.phb_resource_definition
  WHERE slug = 'aberrant-mutation-uses'
    AND feat_id = (SELECT id FROM feat)
),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_build'::rpg.effect_trigger, 1, 1,
         'Aberrant Mutation'
  FROM feat
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'proficiency_bonus'::rpg.resource_max_formula, NULL,
       FALSE, TRUE, TRUE
FROM ins CROSS JOIN rd;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-aberrant-horror'),
rd AS (
  SELECT id FROM rpg.phb_resource_definition
  WHERE slug = 'writhing-tendrils-uses'
    AND feat_id = (SELECT id FROM feat)
),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_build'::rpg.effect_trigger, 2, 2,
         'Writhing Tendrils'
  FROM feat
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'proficiency_bonus'::rpg.resource_max_formula, NULL,
       FALSE, TRUE, TRUE
FROM ins CROSS JOIN rd;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fey'),
rd AS (
  SELECT id FROM rpg.phb_resource_definition
  WHERE slug = 'servant-of-the-spring-court-uses'
    AND feat_id = (SELECT id FROM feat)
),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_build'::rpg.effect_trigger, 1, 3,
         'Servant of the Spring Court'
  FROM feat
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'proficiency_bonus'::rpg.resource_max_formula, NULL,
       FALSE, FALSE, TRUE
FROM ins CROSS JOIN rd;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fey'),
rd AS (
  SELECT id FROM rpg.phb_resource_definition
  WHERE slug = 'servant-of-the-summer-court-uses'
    AND feat_id = (SELECT id FROM feat)
),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_build'::rpg.effect_trigger, 1, 4,
         'Servant of the Summer Court'
  FROM feat
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'proficiency_bonus'::rpg.resource_max_formula, NULL,
       FALSE, FALSE, TRUE
FROM ins CROSS JOIN rd;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fey'),
rd AS (
  SELECT id FROM rpg.phb_resource_definition
  WHERE slug = 'servant-of-the-autumn-court-uses'
    AND feat_id = (SELECT id FROM feat)
),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_build'::rpg.effect_trigger, 1, 5,
         'Servant of the Autumn Court'
  FROM feat
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'proficiency_bonus'::rpg.resource_max_formula, NULL,
       FALSE, FALSE, TRUE
FROM ins CROSS JOIN rd;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fey'),
rd AS (
  SELECT id FROM rpg.phb_resource_definition
  WHERE slug = 'servant-of-the-winter-court-uses'
    AND feat_id = (SELECT id FROM feat)
),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_build'::rpg.effect_trigger, 1, 6,
         'Servant of the Winter Court'
  FROM feat
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'proficiency_bonus'::rpg.resource_max_formula, NULL,
       FALSE, FALSE, TRUE
FROM ins CROSS JOIN rd;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fey'),
rd AS (
  SELECT id FROM rpg.phb_resource_definition
  WHERE slug = 'two-faced-uses'
    AND feat_id = (SELECT id FROM feat)
),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_build'::rpg.effect_trigger, 2, 7,
         'Two-Faced'
  FROM feat
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'proficiency_bonus'::rpg.resource_max_formula, NULL,
       FALSE, FALSE, TRUE
FROM ins CROSS JOIN rd;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fey'),
rd AS (
  SELECT id FROM rpg.phb_resource_definition
  WHERE slug = 'magic-tricks-uses'
    AND feat_id = (SELECT id FROM feat)
),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_build'::rpg.effect_trigger, 2, 8,
         'Magic Tricks'
  FROM feat
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 3,
       FALSE, FALSE, TRUE
FROM ins CROSS JOIN rd;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fey'),
rd AS (
  SELECT id FROM rpg.phb_resource_definition
  WHERE slug = 'tooth-and-claw-uses'
    AND feat_id = (SELECT id FROM feat)
),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_build'::rpg.effect_trigger, 3, 9,
         'Tooth and Claw'
  FROM feat
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'proficiency_bonus'::rpg.resource_max_formula, NULL,
       FALSE, FALSE, TRUE
FROM ins CROSS JOIN rd;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fey'),
rd AS (
  SELECT id FROM rpg.phb_resource_definition
  WHERE slug = 'dreams-and-nightmares-uses'
    AND feat_id = (SELECT id FROM feat)
),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_build'::rpg.effect_trigger, 3, 10,
         'Dreams and Nightmares'
  FROM feat
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'proficiency_bonus'::rpg.resource_max_formula, NULL,
       FALSE, FALSE, TRUE
FROM ins CROSS JOIN rd;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fey'),
rd AS (
  SELECT id FROM rpg.phb_resource_definition
  WHERE slug = 'greater-magic-tricks-uses'
    AND feat_id = (SELECT id FROM feat)
),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_build'::rpg.effect_trigger, 4, 11,
         'Greater Magic Tricks'
  FROM feat
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 3,
       FALSE, FALSE, TRUE
FROM ins CROSS JOIN rd;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fey'),
rd AS (
  SELECT id FROM rpg.phb_resource_definition
  WHERE slug = 'twilight-glamour-uses'
    AND feat_id = (SELECT id FROM feat)
),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_build'::rpg.effect_trigger, 4, 12,
         'Twilight Glamour'
  FROM feat
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 2,
       FALSE, FALSE, TRUE
FROM ins CROSS JOIN rd;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fiend'),
rd AS (
  SELECT id FROM rpg.phb_resource_definition
  WHERE slug = 'infernal-smite-uses'
    AND feat_id = (SELECT id FROM feat)
),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_build'::rpg.effect_trigger, 1, 13,
         'Punição Infernal'
  FROM feat
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'proficiency_bonus'::rpg.resource_max_formula, NULL,
       FALSE, TRUE, TRUE
FROM ins CROSS JOIN rd;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fiend'),
rd AS (
  SELECT id FROM rpg.phb_resource_definition
  WHERE slug = 'daemonic-brand-uses'
    AND feat_id = (SELECT id FROM feat)
),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_build'::rpg.effect_trigger, 2, 14,
         'Marca Demoníaca'
  FROM feat
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'proficiency_bonus'::rpg.resource_max_formula, NULL,
       FALSE, FALSE, TRUE
FROM ins CROSS JOIN rd;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-hag'),
rd AS (
  SELECT id FROM rpg.phb_resource_definition
  WHERE slug = 'adept-of-the-green-sisterhood-uses'
    AND feat_id = (SELECT id FROM feat)
),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_build'::rpg.effect_trigger, 2, 15,
         'Adept of the Green Sisterhood'
  FROM feat
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'level'::rpg.resource_max_formula, NULL,
       FALSE, FALSE, TRUE
FROM ins CROSS JOIN rd;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-hag'),
rd AS (
  SELECT id FROM rpg.phb_resource_definition
  WHERE slug = 'adept-of-the-red-sisterhood-uses'
    AND feat_id = (SELECT id FROM feat)
),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_build'::rpg.effect_trigger, 2, 16,
         'Adept of the Red Sisterhood'
  FROM feat
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'level'::rpg.resource_max_formula, NULL,
       FALSE, FALSE, TRUE
FROM ins CROSS JOIN rd;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-hag'),
rd AS (
  SELECT id FROM rpg.phb_resource_definition
  WHERE slug = 'adept-of-the-sea-sisterhood-uses'
    AND feat_id = (SELECT id FROM feat)
),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_build'::rpg.effect_trigger, 2, 17,
         'Adept of the Sea Sisterhood'
  FROM feat
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'level'::rpg.resource_max_formula, NULL,
       FALSE, FALSE, TRUE
FROM ins CROSS JOIN rd;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-hag'),
rd AS (
  SELECT id FROM rpg.phb_resource_definition
  WHERE slug = 'master-of-the-red-sisterhood-memory-uses'
    AND feat_id = (SELECT id FROM feat)
),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_build'::rpg.effect_trigger, 3, 18,
         'Master of the Red Sisterhood'
  FROM feat
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, TRUE, TRUE
FROM ins CROSS JOIN rd;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-hag'),
rd AS (
  SELECT id FROM rpg.phb_resource_definition
  WHERE slug = 'master-of-the-sea-sisterhood-gaze-uses'
    AND feat_id = (SELECT id FROM feat)
),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_build'::rpg.effect_trigger, 3, 19,
         'Master of the Sea Sisterhood'
  FROM feat
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, TRUE, TRUE
FROM ins CROSS JOIN rd;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-hag'),
rd AS (
  SELECT id FROM rpg.phb_resource_definition
  WHERE slug = 'master-of-the-green-sisterhood-slot-uses'
    AND feat_id = (SELECT id FROM feat)
),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_build'::rpg.effect_trigger, 3, 20,
         'Master of the Green Sisterhood'
  FROM feat
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE
FROM ins CROSS JOIN rd;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-hag'),
rd AS (
  SELECT id FROM rpg.phb_resource_definition
  WHERE slug = 'evil-eye-uses'
    AND feat_id = (SELECT id FROM feat)
),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_build'::rpg.effect_trigger, 4, 21,
         'Evil Eye'
  FROM feat
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE
FROM ins CROSS JOIN rd;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-hag'),
rd AS (
  SELECT id FROM rpg.phb_resource_definition
  WHERE slug = 'grandmothers-curse-uses'
    AND feat_id = (SELECT id FROM feat)
),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_build'::rpg.effect_trigger, 4, 22,
         'Grandmother’s Curse'
  FROM feat
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE
FROM ins CROSS JOIN rd;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-lich'),
rd AS (
  SELECT id FROM rpg.phb_resource_definition
  WHERE slug = 'soul-vessel-capture-uses'
    AND feat_id = (SELECT id FROM feat)
),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_build'::rpg.effect_trigger, 1, 23,
         'Captura de alma (Recipiente)'
  FROM feat
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 2,
       FALSE, FALSE, TRUE
FROM ins CROSS JOIN rd;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-lich'),
rd AS (
  SELECT id FROM rpg.phb_resource_definition
  WHERE slug = 'binding-curse-uses'
    AND feat_id = (SELECT id FROM feat)
),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_build'::rpg.effect_trigger, 2, 24,
         'Binding Curse'
  FROM feat
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 3,
       FALSE, TRUE, TRUE
FROM ins CROSS JOIN rd;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-lich'),
rd AS (
  SELECT id FROM rpg.phb_resource_definition
  WHERE slug = 'eldritch-concentration-uses'
    AND feat_id = (SELECT id FROM feat)
),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_build'::rpg.effect_trigger, 3, 25,
         'Eldritch Concentration'
  FROM feat
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, TRUE, TRUE
FROM ins CROSS JOIN rd;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-lich'),
rd AS (
  SELECT id FROM rpg.phb_resource_definition
  WHERE slug = 'unholy-healing-uses'
    AND feat_id = (SELECT id FROM feat)
),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_build'::rpg.effect_trigger, 3, 26,
         'Unholy Healing'
  FROM feat
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 3,
       FALSE, FALSE, TRUE
FROM ins CROSS JOIN rd;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-lich'),
rd AS (
  SELECT id FROM rpg.phb_resource_definition
  WHERE slug = 'soul-shattering-attack-uses'
    AND feat_id = (SELECT id FROM feat)
),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_build'::rpg.effect_trigger, 4, 27,
         'Soul-Shattering Attack'
  FROM feat
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 4,
       FALSE, FALSE, TRUE
FROM ins CROSS JOIN rd;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-ooze'),
rd AS (
  SELECT id FROM rpg.phb_resource_definition
  WHERE slug = 'ooze-form-uses'
    AND feat_id = (SELECT id FROM feat)
),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_build'::rpg.effect_trigger, 1, 28,
         'Ooze Form'
  FROM feat
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'proficiency_bonus'::rpg.resource_max_formula, NULL,
       FALSE, FALSE, TRUE
FROM ins CROSS JOIN rd;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-primordial'),
rd AS (
  SELECT id FROM rpg.phb_resource_definition
  WHERE slug = 'elemental-surge-uses'
    AND feat_id = (SELECT id FROM feat)
),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_build'::rpg.effect_trigger, 2, 29,
         'Elemental Surge'
  FROM feat
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'constitution_mod'::rpg.resource_max_formula, NULL,
       FALSE, FALSE, TRUE
FROM ins CROSS JOIN rd;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-seraph'),
rd AS (
  SELECT id FROM rpg.phb_resource_definition
  WHERE slug = 'angelic-wings-uses'
    AND feat_id = (SELECT id FROM feat)
),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_build'::rpg.effect_trigger, 1, 30,
         'Angelic Wings'
  FROM feat
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'level'::rpg.resource_max_formula, NULL,
       FALSE, TRUE, TRUE
FROM ins CROSS JOIN rd;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-seraph'),
rd AS (
  SELECT id FROM rpg.phb_resource_definition
  WHERE slug = 'holy-strikes-uses'
    AND feat_id = (SELECT id FROM feat)
),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_build'::rpg.effect_trigger, 1, 31,
         'Holy Strikes'
  FROM feat
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'proficiency_bonus'::rpg.resource_max_formula, NULL,
       FALSE, TRUE, TRUE
FROM ins CROSS JOIN rd;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-seraph'),
rd AS (
  SELECT id FROM rpg.phb_resource_definition
  WHERE slug = 'divine-clemency-uses'
    AND feat_id = (SELECT id FROM feat)
),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_build'::rpg.effect_trigger, 2, 32,
         'Divine Clemency'
  FROM feat
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'level'::rpg.resource_max_formula, NULL,
       FALSE, FALSE, TRUE
FROM ins CROSS JOIN rd;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-seraph'),
rd AS (
  SELECT id FROM rpg.phb_resource_definition
  WHERE slug = 'sacred-retribution-uses'
    AND feat_id = (SELECT id FROM feat)
),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_build'::rpg.effect_trigger, 2, 33,
         'Sacred Retribution'
  FROM feat
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'level'::rpg.resource_max_formula, NULL,
       FALSE, FALSE, TRUE
FROM ins CROSS JOIN rd;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-seraph'),
rd AS (
  SELECT id FROM rpg.phb_resource_definition
  WHERE slug = 'bow-of-celestial-judgement-uses'
    AND feat_id = (SELECT id FROM feat)
),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_build'::rpg.effect_trigger, 3, 34,
         'Bow of Celestial Judgement'
  FROM feat
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'level'::rpg.resource_max_formula, NULL,
       FALSE, FALSE, TRUE
FROM ins CROSS JOIN rd;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-shadowsteel-ghoul'),
rd AS (
  SELECT id FROM rpg.phb_resource_definition
  WHERE slug = 'shadowsteel-arcane-vessel-uses'
    AND feat_id = (SELECT id FROM feat)
),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_build'::rpg.effect_trigger, 4, 35,
         'Shadowsteel Arcane Vessel'
  FROM feat
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'proficiency_bonus'::rpg.resource_max_formula, NULL,
       FALSE, FALSE, TRUE
FROM ins CROSS JOIN rd;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-specter'),
rd AS (
  SELECT id FROM rpg.phb_resource_definition
  WHERE slug = 'ghastly-touch-uses'
    AND feat_id = (SELECT id FROM feat)
),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_build'::rpg.effect_trigger, 1, 36,
         'Ghastly Touch'
  FROM feat
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'proficiency_bonus'::rpg.resource_max_formula, NULL,
       FALSE, TRUE, TRUE
FROM ins CROSS JOIN rd;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-specter'),
rd AS (
  SELECT id FROM rpg.phb_resource_definition
  WHERE slug = 'incorporeal-movement-uses'
    AND feat_id = (SELECT id FROM feat)
),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_build'::rpg.effect_trigger, 1, 37,
         'Incorporeal Movement'
  FROM feat
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'proficiency_bonus'::rpg.resource_max_formula, NULL,
       FALSE, FALSE, TRUE
FROM ins CROSS JOIN rd;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-specter'),
rd AS (
  SELECT id FROM rpg.phb_resource_definition
  WHERE slug = 'ethereal-phasing-uses'
    AND feat_id = (SELECT id FROM feat)
),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_build'::rpg.effect_trigger, 2, 38,
         'Ethereal Phasing'
  FROM feat
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'level'::rpg.resource_max_formula, NULL,
       FALSE, FALSE, TRUE
FROM ins CROSS JOIN rd;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-specter'),
rd AS (
  SELECT id FROM rpg.phb_resource_definition
  WHERE slug = 'haunting-flight-frighten-uses'
    AND feat_id = (SELECT id FROM feat)
),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_build'::rpg.effect_trigger, 2, 39,
         'Haunting Flight'
  FROM feat
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, TRUE, TRUE
FROM ins CROSS JOIN rd;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-specter'),
rd AS (
  SELECT id FROM rpg.phb_resource_definition
  WHERE slug = 'paralyzing-touch-uses'
    AND feat_id = (SELECT id FROM feat)
),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_build'::rpg.effect_trigger, 3, 40,
         'Paralyzing Touch'
  FROM feat
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'level'::rpg.resource_max_formula, NULL,
       FALSE, TRUE, TRUE
FROM ins CROSS JOIN rd;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-specter'),
rd AS (
  SELECT id FROM rpg.phb_resource_definition
  WHERE slug = 'possession-uses'
    AND feat_id = (SELECT id FROM feat)
),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_build'::rpg.effect_trigger, 4, 41,
         'Possession'
  FROM feat
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, TRUE, TRUE
FROM ins CROSS JOIN rd;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-specter'),
rd AS (
  SELECT id FROM rpg.phb_resource_definition
  WHERE slug = 'call-of-unmaking-uses'
    AND feat_id = (SELECT id FROM feat)
),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_build'::rpg.effect_trigger, 4, 42,
         'Call of Unmaking'
  FROM feat
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE
FROM ins CROSS JOIN rd;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-vampire'),
rd AS (
  SELECT id FROM rpg.phb_resource_definition
  WHERE slug = 'undead-resilience-uses'
    AND feat_id = (SELECT id FROM feat)
),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_build'::rpg.effect_trigger, 2, 43,
         'Undead Resilience'
  FROM feat
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE
FROM ins CROSS JOIN rd;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-vampire'),
rd AS (
  SELECT id FROM rpg.phb_resource_definition
  WHERE slug = 'mist-form-uses'
    AND feat_id = (SELECT id FROM feat)
),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_build'::rpg.effect_trigger, 3, 44,
         'Mist Form'
  FROM feat
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'level'::rpg.resource_max_formula, NULL,
       FALSE, FALSE, TRUE
FROM ins CROSS JOIN rd;
