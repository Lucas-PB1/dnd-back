-- Schedules nível→valor por classe/subclasse (ataques/ação, dados, usos…).

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

CREATE UNIQUE INDEX uq_phb_class_feature_schedule_class
  ON rpg.phb_class_feature_schedule (class_id, feature_key, unlock_level)
  WHERE class_id IS NOT NULL;

CREATE UNIQUE INDEX uq_phb_class_feature_schedule_subclass
  ON rpg.phb_class_feature_schedule (subclass_id, feature_key, unlock_level)
  WHERE subclass_id IS NOT NULL;
