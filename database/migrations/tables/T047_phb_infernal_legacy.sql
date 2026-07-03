-- Tabela rpg.phb_infernal_legacy

CREATE TABLE rpg.phb_infernal_legacy (
  id BIGSERIAL PRIMARY KEY,
  slug TEXT NOT NULL UNIQUE,
  name TEXT NOT NULL,
  level1_benefit TEXT NOT NULL,
  spell_level3_id BIGINT REFERENCES rpg.phb_spell(id),
  spell_level5_id BIGINT REFERENCES rpg.phb_spell(id)
);
