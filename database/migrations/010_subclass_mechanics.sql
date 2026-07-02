-- Migration 010: tabelas e views de mecânicas de subclasse

ALTER TABLE rpg.phb_subclass_feature
  ADD COLUMN IF NOT EXISTS feature_kind rpg.subclass_feature_kind NOT NULL DEFAULT 'passive',
  ADD COLUMN IF NOT EXISTS option_key TEXT;

ALTER TABLE rpg.phb_resource_definition
  ADD COLUMN IF NOT EXISTS subclass_id BIGINT REFERENCES rpg.phb_subclass(id) ON DELETE CASCADE;

ALTER TABLE rpg.phb_resource_definition DROP CONSTRAINT IF EXISTS prd_scope_fk;
ALTER TABLE rpg.phb_resource_definition ADD CONSTRAINT prd_scope_fk CHECK (
  (scope = 'species' AND species_id IS NOT NULL AND class_id IS NULL AND subclass_id IS NULL) OR
  (scope = 'class' AND class_id IS NOT NULL AND species_id IS NULL AND subclass_id IS NULL) OR
  (scope = 'subclass' AND subclass_id IS NOT NULL AND species_id IS NULL AND class_id IS NULL)
);

CREATE UNIQUE INDEX IF NOT EXISTS uq_resource_subclass
  ON rpg.phb_resource_definition (subclass_id, slug)
  WHERE scope = 'subclass';

CREATE TABLE IF NOT EXISTS rpg.phb_subclass_option_def (
  subclass_id   BIGINT NOT NULL REFERENCES rpg.phb_subclass(id) ON DELETE CASCADE,
  option_key    TEXT NOT NULL,
  label         TEXT NOT NULL,
  unlock_level  INTEGER NOT NULL DEFAULT 3 CHECK (unlock_level BETWEEN 1 AND 20),
  value_type    rpg.option_value_type NOT NULL DEFAULT 'catalog',
  PRIMARY KEY (subclass_id, option_key)
);

CREATE TABLE IF NOT EXISTS rpg.phb_subclass_option_value (
  subclass_id   BIGINT NOT NULL,
  option_key    TEXT NOT NULL,
  value_id      TEXT NOT NULL,
  label         TEXT NOT NULL,
  sort_order    INTEGER NOT NULL DEFAULT 0,
  PRIMARY KEY (subclass_id, option_key, value_id),
  FOREIGN KEY (subclass_id, option_key)
    REFERENCES rpg.phb_subclass_option_def(subclass_id, option_key) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS rpg.phb_subclass_resource (
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

CREATE INDEX IF NOT EXISTS idx_subclass_option_def_sub ON rpg.phb_subclass_option_def(subclass_id);
CREATE INDEX IF NOT EXISTS idx_subclass_resource_sub ON rpg.phb_subclass_resource(subclass_id);

CREATE TABLE IF NOT EXISTS rpg.player_character_subclass_option (
  character_id      TEXT NOT NULL REFERENCES rpg.player_character(id) ON DELETE CASCADE,
  subclass_id       BIGINT NOT NULL REFERENCES rpg.phb_subclass(id),
  option_key        TEXT NOT NULL,
  catalog_value_id  TEXT,
  ability_id        BIGINT REFERENCES rpg.phb_ability(id),
  PRIMARY KEY (character_id, option_key),
  CONSTRAINT psco_has_value CHECK (
    catalog_value_id IS NOT NULL OR ability_id IS NOT NULL
  ),
  FOREIGN KEY (subclass_id, option_key)
    REFERENCES rpg.phb_subclass_option_def(subclass_id, option_key)
);

CREATE INDEX IF NOT EXISTS idx_pc_subclass_option_char ON rpg.player_character_subclass_option(character_id);

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

CREATE OR REPLACE FUNCTION rpg.validate_pc_subclass_option()
RETURNS TRIGGER AS $$
DECLARE
  pc_subclass BIGINT;
  pc_class BIGINT;
  opt_class BIGINT;
BEGIN
  SELECT subclass_id, class_id INTO pc_subclass, pc_class
  FROM rpg.player_character WHERE id = NEW.character_id;

  IF pc_subclass IS NULL OR pc_subclass <> NEW.subclass_id THEN
    RAISE EXCEPTION 'subclass_option % não pertence à subclasse do personagem', NEW.option_key;
  END IF;

  SELECT class_id INTO opt_class FROM rpg.phb_subclass WHERE id = NEW.subclass_id;
  IF opt_class <> pc_class THEN
    RAISE EXCEPTION 'subclass_id inconsistente em subclass_option';
  END IF;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS tr_validate_pc_subclass_option ON rpg.player_character_subclass_option;
CREATE TRIGGER tr_validate_pc_subclass_option
  BEFORE INSERT OR UPDATE ON rpg.player_character_subclass_option
  FOR EACH ROW EXECUTE FUNCTION rpg.validate_pc_subclass_option();
