-- Recursos de transformação — Grim Hollow Cap. 6 (economy tipada)
-- Gerado por scripts/generate-ghpg-cap6-economy-seeds.mjs

INSERT INTO rpg.phb_resource_definition (slug, name, scope, feat_id, min_level)
VALUES
(
  'aberrant-mutation-uses',
  'Aberrant Mutation',
  'feat'::rpg.resource_scope,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-aberrant-horror'),
  1
),
(
  'writhing-tendrils-uses',
  'Writhing Tendrils',
  'feat'::rpg.resource_scope,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-aberrant-horror'),
  2
),
(
  'servant-of-the-spring-court-uses',
  'Servant of the Spring Court',
  'feat'::rpg.resource_scope,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fey'),
  1
),
(
  'servant-of-the-summer-court-uses',
  'Servant of the Summer Court',
  'feat'::rpg.resource_scope,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fey'),
  1
),
(
  'servant-of-the-autumn-court-uses',
  'Servant of the Autumn Court',
  'feat'::rpg.resource_scope,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fey'),
  1
),
(
  'servant-of-the-winter-court-uses',
  'Servant of the Winter Court',
  'feat'::rpg.resource_scope,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fey'),
  1
),
(
  'two-faced-uses',
  'Two-Faced',
  'feat'::rpg.resource_scope,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fey'),
  2
),
(
  'magic-tricks-uses',
  'Magic Tricks',
  'feat'::rpg.resource_scope,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fey'),
  2
),
(
  'tooth-and-claw-uses',
  'Tooth and Claw',
  'feat'::rpg.resource_scope,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fey'),
  3
),
(
  'dreams-and-nightmares-uses',
  'Dreams and Nightmares',
  'feat'::rpg.resource_scope,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fey'),
  3
),
(
  'greater-magic-tricks-uses',
  'Greater Magic Tricks',
  'feat'::rpg.resource_scope,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fey'),
  4
),
(
  'twilight-glamour-uses',
  'Twilight Glamour',
  'feat'::rpg.resource_scope,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fey'),
  4
),
(
  'infernal-smite-uses',
  'Punição Infernal',
  'feat'::rpg.resource_scope,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fiend'),
  1
),
(
  'daemonic-brand-uses',
  'Marca Demoníaca',
  'feat'::rpg.resource_scope,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fiend'),
  2
),
(
  'adept-of-the-green-sisterhood-uses',
  'Adept of the Green Sisterhood',
  'feat'::rpg.resource_scope,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-hag'),
  2
),
(
  'adept-of-the-red-sisterhood-uses',
  'Adept of the Red Sisterhood',
  'feat'::rpg.resource_scope,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-hag'),
  2
),
(
  'adept-of-the-sea-sisterhood-uses',
  'Adept of the Sea Sisterhood',
  'feat'::rpg.resource_scope,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-hag'),
  2
),
(
  'master-of-the-red-sisterhood-memory-uses',
  'Master of the Red Sisterhood',
  'feat'::rpg.resource_scope,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-hag'),
  3
),
(
  'master-of-the-sea-sisterhood-gaze-uses',
  'Master of the Sea Sisterhood',
  'feat'::rpg.resource_scope,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-hag'),
  3
),
(
  'master-of-the-green-sisterhood-slot-uses',
  'Master of the Green Sisterhood',
  'feat'::rpg.resource_scope,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-hag'),
  3
),
(
  'evil-eye-uses',
  'Evil Eye',
  'feat'::rpg.resource_scope,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-hag'),
  4
),
(
  'grandmothers-curse-uses',
  'Grandmother’s Curse',
  'feat'::rpg.resource_scope,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-hag'),
  4
),
(
  'soul-vessel-capture-uses',
  'Captura de alma (Recipiente)',
  'feat'::rpg.resource_scope,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-lich'),
  1
),
(
  'binding-curse-uses',
  'Binding Curse',
  'feat'::rpg.resource_scope,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-lich'),
  2
),
(
  'eldritch-concentration-uses',
  'Eldritch Concentration',
  'feat'::rpg.resource_scope,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-lich'),
  3
),
(
  'unholy-healing-uses',
  'Unholy Healing',
  'feat'::rpg.resource_scope,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-lich'),
  3
),
(
  'soul-shattering-attack-uses',
  'Soul-Shattering Attack',
  'feat'::rpg.resource_scope,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-lich'),
  4
),
(
  'ooze-form-uses',
  'Ooze Form',
  'feat'::rpg.resource_scope,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-ooze'),
  1
),
(
  'elemental-surge-uses',
  'Elemental Surge',
  'feat'::rpg.resource_scope,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-primordial'),
  2
),
(
  'angelic-wings-uses',
  'Angelic Wings',
  'feat'::rpg.resource_scope,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-seraph'),
  1
),
(
  'holy-strikes-uses',
  'Holy Strikes',
  'feat'::rpg.resource_scope,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-seraph'),
  1
),
(
  'divine-clemency-uses',
  'Divine Clemency',
  'feat'::rpg.resource_scope,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-seraph'),
  2
),
(
  'sacred-retribution-uses',
  'Sacred Retribution',
  'feat'::rpg.resource_scope,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-seraph'),
  2
),
(
  'bow-of-celestial-judgement-uses',
  'Bow of Celestial Judgement',
  'feat'::rpg.resource_scope,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-seraph'),
  3
),
(
  'shadowsteel-arcane-vessel-uses',
  'Shadowsteel Arcane Vessel',
  'feat'::rpg.resource_scope,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-shadowsteel-ghoul'),
  4
),
(
  'ghastly-touch-uses',
  'Ghastly Touch',
  'feat'::rpg.resource_scope,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-specter'),
  1
),
(
  'incorporeal-movement-uses',
  'Incorporeal Movement',
  'feat'::rpg.resource_scope,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-specter'),
  1
),
(
  'ethereal-phasing-uses',
  'Ethereal Phasing',
  'feat'::rpg.resource_scope,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-specter'),
  2
),
(
  'haunting-flight-frighten-uses',
  'Haunting Flight',
  'feat'::rpg.resource_scope,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-specter'),
  2
),
(
  'paralyzing-touch-uses',
  'Paralyzing Touch',
  'feat'::rpg.resource_scope,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-specter'),
  3
),
(
  'possession-uses',
  'Possession',
  'feat'::rpg.resource_scope,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-specter'),
  4
),
(
  'call-of-unmaking-uses',
  'Call of Unmaking',
  'feat'::rpg.resource_scope,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-specter'),
  4
),
(
  'undead-resilience-uses',
  'Undead Resilience',
  'feat'::rpg.resource_scope,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-vampire'),
  2
),
(
  'mist-form-uses',
  'Mist Form',
  'feat'::rpg.resource_scope,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-vampire'),
  3
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  scope = EXCLUDED.scope,
  feat_id = EXCLUDED.feat_id,
  min_level = EXCLUDED.min_level;

INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'feat'::rpg.resource_owner_kind, f.id, rd.id, 1,
  'proficiency_bonus'::rpg.resource_max_formula, NULL,
  FALSE, TRUE, TRUE
FROM rpg.phb_feat f
JOIN rpg.phb_resource_definition rd
  ON rd.slug = 'aberrant-mutation-uses' AND rd.feat_id = f.id
WHERE f.slug = 'gh-transformation-aberrant-horror'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'feat'::rpg.resource_owner_kind, f.id, rd.id, 2,
  'proficiency_bonus'::rpg.resource_max_formula, NULL,
  FALSE, TRUE, TRUE
FROM rpg.phb_feat f
JOIN rpg.phb_resource_definition rd
  ON rd.slug = 'writhing-tendrils-uses' AND rd.feat_id = f.id
WHERE f.slug = 'gh-transformation-aberrant-horror'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'feat'::rpg.resource_owner_kind, f.id, rd.id, 1,
  'proficiency_bonus'::rpg.resource_max_formula, NULL,
  FALSE, FALSE, TRUE
FROM rpg.phb_feat f
JOIN rpg.phb_resource_definition rd
  ON rd.slug = 'servant-of-the-spring-court-uses' AND rd.feat_id = f.id
WHERE f.slug = 'gh-transformation-fey'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'feat'::rpg.resource_owner_kind, f.id, rd.id, 1,
  'proficiency_bonus'::rpg.resource_max_formula, NULL,
  FALSE, FALSE, TRUE
FROM rpg.phb_feat f
JOIN rpg.phb_resource_definition rd
  ON rd.slug = 'servant-of-the-summer-court-uses' AND rd.feat_id = f.id
WHERE f.slug = 'gh-transformation-fey'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'feat'::rpg.resource_owner_kind, f.id, rd.id, 1,
  'proficiency_bonus'::rpg.resource_max_formula, NULL,
  FALSE, FALSE, TRUE
FROM rpg.phb_feat f
JOIN rpg.phb_resource_definition rd
  ON rd.slug = 'servant-of-the-autumn-court-uses' AND rd.feat_id = f.id
WHERE f.slug = 'gh-transformation-fey'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'feat'::rpg.resource_owner_kind, f.id, rd.id, 1,
  'proficiency_bonus'::rpg.resource_max_formula, NULL,
  FALSE, FALSE, TRUE
FROM rpg.phb_feat f
JOIN rpg.phb_resource_definition rd
  ON rd.slug = 'servant-of-the-winter-court-uses' AND rd.feat_id = f.id
WHERE f.slug = 'gh-transformation-fey'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'feat'::rpg.resource_owner_kind, f.id, rd.id, 2,
  'proficiency_bonus'::rpg.resource_max_formula, NULL,
  FALSE, FALSE, TRUE
FROM rpg.phb_feat f
JOIN rpg.phb_resource_definition rd
  ON rd.slug = 'two-faced-uses' AND rd.feat_id = f.id
WHERE f.slug = 'gh-transformation-fey'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'feat'::rpg.resource_owner_kind, f.id, rd.id, 2,
  'fixed'::rpg.resource_max_formula, 3,
  FALSE, FALSE, TRUE
FROM rpg.phb_feat f
JOIN rpg.phb_resource_definition rd
  ON rd.slug = 'magic-tricks-uses' AND rd.feat_id = f.id
WHERE f.slug = 'gh-transformation-fey'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'feat'::rpg.resource_owner_kind, f.id, rd.id, 3,
  'proficiency_bonus'::rpg.resource_max_formula, NULL,
  FALSE, FALSE, TRUE
FROM rpg.phb_feat f
JOIN rpg.phb_resource_definition rd
  ON rd.slug = 'tooth-and-claw-uses' AND rd.feat_id = f.id
WHERE f.slug = 'gh-transformation-fey'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'feat'::rpg.resource_owner_kind, f.id, rd.id, 3,
  'proficiency_bonus'::rpg.resource_max_formula, NULL,
  FALSE, FALSE, TRUE
FROM rpg.phb_feat f
JOIN rpg.phb_resource_definition rd
  ON rd.slug = 'dreams-and-nightmares-uses' AND rd.feat_id = f.id
WHERE f.slug = 'gh-transformation-fey'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'feat'::rpg.resource_owner_kind, f.id, rd.id, 4,
  'fixed'::rpg.resource_max_formula, 3,
  FALSE, FALSE, TRUE
FROM rpg.phb_feat f
JOIN rpg.phb_resource_definition rd
  ON rd.slug = 'greater-magic-tricks-uses' AND rd.feat_id = f.id
WHERE f.slug = 'gh-transformation-fey'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'feat'::rpg.resource_owner_kind, f.id, rd.id, 4,
  'fixed'::rpg.resource_max_formula, 2,
  FALSE, FALSE, TRUE
FROM rpg.phb_feat f
JOIN rpg.phb_resource_definition rd
  ON rd.slug = 'twilight-glamour-uses' AND rd.feat_id = f.id
WHERE f.slug = 'gh-transformation-fey'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'feat'::rpg.resource_owner_kind, f.id, rd.id, 1,
  'proficiency_bonus'::rpg.resource_max_formula, NULL,
  FALSE, TRUE, TRUE
FROM rpg.phb_feat f
JOIN rpg.phb_resource_definition rd
  ON rd.slug = 'infernal-smite-uses' AND rd.feat_id = f.id
WHERE f.slug = 'gh-transformation-fiend'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'feat'::rpg.resource_owner_kind, f.id, rd.id, 2,
  'proficiency_bonus'::rpg.resource_max_formula, NULL,
  FALSE, FALSE, TRUE
FROM rpg.phb_feat f
JOIN rpg.phb_resource_definition rd
  ON rd.slug = 'daemonic-brand-uses' AND rd.feat_id = f.id
WHERE f.slug = 'gh-transformation-fiend'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'feat'::rpg.resource_owner_kind, f.id, rd.id, 2,
  'level'::rpg.resource_max_formula, NULL,
  FALSE, FALSE, TRUE
FROM rpg.phb_feat f
JOIN rpg.phb_resource_definition rd
  ON rd.slug = 'adept-of-the-green-sisterhood-uses' AND rd.feat_id = f.id
WHERE f.slug = 'gh-transformation-hag'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'feat'::rpg.resource_owner_kind, f.id, rd.id, 2,
  'level'::rpg.resource_max_formula, NULL,
  FALSE, FALSE, TRUE
FROM rpg.phb_feat f
JOIN rpg.phb_resource_definition rd
  ON rd.slug = 'adept-of-the-red-sisterhood-uses' AND rd.feat_id = f.id
WHERE f.slug = 'gh-transformation-hag'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'feat'::rpg.resource_owner_kind, f.id, rd.id, 2,
  'level'::rpg.resource_max_formula, NULL,
  FALSE, FALSE, TRUE
FROM rpg.phb_feat f
JOIN rpg.phb_resource_definition rd
  ON rd.slug = 'adept-of-the-sea-sisterhood-uses' AND rd.feat_id = f.id
WHERE f.slug = 'gh-transformation-hag'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'feat'::rpg.resource_owner_kind, f.id, rd.id, 3,
  'fixed'::rpg.resource_max_formula, 1,
  FALSE, TRUE, TRUE
FROM rpg.phb_feat f
JOIN rpg.phb_resource_definition rd
  ON rd.slug = 'master-of-the-red-sisterhood-memory-uses' AND rd.feat_id = f.id
WHERE f.slug = 'gh-transformation-hag'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'feat'::rpg.resource_owner_kind, f.id, rd.id, 3,
  'fixed'::rpg.resource_max_formula, 1,
  FALSE, TRUE, TRUE
FROM rpg.phb_feat f
JOIN rpg.phb_resource_definition rd
  ON rd.slug = 'master-of-the-sea-sisterhood-gaze-uses' AND rd.feat_id = f.id
WHERE f.slug = 'gh-transformation-hag'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'feat'::rpg.resource_owner_kind, f.id, rd.id, 3,
  'fixed'::rpg.resource_max_formula, 1,
  FALSE, FALSE, TRUE
FROM rpg.phb_feat f
JOIN rpg.phb_resource_definition rd
  ON rd.slug = 'master-of-the-green-sisterhood-slot-uses' AND rd.feat_id = f.id
WHERE f.slug = 'gh-transformation-hag'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'feat'::rpg.resource_owner_kind, f.id, rd.id, 4,
  'fixed'::rpg.resource_max_formula, 1,
  FALSE, FALSE, TRUE
FROM rpg.phb_feat f
JOIN rpg.phb_resource_definition rd
  ON rd.slug = 'evil-eye-uses' AND rd.feat_id = f.id
WHERE f.slug = 'gh-transformation-hag'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'feat'::rpg.resource_owner_kind, f.id, rd.id, 4,
  'fixed'::rpg.resource_max_formula, 1,
  FALSE, FALSE, TRUE
FROM rpg.phb_feat f
JOIN rpg.phb_resource_definition rd
  ON rd.slug = 'grandmothers-curse-uses' AND rd.feat_id = f.id
WHERE f.slug = 'gh-transformation-hag'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'feat'::rpg.resource_owner_kind, f.id, rd.id, 1,
  'fixed'::rpg.resource_max_formula, 2,
  FALSE, FALSE, TRUE
FROM rpg.phb_feat f
JOIN rpg.phb_resource_definition rd
  ON rd.slug = 'soul-vessel-capture-uses' AND rd.feat_id = f.id
WHERE f.slug = 'gh-transformation-lich'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'feat'::rpg.resource_owner_kind, f.id, rd.id, 2,
  'fixed'::rpg.resource_max_formula, 3,
  FALSE, TRUE, TRUE
FROM rpg.phb_feat f
JOIN rpg.phb_resource_definition rd
  ON rd.slug = 'binding-curse-uses' AND rd.feat_id = f.id
WHERE f.slug = 'gh-transformation-lich'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'feat'::rpg.resource_owner_kind, f.id, rd.id, 3,
  'fixed'::rpg.resource_max_formula, 1,
  FALSE, TRUE, TRUE
FROM rpg.phb_feat f
JOIN rpg.phb_resource_definition rd
  ON rd.slug = 'eldritch-concentration-uses' AND rd.feat_id = f.id
WHERE f.slug = 'gh-transformation-lich'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'feat'::rpg.resource_owner_kind, f.id, rd.id, 3,
  'fixed'::rpg.resource_max_formula, 3,
  FALSE, FALSE, TRUE
FROM rpg.phb_feat f
JOIN rpg.phb_resource_definition rd
  ON rd.slug = 'unholy-healing-uses' AND rd.feat_id = f.id
WHERE f.slug = 'gh-transformation-lich'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'feat'::rpg.resource_owner_kind, f.id, rd.id, 4,
  'fixed'::rpg.resource_max_formula, 4,
  FALSE, FALSE, TRUE
FROM rpg.phb_feat f
JOIN rpg.phb_resource_definition rd
  ON rd.slug = 'soul-shattering-attack-uses' AND rd.feat_id = f.id
WHERE f.slug = 'gh-transformation-lich'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'feat'::rpg.resource_owner_kind, f.id, rd.id, 1,
  'proficiency_bonus'::rpg.resource_max_formula, NULL,
  FALSE, FALSE, TRUE
FROM rpg.phb_feat f
JOIN rpg.phb_resource_definition rd
  ON rd.slug = 'ooze-form-uses' AND rd.feat_id = f.id
WHERE f.slug = 'gh-transformation-ooze'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'feat'::rpg.resource_owner_kind, f.id, rd.id, 2,
  'constitution_mod'::rpg.resource_max_formula, NULL,
  FALSE, FALSE, TRUE
FROM rpg.phb_feat f
JOIN rpg.phb_resource_definition rd
  ON rd.slug = 'elemental-surge-uses' AND rd.feat_id = f.id
WHERE f.slug = 'gh-transformation-primordial'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'feat'::rpg.resource_owner_kind, f.id, rd.id, 1,
  'level'::rpg.resource_max_formula, NULL,
  FALSE, TRUE, TRUE
FROM rpg.phb_feat f
JOIN rpg.phb_resource_definition rd
  ON rd.slug = 'angelic-wings-uses' AND rd.feat_id = f.id
WHERE f.slug = 'gh-transformation-seraph'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'feat'::rpg.resource_owner_kind, f.id, rd.id, 1,
  'proficiency_bonus'::rpg.resource_max_formula, NULL,
  FALSE, TRUE, TRUE
FROM rpg.phb_feat f
JOIN rpg.phb_resource_definition rd
  ON rd.slug = 'holy-strikes-uses' AND rd.feat_id = f.id
WHERE f.slug = 'gh-transformation-seraph'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'feat'::rpg.resource_owner_kind, f.id, rd.id, 2,
  'level'::rpg.resource_max_formula, NULL,
  FALSE, FALSE, TRUE
FROM rpg.phb_feat f
JOIN rpg.phb_resource_definition rd
  ON rd.slug = 'divine-clemency-uses' AND rd.feat_id = f.id
WHERE f.slug = 'gh-transformation-seraph'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'feat'::rpg.resource_owner_kind, f.id, rd.id, 2,
  'level'::rpg.resource_max_formula, NULL,
  FALSE, FALSE, TRUE
FROM rpg.phb_feat f
JOIN rpg.phb_resource_definition rd
  ON rd.slug = 'sacred-retribution-uses' AND rd.feat_id = f.id
WHERE f.slug = 'gh-transformation-seraph'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'feat'::rpg.resource_owner_kind, f.id, rd.id, 3,
  'level'::rpg.resource_max_formula, NULL,
  FALSE, FALSE, TRUE
FROM rpg.phb_feat f
JOIN rpg.phb_resource_definition rd
  ON rd.slug = 'bow-of-celestial-judgement-uses' AND rd.feat_id = f.id
WHERE f.slug = 'gh-transformation-seraph'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'feat'::rpg.resource_owner_kind, f.id, rd.id, 4,
  'proficiency_bonus'::rpg.resource_max_formula, NULL,
  FALSE, FALSE, TRUE
FROM rpg.phb_feat f
JOIN rpg.phb_resource_definition rd
  ON rd.slug = 'shadowsteel-arcane-vessel-uses' AND rd.feat_id = f.id
WHERE f.slug = 'gh-transformation-shadowsteel-ghoul'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'feat'::rpg.resource_owner_kind, f.id, rd.id, 1,
  'proficiency_bonus'::rpg.resource_max_formula, NULL,
  FALSE, TRUE, TRUE
FROM rpg.phb_feat f
JOIN rpg.phb_resource_definition rd
  ON rd.slug = 'ghastly-touch-uses' AND rd.feat_id = f.id
WHERE f.slug = 'gh-transformation-specter'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'feat'::rpg.resource_owner_kind, f.id, rd.id, 1,
  'proficiency_bonus'::rpg.resource_max_formula, NULL,
  FALSE, FALSE, TRUE
FROM rpg.phb_feat f
JOIN rpg.phb_resource_definition rd
  ON rd.slug = 'incorporeal-movement-uses' AND rd.feat_id = f.id
WHERE f.slug = 'gh-transformation-specter'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'feat'::rpg.resource_owner_kind, f.id, rd.id, 2,
  'level'::rpg.resource_max_formula, NULL,
  FALSE, FALSE, TRUE
FROM rpg.phb_feat f
JOIN rpg.phb_resource_definition rd
  ON rd.slug = 'ethereal-phasing-uses' AND rd.feat_id = f.id
WHERE f.slug = 'gh-transformation-specter'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'feat'::rpg.resource_owner_kind, f.id, rd.id, 2,
  'fixed'::rpg.resource_max_formula, 1,
  FALSE, TRUE, TRUE
FROM rpg.phb_feat f
JOIN rpg.phb_resource_definition rd
  ON rd.slug = 'haunting-flight-frighten-uses' AND rd.feat_id = f.id
WHERE f.slug = 'gh-transformation-specter'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'feat'::rpg.resource_owner_kind, f.id, rd.id, 3,
  'level'::rpg.resource_max_formula, NULL,
  FALSE, TRUE, TRUE
FROM rpg.phb_feat f
JOIN rpg.phb_resource_definition rd
  ON rd.slug = 'paralyzing-touch-uses' AND rd.feat_id = f.id
WHERE f.slug = 'gh-transformation-specter'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'feat'::rpg.resource_owner_kind, f.id, rd.id, 4,
  'fixed'::rpg.resource_max_formula, 1,
  FALSE, TRUE, TRUE
FROM rpg.phb_feat f
JOIN rpg.phb_resource_definition rd
  ON rd.slug = 'possession-uses' AND rd.feat_id = f.id
WHERE f.slug = 'gh-transformation-specter'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'feat'::rpg.resource_owner_kind, f.id, rd.id, 4,
  'fixed'::rpg.resource_max_formula, 1,
  FALSE, FALSE, TRUE
FROM rpg.phb_feat f
JOIN rpg.phb_resource_definition rd
  ON rd.slug = 'call-of-unmaking-uses' AND rd.feat_id = f.id
WHERE f.slug = 'gh-transformation-specter'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'feat'::rpg.resource_owner_kind, f.id, rd.id, 2,
  'fixed'::rpg.resource_max_formula, 1,
  FALSE, FALSE, TRUE
FROM rpg.phb_feat f
JOIN rpg.phb_resource_definition rd
  ON rd.slug = 'undead-resilience-uses' AND rd.feat_id = f.id
WHERE f.slug = 'gh-transformation-vampire'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'feat'::rpg.resource_owner_kind, f.id, rd.id, 3,
  'level'::rpg.resource_max_formula, NULL,
  FALSE, FALSE, TRUE
FROM rpg.phb_feat f
JOIN rpg.phb_resource_definition rd
  ON rd.slug = 'mist-form-uses' AND rd.feat_id = f.id
WHERE f.slug = 'gh-transformation-vampire'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;
