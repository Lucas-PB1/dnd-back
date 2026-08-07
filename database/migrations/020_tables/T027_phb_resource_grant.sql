-- Lote G: cotas jogáveis unificadas (classe + subclasse)

CREATE TABLE rpg.phb_resource_grant (
  owner_kind rpg.resource_owner_kind NOT NULL,
  owner_id BIGINT NOT NULL,
  resource_id BIGINT NOT NULL REFERENCES rpg.phb_resource_definition(id) ON DELETE CASCADE,
  unlock_level INTEGER NOT NULL CHECK (unlock_level BETWEEN 1 AND 20),
  max_formula rpg.resource_max_formula NOT NULL,
  fixed_max INTEGER CHECK (fixed_max IS NULL OR fixed_max >= 0),
  feature_id BIGINT REFERENCES rpg.phb_subclass_feature(id) ON DELETE SET NULL,
  recover_one_on_short BOOLEAN NOT NULL DEFAULT FALSE,
  recover_all_on_short BOOLEAN NOT NULL DEFAULT FALSE,
  recover_all_on_long BOOLEAN NOT NULL DEFAULT TRUE,
  PRIMARY KEY (owner_kind, owner_id, resource_id, unlock_level),
  CONSTRAINT prg_formula_fixed CHECK (
    (max_formula = 'fixed' AND fixed_max IS NOT NULL)
    OR (max_formula <> 'fixed' AND fixed_max IS NULL)
  ),
  CONSTRAINT prg_feature_owner CHECK (
    feature_id IS NULL OR owner_kind = 'subclass'::rpg.resource_owner_kind
  )
);

CREATE INDEX idx_phb_resource_grant_owner
  ON rpg.phb_resource_grant(owner_kind, owner_id);

-- Compat: leitura legada por classe / subclasse (class-resources.ts, views)
CREATE OR REPLACE VIEW rpg.phb_class_resource AS
SELECT
  owner_id AS class_id,
  resource_id,
  unlock_level,
  max_formula,
  fixed_max,
  recover_one_on_short,
  recover_all_on_short,
  recover_all_on_long
FROM rpg.phb_resource_grant
WHERE owner_kind = 'class';

CREATE OR REPLACE VIEW rpg.phb_subclass_resource AS
SELECT
  owner_id AS subclass_id,
  resource_id,
  unlock_level,
  max_formula,
  fixed_max,
  feature_id,
  recover_one_on_short,
  recover_all_on_short,
  recover_all_on_long
FROM rpg.phb_resource_grant
WHERE owner_kind = 'subclass';
