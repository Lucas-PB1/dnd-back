-- Forward: schedules onda 3 (brutal/gunslinger/warlock/sorcerer).

-- Onda 3: brutal strike, gunslinger crit, warlock pact/invocations, sorcerer metamagic.

INSERT INTO rpg.phb_class_feature_schedule (owner_kind, class_id, subclass_id, feature_key, unlock_level, value_num)
SELECT 'class', c.id, NULL, v.feature_key, v.unlock_level, v.value_num
FROM rpg.phb_class c
CROSS JOIN (
  VALUES
    ('brutal_strike_dice_count', 9, 1::float8),
    ('brutal_strike_dice_count', 17, 2::float8)
) AS v(feature_key, unlock_level, value_num)
WHERE c.slug = 'barbarian'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_class_feature_schedule s
    WHERE s.class_id = c.id AND s.feature_key = v.feature_key AND s.unlock_level = v.unlock_level
  );

INSERT INTO rpg.phb_class_feature_schedule (owner_kind, class_id, subclass_id, feature_key, unlock_level, value_num)
SELECT 'class', c.id, NULL, v.feature_key, v.unlock_level, v.value_num
FROM rpg.phb_class c
CROSS JOIN (
  VALUES
    ('gunslinger_crit_threshold', 2, 19::float8),
    ('gunslinger_crit_threshold', 9, 18::float8),
    ('gunslinger_crit_threshold', 17, 17::float8)
) AS v(feature_key, unlock_level, value_num)
WHERE c.slug = 'gunslinger'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_class_feature_schedule s
    WHERE s.class_id = c.id AND s.feature_key = v.feature_key AND s.unlock_level = v.unlock_level
  );

INSERT INTO rpg.phb_class_feature_schedule (owner_kind, class_id, subclass_id, feature_key, unlock_level, value_num)
SELECT 'class', c.id, NULL, v.feature_key, v.unlock_level, v.value_num
FROM rpg.phb_class c
CROSS JOIN (
  VALUES
    ('warlock_pact_slot_level', 1, 1::float8),
    ('warlock_pact_slot_level', 3, 2::float8),
    ('warlock_pact_slot_level', 5, 3::float8),
    ('warlock_pact_slot_level', 7, 4::float8),
    ('warlock_pact_slot_level', 9, 5::float8),
    ('warlock_pact_slot_count', 1, 1::float8),
    ('warlock_pact_slot_count', 2, 2::float8),
    ('warlock_pact_slot_count', 11, 3::float8),
    ('warlock_pact_slot_count', 17, 4::float8),
    ('warlock_invocation_limit', 1, 1::float8),
    ('warlock_invocation_limit', 2, 3::float8),
    ('warlock_invocation_limit', 5, 5::float8),
    ('warlock_invocation_limit', 7, 6::float8),
    ('warlock_invocation_limit', 9, 7::float8),
    ('warlock_invocation_limit', 12, 8::float8),
    ('warlock_invocation_limit', 15, 9::float8),
    ('warlock_invocation_limit', 18, 10::float8)
) AS v(feature_key, unlock_level, value_num)
WHERE c.slug = 'warlock'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_class_feature_schedule s
    WHERE s.class_id = c.id AND s.feature_key = v.feature_key AND s.unlock_level = v.unlock_level
  );

INSERT INTO rpg.phb_class_feature_schedule (owner_kind, class_id, subclass_id, feature_key, unlock_level, value_num)
SELECT 'class', c.id, NULL, v.feature_key, v.unlock_level, v.value_num
FROM rpg.phb_class c
CROSS JOIN (
  VALUES
    ('sorcerer_metamagic_limit', 2, 2::float8),
    ('sorcerer_metamagic_limit', 10, 4::float8),
    ('sorcerer_metamagic_limit', 17, 6::float8)
) AS v(feature_key, unlock_level, value_num)
WHERE c.slug = 'sorcerer'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_class_feature_schedule s
    WHERE s.class_id = c.id AND s.feature_key = v.feature_key AND s.unlock_level = v.unlock_level
  );
