-- Cap.6 — choice rules (SSOT; gerado por scripts/generate/cap6-choice-rules-seed.mjs)

-- —— gh-transformation-aberrant-horror ——
WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-aberrant-horror')
, stage_1 AS (
  INSERT INTO rpg.phb_transformation_stage_rule (feat_id, stage, mode)
  SELECT feat.id, 1, 'auto_all'::rpg.transformation_stage_mode
  FROM feat
  ON CONFLICT (feat_id, stage) DO UPDATE SET mode = EXCLUDED.mode
  RETURNING id
)
, auto_1_0 AS (
  INSERT INTO rpg.phb_transformation_stage_auto_boon (stage_rule_id, boon_id, sort_order)
  SELECT stage_1.id, 'aberrant-form', 0
  FROM stage_1
  ON CONFLICT (stage_rule_id, boon_id) DO UPDATE SET sort_order = EXCLUDED.sort_order
  RETURNING stage_rule_id
)
, auto_1_1 AS (
  INSERT INTO rpg.phb_transformation_stage_auto_boon (stage_rule_id, boon_id, sort_order)
  SELECT stage_1.id, 'aberrant-mutation', 1
  FROM stage_1
  ON CONFLICT (stage_rule_id, boon_id) DO UPDATE SET sort_order = EXCLUDED.sort_order
  RETURNING stage_rule_id
)
, stage_2 AS (
  INSERT INTO rpg.phb_transformation_stage_rule (feat_id, stage, mode)
  SELECT feat.id, 2, 'pick1'::rpg.transformation_stage_mode
  FROM feat
  ON CONFLICT (feat_id, stage) DO UPDATE SET mode = EXCLUDED.mode
  RETURNING id
)
, pick_2_0 AS (
  INSERT INTO rpg.phb_transformation_stage_pick_key (stage_rule_id, pick_key, sort_order)
  SELECT stage_2.id, 'stage2Boon', 0
  FROM stage_2
  ON CONFLICT (stage_rule_id, pick_key) DO UPDATE SET sort_order = EXCLUDED.sort_order
  RETURNING stage_rule_id
)
, stage_3 AS (
  INSERT INTO rpg.phb_transformation_stage_rule (feat_id, stage, mode)
  SELECT feat.id, 3, 'pick1'::rpg.transformation_stage_mode
  FROM feat
  ON CONFLICT (feat_id, stage) DO UPDATE SET mode = EXCLUDED.mode
  RETURNING id
)
, pick_3_0 AS (
  INSERT INTO rpg.phb_transformation_stage_pick_key (stage_rule_id, pick_key, sort_order)
  SELECT stage_3.id, 'stage3Boon', 0
  FROM stage_3
  ON CONFLICT (stage_rule_id, pick_key) DO UPDATE SET sort_order = EXCLUDED.sort_order
  RETURNING stage_rule_id
)
, stage_4 AS (
  INSERT INTO rpg.phb_transformation_stage_rule (feat_id, stage, mode)
  SELECT feat.id, 4, 'pick1'::rpg.transformation_stage_mode
  FROM feat
  ON CONFLICT (feat_id, stage) DO UPDATE SET mode = EXCLUDED.mode
  RETURNING id
)
, pick_4_0 AS (
  INSERT INTO rpg.phb_transformation_stage_pick_key (stage_rule_id, pick_key, sort_order)
  SELECT stage_4.id, 'stage4Boon', 0
  FROM stage_4
  ON CONFLICT (stage_rule_id, pick_key) DO UPDATE SET sort_order = EXCLUDED.sort_order
  RETURNING stage_rule_id
)
SELECT 1 FROM feat;

-- —— gh-transformation-fey ——
WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fey')
, stage_1 AS (
  INSERT INTO rpg.phb_transformation_stage_rule (feat_id, stage, mode)
  SELECT feat.id, 1, 'fixed_plus_pick1'::rpg.transformation_stage_mode
  FROM feat
  ON CONFLICT (feat_id, stage) DO UPDATE SET mode = EXCLUDED.mode
  RETURNING id
)
, auto_1_0 AS (
  INSERT INTO rpg.phb_transformation_stage_auto_boon (stage_rule_id, boon_id, sort_order)
  SELECT stage_1.id, 'fey-form', 0
  FROM stage_1
  ON CONFLICT (stage_rule_id, boon_id) DO UPDATE SET sort_order = EXCLUDED.sort_order
  RETURNING stage_rule_id
)
, pick_1_0 AS (
  INSERT INTO rpg.phb_transformation_stage_pick_key (stage_rule_id, pick_key, sort_order)
  SELECT stage_1.id, 'stage1Boon', 0
  FROM stage_1
  ON CONFLICT (stage_rule_id, pick_key) DO UPDATE SET sort_order = EXCLUDED.sort_order
  RETURNING stage_rule_id
)
, stage_2 AS (
  INSERT INTO rpg.phb_transformation_stage_rule (feat_id, stage, mode)
  SELECT feat.id, 2, 'pick1'::rpg.transformation_stage_mode
  FROM feat
  ON CONFLICT (feat_id, stage) DO UPDATE SET mode = EXCLUDED.mode
  RETURNING id
)
, pick_2_0 AS (
  INSERT INTO rpg.phb_transformation_stage_pick_key (stage_rule_id, pick_key, sort_order)
  SELECT stage_2.id, 'stage2Boon', 0
  FROM stage_2
  ON CONFLICT (stage_rule_id, pick_key) DO UPDATE SET sort_order = EXCLUDED.sort_order
  RETURNING stage_rule_id
)
, stage_3 AS (
  INSERT INTO rpg.phb_transformation_stage_rule (feat_id, stage, mode)
  SELECT feat.id, 3, 'pick1'::rpg.transformation_stage_mode
  FROM feat
  ON CONFLICT (feat_id, stage) DO UPDATE SET mode = EXCLUDED.mode
  RETURNING id
)
, pick_3_0 AS (
  INSERT INTO rpg.phb_transformation_stage_pick_key (stage_rule_id, pick_key, sort_order)
  SELECT stage_3.id, 'stage3Boon', 0
  FROM stage_3
  ON CONFLICT (stage_rule_id, pick_key) DO UPDATE SET sort_order = EXCLUDED.sort_order
  RETURNING stage_rule_id
)
, stage_4 AS (
  INSERT INTO rpg.phb_transformation_stage_rule (feat_id, stage, mode)
  SELECT feat.id, 4, 'pick1'::rpg.transformation_stage_mode
  FROM feat
  ON CONFLICT (feat_id, stage) DO UPDATE SET mode = EXCLUDED.mode
  RETURNING id
)
, pick_4_0 AS (
  INSERT INTO rpg.phb_transformation_stage_pick_key (stage_rule_id, pick_key, sort_order)
  SELECT stage_4.id, 'stage4Boon', 0
  FROM stage_4
  ON CONFLICT (stage_rule_id, pick_key) DO UPDATE SET sort_order = EXCLUDED.sort_order
  RETURNING stage_rule_id
)
SELECT 1 FROM feat;

-- —— gh-transformation-fiend ——
WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fiend')
, stage_1 AS (
  INSERT INTO rpg.phb_transformation_stage_rule (feat_id, stage, mode)
  SELECT feat.id, 1, 'fixed_plus_pick1'::rpg.transformation_stage_mode
  FROM feat
  ON CONFLICT (feat_id, stage) DO UPDATE SET mode = EXCLUDED.mode
  RETURNING id
)
, auto_1_0 AS (
  INSERT INTO rpg.phb_transformation_stage_auto_boon (stage_rule_id, boon_id, sort_order)
  SELECT stage_1.id, 'fiendish-soul', 0
  FROM stage_1
  ON CONFLICT (stage_rule_id, boon_id) DO UPDATE SET sort_order = EXCLUDED.sort_order
  RETURNING stage_rule_id
)
, pick_1_0 AS (
  INSERT INTO rpg.phb_transformation_stage_pick_key (stage_rule_id, pick_key, sort_order)
  SELECT stage_1.id, 'stage1Boon', 0
  FROM stage_1
  ON CONFLICT (stage_rule_id, pick_key) DO UPDATE SET sort_order = EXCLUDED.sort_order
  RETURNING stage_rule_id
)
, stage_2 AS (
  INSERT INTO rpg.phb_transformation_stage_rule (feat_id, stage, mode)
  SELECT feat.id, 2, 'pick1'::rpg.transformation_stage_mode
  FROM feat
  ON CONFLICT (feat_id, stage) DO UPDATE SET mode = EXCLUDED.mode
  RETURNING id
)
, pick_2_0 AS (
  INSERT INTO rpg.phb_transformation_stage_pick_key (stage_rule_id, pick_key, sort_order)
  SELECT stage_2.id, 'stage2Boon', 0
  FROM stage_2
  ON CONFLICT (stage_rule_id, pick_key) DO UPDATE SET sort_order = EXCLUDED.sort_order
  RETURNING stage_rule_id
)
, stage_3 AS (
  INSERT INTO rpg.phb_transformation_stage_rule (feat_id, stage, mode)
  SELECT feat.id, 3, 'pick1'::rpg.transformation_stage_mode
  FROM feat
  ON CONFLICT (feat_id, stage) DO UPDATE SET mode = EXCLUDED.mode
  RETURNING id
)
, pick_3_0 AS (
  INSERT INTO rpg.phb_transformation_stage_pick_key (stage_rule_id, pick_key, sort_order)
  SELECT stage_3.id, 'stage3Boon', 0
  FROM stage_3
  ON CONFLICT (stage_rule_id, pick_key) DO UPDATE SET sort_order = EXCLUDED.sort_order
  RETURNING stage_rule_id
)
, stage_4 AS (
  INSERT INTO rpg.phb_transformation_stage_rule (feat_id, stage, mode)
  SELECT feat.id, 4, 'pick1'::rpg.transformation_stage_mode
  FROM feat
  ON CONFLICT (feat_id, stage) DO UPDATE SET mode = EXCLUDED.mode
  RETURNING id
)
, pick_4_0 AS (
  INSERT INTO rpg.phb_transformation_stage_pick_key (stage_rule_id, pick_key, sort_order)
  SELECT stage_4.id, 'stage4Boon', 0
  FROM stage_4
  ON CONFLICT (stage_rule_id, pick_key) DO UPDATE SET sort_order = EXCLUDED.sort_order
  RETURNING stage_rule_id
)
, sub_0 AS (
  INSERT INTO rpg.phb_transformation_sub_option (
    feat_id, option_key, from_stage, when_choice_key, when_choice_value
  )
  SELECT feat.id, 'fiendDamageType', 1, NULL, NULL
  FROM feat
  ON CONFLICT (feat_id, option_key) DO UPDATE SET
    from_stage = EXCLUDED.from_stage,
    when_choice_key = EXCLUDED.when_choice_key,
    when_choice_value = EXCLUDED.when_choice_value
  RETURNING id
)
SELECT 1 FROM feat;

-- —— gh-transformation-hag ——
WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-hag')
, stage_1 AS (
  INSERT INTO rpg.phb_transformation_stage_rule (feat_id, stage, mode)
  SELECT feat.id, 1, 'fixed_plus_pick1'::rpg.transformation_stage_mode
  FROM feat
  ON CONFLICT (feat_id, stage) DO UPDATE SET mode = EXCLUDED.mode
  RETURNING id
)
, auto_1_0 AS (
  INSERT INTO rpg.phb_transformation_stage_auto_boon (stage_rule_id, boon_id, sort_order)
  SELECT stage_1.id, 'hag-form', 0
  FROM stage_1
  ON CONFLICT (stage_rule_id, boon_id) DO UPDATE SET sort_order = EXCLUDED.sort_order
  RETURNING stage_rule_id
)
, pick_1_0 AS (
  INSERT INTO rpg.phb_transformation_stage_pick_key (stage_rule_id, pick_key, sort_order)
  SELECT stage_1.id, 'stage1Boon', 0
  FROM stage_1
  ON CONFLICT (stage_rule_id, pick_key) DO UPDATE SET sort_order = EXCLUDED.sort_order
  RETURNING stage_rule_id
)
, stage_2 AS (
  INSERT INTO rpg.phb_transformation_stage_rule (feat_id, stage, mode)
  SELECT feat.id, 2, 'pick1'::rpg.transformation_stage_mode
  FROM feat
  ON CONFLICT (feat_id, stage) DO UPDATE SET mode = EXCLUDED.mode
  RETURNING id
)
, pick_2_0 AS (
  INSERT INTO rpg.phb_transformation_stage_pick_key (stage_rule_id, pick_key, sort_order)
  SELECT stage_2.id, 'stage2Boon', 0
  FROM stage_2
  ON CONFLICT (stage_rule_id, pick_key) DO UPDATE SET sort_order = EXCLUDED.sort_order
  RETURNING stage_rule_id
)
, stage_3 AS (
  INSERT INTO rpg.phb_transformation_stage_rule (feat_id, stage, mode)
  SELECT feat.id, 3, 'pick1'::rpg.transformation_stage_mode
  FROM feat
  ON CONFLICT (feat_id, stage) DO UPDATE SET mode = EXCLUDED.mode
  RETURNING id
)
, pick_3_0 AS (
  INSERT INTO rpg.phb_transformation_stage_pick_key (stage_rule_id, pick_key, sort_order)
  SELECT stage_3.id, 'stage3Boon', 0
  FROM stage_3
  ON CONFLICT (stage_rule_id, pick_key) DO UPDATE SET sort_order = EXCLUDED.sort_order
  RETURNING stage_rule_id
)
, stage_4 AS (
  INSERT INTO rpg.phb_transformation_stage_rule (feat_id, stage, mode)
  SELECT feat.id, 4, 'pick1'::rpg.transformation_stage_mode
  FROM feat
  ON CONFLICT (feat_id, stage) DO UPDATE SET mode = EXCLUDED.mode
  RETURNING id
)
, pick_4_0 AS (
  INSERT INTO rpg.phb_transformation_stage_pick_key (stage_rule_id, pick_key, sort_order)
  SELECT stage_4.id, 'stage4Boon', 0
  FROM stage_4
  ON CONFLICT (stage_rule_id, pick_key) DO UPDATE SET sort_order = EXCLUDED.sort_order
  RETURNING stage_rule_id
)
, match_0 AS (
  INSERT INTO rpg.phb_transformation_require_match (feat_id, later_key, earlier_key)
  SELECT feat.id, 'stage2Boon', 'stage1Boon'
  FROM feat
  ON CONFLICT (feat_id, later_key, earlier_key) DO UPDATE SET later_key = EXCLUDED.later_key
  RETURNING id
)
, match_0_pair_0 AS (
  INSERT INTO rpg.phb_transformation_require_match_pair (match_id, earlier_value, later_value)
  SELECT match_0.id, 'the-green-sisterhood', 'adept-of-the-green-sisterhood'
  FROM match_0
  ON CONFLICT (match_id, earlier_value) DO UPDATE SET later_value = EXCLUDED.later_value
  RETURNING match_id
)
, match_0_pair_1 AS (
  INSERT INTO rpg.phb_transformation_require_match_pair (match_id, earlier_value, later_value)
  SELECT match_0.id, 'the-red-sisterhood', 'adept-of-the-red-sisterhood'
  FROM match_0
  ON CONFLICT (match_id, earlier_value) DO UPDATE SET later_value = EXCLUDED.later_value
  RETURNING match_id
)
, match_0_pair_2 AS (
  INSERT INTO rpg.phb_transformation_require_match_pair (match_id, earlier_value, later_value)
  SELECT match_0.id, 'the-sea-sisterhood', 'adept-of-the-sea-sisterhood'
  FROM match_0
  ON CONFLICT (match_id, earlier_value) DO UPDATE SET later_value = EXCLUDED.later_value
  RETURNING match_id
)
, match_1 AS (
  INSERT INTO rpg.phb_transformation_require_match (feat_id, later_key, earlier_key)
  SELECT feat.id, 'stage3Boon', 'stage1Boon'
  FROM feat
  ON CONFLICT (feat_id, later_key, earlier_key) DO UPDATE SET later_key = EXCLUDED.later_key
  RETURNING id
)
, match_1_pair_0 AS (
  INSERT INTO rpg.phb_transformation_require_match_pair (match_id, earlier_value, later_value)
  SELECT match_1.id, 'the-green-sisterhood', 'master-of-the-green-sisterhood'
  FROM match_1
  ON CONFLICT (match_id, earlier_value) DO UPDATE SET later_value = EXCLUDED.later_value
  RETURNING match_id
)
, match_1_pair_1 AS (
  INSERT INTO rpg.phb_transformation_require_match_pair (match_id, earlier_value, later_value)
  SELECT match_1.id, 'the-red-sisterhood', 'master-of-the-red-sisterhood'
  FROM match_1
  ON CONFLICT (match_id, earlier_value) DO UPDATE SET later_value = EXCLUDED.later_value
  RETURNING match_id
)
, match_1_pair_2 AS (
  INSERT INTO rpg.phb_transformation_require_match_pair (match_id, earlier_value, later_value)
  SELECT match_1.id, 'the-sea-sisterhood', 'master-of-the-sea-sisterhood'
  FROM match_1
  ON CONFLICT (match_id, earlier_value) DO UPDATE SET later_value = EXCLUDED.later_value
  RETURNING match_id
)
SELECT 1 FROM feat;

-- —— gh-transformation-lich ——
WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-lich')
, stage_1 AS (
  INSERT INTO rpg.phb_transformation_stage_rule (feat_id, stage, mode)
  SELECT feat.id, 1, 'fixed_plus_pick1'::rpg.transformation_stage_mode
  FROM feat
  ON CONFLICT (feat_id, stage) DO UPDATE SET mode = EXCLUDED.mode
  RETURNING id
)
, auto_1_0 AS (
  INSERT INTO rpg.phb_transformation_stage_auto_boon (stage_rule_id, boon_id, sort_order)
  SELECT stage_1.id, 'undead-form', 0
  FROM stage_1
  ON CONFLICT (stage_rule_id, boon_id) DO UPDATE SET sort_order = EXCLUDED.sort_order
  RETURNING stage_rule_id
)
, pick_1_0 AS (
  INSERT INTO rpg.phb_transformation_stage_pick_key (stage_rule_id, pick_key, sort_order)
  SELECT stage_1.id, 'stage1Boon', 0
  FROM stage_1
  ON CONFLICT (stage_rule_id, pick_key) DO UPDATE SET sort_order = EXCLUDED.sort_order
  RETURNING stage_rule_id
)
, stage_2 AS (
  INSERT INTO rpg.phb_transformation_stage_rule (feat_id, stage, mode)
  SELECT feat.id, 2, 'pick1'::rpg.transformation_stage_mode
  FROM feat
  ON CONFLICT (feat_id, stage) DO UPDATE SET mode = EXCLUDED.mode
  RETURNING id
)
, pick_2_0 AS (
  INSERT INTO rpg.phb_transformation_stage_pick_key (stage_rule_id, pick_key, sort_order)
  SELECT stage_2.id, 'stage2Boon', 0
  FROM stage_2
  ON CONFLICT (stage_rule_id, pick_key) DO UPDATE SET sort_order = EXCLUDED.sort_order
  RETURNING stage_rule_id
)
, stage_3 AS (
  INSERT INTO rpg.phb_transformation_stage_rule (feat_id, stage, mode)
  SELECT feat.id, 3, 'pick1'::rpg.transformation_stage_mode
  FROM feat
  ON CONFLICT (feat_id, stage) DO UPDATE SET mode = EXCLUDED.mode
  RETURNING id
)
, pick_3_0 AS (
  INSERT INTO rpg.phb_transformation_stage_pick_key (stage_rule_id, pick_key, sort_order)
  SELECT stage_3.id, 'stage3Boon', 0
  FROM stage_3
  ON CONFLICT (stage_rule_id, pick_key) DO UPDATE SET sort_order = EXCLUDED.sort_order
  RETURNING stage_rule_id
)
, stage_4 AS (
  INSERT INTO rpg.phb_transformation_stage_rule (feat_id, stage, mode)
  SELECT feat.id, 4, 'pick1'::rpg.transformation_stage_mode
  FROM feat
  ON CONFLICT (feat_id, stage) DO UPDATE SET mode = EXCLUDED.mode
  RETURNING id
)
, pick_4_0 AS (
  INSERT INTO rpg.phb_transformation_stage_pick_key (stage_rule_id, pick_key, sort_order)
  SELECT stage_4.id, 'stage4Boon', 0
  FROM stage_4
  ON CONFLICT (stage_rule_id, pick_key) DO UPDATE SET sort_order = EXCLUDED.sort_order
  RETURNING stage_rule_id
)
SELECT 1 FROM feat;

-- —— gh-transformation-lycanthrope ——
WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-lycanthrope')
, stage_1 AS (
  INSERT INTO rpg.phb_transformation_stage_rule (feat_id, stage, mode)
  SELECT feat.id, 1, 'pick1'::rpg.transformation_stage_mode
  FROM feat
  ON CONFLICT (feat_id, stage) DO UPDATE SET mode = EXCLUDED.mode
  RETURNING id
)
, pick_1_0 AS (
  INSERT INTO rpg.phb_transformation_stage_pick_key (stage_rule_id, pick_key, sort_order)
  SELECT stage_1.id, 'stage1Boon', 0
  FROM stage_1
  ON CONFLICT (stage_rule_id, pick_key) DO UPDATE SET sort_order = EXCLUDED.sort_order
  RETURNING stage_rule_id
)
, stage_2 AS (
  INSERT INTO rpg.phb_transformation_stage_rule (feat_id, stage, mode)
  SELECT feat.id, 2, 'pick1'::rpg.transformation_stage_mode
  FROM feat
  ON CONFLICT (feat_id, stage) DO UPDATE SET mode = EXCLUDED.mode
  RETURNING id
)
, pick_2_0 AS (
  INSERT INTO rpg.phb_transformation_stage_pick_key (stage_rule_id, pick_key, sort_order)
  SELECT stage_2.id, 'stage2Boon', 0
  FROM stage_2
  ON CONFLICT (stage_rule_id, pick_key) DO UPDATE SET sort_order = EXCLUDED.sort_order
  RETURNING stage_rule_id
)
, stage_3 AS (
  INSERT INTO rpg.phb_transformation_stage_rule (feat_id, stage, mode)
  SELECT feat.id, 3, 'pick1'::rpg.transformation_stage_mode
  FROM feat
  ON CONFLICT (feat_id, stage) DO UPDATE SET mode = EXCLUDED.mode
  RETURNING id
)
, pick_3_0 AS (
  INSERT INTO rpg.phb_transformation_stage_pick_key (stage_rule_id, pick_key, sort_order)
  SELECT stage_3.id, 'stage3Boon', 0
  FROM stage_3
  ON CONFLICT (stage_rule_id, pick_key) DO UPDATE SET sort_order = EXCLUDED.sort_order
  RETURNING stage_rule_id
)
, stage_4 AS (
  INSERT INTO rpg.phb_transformation_stage_rule (feat_id, stage, mode)
  SELECT feat.id, 4, 'pick1'::rpg.transformation_stage_mode
  FROM feat
  ON CONFLICT (feat_id, stage) DO UPDATE SET mode = EXCLUDED.mode
  RETURNING id
)
, pick_4_0 AS (
  INSERT INTO rpg.phb_transformation_stage_pick_key (stage_rule_id, pick_key, sort_order)
  SELECT stage_4.id, 'stage4Boon', 0
  FROM stage_4
  ON CONFLICT (stage_rule_id, pick_key) DO UPDATE SET sort_order = EXCLUDED.sort_order
  RETURNING stage_rule_id
)
SELECT 1 FROM feat;

-- —— gh-transformation-ooze ——
WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-ooze')
, stage_1 AS (
  INSERT INTO rpg.phb_transformation_stage_rule (feat_id, stage, mode)
  SELECT feat.id, 1, 'fixed_plus_pick1'::rpg.transformation_stage_mode
  FROM feat
  ON CONFLICT (feat_id, stage) DO UPDATE SET mode = EXCLUDED.mode
  RETURNING id
)
, auto_1_0 AS (
  INSERT INTO rpg.phb_transformation_stage_auto_boon (stage_rule_id, boon_id, sort_order)
  SELECT stage_1.id, 'ooze-form', 0
  FROM stage_1
  ON CONFLICT (stage_rule_id, boon_id) DO UPDATE SET sort_order = EXCLUDED.sort_order
  RETURNING stage_rule_id
)
, pick_1_0 AS (
  INSERT INTO rpg.phb_transformation_stage_pick_key (stage_rule_id, pick_key, sort_order)
  SELECT stage_1.id, 'stage1Boon', 0
  FROM stage_1
  ON CONFLICT (stage_rule_id, pick_key) DO UPDATE SET sort_order = EXCLUDED.sort_order
  RETURNING stage_rule_id
)
, stage_2 AS (
  INSERT INTO rpg.phb_transformation_stage_rule (feat_id, stage, mode)
  SELECT feat.id, 2, 'pick1'::rpg.transformation_stage_mode
  FROM feat
  ON CONFLICT (feat_id, stage) DO UPDATE SET mode = EXCLUDED.mode
  RETURNING id
)
, pick_2_0 AS (
  INSERT INTO rpg.phb_transformation_stage_pick_key (stage_rule_id, pick_key, sort_order)
  SELECT stage_2.id, 'stage2Boon', 0
  FROM stage_2
  ON CONFLICT (stage_rule_id, pick_key) DO UPDATE SET sort_order = EXCLUDED.sort_order
  RETURNING stage_rule_id
)
, stage_3 AS (
  INSERT INTO rpg.phb_transformation_stage_rule (feat_id, stage, mode)
  SELECT feat.id, 3, 'pick1'::rpg.transformation_stage_mode
  FROM feat
  ON CONFLICT (feat_id, stage) DO UPDATE SET mode = EXCLUDED.mode
  RETURNING id
)
, pick_3_0 AS (
  INSERT INTO rpg.phb_transformation_stage_pick_key (stage_rule_id, pick_key, sort_order)
  SELECT stage_3.id, 'stage3Boon', 0
  FROM stage_3
  ON CONFLICT (stage_rule_id, pick_key) DO UPDATE SET sort_order = EXCLUDED.sort_order
  RETURNING stage_rule_id
)
, stage_4 AS (
  INSERT INTO rpg.phb_transformation_stage_rule (feat_id, stage, mode)
  SELECT feat.id, 4, 'pick1'::rpg.transformation_stage_mode
  FROM feat
  ON CONFLICT (feat_id, stage) DO UPDATE SET mode = EXCLUDED.mode
  RETURNING id
)
, pick_4_0 AS (
  INSERT INTO rpg.phb_transformation_stage_pick_key (stage_rule_id, pick_key, sort_order)
  SELECT stage_4.id, 'stage4Boon', 0
  FROM stage_4
  ON CONFLICT (stage_rule_id, pick_key) DO UPDATE SET sort_order = EXCLUDED.sort_order
  RETURNING stage_rule_id
)
SELECT 1 FROM feat;

-- —— gh-transformation-primordial ——
WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-primordial')
, stage_1 AS (
  INSERT INTO rpg.phb_transformation_stage_rule (feat_id, stage, mode)
  SELECT feat.id, 1, 'auto_all'::rpg.transformation_stage_mode
  FROM feat
  ON CONFLICT (feat_id, stage) DO UPDATE SET mode = EXCLUDED.mode
  RETURNING id
)
, auto_1_0 AS (
  INSERT INTO rpg.phb_transformation_stage_auto_boon (stage_rule_id, boon_id, sort_order)
  SELECT stage_1.id, 'primordial-form', 0
  FROM stage_1
  ON CONFLICT (stage_rule_id, boon_id) DO UPDATE SET sort_order = EXCLUDED.sort_order
  RETURNING stage_rule_id
)
, auto_1_1 AS (
  INSERT INTO rpg.phb_transformation_stage_auto_boon (stage_rule_id, boon_id, sort_order)
  SELECT stage_1.id, 'elemental-affinity', 1
  FROM stage_1
  ON CONFLICT (stage_rule_id, boon_id) DO UPDATE SET sort_order = EXCLUDED.sort_order
  RETURNING stage_rule_id
)
, stage_2 AS (
  INSERT INTO rpg.phb_transformation_stage_rule (feat_id, stage, mode)
  SELECT feat.id, 2, 'pick1'::rpg.transformation_stage_mode
  FROM feat
  ON CONFLICT (feat_id, stage) DO UPDATE SET mode = EXCLUDED.mode
  RETURNING id
)
, pick_2_0 AS (
  INSERT INTO rpg.phb_transformation_stage_pick_key (stage_rule_id, pick_key, sort_order)
  SELECT stage_2.id, 'stage2Boon', 0
  FROM stage_2
  ON CONFLICT (stage_rule_id, pick_key) DO UPDATE SET sort_order = EXCLUDED.sort_order
  RETURNING stage_rule_id
)
, stage_3 AS (
  INSERT INTO rpg.phb_transformation_stage_rule (feat_id, stage, mode)
  SELECT feat.id, 3, 'pick1'::rpg.transformation_stage_mode
  FROM feat
  ON CONFLICT (feat_id, stage) DO UPDATE SET mode = EXCLUDED.mode
  RETURNING id
)
, pick_3_0 AS (
  INSERT INTO rpg.phb_transformation_stage_pick_key (stage_rule_id, pick_key, sort_order)
  SELECT stage_3.id, 'stage3Boon', 0
  FROM stage_3
  ON CONFLICT (stage_rule_id, pick_key) DO UPDATE SET sort_order = EXCLUDED.sort_order
  RETURNING stage_rule_id
)
, stage_4 AS (
  INSERT INTO rpg.phb_transformation_stage_rule (feat_id, stage, mode)
  SELECT feat.id, 4, 'pick1'::rpg.transformation_stage_mode
  FROM feat
  ON CONFLICT (feat_id, stage) DO UPDATE SET mode = EXCLUDED.mode
  RETURNING id
)
, pick_4_0 AS (
  INSERT INTO rpg.phb_transformation_stage_pick_key (stage_rule_id, pick_key, sort_order)
  SELECT stage_4.id, 'stage4Boon', 0
  FROM stage_4
  ON CONFLICT (stage_rule_id, pick_key) DO UPDATE SET sort_order = EXCLUDED.sort_order
  RETURNING stage_rule_id
)
, sub_0 AS (
  INSERT INTO rpg.phb_transformation_sub_option (
    feat_id, option_key, from_stage, when_choice_key, when_choice_value
  )
  SELECT feat.id, 'elementalAffinity', 1, NULL, NULL
  FROM feat
  ON CONFLICT (feat_id, option_key) DO UPDATE SET
    from_stage = EXCLUDED.from_stage,
    when_choice_key = EXCLUDED.when_choice_key,
    when_choice_value = EXCLUDED.when_choice_value
  RETURNING id
)
, sub_1 AS (
  INSERT INTO rpg.phb_transformation_sub_option (
    feat_id, option_key, from_stage, when_choice_key, when_choice_value
  )
  SELECT feat.id, 'primordialDamageType', 3, 'stage3Boon', 'primeval-body'
  FROM feat
  ON CONFLICT (feat_id, option_key) DO UPDATE SET
    from_stage = EXCLUDED.from_stage,
    when_choice_key = EXCLUDED.when_choice_key,
    when_choice_value = EXCLUDED.when_choice_value
  RETURNING id
)
SELECT 1 FROM feat;

-- —— gh-transformation-seraph ——
WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-seraph')
, stage_1 AS (
  INSERT INTO rpg.phb_transformation_stage_rule (feat_id, stage, mode)
  SELECT feat.id, 1, 'fixed_plus_pick1'::rpg.transformation_stage_mode
  FROM feat
  ON CONFLICT (feat_id, stage) DO UPDATE SET mode = EXCLUDED.mode
  RETURNING id
)
, auto_1_0 AS (
  INSERT INTO rpg.phb_transformation_stage_auto_boon (stage_rule_id, boon_id, sort_order)
  SELECT stage_1.id, 'celestial-form', 0
  FROM stage_1
  ON CONFLICT (stage_rule_id, boon_id) DO UPDATE SET sort_order = EXCLUDED.sort_order
  RETURNING stage_rule_id
)
, pick_1_0 AS (
  INSERT INTO rpg.phb_transformation_stage_pick_key (stage_rule_id, pick_key, sort_order)
  SELECT stage_1.id, 'stage1Boon', 0
  FROM stage_1
  ON CONFLICT (stage_rule_id, pick_key) DO UPDATE SET sort_order = EXCLUDED.sort_order
  RETURNING stage_rule_id
)
, stage_2 AS (
  INSERT INTO rpg.phb_transformation_stage_rule (feat_id, stage, mode)
  SELECT feat.id, 2, 'pick1'::rpg.transformation_stage_mode
  FROM feat
  ON CONFLICT (feat_id, stage) DO UPDATE SET mode = EXCLUDED.mode
  RETURNING id
)
, pick_2_0 AS (
  INSERT INTO rpg.phb_transformation_stage_pick_key (stage_rule_id, pick_key, sort_order)
  SELECT stage_2.id, 'stage2Boon', 0
  FROM stage_2
  ON CONFLICT (stage_rule_id, pick_key) DO UPDATE SET sort_order = EXCLUDED.sort_order
  RETURNING stage_rule_id
)
, stage_3 AS (
  INSERT INTO rpg.phb_transformation_stage_rule (feat_id, stage, mode)
  SELECT feat.id, 3, 'pick1'::rpg.transformation_stage_mode
  FROM feat
  ON CONFLICT (feat_id, stage) DO UPDATE SET mode = EXCLUDED.mode
  RETURNING id
)
, pick_3_0 AS (
  INSERT INTO rpg.phb_transformation_stage_pick_key (stage_rule_id, pick_key, sort_order)
  SELECT stage_3.id, 'stage3Boon', 0
  FROM stage_3
  ON CONFLICT (stage_rule_id, pick_key) DO UPDATE SET sort_order = EXCLUDED.sort_order
  RETURNING stage_rule_id
)
, stage_4 AS (
  INSERT INTO rpg.phb_transformation_stage_rule (feat_id, stage, mode)
  SELECT feat.id, 4, 'pick1'::rpg.transformation_stage_mode
  FROM feat
  ON CONFLICT (feat_id, stage) DO UPDATE SET mode = EXCLUDED.mode
  RETURNING id
)
, pick_4_0 AS (
  INSERT INTO rpg.phb_transformation_stage_pick_key (stage_rule_id, pick_key, sort_order)
  SELECT stage_4.id, 'stage4Boon', 0
  FROM stage_4
  ON CONFLICT (stage_rule_id, pick_key) DO UPDATE SET sort_order = EXCLUDED.sort_order
  RETURNING stage_rule_id
)
SELECT 1 FROM feat;

-- —— gh-transformation-shadowsteel-ghoul ——
WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-shadowsteel-ghoul')
, stage_1 AS (
  INSERT INTO rpg.phb_transformation_stage_rule (feat_id, stage, mode)
  SELECT feat.id, 1, 'pick1'::rpg.transformation_stage_mode
  FROM feat
  ON CONFLICT (feat_id, stage) DO UPDATE SET mode = EXCLUDED.mode
  RETURNING id
)
, pick_1_0 AS (
  INSERT INTO rpg.phb_transformation_stage_pick_key (stage_rule_id, pick_key, sort_order)
  SELECT stage_1.id, 'stage1Boon', 0
  FROM stage_1
  ON CONFLICT (stage_rule_id, pick_key) DO UPDATE SET sort_order = EXCLUDED.sort_order
  RETURNING stage_rule_id
)
, stage_2 AS (
  INSERT INTO rpg.phb_transformation_stage_rule (feat_id, stage, mode)
  SELECT feat.id, 2, 'pick2'::rpg.transformation_stage_mode
  FROM feat
  ON CONFLICT (feat_id, stage) DO UPDATE SET mode = EXCLUDED.mode
  RETURNING id
)
, pick_2_0 AS (
  INSERT INTO rpg.phb_transformation_stage_pick_key (stage_rule_id, pick_key, sort_order)
  SELECT stage_2.id, 'stage2Boon', 0
  FROM stage_2
  ON CONFLICT (stage_rule_id, pick_key) DO UPDATE SET sort_order = EXCLUDED.sort_order
  RETURNING stage_rule_id
)
, pick_2_1 AS (
  INSERT INTO rpg.phb_transformation_stage_pick_key (stage_rule_id, pick_key, sort_order)
  SELECT stage_2.id, 'stage2Boon2', 1
  FROM stage_2
  ON CONFLICT (stage_rule_id, pick_key) DO UPDATE SET sort_order = EXCLUDED.sort_order
  RETURNING stage_rule_id
)
, stage_3 AS (
  INSERT INTO rpg.phb_transformation_stage_rule (feat_id, stage, mode)
  SELECT feat.id, 3, 'auto_single'::rpg.transformation_stage_mode
  FROM feat
  ON CONFLICT (feat_id, stage) DO UPDATE SET mode = EXCLUDED.mode
  RETURNING id
)
, auto_3_0 AS (
  INSERT INTO rpg.phb_transformation_stage_auto_boon (stage_rule_id, boon_id, sort_order)
  SELECT stage_3.id, 'cursed-claw', 0
  FROM stage_3
  ON CONFLICT (stage_rule_id, boon_id) DO UPDATE SET sort_order = EXCLUDED.sort_order
  RETURNING stage_rule_id
)
, stage_4 AS (
  INSERT INTO rpg.phb_transformation_stage_rule (feat_id, stage, mode)
  SELECT feat.id, 4, 'pick1'::rpg.transformation_stage_mode
  FROM feat
  ON CONFLICT (feat_id, stage) DO UPDATE SET mode = EXCLUDED.mode
  RETURNING id
)
, pick_4_0 AS (
  INSERT INTO rpg.phb_transformation_stage_pick_key (stage_rule_id, pick_key, sort_order)
  SELECT stage_4.id, 'stage4Boon', 0
  FROM stage_4
  ON CONFLICT (stage_rule_id, pick_key) DO UPDATE SET sort_order = EXCLUDED.sort_order
  RETURNING stage_rule_id
)
SELECT 1 FROM feat;

-- —— gh-transformation-specter ——
WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-specter')
, stage_1 AS (
  INSERT INTO rpg.phb_transformation_stage_rule (feat_id, stage, mode)
  SELECT feat.id, 1, 'fixed_plus_pick1'::rpg.transformation_stage_mode
  FROM feat
  ON CONFLICT (feat_id, stage) DO UPDATE SET mode = EXCLUDED.mode
  RETURNING id
)
, auto_1_0 AS (
  INSERT INTO rpg.phb_transformation_stage_auto_boon (stage_rule_id, boon_id, sort_order)
  SELECT stage_1.id, 'spectral-form', 0
  FROM stage_1
  ON CONFLICT (stage_rule_id, boon_id) DO UPDATE SET sort_order = EXCLUDED.sort_order
  RETURNING stage_rule_id
)
, pick_1_0 AS (
  INSERT INTO rpg.phb_transformation_stage_pick_key (stage_rule_id, pick_key, sort_order)
  SELECT stage_1.id, 'stage1Boon', 0
  FROM stage_1
  ON CONFLICT (stage_rule_id, pick_key) DO UPDATE SET sort_order = EXCLUDED.sort_order
  RETURNING stage_rule_id
)
, stage_2 AS (
  INSERT INTO rpg.phb_transformation_stage_rule (feat_id, stage, mode)
  SELECT feat.id, 2, 'pick1'::rpg.transformation_stage_mode
  FROM feat
  ON CONFLICT (feat_id, stage) DO UPDATE SET mode = EXCLUDED.mode
  RETURNING id
)
, pick_2_0 AS (
  INSERT INTO rpg.phb_transformation_stage_pick_key (stage_rule_id, pick_key, sort_order)
  SELECT stage_2.id, 'stage2Boon', 0
  FROM stage_2
  ON CONFLICT (stage_rule_id, pick_key) DO UPDATE SET sort_order = EXCLUDED.sort_order
  RETURNING stage_rule_id
)
, stage_3 AS (
  INSERT INTO rpg.phb_transformation_stage_rule (feat_id, stage, mode)
  SELECT feat.id, 3, 'pick1'::rpg.transformation_stage_mode
  FROM feat
  ON CONFLICT (feat_id, stage) DO UPDATE SET mode = EXCLUDED.mode
  RETURNING id
)
, pick_3_0 AS (
  INSERT INTO rpg.phb_transformation_stage_pick_key (stage_rule_id, pick_key, sort_order)
  SELECT stage_3.id, 'stage3Boon', 0
  FROM stage_3
  ON CONFLICT (stage_rule_id, pick_key) DO UPDATE SET sort_order = EXCLUDED.sort_order
  RETURNING stage_rule_id
)
, stage_4 AS (
  INSERT INTO rpg.phb_transformation_stage_rule (feat_id, stage, mode)
  SELECT feat.id, 4, 'pick1'::rpg.transformation_stage_mode
  FROM feat
  ON CONFLICT (feat_id, stage) DO UPDATE SET mode = EXCLUDED.mode
  RETURNING id
)
, pick_4_0 AS (
  INSERT INTO rpg.phb_transformation_stage_pick_key (stage_rule_id, pick_key, sort_order)
  SELECT stage_4.id, 'stage4Boon', 0
  FROM stage_4
  ON CONFLICT (stage_rule_id, pick_key) DO UPDATE SET sort_order = EXCLUDED.sort_order
  RETURNING stage_rule_id
)
SELECT 1 FROM feat;

-- —— gh-transformation-vampire ——
WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-vampire')
, stage_1 AS (
  INSERT INTO rpg.phb_transformation_stage_rule (feat_id, stage, mode)
  SELECT feat.id, 1, 'fixed_plus_pick1'::rpg.transformation_stage_mode
  FROM feat
  ON CONFLICT (feat_id, stage) DO UPDATE SET mode = EXCLUDED.mode
  RETURNING id
)
, auto_1_0 AS (
  INSERT INTO rpg.phb_transformation_stage_auto_boon (stage_rule_id, boon_id, sort_order)
  SELECT stage_1.id, 'fanged-bite', 0
  FROM stage_1
  ON CONFLICT (stage_rule_id, boon_id) DO UPDATE SET sort_order = EXCLUDED.sort_order
  RETURNING stage_rule_id
)
, pick_1_0 AS (
  INSERT INTO rpg.phb_transformation_stage_pick_key (stage_rule_id, pick_key, sort_order)
  SELECT stage_1.id, 'stage1Boon', 0
  FROM stage_1
  ON CONFLICT (stage_rule_id, pick_key) DO UPDATE SET sort_order = EXCLUDED.sort_order
  RETURNING stage_rule_id
)
, stage_2 AS (
  INSERT INTO rpg.phb_transformation_stage_rule (feat_id, stage, mode)
  SELECT feat.id, 2, 'pick2'::rpg.transformation_stage_mode
  FROM feat
  ON CONFLICT (feat_id, stage) DO UPDATE SET mode = EXCLUDED.mode
  RETURNING id
)
, pick_2_0 AS (
  INSERT INTO rpg.phb_transformation_stage_pick_key (stage_rule_id, pick_key, sort_order)
  SELECT stage_2.id, 'stage2Boon', 0
  FROM stage_2
  ON CONFLICT (stage_rule_id, pick_key) DO UPDATE SET sort_order = EXCLUDED.sort_order
  RETURNING stage_rule_id
)
, pick_2_1 AS (
  INSERT INTO rpg.phb_transformation_stage_pick_key (stage_rule_id, pick_key, sort_order)
  SELECT stage_2.id, 'stage2Boon2', 1
  FROM stage_2
  ON CONFLICT (stage_rule_id, pick_key) DO UPDATE SET sort_order = EXCLUDED.sort_order
  RETURNING stage_rule_id
)
, stage_3 AS (
  INSERT INTO rpg.phb_transformation_stage_rule (feat_id, stage, mode)
  SELECT feat.id, 3, 'pick2'::rpg.transformation_stage_mode
  FROM feat
  ON CONFLICT (feat_id, stage) DO UPDATE SET mode = EXCLUDED.mode
  RETURNING id
)
, pick_3_0 AS (
  INSERT INTO rpg.phb_transformation_stage_pick_key (stage_rule_id, pick_key, sort_order)
  SELECT stage_3.id, 'stage3Boon', 0
  FROM stage_3
  ON CONFLICT (stage_rule_id, pick_key) DO UPDATE SET sort_order = EXCLUDED.sort_order
  RETURNING stage_rule_id
)
, pick_3_1 AS (
  INSERT INTO rpg.phb_transformation_stage_pick_key (stage_rule_id, pick_key, sort_order)
  SELECT stage_3.id, 'stage3Boon2', 1
  FROM stage_3
  ON CONFLICT (stage_rule_id, pick_key) DO UPDATE SET sort_order = EXCLUDED.sort_order
  RETURNING stage_rule_id
)
, stage_4 AS (
  INSERT INTO rpg.phb_transformation_stage_rule (feat_id, stage, mode)
  SELECT feat.id, 4, 'fixed_plus_pick1'::rpg.transformation_stage_mode
  FROM feat
  ON CONFLICT (feat_id, stage) DO UPDATE SET mode = EXCLUDED.mode
  RETURNING id
)
, auto_4_0 AS (
  INSERT INTO rpg.phb_transformation_stage_auto_boon (stage_rule_id, boon_id, sort_order)
  SELECT stage_4.id, 'regeneration', 0
  FROM stage_4
  ON CONFLICT (stage_rule_id, boon_id) DO UPDATE SET sort_order = EXCLUDED.sort_order
  RETURNING stage_rule_id
)
, pick_4_0 AS (
  INSERT INTO rpg.phb_transformation_stage_pick_key (stage_rule_id, pick_key, sort_order)
  SELECT stage_4.id, 'stage4Boon', 0
  FROM stage_4
  ON CONFLICT (stage_rule_id, pick_key) DO UPDATE SET sort_order = EXCLUDED.sort_order
  RETURNING stage_rule_id
)
, match_0 AS (
  INSERT INTO rpg.phb_transformation_require_match (feat_id, later_key, earlier_key)
  SELECT feat.id, 'stage4Boon', 'stage1Boon'
  FROM feat
  ON CONFLICT (feat_id, later_key, earlier_key) DO UPDATE SET later_key = EXCLUDED.later_key
  RETURNING id
)
, match_0_pair_0 AS (
  INSERT INTO rpg.phb_transformation_require_match_pair (match_id, earlier_value, later_value)
  SELECT match_0.id, 'soman-bloodline', 'final-soman-bloodline'
  FROM match_0
  ON CONFLICT (match_id, earlier_value) DO UPDATE SET later_value = EXCLUDED.later_value
  RETURNING match_id
)
, match_0_pair_1 AS (
  INSERT INTO rpg.phb_transformation_require_match_pair (match_id, earlier_value, later_value)
  SELECT match_0.id, 'fzeg-bloodline', 'final-fzeg-bloodline'
  FROM match_0
  ON CONFLICT (match_id, earlier_value) DO UPDATE SET later_value = EXCLUDED.later_value
  RETURNING match_id
)
, match_0_pair_2 AS (
  INSERT INTO rpg.phb_transformation_require_match_pair (match_id, earlier_value, later_value)
  SELECT match_0.id, 'strigoi-bloodline', 'final-strigoi-bloodline'
  FROM match_0
  ON CONFLICT (match_id, earlier_value) DO UPDATE SET later_value = EXCLUDED.later_value
  RETURNING match_id
)
SELECT 1 FROM feat;
