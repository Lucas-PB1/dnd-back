-- Fase 3 — índices de consulta + materialized view magias por classe
-- Incremental: bancos que já aplicaram 001_initial_catalog.sql

DROP INDEX IF EXISTS rpg.idx_spell_level;

CREATE INDEX IF NOT EXISTS idx_phb_spell_level_school ON rpg.phb_spell (level, school_id);
CREATE INDEX IF NOT EXISTS idx_class_skill_pool_skill ON rpg.phb_class_skill_pool (skill_id);
CREATE INDEX IF NOT EXISTS idx_phb_item_type ON rpg.phb_item (item_type);

CREATE INDEX IF NOT EXISTS idx_phb_species_name_trgm ON rpg.phb_species USING gin (name gin_trgm_ops);
CREATE INDEX IF NOT EXISTS idx_phb_subclass_name_trgm ON rpg.phb_subclass USING gin (name gin_trgm_ops);
CREATE INDEX IF NOT EXISTS idx_phb_background_name_trgm ON rpg.phb_background USING gin (name gin_trgm_ops);

DROP MATERIALIZED VIEW IF EXISTS rpg.mv_spell_by_class;
CREATE MATERIALIZED VIEW rpg.mv_spell_by_class AS
  SELECT * FROM rpg.v_spell_by_class;

CREATE UNIQUE INDEX idx_mv_spell_by_class
  ON rpg.mv_spell_by_class (class_slug, spell_slug);

REFRESH MATERIALIZED VIEW rpg.mv_spell_by_class;
