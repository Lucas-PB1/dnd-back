-- Forward: phb_class_feature_schedule (piloto attacks + martial arts).

CREATE TABLE IF NOT EXISTS rpg.phb_class_feature_schedule (
  id BIGSERIAL PRIMARY KEY,
  owner_kind TEXT NOT NULL CHECK (owner_kind IN ('class', 'subclass')),
  class_id BIGINT REFERENCES rpg.phb_class(id) ON DELETE CASCADE,
  subclass_id BIGINT REFERENCES rpg.phb_subclass(id) ON DELETE CASCADE,
  feature_key TEXT NOT NULL CHECK (length(trim(feature_key)) > 0),
  unlock_level INTEGER NOT NULL CHECK (unlock_level BETWEEN 1 AND 20),
  value_num DOUBLE PRECISION NOT NULL,
  CONSTRAINT phb_class_feature_schedule_owner CHECK (
    (owner_kind = 'class' AND class_id IS NOT NULL AND subclass_id IS NULL)
    OR (owner_kind = 'subclass' AND subclass_id IS NOT NULL AND class_id IS NULL)
  )
);

CREATE UNIQUE INDEX IF NOT EXISTS uq_phb_class_feature_schedule_class
  ON rpg.phb_class_feature_schedule (class_id, feature_key, unlock_level)
  WHERE class_id IS NOT NULL;

CREATE UNIQUE INDEX IF NOT EXISTS uq_phb_class_feature_schedule_subclass
  ON rpg.phb_class_feature_schedule (subclass_id, feature_key, unlock_level)
  WHERE subclass_id IS NOT NULL;

INSERT INTO rpg.phb_class_feature_schedule (owner_kind, class_id, subclass_id, feature_key, unlock_level, value_num)
SELECT 'class', c.id, NULL, v.feature_key, v.unlock_level, v.value_num
FROM rpg.phb_class c
CROSS JOIN (
  VALUES
    ('attacks_per_action', 1, 1::float8),
    ('attacks_per_action', 5, 2::float8),
    ('attacks_per_action', 11, 3::float8),
    ('attacks_per_action', 20, 4::float8)
) AS v(feature_key, unlock_level, value_num)
WHERE c.slug = 'fighter'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_class_feature_schedule s
    WHERE s.class_id = c.id AND s.feature_key = v.feature_key AND s.unlock_level = v.unlock_level
  );

INSERT INTO rpg.phb_class_feature_schedule (owner_kind, class_id, subclass_id, feature_key, unlock_level, value_num)
SELECT 'class', c.id, NULL, v.feature_key, v.unlock_level, v.value_num
FROM rpg.phb_class c
CROSS JOIN (
  VALUES
    ('attacks_per_action', 1, 1::float8),
    ('attacks_per_action', 5, 2::float8)
) AS v(feature_key, unlock_level, value_num)
WHERE c.slug IN ('monk', 'paladin', 'ranger')
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_class_feature_schedule s
    WHERE s.class_id = c.id AND s.feature_key = v.feature_key AND s.unlock_level = v.unlock_level
  );

INSERT INTO rpg.phb_class_feature_schedule (owner_kind, class_id, subclass_id, feature_key, unlock_level, value_num)
SELECT 'class', c.id, NULL, v.feature_key, v.unlock_level, v.value_num
FROM rpg.phb_class c
CROSS JOIN (
  VALUES
    ('martial_arts_die_faces', 1, 6::float8),
    ('martial_arts_die_faces', 5, 8::float8),
    ('martial_arts_die_faces', 11, 10::float8),
    ('martial_arts_die_faces', 17, 12::float8)
) AS v(feature_key, unlock_level, value_num)
WHERE c.slug = 'monk'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_class_feature_schedule s
    WHERE s.class_id = c.id AND s.feature_key = v.feature_key AND s.unlock_level = v.unlock_level
  );

INSERT INTO rpg.phb_class_feature_schedule (owner_kind, class_id, subclass_id, feature_key, unlock_level, value_num)
SELECT 'class', c.id, NULL, v.feature_key, v.unlock_level, v.value_num
FROM rpg.phb_class c
CROSS JOIN (
  VALUES
    ('unarmored_speed_bonus_m', 2, 3::float8),
    ('unarmored_speed_bonus_m', 6, 4.5::float8),
    ('unarmored_speed_bonus_m', 10, 6::float8),
    ('unarmored_speed_bonus_m', 14, 7.5::float8),
    ('unarmored_speed_bonus_m', 18, 9::float8)
) AS v(feature_key, unlock_level, value_num)
WHERE c.slug = 'monk'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_class_feature_schedule s
    WHERE s.class_id = c.id AND s.feature_key = v.feature_key AND s.unlock_level = v.unlock_level
  );
