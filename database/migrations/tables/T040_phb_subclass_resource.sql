-- Tabela rpg.phb_subclass_resource

CREATE TABLE rpg.phb_subclass_resource (
  subclass_id   BIGINT NOT NULL REFERENCES rpg.phb_subclass(id) ON DELETE CASCADE,
  resource_id   BIGINT NOT NULL REFERENCES rpg.phb_resource_definition(id) ON DELETE CASCADE,
  unlock_level  INTEGER NOT NULL CHECK (unlock_level BETWEEN 1 AND 20),
  max_formula   rpg.resource_max_formula NOT NULL,
  fixed_max     INTEGER CHECK (fixed_max IS NULL OR fixed_max >= 0),
  feature_id    BIGINT REFERENCES rpg.phb_subclass_feature(id) ON DELETE SET NULL,
  PRIMARY KEY (subclass_id, resource_id, unlock_level),
  CONSTRAINT pscr_formula_fixed CHECK (
    (max_formula = 'fixed' AND fixed_max IS NOT NULL)
    OR (max_formula <> 'fixed' AND fixed_max IS NULL)
  )
);

CREATE INDEX idx_subclass_option_def_sub ON rpg.phb_subclass_option_def(subclass_id);

CREATE INDEX idx_subclass_resource_sub ON rpg.phb_subclass_resource(subclass_id);
