-- Gates de nível por subclasse (ex.: Sabujo de Sangue L7/L10/L15).

CREATE TABLE IF NOT EXISTS rpg.phb_subclass_feature_gate (
  subclass_id BIGINT NOT NULL REFERENCES rpg.phb_subclass(id) ON DELETE CASCADE,
  gate_key TEXT NOT NULL,
  unlock_level INTEGER NOT NULL CHECK (unlock_level BETWEEN 1 AND 20),
  PRIMARY KEY (subclass_id, gate_key)
);
