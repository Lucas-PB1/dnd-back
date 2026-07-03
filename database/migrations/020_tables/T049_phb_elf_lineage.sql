-- Tabela rpg.phb_elf_lineage

CREATE TABLE rpg.phb_elf_lineage (
  id BIGSERIAL PRIMARY KEY,
  slug TEXT NOT NULL UNIQUE,
  name TEXT NOT NULL,
  level1_benefit TEXT NOT NULL,
  spell_level3_id BIGINT REFERENCES rpg.phb_spell(id),
  spell_level5_id BIGINT REFERENCES rpg.phb_spell(id)
);
