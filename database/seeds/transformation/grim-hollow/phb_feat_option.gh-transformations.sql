-- Cap. 6 transformações: option_def / option_value (J060)
-- Gerado por scripts/generate-ghpg-cap6-options.mjs — não editar à mão.

-- —— gh-transformation-aberrant-horror ——
INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, label, value_type, sort_order, unlock_level, depends_on_option_key)
SELECT 'feat'::rpg.option_scope, f.id, 'stage2Boon', 'Estágio 2 — bênção', 'catalog', 20, 2, NULL
FROM rpg.phb_feat f WHERE f.slug = 'gh-transformation-aberrant-horror'
ON CONFLICT (scope, owner_id, option_key) DO UPDATE SET
  label = EXCLUDED.label, unlock_level = EXCLUDED.unlock_level, depends_on_option_key = EXCLUDED.depends_on_option_key;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
SELECT 'feat'::rpg.option_scope, f.id, 'stage2Boon', v.value_id, v.label, v.sort_order
FROM rpg.phb_feat f
CROSS JOIN (VALUES
  ('efficient-killer', 'Efficient Killer', 1),
  ('writhing-tendrils', 'Writhing Tendrils', 2)
) AS v(value_id, label, sort_order)
WHERE f.slug = 'gh-transformation-aberrant-horror'
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label, sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, label, value_type, sort_order, unlock_level, depends_on_option_key)
SELECT 'feat'::rpg.option_scope, f.id, 'stage3Boon', 'Estágio 3 — bênção', 'catalog', 30, 3, NULL
FROM rpg.phb_feat f WHERE f.slug = 'gh-transformation-aberrant-horror'
ON CONFLICT (scope, owner_id, option_key) DO UPDATE SET
  label = EXCLUDED.label, unlock_level = EXCLUDED.unlock_level, depends_on_option_key = EXCLUDED.depends_on_option_key;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
SELECT 'feat'::rpg.option_scope, f.id, 'stage3Boon', v.value_id, v.label, v.sort_order
FROM rpg.phb_feat f
CROSS JOIN (VALUES
  ('terrifying-visage', 'Terrifying Visage', 1),
  ('constricting-tendrils', 'Constricting Tendrils', 2)
) AS v(value_id, label, sort_order)
WHERE f.slug = 'gh-transformation-aberrant-horror'
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label, sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, label, value_type, sort_order, unlock_level, depends_on_option_key)
SELECT 'feat'::rpg.option_scope, f.id, 'stage4Boon', 'Estágio 4 — bênção', 'catalog', 40, 4, NULL
FROM rpg.phb_feat f WHERE f.slug = 'gh-transformation-aberrant-horror'
ON CONFLICT (scope, owner_id, option_key) DO UPDATE SET
  label = EXCLUDED.label, unlock_level = EXCLUDED.unlock_level, depends_on_option_key = EXCLUDED.depends_on_option_key;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
SELECT 'feat'::rpg.option_scope, f.id, 'stage4Boon', v.value_id, v.label, v.sort_order
FROM rpg.phb_feat f
CROSS JOIN (VALUES
  ('eldritch-aberration', 'Eldritch Aberration', 1),
  ('poisonous-mutations', 'Poisonous Mutations', 2)
) AS v(value_id, label, sort_order)
WHERE f.slug = 'gh-transformation-aberrant-horror'
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label, sort_order = EXCLUDED.sort_order;

-- —— gh-transformation-fey ——
INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, label, value_type, sort_order, unlock_level, depends_on_option_key)
SELECT 'feat'::rpg.option_scope, f.id, 'stage1Boon', 'Estágio 1 — bênção', 'catalog', 10, 1, NULL
FROM rpg.phb_feat f WHERE f.slug = 'gh-transformation-fey'
ON CONFLICT (scope, owner_id, option_key) DO UPDATE SET
  label = EXCLUDED.label, unlock_level = EXCLUDED.unlock_level, depends_on_option_key = EXCLUDED.depends_on_option_key;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
SELECT 'feat'::rpg.option_scope, f.id, 'stage1Boon', v.value_id, v.label, v.sort_order
FROM rpg.phb_feat f
CROSS JOIN (VALUES
  ('servant-of-the-spring-court', 'Servant of the Spring Court', 1),
  ('servant-of-the-summer-court', 'Servant of the Summer Court', 2),
  ('servant-of-the-autumn-court', 'Servant of the Autumn Court', 3),
  ('servant-of-the-winter-court', 'Servant of the Winter Court', 4)
) AS v(value_id, label, sort_order)
WHERE f.slug = 'gh-transformation-fey'
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label, sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, label, value_type, sort_order, unlock_level, depends_on_option_key)
SELECT 'feat'::rpg.option_scope, f.id, 'stage2Boon', 'Estágio 2 — bênção', 'catalog', 20, 2, NULL
FROM rpg.phb_feat f WHERE f.slug = 'gh-transformation-fey'
ON CONFLICT (scope, owner_id, option_key) DO UPDATE SET
  label = EXCLUDED.label, unlock_level = EXCLUDED.unlock_level, depends_on_option_key = EXCLUDED.depends_on_option_key;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
SELECT 'feat'::rpg.option_scope, f.id, 'stage2Boon', v.value_id, v.label, v.sort_order
FROM rpg.phb_feat f
CROSS JOIN (VALUES
  ('two-faced', 'Two-Faced', 1),
  ('magic-tricks', 'Magic Tricks', 2)
) AS v(value_id, label, sort_order)
WHERE f.slug = 'gh-transformation-fey'
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label, sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, label, value_type, sort_order, unlock_level, depends_on_option_key)
SELECT 'feat'::rpg.option_scope, f.id, 'stage3Boon', 'Estágio 3 — bênção', 'catalog', 30, 3, NULL
FROM rpg.phb_feat f WHERE f.slug = 'gh-transformation-fey'
ON CONFLICT (scope, owner_id, option_key) DO UPDATE SET
  label = EXCLUDED.label, unlock_level = EXCLUDED.unlock_level, depends_on_option_key = EXCLUDED.depends_on_option_key;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
SELECT 'feat'::rpg.option_scope, f.id, 'stage3Boon', v.value_id, v.label, v.sort_order
FROM rpg.phb_feat f
CROSS JOIN (VALUES
  ('illusionary-cloak', 'Illusionary Cloak', 1),
  ('tooth-and-claw', 'Tooth and Claw', 2),
  ('dreams-and-nightmares', 'Dreams and Nightmares', 3)
) AS v(value_id, label, sort_order)
WHERE f.slug = 'gh-transformation-fey'
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label, sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, label, value_type, sort_order, unlock_level, depends_on_option_key)
SELECT 'feat'::rpg.option_scope, f.id, 'stage4Boon', 'Estágio 4 — bênção', 'catalog', 40, 4, NULL
FROM rpg.phb_feat f WHERE f.slug = 'gh-transformation-fey'
ON CONFLICT (scope, owner_id, option_key) DO UPDATE SET
  label = EXCLUDED.label, unlock_level = EXCLUDED.unlock_level, depends_on_option_key = EXCLUDED.depends_on_option_key;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
SELECT 'feat'::rpg.option_scope, f.id, 'stage4Boon', v.value_id, v.label, v.sort_order
FROM rpg.phb_feat f
CROSS JOIN (VALUES
  ('greater-magic-tricks', 'Greater Magic Tricks', 1),
  ('twilight-glamour', 'Twilight Glamour', 2)
) AS v(value_id, label, sort_order)
WHERE f.slug = 'gh-transformation-fey'
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label, sort_order = EXCLUDED.sort_order;

-- —— gh-transformation-fiend ——
INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, label, value_type, sort_order, unlock_level, depends_on_option_key)
SELECT 'feat'::rpg.option_scope, f.id, 'stage1Boon', 'Estágio 1 — bênção', 'catalog', 10, 1, NULL
FROM rpg.phb_feat f WHERE f.slug = 'gh-transformation-fiend'
ON CONFLICT (scope, owner_id, option_key) DO UPDATE SET
  label = EXCLUDED.label, unlock_level = EXCLUDED.unlock_level, depends_on_option_key = EXCLUDED.depends_on_option_key;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
SELECT 'feat'::rpg.option_scope, f.id, 'stage1Boon', v.value_id, v.label, v.sort_order
FROM rpg.phb_feat f
CROSS JOIN (VALUES
  ('devilish-contractor', 'Devilish Contractor', 1),
  ('infernal-smite', 'Infernal Smite', 2)
) AS v(value_id, label, sort_order)
WHERE f.slug = 'gh-transformation-fiend'
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label, sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, label, value_type, sort_order, unlock_level, depends_on_option_key)
SELECT 'feat'::rpg.option_scope, f.id, 'stage2Boon', 'Estágio 2 — bênção', 'catalog', 20, 2, NULL
FROM rpg.phb_feat f WHERE f.slug = 'gh-transformation-fiend'
ON CONFLICT (scope, owner_id, option_key) DO UPDATE SET
  label = EXCLUDED.label, unlock_level = EXCLUDED.unlock_level, depends_on_option_key = EXCLUDED.depends_on_option_key;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
SELECT 'feat'::rpg.option_scope, f.id, 'stage2Boon', v.value_id, v.label, v.sort_order
FROM rpg.phb_feat f
CROSS JOIN (VALUES
  ('daemonic-brand', 'Daemonic Brand', 1),
  ('enhanced-contract', 'Enhanced Contract', 2)
) AS v(value_id, label, sort_order)
WHERE f.slug = 'gh-transformation-fiend'
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label, sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, label, value_type, sort_order, unlock_level, depends_on_option_key)
SELECT 'feat'::rpg.option_scope, f.id, 'stage3Boon', 'Estágio 3 — bênção', 'catalog', 30, 3, NULL
FROM rpg.phb_feat f WHERE f.slug = 'gh-transformation-fiend'
ON CONFLICT (scope, owner_id, option_key) DO UPDATE SET
  label = EXCLUDED.label, unlock_level = EXCLUDED.unlock_level, depends_on_option_key = EXCLUDED.depends_on_option_key;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
SELECT 'feat'::rpg.option_scope, f.id, 'stage3Boon', v.value_id, v.label, v.sort_order
FROM rpg.phb_feat f
CROSS JOIN (VALUES
  ('devilish-subcontractor', 'Devilish Subcontractor', 1),
  ('overwhelming-brand', 'Overwhelming Brand', 2)
) AS v(value_id, label, sort_order)
WHERE f.slug = 'gh-transformation-fiend'
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label, sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, label, value_type, sort_order, unlock_level, depends_on_option_key)
SELECT 'feat'::rpg.option_scope, f.id, 'stage4Boon', 'Estágio 4 — bênção', 'catalog', 40, 4, NULL
FROM rpg.phb_feat f WHERE f.slug = 'gh-transformation-fiend'
ON CONFLICT (scope, owner_id, option_key) DO UPDATE SET
  label = EXCLUDED.label, unlock_level = EXCLUDED.unlock_level, depends_on_option_key = EXCLUDED.depends_on_option_key;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
SELECT 'feat'::rpg.option_scope, f.id, 'stage4Boon', v.value_id, v.label, v.sort_order
FROM rpg.phb_feat f
CROSS JOIN (VALUES
  ('abyssal-resistance', 'Abyssal Resistance', 1),
  ('infernal-summons', 'Infernal Summons', 2),
  ('ultimate-brand', 'Ultimate Brand', 3)
) AS v(value_id, label, sort_order)
WHERE f.slug = 'gh-transformation-fiend'
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label, sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, label, value_type, sort_order, unlock_level)
SELECT 'feat'::rpg.option_scope, f.id, 'fiendDamageType', 'fiendDamageType', 'catalog', 101, 1
FROM rpg.phb_feat f WHERE f.slug = 'gh-transformation-fiend'
ON CONFLICT (scope, owner_id, option_key) DO UPDATE SET unlock_level = EXCLUDED.unlock_level;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
SELECT 'feat'::rpg.option_scope, f.id, 'fiendDamageType', v.value_id, v.label, v.sort_order
FROM rpg.phb_feat f
CROSS JOIN (VALUES
  ('acid', 'Ácido', 1),
  ('cold', 'Frio', 2),
  ('fire', 'Fogo', 3)
) AS v(value_id, label, sort_order)
WHERE f.slug = 'gh-transformation-fiend'
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;

-- —— gh-transformation-hag ——
INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, label, value_type, sort_order, unlock_level, depends_on_option_key)
SELECT 'feat'::rpg.option_scope, f.id, 'stage1Boon', 'Estágio 1 — bênção', 'catalog', 10, 1, NULL
FROM rpg.phb_feat f WHERE f.slug = 'gh-transformation-hag'
ON CONFLICT (scope, owner_id, option_key) DO UPDATE SET
  label = EXCLUDED.label, unlock_level = EXCLUDED.unlock_level, depends_on_option_key = EXCLUDED.depends_on_option_key;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
SELECT 'feat'::rpg.option_scope, f.id, 'stage1Boon', v.value_id, v.label, v.sort_order
FROM rpg.phb_feat f
CROSS JOIN (VALUES
  ('the-green-sisterhood', 'The Green Sisterhood', 1),
  ('the-red-sisterhood', 'The Red Sisterhood', 2),
  ('the-sea-sisterhood', 'The Sea Sisterhood', 3)
) AS v(value_id, label, sort_order)
WHERE f.slug = 'gh-transformation-hag'
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label, sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, label, value_type, sort_order, unlock_level, depends_on_option_key)
SELECT 'feat'::rpg.option_scope, f.id, 'stage2Boon', 'Estágio 2 — bênção', 'catalog', 20, 2, NULL
FROM rpg.phb_feat f WHERE f.slug = 'gh-transformation-hag'
ON CONFLICT (scope, owner_id, option_key) DO UPDATE SET
  label = EXCLUDED.label, unlock_level = EXCLUDED.unlock_level, depends_on_option_key = EXCLUDED.depends_on_option_key;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
SELECT 'feat'::rpg.option_scope, f.id, 'stage2Boon', v.value_id, v.label, v.sort_order
FROM rpg.phb_feat f
CROSS JOIN (VALUES
  ('adept-of-the-green-sisterhood', 'Adept of the Green Sisterhood', 1),
  ('adept-of-the-red-sisterhood', 'Adept of the Red Sisterhood', 2),
  ('adept-of-the-sea-sisterhood', 'Adept of the Sea Sisterhood', 3)
) AS v(value_id, label, sort_order)
WHERE f.slug = 'gh-transformation-hag'
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label, sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, label, value_type, sort_order, unlock_level, depends_on_option_key)
SELECT 'feat'::rpg.option_scope, f.id, 'stage3Boon', 'Estágio 3 — bênção', 'catalog', 30, 3, NULL
FROM rpg.phb_feat f WHERE f.slug = 'gh-transformation-hag'
ON CONFLICT (scope, owner_id, option_key) DO UPDATE SET
  label = EXCLUDED.label, unlock_level = EXCLUDED.unlock_level, depends_on_option_key = EXCLUDED.depends_on_option_key;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
SELECT 'feat'::rpg.option_scope, f.id, 'stage3Boon', v.value_id, v.label, v.sort_order
FROM rpg.phb_feat f
CROSS JOIN (VALUES
  ('master-of-the-green-sisterhood', 'Master of the Green Sisterhood', 1),
  ('master-of-the-red-sisterhood', 'Master of the Red Sisterhood', 2),
  ('master-of-the-sea-sisterhood', 'Master of the Sea Sisterhood', 3)
) AS v(value_id, label, sort_order)
WHERE f.slug = 'gh-transformation-hag'
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label, sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, label, value_type, sort_order, unlock_level, depends_on_option_key)
SELECT 'feat'::rpg.option_scope, f.id, 'stage4Boon', 'Estágio 4 — bênção', 'catalog', 40, 4, NULL
FROM rpg.phb_feat f WHERE f.slug = 'gh-transformation-hag'
ON CONFLICT (scope, owner_id, option_key) DO UPDATE SET
  label = EXCLUDED.label, unlock_level = EXCLUDED.unlock_level, depends_on_option_key = EXCLUDED.depends_on_option_key;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
SELECT 'feat'::rpg.option_scope, f.id, 'stage4Boon', v.value_id, v.label, v.sort_order
FROM rpg.phb_feat f
CROSS JOIN (VALUES
  ('evil-eye', 'Evil Eye', 1),
  ('grandmothers-curse', 'Grandmother’s Curse', 2)
) AS v(value_id, label, sort_order)
WHERE f.slug = 'gh-transformation-hag'
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label, sort_order = EXCLUDED.sort_order;

-- —— gh-transformation-lich ——
INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, label, value_type, sort_order, unlock_level, depends_on_option_key)
SELECT 'feat'::rpg.option_scope, f.id, 'stage1Boon', 'Estágio 1 — bênção', 'catalog', 10, 1, NULL
FROM rpg.phb_feat f WHERE f.slug = 'gh-transformation-lich'
ON CONFLICT (scope, owner_id, option_key) DO UPDATE SET
  label = EXCLUDED.label, unlock_level = EXCLUDED.unlock_level, depends_on_option_key = EXCLUDED.depends_on_option_key;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
SELECT 'feat'::rpg.option_scope, f.id, 'stage1Boon', v.value_id, v.label, v.sort_order
FROM rpg.phb_feat f
CROSS JOIN (VALUES
  ('lich-magica', 'Lich Magica', 1),
  ('memori-lichdom', 'Memori Lichdom', 2)
) AS v(value_id, label, sort_order)
WHERE f.slug = 'gh-transformation-lich'
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label, sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, label, value_type, sort_order, unlock_level, depends_on_option_key)
SELECT 'feat'::rpg.option_scope, f.id, 'stage2Boon', 'Estágio 2 — bênção', 'catalog', 20, 2, NULL
FROM rpg.phb_feat f WHERE f.slug = 'gh-transformation-lich'
ON CONFLICT (scope, owner_id, option_key) DO UPDATE SET
  label = EXCLUDED.label, unlock_level = EXCLUDED.unlock_level, depends_on_option_key = EXCLUDED.depends_on_option_key;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
SELECT 'feat'::rpg.option_scope, f.id, 'stage2Boon', v.value_id, v.label, v.sort_order
FROM rpg.phb_feat f
CROSS JOIN (VALUES
  ('acolyte-of-undeath', 'Acolyte of Undeath', 1),
  ('binding-curse', 'Binding Curse', 2),
  ('corrupting-magic', 'Corrupting Magic', 3)
) AS v(value_id, label, sort_order)
WHERE f.slug = 'gh-transformation-lich'
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label, sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, label, value_type, sort_order, unlock_level, depends_on_option_key)
SELECT 'feat'::rpg.option_scope, f.id, 'stage3Boon', 'Estágio 3 — bênção', 'catalog', 30, 3, NULL
FROM rpg.phb_feat f WHERE f.slug = 'gh-transformation-lich'
ON CONFLICT (scope, owner_id, option_key) DO UPDATE SET
  label = EXCLUDED.label, unlock_level = EXCLUDED.unlock_level, depends_on_option_key = EXCLUDED.depends_on_option_key;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
SELECT 'feat'::rpg.option_scope, f.id, 'stage3Boon', v.value_id, v.label, v.sort_order
FROM rpg.phb_feat f
CROSS JOIN (VALUES
  ('eldritch-concentration', 'Eldritch Concentration', 1),
  ('master-of-undeath', 'Master of Undeath', 2),
  ('unholy-healing', 'Unholy Healing', 3)
) AS v(value_id, label, sort_order)
WHERE f.slug = 'gh-transformation-lich'
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label, sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, label, value_type, sort_order, unlock_level, depends_on_option_key)
SELECT 'feat'::rpg.option_scope, f.id, 'stage4Boon', 'Estágio 4 — bênção', 'catalog', 40, 4, NULL
FROM rpg.phb_feat f WHERE f.slug = 'gh-transformation-lich'
ON CONFLICT (scope, owner_id, option_key) DO UPDATE SET
  label = EXCLUDED.label, unlock_level = EXCLUDED.unlock_level, depends_on_option_key = EXCLUDED.depends_on_option_key;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
SELECT 'feat'::rpg.option_scope, f.id, 'stage4Boon', v.value_id, v.label, v.sort_order
FROM rpg.phb_feat f
CROSS JOIN (VALUES
  ('eldritch-omniscience', 'Eldritch Omniscience', 1),
  ('lord-of-undeath', 'Lord of Undeath', 2),
  ('soul-shattering-attack', 'Soul-Shattering Attack', 3)
) AS v(value_id, label, sort_order)
WHERE f.slug = 'gh-transformation-lich'
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label, sort_order = EXCLUDED.sort_order;

-- —— gh-transformation-lycanthrope ——
INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, label, value_type, sort_order, unlock_level, depends_on_option_key)
SELECT 'feat'::rpg.option_scope, f.id, 'stage1Boon', 'Estágio 1 — bênção', 'catalog', 10, 1, NULL
FROM rpg.phb_feat f WHERE f.slug = 'gh-transformation-lycanthrope'
ON CONFLICT (scope, owner_id, option_key) DO UPDATE SET
  label = EXCLUDED.label, unlock_level = EXCLUDED.unlock_level, depends_on_option_key = EXCLUDED.depends_on_option_key;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
SELECT 'feat'::rpg.option_scope, f.id, 'stage1Boon', v.value_id, v.label, v.sort_order
FROM rpg.phb_feat f
CROSS JOIN (VALUES
  ('hybrid-wolf-form', 'Hybrid Wolf Form', 1),
  ('hybrid-bear-form', 'Hybrid Bear Form', 2),
  ('hybrid-rat-form', 'Hybrid Rat Form', 3)
) AS v(value_id, label, sort_order)
WHERE f.slug = 'gh-transformation-lycanthrope'
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label, sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, label, value_type, sort_order, unlock_level, depends_on_option_key)
SELECT 'feat'::rpg.option_scope, f.id, 'stage2Boon', 'Estágio 2 — bênção', 'catalog', 20, 2, NULL
FROM rpg.phb_feat f WHERE f.slug = 'gh-transformation-lycanthrope'
ON CONFLICT (scope, owner_id, option_key) DO UPDATE SET
  label = EXCLUDED.label, unlock_level = EXCLUDED.unlock_level, depends_on_option_key = EXCLUDED.depends_on_option_key;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
SELECT 'feat'::rpg.option_scope, f.id, 'stage2Boon', v.value_id, v.label, v.sort_order
FROM rpg.phb_feat f
CROSS JOIN (VALUES
  ('hunters-focus', 'Hunter’s Focus', 1),
  ('iron-pelt', 'Iron Pelt', 2),
  ('kindred-form', 'Kindred Form', 3)
) AS v(value_id, label, sort_order)
WHERE f.slug = 'gh-transformation-lycanthrope'
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label, sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, label, value_type, sort_order, unlock_level, depends_on_option_key)
SELECT 'feat'::rpg.option_scope, f.id, 'stage3Boon', 'Estágio 3 — bênção', 'catalog', 30, 3, NULL
FROM rpg.phb_feat f WHERE f.slug = 'gh-transformation-lycanthrope'
ON CONFLICT (scope, owner_id, option_key) DO UPDATE SET
  label = EXCLUDED.label, unlock_level = EXCLUDED.unlock_level, depends_on_option_key = EXCLUDED.depends_on_option_key;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
SELECT 'feat'::rpg.option_scope, f.id, 'stage3Boon', v.value_id, v.label, v.sort_order
FROM rpg.phb_feat f
CROSS JOIN (VALUES
  ('bestial-vigor', 'Bestial Vigor', 1),
  ('shapeshifters-savagery', 'Shapeshifter’s Savagery', 2)
) AS v(value_id, label, sort_order)
WHERE f.slug = 'gh-transformation-lycanthrope'
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label, sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, label, value_type, sort_order, unlock_level, depends_on_option_key)
SELECT 'feat'::rpg.option_scope, f.id, 'stage4Boon', 'Estágio 4 — bênção', 'catalog', 40, 4, NULL
FROM rpg.phb_feat f WHERE f.slug = 'gh-transformation-lycanthrope'
ON CONFLICT (scope, owner_id, option_key) DO UPDATE SET
  label = EXCLUDED.label, unlock_level = EXCLUDED.unlock_level, depends_on_option_key = EXCLUDED.depends_on_option_key;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
SELECT 'feat'::rpg.option_scope, f.id, 'stage4Boon', v.value_id, v.label, v.sort_order
FROM rpg.phb_feat f
CROSS JOIN (VALUES
  ('hybrid-form-affinity', 'Hybrid Form Affinity', 1),
  ('savage-instincts', 'Savage Instincts', 2)
) AS v(value_id, label, sort_order)
WHERE f.slug = 'gh-transformation-lycanthrope'
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label, sort_order = EXCLUDED.sort_order;

-- —— gh-transformation-ooze ——
INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, label, value_type, sort_order, unlock_level, depends_on_option_key)
SELECT 'feat'::rpg.option_scope, f.id, 'stage1Boon', 'Estágio 1 — bênção', 'catalog', 10, 1, NULL
FROM rpg.phb_feat f WHERE f.slug = 'gh-transformation-ooze'
ON CONFLICT (scope, owner_id, option_key) DO UPDATE SET
  label = EXCLUDED.label, unlock_level = EXCLUDED.unlock_level, depends_on_option_key = EXCLUDED.depends_on_option_key;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
SELECT 'feat'::rpg.option_scope, f.id, 'stage1Boon', v.value_id, v.label, v.sort_order
FROM rpg.phb_feat f
CROSS JOIN (VALUES
  ('mutable-corpus', 'Mutable Corpus', 1),
  ('slimy-mien', 'Slimy Mien', 2)
) AS v(value_id, label, sort_order)
WHERE f.slug = 'gh-transformation-ooze'
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label, sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, label, value_type, sort_order, unlock_level, depends_on_option_key)
SELECT 'feat'::rpg.option_scope, f.id, 'stage2Boon', 'Estágio 2 — bênção', 'catalog', 20, 2, NULL
FROM rpg.phb_feat f WHERE f.slug = 'gh-transformation-ooze'
ON CONFLICT (scope, owner_id, option_key) DO UPDATE SET
  label = EXCLUDED.label, unlock_level = EXCLUDED.unlock_level, depends_on_option_key = EXCLUDED.depends_on_option_key;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
SELECT 'feat'::rpg.option_scope, f.id, 'stage2Boon', v.value_id, v.label, v.sort_order
FROM rpg.phb_feat f
CROSS JOIN (VALUES
  ('elastic-limbs', 'Elastic Limbs', 1),
  ('viscous-durability', 'Viscous Durability', 2)
) AS v(value_id, label, sort_order)
WHERE f.slug = 'gh-transformation-ooze'
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label, sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, label, value_type, sort_order, unlock_level, depends_on_option_key)
SELECT 'feat'::rpg.option_scope, f.id, 'stage3Boon', 'Estágio 3 — bênção', 'catalog', 30, 3, NULL
FROM rpg.phb_feat f WHERE f.slug = 'gh-transformation-ooze'
ON CONFLICT (scope, owner_id, option_key) DO UPDATE SET
  label = EXCLUDED.label, unlock_level = EXCLUDED.unlock_level, depends_on_option_key = EXCLUDED.depends_on_option_key;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
SELECT 'feat'::rpg.option_scope, f.id, 'stage3Boon', v.value_id, v.label, v.sort_order
FROM rpg.phb_feat f
CROSS JOIN (VALUES
  ('corrosive-membrane', 'Corrosive Membrane', 1),
  ('engulf', 'Engulf', 2)
) AS v(value_id, label, sort_order)
WHERE f.slug = 'gh-transformation-ooze'
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label, sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, label, value_type, sort_order, unlock_level, depends_on_option_key)
SELECT 'feat'::rpg.option_scope, f.id, 'stage4Boon', 'Estágio 4 — bênção', 'catalog', 40, 4, NULL
FROM rpg.phb_feat f WHERE f.slug = 'gh-transformation-ooze'
ON CONFLICT (scope, owner_id, option_key) DO UPDATE SET
  label = EXCLUDED.label, unlock_level = EXCLUDED.unlock_level, depends_on_option_key = EXCLUDED.depends_on_option_key;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
SELECT 'feat'::rpg.option_scope, f.id, 'stage4Boon', v.value_id, v.label, v.sort_order
FROM rpg.phb_feat f
CROSS JOIN (VALUES
  ('legion-of-slime', 'Legion of Slime', 1),
  ('mimic-object', 'Mimic Object', 2)
) AS v(value_id, label, sort_order)
WHERE f.slug = 'gh-transformation-ooze'
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label, sort_order = EXCLUDED.sort_order;

-- —— gh-transformation-primordial ——
INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, label, value_type, sort_order, unlock_level, depends_on_option_key)
SELECT 'feat'::rpg.option_scope, f.id, 'stage2Boon', 'Estágio 2 — bênção', 'catalog', 20, 2, NULL
FROM rpg.phb_feat f WHERE f.slug = 'gh-transformation-primordial'
ON CONFLICT (scope, owner_id, option_key) DO UPDATE SET
  label = EXCLUDED.label, unlock_level = EXCLUDED.unlock_level, depends_on_option_key = EXCLUDED.depends_on_option_key;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
SELECT 'feat'::rpg.option_scope, f.id, 'stage2Boon', v.value_id, v.label, v.sort_order
FROM rpg.phb_feat f
CROSS JOIN (VALUES
  ('dual-nature', 'Dual Nature', 1),
  ('elemental-surge', 'Elemental Surge', 2)
) AS v(value_id, label, sort_order)
WHERE f.slug = 'gh-transformation-primordial'
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label, sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, label, value_type, sort_order, unlock_level, depends_on_option_key)
SELECT 'feat'::rpg.option_scope, f.id, 'stage3Boon', 'Estágio 3 — bênção', 'catalog', 30, 3, NULL
FROM rpg.phb_feat f WHERE f.slug = 'gh-transformation-primordial'
ON CONFLICT (scope, owner_id, option_key) DO UPDATE SET
  label = EXCLUDED.label, unlock_level = EXCLUDED.unlock_level, depends_on_option_key = EXCLUDED.depends_on_option_key;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
SELECT 'feat'::rpg.option_scope, f.id, 'stage3Boon', v.value_id, v.label, v.sort_order
FROM rpg.phb_feat f
CROSS JOIN (VALUES
  ('aura-of-awakening', 'Aura of Awakening', 1),
  ('primeval-body', 'Primeval Body', 2),
  ('master-of-many', 'Master of Many', 3)
) AS v(value_id, label, sort_order)
WHERE f.slug = 'gh-transformation-primordial'
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label, sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, label, value_type, sort_order, unlock_level, depends_on_option_key)
SELECT 'feat'::rpg.option_scope, f.id, 'stage4Boon', 'Estágio 4 — bênção', 'catalog', 40, 4, NULL
FROM rpg.phb_feat f WHERE f.slug = 'gh-transformation-primordial'
ON CONFLICT (scope, owner_id, option_key) DO UPDATE SET
  label = EXCLUDED.label, unlock_level = EXCLUDED.unlock_level, depends_on_option_key = EXCLUDED.depends_on_option_key;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
SELECT 'feat'::rpg.option_scope, f.id, 'stage4Boon', v.value_id, v.label, v.sort_order
FROM rpg.phb_feat f
CROSS JOIN (VALUES
  ('primordial-aura', 'Primordial Aura', 1),
  ('elemental-mastery', 'Elemental Mastery', 2)
) AS v(value_id, label, sort_order)
WHERE f.slug = 'gh-transformation-primordial'
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label, sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, label, value_type, sort_order, unlock_level)
SELECT 'feat'::rpg.option_scope, f.id, 'elementalAffinity', 'elementalAffinity', 'catalog', 101, 1
FROM rpg.phb_feat f WHERE f.slug = 'gh-transformation-primordial'
ON CONFLICT (scope, owner_id, option_key) DO UPDATE SET unlock_level = EXCLUDED.unlock_level;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
SELECT 'feat'::rpg.option_scope, f.id, 'elementalAffinity', v.value_id, v.label, v.sort_order
FROM rpg.phb_feat f
CROSS JOIN (VALUES
  ('air', 'Ar', 1),
  ('earth', 'Terra', 2),
  ('fire', 'Fogo', 3),
  ('water', 'Água', 4)
) AS v(value_id, label, sort_order)
WHERE f.slug = 'gh-transformation-primordial'
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;

INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, label, value_type, sort_order, unlock_level)
SELECT 'feat'::rpg.option_scope, f.id, 'primordialDamageType', 'primordialDamageType', 'catalog', 103, 3
FROM rpg.phb_feat f WHERE f.slug = 'gh-transformation-primordial'
ON CONFLICT (scope, owner_id, option_key) DO UPDATE SET unlock_level = EXCLUDED.unlock_level;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
SELECT 'feat'::rpg.option_scope, f.id, 'primordialDamageType', v.value_id, v.label, v.sort_order
FROM rpg.phb_feat f
CROSS JOIN (VALUES
  ('bludgeoning', 'Contundente', 1),
  ('cold', 'Frio', 2),
  ('fire', 'Fogo', 3),
  ('lightning', 'Elétrico', 4)
) AS v(value_id, label, sort_order)
WHERE f.slug = 'gh-transformation-primordial'
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;

-- —— gh-transformation-seraph ——
INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, label, value_type, sort_order, unlock_level, depends_on_option_key)
SELECT 'feat'::rpg.option_scope, f.id, 'stage1Boon', 'Estágio 1 — bênção', 'catalog', 10, 1, NULL
FROM rpg.phb_feat f WHERE f.slug = 'gh-transformation-seraph'
ON CONFLICT (scope, owner_id, option_key) DO UPDATE SET
  label = EXCLUDED.label, unlock_level = EXCLUDED.unlock_level, depends_on_option_key = EXCLUDED.depends_on_option_key;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
SELECT 'feat'::rpg.option_scope, f.id, 'stage1Boon', v.value_id, v.label, v.sort_order
FROM rpg.phb_feat f
CROSS JOIN (VALUES
  ('angelic-wings', 'Angelic Wings', 1),
  ('holy-strikes', 'Holy Strikes', 2)
) AS v(value_id, label, sort_order)
WHERE f.slug = 'gh-transformation-seraph'
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label, sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, label, value_type, sort_order, unlock_level, depends_on_option_key)
SELECT 'feat'::rpg.option_scope, f.id, 'stage2Boon', 'Estágio 2 — bênção', 'catalog', 20, 2, NULL
FROM rpg.phb_feat f WHERE f.slug = 'gh-transformation-seraph'
ON CONFLICT (scope, owner_id, option_key) DO UPDATE SET
  label = EXCLUDED.label, unlock_level = EXCLUDED.unlock_level, depends_on_option_key = EXCLUDED.depends_on_option_key;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
SELECT 'feat'::rpg.option_scope, f.id, 'stage2Boon', v.value_id, v.label, v.sort_order
FROM rpg.phb_feat f
CROSS JOIN (VALUES
  ('divine-clemency', 'Divine Clemency', 1),
  ('sacred-retribution', 'Sacred Retribution', 2)
) AS v(value_id, label, sort_order)
WHERE f.slug = 'gh-transformation-seraph'
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label, sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, label, value_type, sort_order, unlock_level, depends_on_option_key)
SELECT 'feat'::rpg.option_scope, f.id, 'stage3Boon', 'Estágio 3 — bênção', 'catalog', 30, 3, NULL
FROM rpg.phb_feat f WHERE f.slug = 'gh-transformation-seraph'
ON CONFLICT (scope, owner_id, option_key) DO UPDATE SET
  label = EXCLUDED.label, unlock_level = EXCLUDED.unlock_level, depends_on_option_key = EXCLUDED.depends_on_option_key;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
SELECT 'feat'::rpg.option_scope, f.id, 'stage3Boon', v.value_id, v.label, v.sort_order
FROM rpg.phb_feat f
CROSS JOIN (VALUES
  ('cleanse-affliction', 'Cleanse Affliction', 1),
  ('protective-wings', 'Protective Wings', 2),
  ('bow-of-celestial-judgement', 'Bow of Celestial Judgement', 3)
) AS v(value_id, label, sort_order)
WHERE f.slug = 'gh-transformation-seraph'
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label, sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, label, value_type, sort_order, unlock_level, depends_on_option_key)
SELECT 'feat'::rpg.option_scope, f.id, 'stage4Boon', 'Estágio 4 — bênção', 'catalog', 40, 4, NULL
FROM rpg.phb_feat f WHERE f.slug = 'gh-transformation-seraph'
ON CONFLICT (scope, owner_id, option_key) DO UPDATE SET
  label = EXCLUDED.label, unlock_level = EXCLUDED.unlock_level, depends_on_option_key = EXCLUDED.depends_on_option_key;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
SELECT 'feat'::rpg.option_scope, f.id, 'stage4Boon', v.value_id, v.label, v.sort_order
FROM rpg.phb_feat f
CROSS JOIN (VALUES
  ('aura-of-holy-purge', 'Aura of Holy Purge', 1),
  ('aura-of-righteous-mercy', 'Aura of Righteous Mercy', 2),
  ('bow-of-celestial-domination', 'Bow of Celestial Domination', 3)
) AS v(value_id, label, sort_order)
WHERE f.slug = 'gh-transformation-seraph'
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label, sort_order = EXCLUDED.sort_order;

-- —— gh-transformation-shadowsteel-ghoul ——
INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, label, value_type, sort_order, unlock_level, depends_on_option_key)
SELECT 'feat'::rpg.option_scope, f.id, 'stage1Boon', 'Estágio 1 — bênção', 'catalog', 10, 1, NULL
FROM rpg.phb_feat f WHERE f.slug = 'gh-transformation-shadowsteel-ghoul'
ON CONFLICT (scope, owner_id, option_key) DO UPDATE SET
  label = EXCLUDED.label, unlock_level = EXCLUDED.unlock_level, depends_on_option_key = EXCLUDED.depends_on_option_key;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
SELECT 'feat'::rpg.option_scope, f.id, 'stage1Boon', v.value_id, v.label, v.sort_order
FROM rpg.phb_feat f
CROSS JOIN (VALUES
  ('shadowsteel-curser', 'Shadowsteel Curser', 1),
  ('shadowsteel-weapon', 'Shadowsteel Weapon', 2)
) AS v(value_id, label, sort_order)
WHERE f.slug = 'gh-transformation-shadowsteel-ghoul'
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label, sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, label, value_type, sort_order, unlock_level, depends_on_option_key)
SELECT 'feat'::rpg.option_scope, f.id, 'stage2Boon', 'Estágio 2 — bênção', 'catalog', 20, 2, NULL
FROM rpg.phb_feat f WHERE f.slug = 'gh-transformation-shadowsteel-ghoul'
ON CONFLICT (scope, owner_id, option_key) DO UPDATE SET
  label = EXCLUDED.label, unlock_level = EXCLUDED.unlock_level, depends_on_option_key = EXCLUDED.depends_on_option_key;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
SELECT 'feat'::rpg.option_scope, f.id, 'stage2Boon', v.value_id, v.label, v.sort_order
FROM rpg.phb_feat f
CROSS JOIN (VALUES
  ('magic-resistance', 'Magic Resistance', 1),
  ('shadowsteel-absorption', 'Shadowsteel Absorption', 2),
  ('shadowsteel-caster', 'Shadowsteel Caster', 3),
  ('shadowsteel-weapon-master', 'Shadowsteel Weapon Master', 4)
) AS v(value_id, label, sort_order)
WHERE f.slug = 'gh-transformation-shadowsteel-ghoul'
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label, sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, label, value_type, sort_order, unlock_level, depends_on_option_key)
SELECT 'feat'::rpg.option_scope, f.id, 'stage2Boon2', 'Estágio 2 — bênção', 'catalog', 21, 2, NULL
FROM rpg.phb_feat f WHERE f.slug = 'gh-transformation-shadowsteel-ghoul'
ON CONFLICT (scope, owner_id, option_key) DO UPDATE SET
  label = EXCLUDED.label, unlock_level = EXCLUDED.unlock_level, depends_on_option_key = EXCLUDED.depends_on_option_key;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
SELECT 'feat'::rpg.option_scope, f.id, 'stage2Boon2', v.value_id, v.label, v.sort_order
FROM rpg.phb_feat f
CROSS JOIN (VALUES
  ('magic-resistance', 'Magic Resistance', 1),
  ('shadowsteel-absorption', 'Shadowsteel Absorption', 2),
  ('shadowsteel-caster', 'Shadowsteel Caster', 3),
  ('shadowsteel-weapon-master', 'Shadowsteel Weapon Master', 4)
) AS v(value_id, label, sort_order)
WHERE f.slug = 'gh-transformation-shadowsteel-ghoul'
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label, sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, label, value_type, sort_order, unlock_level, depends_on_option_key)
SELECT 'feat'::rpg.option_scope, f.id, 'stage4Boon', 'Estágio 4 — bênção', 'catalog', 40, 4, NULL
FROM rpg.phb_feat f WHERE f.slug = 'gh-transformation-shadowsteel-ghoul'
ON CONFLICT (scope, owner_id, option_key) DO UPDATE SET
  label = EXCLUDED.label, unlock_level = EXCLUDED.unlock_level, depends_on_option_key = EXCLUDED.depends_on_option_key;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
SELECT 'feat'::rpg.option_scope, f.id, 'stage4Boon', v.value_id, v.label, v.sort_order
FROM rpg.phb_feat f
CROSS JOIN (VALUES
  ('shadowsteel-arcane-vessel', 'Shadowsteel Arcane Vessel', 1),
  ('shadowsteel-fury', 'Shadowsteel Fury', 2)
) AS v(value_id, label, sort_order)
WHERE f.slug = 'gh-transformation-shadowsteel-ghoul'
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label, sort_order = EXCLUDED.sort_order;

-- —— gh-transformation-specter ——
INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, label, value_type, sort_order, unlock_level, depends_on_option_key)
SELECT 'feat'::rpg.option_scope, f.id, 'stage1Boon', 'Estágio 1 — bênção', 'catalog', 10, 1, NULL
FROM rpg.phb_feat f WHERE f.slug = 'gh-transformation-specter'
ON CONFLICT (scope, owner_id, option_key) DO UPDATE SET
  label = EXCLUDED.label, unlock_level = EXCLUDED.unlock_level, depends_on_option_key = EXCLUDED.depends_on_option_key;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
SELECT 'feat'::rpg.option_scope, f.id, 'stage1Boon', v.value_id, v.label, v.sort_order
FROM rpg.phb_feat f
CROSS JOIN (VALUES
  ('ghastly-touch', 'Ghastly Touch', 1),
  ('incorporeal-movement', 'Incorporeal Movement', 2)
) AS v(value_id, label, sort_order)
WHERE f.slug = 'gh-transformation-specter'
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label, sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, label, value_type, sort_order, unlock_level, depends_on_option_key)
SELECT 'feat'::rpg.option_scope, f.id, 'stage2Boon', 'Estágio 2 — bênção', 'catalog', 20, 2, NULL
FROM rpg.phb_feat f WHERE f.slug = 'gh-transformation-specter'
ON CONFLICT (scope, owner_id, option_key) DO UPDATE SET
  label = EXCLUDED.label, unlock_level = EXCLUDED.unlock_level, depends_on_option_key = EXCLUDED.depends_on_option_key;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
SELECT 'feat'::rpg.option_scope, f.id, 'stage2Boon', v.value_id, v.label, v.sort_order
FROM rpg.phb_feat f
CROSS JOIN (VALUES
  ('ethereal-phasing', 'Ethereal Phasing', 1),
  ('haunting-flight', 'Haunting Flight', 2)
) AS v(value_id, label, sort_order)
WHERE f.slug = 'gh-transformation-specter'
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label, sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, label, value_type, sort_order, unlock_level, depends_on_option_key)
SELECT 'feat'::rpg.option_scope, f.id, 'stage3Boon', 'Estágio 3 — bênção', 'catalog', 30, 3, NULL
FROM rpg.phb_feat f WHERE f.slug = 'gh-transformation-specter'
ON CONFLICT (scope, owner_id, option_key) DO UPDATE SET
  label = EXCLUDED.label, unlock_level = EXCLUDED.unlock_level, depends_on_option_key = EXCLUDED.depends_on_option_key;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
SELECT 'feat'::rpg.option_scope, f.id, 'stage3Boon', v.value_id, v.label, v.sort_order
FROM rpg.phb_feat f
CROSS JOIN (VALUES
  ('draining-flight', 'Draining Flight', 1),
  ('paralyzing-touch', 'Paralyzing Touch', 2)
) AS v(value_id, label, sort_order)
WHERE f.slug = 'gh-transformation-specter'
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label, sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, label, value_type, sort_order, unlock_level, depends_on_option_key)
SELECT 'feat'::rpg.option_scope, f.id, 'stage4Boon', 'Estágio 4 — bênção', 'catalog', 40, 4, NULL
FROM rpg.phb_feat f WHERE f.slug = 'gh-transformation-specter'
ON CONFLICT (scope, owner_id, option_key) DO UPDATE SET
  label = EXCLUDED.label, unlock_level = EXCLUDED.unlock_level, depends_on_option_key = EXCLUDED.depends_on_option_key;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
SELECT 'feat'::rpg.option_scope, f.id, 'stage4Boon', v.value_id, v.label, v.sort_order
FROM rpg.phb_feat f
CROSS JOIN (VALUES
  ('call-of-unmaking', 'Call of Unmaking', 1),
  ('possession', 'Possession', 2)
) AS v(value_id, label, sort_order)
WHERE f.slug = 'gh-transformation-specter'
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label, sort_order = EXCLUDED.sort_order;

-- —— gh-transformation-vampire ——
INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, label, value_type, sort_order, unlock_level, depends_on_option_key)
SELECT 'feat'::rpg.option_scope, f.id, 'stage1Boon', 'Estágio 1 — bênção', 'catalog', 10, 1, NULL
FROM rpg.phb_feat f WHERE f.slug = 'gh-transformation-vampire'
ON CONFLICT (scope, owner_id, option_key) DO UPDATE SET
  label = EXCLUDED.label, unlock_level = EXCLUDED.unlock_level, depends_on_option_key = EXCLUDED.depends_on_option_key;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
SELECT 'feat'::rpg.option_scope, f.id, 'stage1Boon', v.value_id, v.label, v.sort_order
FROM rpg.phb_feat f
CROSS JOIN (VALUES
  ('soman-bloodline', 'Soman Bloodline', 1),
  ('fzeg-bloodline', 'Fzeg Bloodline', 2),
  ('strigoi-bloodline', 'Strigoi Bloodline', 3)
) AS v(value_id, label, sort_order)
WHERE f.slug = 'gh-transformation-vampire'
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label, sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, label, value_type, sort_order, unlock_level, depends_on_option_key)
SELECT 'feat'::rpg.option_scope, f.id, 'stage2Boon', 'Estágio 2 — bênção', 'catalog', 20, 2, NULL
FROM rpg.phb_feat f WHERE f.slug = 'gh-transformation-vampire'
ON CONFLICT (scope, owner_id, option_key) DO UPDATE SET
  label = EXCLUDED.label, unlock_level = EXCLUDED.unlock_level, depends_on_option_key = EXCLUDED.depends_on_option_key;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
SELECT 'feat'::rpg.option_scope, f.id, 'stage2Boon', v.value_id, v.label, v.sort_order
FROM rpg.phb_feat f
CROSS JOIN (VALUES
  ('eyes-of-the-night', 'Eyes of the Night', 1),
  ('grave-touched-soul', 'Grave-Touched Soul', 2),
  ('inhuman-reflexes', 'Inhuman Reflexes', 3),
  ('undead-resilience', 'Undead Resilience', 4)
) AS v(value_id, label, sort_order)
WHERE f.slug = 'gh-transformation-vampire'
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label, sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, label, value_type, sort_order, unlock_level, depends_on_option_key)
SELECT 'feat'::rpg.option_scope, f.id, 'stage2Boon2', 'Estágio 2 — bênção', 'catalog', 21, 2, NULL
FROM rpg.phb_feat f WHERE f.slug = 'gh-transformation-vampire'
ON CONFLICT (scope, owner_id, option_key) DO UPDATE SET
  label = EXCLUDED.label, unlock_level = EXCLUDED.unlock_level, depends_on_option_key = EXCLUDED.depends_on_option_key;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
SELECT 'feat'::rpg.option_scope, f.id, 'stage2Boon2', v.value_id, v.label, v.sort_order
FROM rpg.phb_feat f
CROSS JOIN (VALUES
  ('eyes-of-the-night', 'Eyes of the Night', 1),
  ('grave-touched-soul', 'Grave-Touched Soul', 2),
  ('inhuman-reflexes', 'Inhuman Reflexes', 3),
  ('undead-resilience', 'Undead Resilience', 4)
) AS v(value_id, label, sort_order)
WHERE f.slug = 'gh-transformation-vampire'
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label, sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, label, value_type, sort_order, unlock_level, depends_on_option_key)
SELECT 'feat'::rpg.option_scope, f.id, 'stage3Boon', 'Estágio 3 — bênção', 'catalog', 30, 3, NULL
FROM rpg.phb_feat f WHERE f.slug = 'gh-transformation-vampire'
ON CONFLICT (scope, owner_id, option_key) DO UPDATE SET
  label = EXCLUDED.label, unlock_level = EXCLUDED.unlock_level, depends_on_option_key = EXCLUDED.depends_on_option_key;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
SELECT 'feat'::rpg.option_scope, f.id, 'stage3Boon', v.value_id, v.label, v.sort_order
FROM rpg.phb_feat f
CROSS JOIN (VALUES
  ('beguilers-charm', 'Beguiler’s Charm', 1),
  ('improved-fanged-bite', 'Improved Fanged Bite', 2),
  ('mist-form', 'Mist Form', 3),
  ('sangromancy-specialist', 'Sangromancy Specialist', 4)
) AS v(value_id, label, sort_order)
WHERE f.slug = 'gh-transformation-vampire'
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label, sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, label, value_type, sort_order, unlock_level, depends_on_option_key)
SELECT 'feat'::rpg.option_scope, f.id, 'stage3Boon2', 'Estágio 3 — bênção', 'catalog', 31, 3, NULL
FROM rpg.phb_feat f WHERE f.slug = 'gh-transformation-vampire'
ON CONFLICT (scope, owner_id, option_key) DO UPDATE SET
  label = EXCLUDED.label, unlock_level = EXCLUDED.unlock_level, depends_on_option_key = EXCLUDED.depends_on_option_key;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
SELECT 'feat'::rpg.option_scope, f.id, 'stage3Boon2', v.value_id, v.label, v.sort_order
FROM rpg.phb_feat f
CROSS JOIN (VALUES
  ('beguilers-charm', 'Beguiler’s Charm', 1),
  ('improved-fanged-bite', 'Improved Fanged Bite', 2),
  ('mist-form', 'Mist Form', 3),
  ('sangromancy-specialist', 'Sangromancy Specialist', 4)
) AS v(value_id, label, sort_order)
WHERE f.slug = 'gh-transformation-vampire'
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label, sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, label, value_type, sort_order, unlock_level, depends_on_option_key)
SELECT 'feat'::rpg.option_scope, f.id, 'stage4Boon', 'Estágio 4 — bênção', 'catalog', 40, 4, 'stage1Boon'
FROM rpg.phb_feat f WHERE f.slug = 'gh-transformation-vampire'
ON CONFLICT (scope, owner_id, option_key) DO UPDATE SET
  label = EXCLUDED.label, unlock_level = EXCLUDED.unlock_level, depends_on_option_key = EXCLUDED.depends_on_option_key;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
SELECT 'feat'::rpg.option_scope, f.id, 'stage4Boon', v.value_id, v.label, v.sort_order
FROM rpg.phb_feat f
CROSS JOIN (VALUES
  ('final-soman-bloodline', 'Final Soman Bloodline', 1),
  ('final-fzeg-bloodline', 'Final Fzeg Bloodline', 2),
  ('final-strigoi-bloodline', 'Final Strigoi Bloodline', 3)
) AS v(value_id, label, sort_order)
WHERE f.slug = 'gh-transformation-vampire'
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label, sort_order = EXCLUDED.sort_order;

