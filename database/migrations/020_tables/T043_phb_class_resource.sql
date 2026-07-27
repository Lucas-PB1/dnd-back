-- Tabela rpg.phb_class_resource (cotas jogáveis por classe)

CREATE TABLE IF NOT EXISTS rpg.phb_class_resource (
  class_id BIGINT NOT NULL REFERENCES rpg.phb_class(id) ON DELETE CASCADE,
  resource_id BIGINT NOT NULL REFERENCES rpg.phb_resource_definition(id) ON DELETE CASCADE,
  unlock_level INTEGER NOT NULL CHECK (unlock_level BETWEEN 1 AND 20),
  max_formula rpg.resource_max_formula NOT NULL,
  fixed_max INTEGER CHECK (fixed_max IS NULL OR fixed_max >= 0),
  recover_one_on_short BOOLEAN NOT NULL DEFAULT FALSE,
  recover_all_on_short BOOLEAN NOT NULL DEFAULT FALSE,
  recover_all_on_long BOOLEAN NOT NULL DEFAULT TRUE,
  PRIMARY KEY (class_id, resource_id, unlock_level),
  CONSTRAINT pcr_formula_fixed CHECK (
    (max_formula = 'fixed' AND fixed_max IS NOT NULL)
    OR (max_formula <> 'fixed' AND fixed_max IS NULL)
  )
);

CREATE INDEX IF NOT EXISTS idx_phb_class_resource_class
  ON rpg.phb_class_resource(class_id);
