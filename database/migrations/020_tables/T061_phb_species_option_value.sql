-- Tabela rpg.phb_species_option_value

CREATE TABLE rpg.phb_species_option_value (
  species_id BIGINT NOT NULL,
  option_key TEXT NOT NULL,
  value_id TEXT NOT NULL,
  label TEXT NOT NULL,
  PRIMARY KEY (species_id, option_key, value_id),
  FOREIGN KEY (species_id, option_key)
    REFERENCES rpg.phb_species_option_def(species_id, option_key) ON DELETE CASCADE
);
