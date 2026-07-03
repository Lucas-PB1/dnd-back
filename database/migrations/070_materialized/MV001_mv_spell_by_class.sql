-- Materialized view rpg.mv_spell_by_class

CREATE MATERIALIZED VIEW rpg.mv_spell_by_class AS
  SELECT * FROM rpg.v_spell_by_class;
