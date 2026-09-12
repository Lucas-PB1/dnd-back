-- Onda 4: divine strike, radiant strikes, aura range, masks, portent, divine spark.

INSERT INTO rpg.phb_class_feature_schedule (owner_kind, class_id, subclass_id, feature_key, unlock_level, value_num)
SELECT 'class', c.id, NULL, v.feature_key, v.unlock_level, v.value_num
FROM rpg.phb_class c
CROSS JOIN (
  VALUES
    ('divine_strike_dice_count', 7, 1::float8),
    ('divine_strike_dice_count', 14, 2::float8),
    ('divine_spark_dice_count', 2, 1::float8),
    ('divine_spark_dice_count', 7, 2::float8),
    ('divine_spark_dice_count', 13, 3::float8),
    ('divine_spark_dice_count', 18, 4::float8)
) AS v(feature_key, unlock_level, value_num)
WHERE c.slug = 'cleric'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_class_feature_schedule s
    WHERE s.class_id = c.id AND s.feature_key = v.feature_key AND s.unlock_level = v.unlock_level
  );

INSERT INTO rpg.phb_class_feature_schedule (owner_kind, class_id, subclass_id, feature_key, unlock_level, value_num)
SELECT 'class', c.id, NULL, v.feature_key, v.unlock_level, v.value_num
FROM rpg.phb_class c
CROSS JOIN (
  VALUES
    ('radiant_strikes_dice_count', 11, 1::float8),
    ('aura_range_m', 6, 3::float8),
    ('aura_range_m', 18, 9::float8)
) AS v(feature_key, unlock_level, value_num)
WHERE c.slug = 'paladin'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_class_feature_schedule s
    WHERE s.class_id = c.id AND s.feature_key = v.feature_key AND s.unlock_level = v.unlock_level
  );

INSERT INTO rpg.phb_class_feature_schedule (owner_kind, class_id, subclass_id, feature_key, unlock_level, value_num)
SELECT 'subclass', NULL, s.id, v.feature_key, v.unlock_level, v.value_num
FROM rpg.phb_subclass s
CROSS JOIN (
  VALUES
    ('persona_masks_equipped', 3, 1::float8),
    ('persona_masks_equipped', 14, 2::float8),
    ('persona_masks_known', 3, 3::float8),
    ('persona_masks_known', 6, 4::float8),
    ('persona_masks_known', 14, 5::float8)
) AS v(feature_key, unlock_level, value_num)
WHERE s.slug = 'college-of-masks'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_class_feature_schedule x
    WHERE x.subclass_id = s.id AND x.feature_key = v.feature_key AND x.unlock_level = v.unlock_level
  );

INSERT INTO rpg.phb_class_feature_schedule (owner_kind, class_id, subclass_id, feature_key, unlock_level, value_num)
SELECT 'subclass', NULL, s.id, v.feature_key, v.unlock_level, v.value_num
FROM rpg.phb_subclass s
CROSS JOIN (
  VALUES
    ('portent_d20_count', 2, 2::float8),
    ('portent_d20_count', 14, 3::float8)
) AS v(feature_key, unlock_level, value_num)
WHERE s.slug = 'diviner'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_class_feature_schedule x
    WHERE x.subclass_id = s.id AND x.feature_key = v.feature_key AND x.unlock_level = v.unlock_level
  );
