-- Tabela rpg.phb_species_trait

CREATE TABLE rpg.phb_species_trait (
  id BIGSERIAL PRIMARY KEY,
  species_id BIGINT NOT NULL REFERENCES rpg.phb_species(id) ON DELETE CASCADE,
  name TEXT NOT NULL,
  description TEXT NOT NULL,
  choice_kind rpg.species_choice_kind,
  UNIQUE (species_id, name)
);
