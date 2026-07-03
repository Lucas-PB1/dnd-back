-- Tabela rpg.phb_subclass_prepared_spell

CREATE TABLE rpg.phb_subclass_prepared_spell (
  id BIGSERIAL PRIMARY KEY,
  subclass_id BIGINT NOT NULL REFERENCES rpg.phb_subclass(id) ON DELETE CASCADE,
  unlock_level INTEGER NOT NULL CHECK (unlock_level >= 1),
  spell_id BIGINT NOT NULL REFERENCES rpg.phb_spell(id) ON DELETE CASCADE,
  terrain_id BIGINT REFERENCES rpg.phb_druid_land_terrain(id) ON DELETE CASCADE,
  CONSTRAINT uq_subclass_prepared_spell
    UNIQUE NULLS NOT DISTINCT (subclass_id, unlock_level, spell_id, terrain_id)
);
