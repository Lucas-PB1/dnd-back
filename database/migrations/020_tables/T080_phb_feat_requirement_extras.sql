-- Pré-requisitos adicionais de talentos: perícia, espécie (OR) e Maestria em Arma.

ALTER TABLE rpg.phb_feat_requirement
  ADD COLUMN IF NOT EXISTS requires_weapon_mastery BOOLEAN NOT NULL DEFAULT FALSE;

CREATE TABLE IF NOT EXISTS rpg.phb_feat_requirement_skill (
  feat_id BIGINT NOT NULL REFERENCES rpg.phb_feat_requirement(feat_id) ON DELETE CASCADE,
  skill_id BIGINT NOT NULL REFERENCES rpg.phb_skill(id),
  PRIMARY KEY (feat_id, skill_id)
);

CREATE TABLE IF NOT EXISTS rpg.phb_feat_requirement_species (
  feat_id BIGINT NOT NULL REFERENCES rpg.phb_feat_requirement(feat_id) ON DELETE CASCADE,
  species_id BIGINT NOT NULL REFERENCES rpg.phb_species(id),
  PRIMARY KEY (feat_id, species_id)
);

CREATE INDEX IF NOT EXISTS idx_phb_feat_requirement_skill_skill
  ON rpg.phb_feat_requirement_skill (skill_id);

CREATE INDEX IF NOT EXISTS idx_phb_feat_requirement_species_species
  ON rpg.phb_feat_requirement_species (species_id);
