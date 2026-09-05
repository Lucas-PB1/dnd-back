-- Recursos de transformação — Grim Hollow Cap. 6 (economy tipada)
-- Gerado por scripts/generate-ghpg-cap6-economy-seeds.mjs
-- Grants: SSOT em effects/E008_ghpg_transform.sql

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
