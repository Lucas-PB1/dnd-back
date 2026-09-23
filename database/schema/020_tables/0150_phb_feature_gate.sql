-- Gates booleanos de nível por classe/subclasse (GEN-5).

CREATE TABLE rpg.phb_feature_gate (
  id BIGSERIAL PRIMARY KEY,
  owner_kind rpg.class_subclass_owner NOT NULL,
  class_id BIGINT REFERENCES rpg.phb_class(id) ON DELETE CASCADE,
  subclass_id BIGINT REFERENCES rpg.phb_subclass(id) ON DELETE CASCADE,
  gate_key TEXT NOT NULL CHECK (length(trim(gate_key)) > 0),
  unlock_level INTEGER NOT NULL CHECK (unlock_level BETWEEN 1 AND 20),
  CONSTRAINT phb_feature_gate_owner CHECK (
    (
      owner_kind = 'class'::rpg.class_subclass_owner
      AND class_id IS NOT NULL
      AND subclass_id IS NULL
    )
    OR (
      owner_kind = 'subclass'::rpg.class_subclass_owner
      AND subclass_id IS NOT NULL
      AND class_id IS NULL
    )
  )
);

CREATE UNIQUE INDEX uq_phb_feature_gate_class
  ON rpg.phb_feature_gate (class_id, gate_key)
  WHERE class_id IS NOT NULL;

CREATE UNIQUE INDEX uq_phb_feature_gate_subclass
  ON rpg.phb_feature_gate (subclass_id, gate_key)
  WHERE subclass_id IS NOT NULL;

CREATE INDEX idx_phb_feature_gate_owner
  ON rpg.phb_feature_gate (owner_kind, unlock_level);

COMMENT ON TABLE rpg.phb_feature_gate IS
  'Unlock booleano por nível (GEN-5; unifica class/subclass feature_gate).';
