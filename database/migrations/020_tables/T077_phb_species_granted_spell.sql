-- Tabela rpg.phb_species_granted_spell
-- Magias concedidas por espécies diretamente (sem linhagem/legado)

CREATE TABLE IF NOT EXISTS rpg.phb_species_granted_spell (
  species_id BIGINT NOT NULL REFERENCES rpg.phb_species(id) ON DELETE CASCADE,
  spell_id BIGINT NOT NULL REFERENCES rpg.phb_spell(id) ON DELETE CASCADE,
  unlock_level INT NOT NULL DEFAULT 1,
  PRIMARY KEY (species_id, spell_id, unlock_level)
);
