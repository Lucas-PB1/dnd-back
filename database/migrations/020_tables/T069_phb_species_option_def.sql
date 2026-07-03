-- Tabela rpg.phb_species_option_def

CREATE TABLE rpg.phb_species_option_def (
  species_id BIGINT NOT NULL REFERENCES rpg.phb_species(id) ON DELETE CASCADE,
  option_key TEXT NOT NULL,
  value_type rpg.option_value_type NOT NULL,
  PRIMARY KEY (species_id, option_key)
);
