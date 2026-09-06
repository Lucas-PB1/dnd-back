CREATE TABLE rpg.phb_feat_requirement_species (
  feat_id BIGINT NOT NULL REFERENCES rpg.phb_feat_requirement(feat_id) ON DELETE CASCADE,
  species_id BIGINT NOT NULL REFERENCES rpg.phb_species(id),
  PRIMARY KEY (feat_id, species_id)
);

CREATE INDEX idx_phb_feat_requirement_skill_skill
  ON rpg.phb_feat_requirement_skill (skill_id);

CREATE INDEX idx_phb_feat_requirement_species_species
  ON rpg.phb_feat_requirement_species (species_id);

-- ProficiÃªncia de arma exigida + opÃ§Ã£o de talento prÃ©-requisito (ex.: Adepto Elemental / tipo).
