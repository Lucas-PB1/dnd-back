/** Catálogo e fichas — mecânicas de subclasse (ex-migrations 009–012). */

export const SUBCLASS_MECHANICS_TABLES_DDL = `
CREATE TABLE rpg.phb_subclass_option_def (
  subclass_id   BIGINT NOT NULL REFERENCES rpg.phb_subclass(id) ON DELETE CASCADE,
  option_key    TEXT NOT NULL,
  label         TEXT NOT NULL,
  unlock_level  INTEGER NOT NULL DEFAULT 3 CHECK (unlock_level BETWEEN 1 AND 20),
  value_type    rpg.option_value_type NOT NULL DEFAULT 'catalog',
  PRIMARY KEY (subclass_id, option_key)
);

CREATE TABLE rpg.phb_subclass_option_value (
  subclass_id   BIGINT NOT NULL,
  option_key    TEXT NOT NULL,
  value_id      TEXT NOT NULL,
  label         TEXT NOT NULL,
  sort_order    INTEGER NOT NULL DEFAULT 0,
  PRIMARY KEY (subclass_id, option_key, value_id),
  FOREIGN KEY (subclass_id, option_key)
    REFERENCES rpg.phb_subclass_option_def(subclass_id, option_key) ON DELETE CASCADE
);

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
`;

export const SUBCLASS_MECHANICS_VIEWS_DDL = `
CREATE OR REPLACE VIEW rpg.v_phb_subclass_mechanics AS
SELECT
  c.slug AS class_slug,
  s.slug AS subclass_slug,
  sf.level AS feature_level,
  sf.name AS feature_name,
  sf.feature_kind,
  sf.option_key,
  rd.slug AS resource_slug,
  rd.name AS resource_name,
  psr.unlock_level AS resource_unlock_level,
  psr.max_formula,
  psr.fixed_max
FROM rpg.phb_subclass_feature sf
JOIN rpg.phb_subclass s ON s.id = sf.subclass_id
JOIN rpg.phb_class c ON c.id = s.class_id
LEFT JOIN rpg.phb_subclass_resource psr ON psr.feature_id = sf.id
LEFT JOIN rpg.phb_resource_definition rd ON rd.id = psr.resource_id;

CREATE OR REPLACE VIEW rpg.v_phb_subclass_spells_expected AS
SELECT
  c.slug AS class_slug,
  s.slug AS subclass_slug,
  ps.unlock_level,
  sp.slug AS spell_slug,
  ss.slug AS spell_source_slug
FROM rpg.phb_subclass_prepared_spell ps
JOIN rpg.phb_subclass s ON s.id = ps.subclass_id
JOIN rpg.phb_class c ON c.id = s.class_id
JOIN rpg.phb_spell sp ON sp.id = ps.spell_id
LEFT JOIN rpg.phb_spell_source ss ON ss.subclass_id = s.id AND ss.origin_type = 'subclass';
`;
