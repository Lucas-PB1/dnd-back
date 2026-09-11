-- Perfis de companheiro vinculados a subclasse (Beast Master / Primal Spirit).

CREATE TABLE rpg.phb_companion_profile (
  profile_id TEXT PRIMARY KEY,
  subclass_id BIGINT NOT NULL REFERENCES rpg.phb_subclass(id) ON DELETE CASCADE,
  min_level INTEGER NOT NULL CHECK (min_level BETWEEN 1 AND 20)
);

CREATE UNIQUE INDEX idx_phb_companion_profile_subclass
  ON rpg.phb_companion_profile(subclass_id);

CREATE TABLE rpg.phb_companion_template_map (
  id BIGSERIAL PRIMARY KEY,
  profile_id TEXT NOT NULL REFERENCES rpg.phb_companion_profile(profile_id) ON DELETE CASCADE,
  option_matches JSONB NOT NULL,
  template_slug TEXT NOT NULL REFERENCES rpg.phb_creature_template(slug) ON DELETE RESTRICT,
  variant_label TEXT NOT NULL,
  CONSTRAINT phb_companion_template_map_matches_object CHECK (
    jsonb_typeof(option_matches) = 'object'
  )
);

CREATE UNIQUE INDEX idx_phb_companion_template_map_profile_matches
  ON rpg.phb_companion_template_map(profile_id, option_matches);
