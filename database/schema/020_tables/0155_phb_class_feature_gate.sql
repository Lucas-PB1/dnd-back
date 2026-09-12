-- Gates booleanos de nível por classe (ex.: Ataques Estudados L13, Evasão L7).

CREATE TABLE IF NOT EXISTS rpg.phb_class_feature_gate (
  class_id BIGINT NOT NULL REFERENCES rpg.phb_class(id) ON DELETE CASCADE,
  gate_key TEXT NOT NULL,
  unlock_level INTEGER NOT NULL CHECK (unlock_level BETWEEN 1 AND 20),
  PRIMARY KEY (class_id, gate_key)
);
