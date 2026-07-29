-- Valores de catálogo para opções de talentos (ex.: lista de magias do Iniciado em Magia)

CREATE TABLE rpg.phb_feat_option_value (
  feat_id BIGINT NOT NULL,
  option_key TEXT NOT NULL,
  value_id TEXT NOT NULL,
  label TEXT NOT NULL,
  sort_order INTEGER NOT NULL DEFAULT 0,
  PRIMARY KEY (feat_id, option_key, value_id),
  FOREIGN KEY (feat_id, option_key)
    REFERENCES rpg.phb_feat_option_def(feat_id, option_key) ON DELETE CASCADE
);
