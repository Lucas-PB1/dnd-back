-- Cláusulas polimórficas de pré-requisito de talento (GEN-4).

CREATE TABLE rpg.phb_feat_requirement_clause (
  id BIGSERIAL PRIMARY KEY,
  feat_id BIGINT NOT NULL REFERENCES rpg.phb_feat_requirement(feat_id) ON DELETE CASCADE,
  clause_kind rpg.feat_requirement_clause_kind NOT NULL,
  ability_id BIGINT REFERENCES rpg.phb_ability(id),
  minimum_score INTEGER CHECK (minimum_score IS NULL OR minimum_score BETWEEN 1 AND 30),
  required_feat_id BIGINT REFERENCES rpg.phb_feat(id),
  option_key TEXT,
  value_id TEXT,
  skill_id BIGINT REFERENCES rpg.phb_skill(id),
  species_id BIGINT REFERENCES rpg.phb_species(id),
  proficiency_slug TEXT,
  CONSTRAINT phb_feat_requirement_clause_no_self CHECK (
    required_feat_id IS NULL OR feat_id <> required_feat_id
  ),
  CONSTRAINT phb_feat_requirement_clause_shape CHECK (
    (
      clause_kind = 'ability'::rpg.feat_requirement_clause_kind
      AND ability_id IS NOT NULL AND minimum_score IS NOT NULL
      AND required_feat_id IS NULL AND option_key IS NULL AND value_id IS NULL
      AND skill_id IS NULL AND species_id IS NULL AND proficiency_slug IS NULL
    )
    OR (
      clause_kind = 'feat'::rpg.feat_requirement_clause_kind
      AND required_feat_id IS NOT NULL
      AND ability_id IS NULL AND minimum_score IS NULL
      AND option_key IS NULL AND value_id IS NULL
      AND skill_id IS NULL AND species_id IS NULL AND proficiency_slug IS NULL
    )
    OR (
      clause_kind = 'feat_option'::rpg.feat_requirement_clause_kind
      AND required_feat_id IS NOT NULL
      AND option_key IS NOT NULL AND value_id IS NOT NULL
      AND ability_id IS NULL AND minimum_score IS NULL
      AND skill_id IS NULL AND species_id IS NULL AND proficiency_slug IS NULL
    )
    OR (
      clause_kind = 'skill'::rpg.feat_requirement_clause_kind
      AND skill_id IS NOT NULL
      AND ability_id IS NULL AND minimum_score IS NULL
      AND required_feat_id IS NULL AND option_key IS NULL AND value_id IS NULL
      AND species_id IS NULL AND proficiency_slug IS NULL
    )
    OR (
      clause_kind = 'species'::rpg.feat_requirement_clause_kind
      AND species_id IS NOT NULL
      AND ability_id IS NULL AND minimum_score IS NULL
      AND required_feat_id IS NULL AND option_key IS NULL AND value_id IS NULL
      AND skill_id IS NULL AND proficiency_slug IS NULL
    )
    OR (
      clause_kind = 'weapon_proficiency'::rpg.feat_requirement_clause_kind
      AND proficiency_slug IS NOT NULL AND length(trim(proficiency_slug)) > 0
      AND ability_id IS NULL AND minimum_score IS NULL
      AND required_feat_id IS NULL AND option_key IS NULL AND value_id IS NULL
      AND skill_id IS NULL AND species_id IS NULL
    )
  )
);

CREATE UNIQUE INDEX uq_phb_feat_req_clause_ability
  ON rpg.phb_feat_requirement_clause (feat_id, ability_id)
  WHERE clause_kind = 'ability'::rpg.feat_requirement_clause_kind;

CREATE UNIQUE INDEX uq_phb_feat_req_clause_feat
  ON rpg.phb_feat_requirement_clause (feat_id, required_feat_id)
  WHERE clause_kind = 'feat'::rpg.feat_requirement_clause_kind;

CREATE UNIQUE INDEX uq_phb_feat_req_clause_feat_option
  ON rpg.phb_feat_requirement_clause (feat_id, required_feat_id, option_key, value_id)
  WHERE clause_kind = 'feat_option'::rpg.feat_requirement_clause_kind;

CREATE UNIQUE INDEX uq_phb_feat_req_clause_skill
  ON rpg.phb_feat_requirement_clause (feat_id, skill_id)
  WHERE clause_kind = 'skill'::rpg.feat_requirement_clause_kind;

CREATE UNIQUE INDEX uq_phb_feat_req_clause_species
  ON rpg.phb_feat_requirement_clause (feat_id, species_id)
  WHERE clause_kind = 'species'::rpg.feat_requirement_clause_kind;

CREATE UNIQUE INDEX uq_phb_feat_req_clause_weapon
  ON rpg.phb_feat_requirement_clause (feat_id, proficiency_slug)
  WHERE clause_kind = 'weapon_proficiency'::rpg.feat_requirement_clause_kind;

CREATE INDEX idx_phb_feat_req_clause_feat_id
  ON rpg.phb_feat_requirement_clause (feat_id, clause_kind);

CREATE INDEX idx_phb_feat_req_clause_required_feat
  ON rpg.phb_feat_requirement_clause (required_feat_id)
  WHERE required_feat_id IS NOT NULL;

COMMENT ON TABLE rpg.phb_feat_requirement_clause IS
  'Pré-requisitos tipados por clause_kind (GEN-4; substitui 6 satélites).';
