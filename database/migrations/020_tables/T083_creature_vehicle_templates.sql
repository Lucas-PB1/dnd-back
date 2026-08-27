-- Catálogo read-only: templates de criatura (stat blocks)

CREATE TABLE rpg.phb_creature_template (
  slug TEXT PRIMARY KEY,
  edition_slug TEXT NOT NULL REFERENCES rpg.phb_edition(slug),
  name TEXT NOT NULL CHECK (char_length(name) BETWEEN 1 AND 120),
  creature_type TEXT NOT NULL,
  creature_subtype TEXT,
  size_slug TEXT,
  challenge_rating TEXT,
  proficiency_bonus INT CHECK (proficiency_bonus IS NULL OR proficiency_bonus BETWEEN 0 AND 9),
  armor_class INT,
  hit_points_avg INT CHECK (hit_points_avg IS NULL OR hit_points_avg >= 0),
  hit_points_formula TEXT,
  spellcasting_ability_slug TEXT REFERENCES rpg.phb_ability(slug),
  spell_save_dc INT CHECK (spell_save_dc IS NULL OR spell_save_dc BETWEEN 1 AND 40),
  spell_attack_bonus INT CHECK (spell_attack_bonus IS NULL OR spell_attack_bonus BETWEEN -10 AND 30),
  source_citation_id BIGINT REFERENCES rpg.phb_source_citation(id)
);

CREATE TABLE rpg.phb_creature_template_speed (
  template_slug TEXT NOT NULL REFERENCES rpg.phb_creature_template(slug) ON DELETE CASCADE,
  movement_kind TEXT NOT NULL CHECK (char_length(movement_kind) BETWEEN 1 AND 32),
  speed_ft INT NOT NULL CHECK (speed_ft >= 0),
  PRIMARY KEY (template_slug, movement_kind)
);

CREATE TABLE rpg.phb_creature_template_action (
  id BIGSERIAL PRIMARY KEY,
  template_slug TEXT NOT NULL REFERENCES rpg.phb_creature_template(slug) ON DELETE CASCADE,
  name TEXT NOT NULL CHECK (char_length(name) BETWEEN 1 AND 120),
  action_bucket rpg.actor_action_bucket NOT NULL DEFAULT 'action',
  attack_bonus INT,
  damage_expression TEXT,
  reach_ft INT CHECK (reach_ft IS NULL OR reach_ft >= 0),
  sort_order INT NOT NULL DEFAULT 0
);

CREATE INDEX idx_phb_creature_template_action_slug
  ON rpg.phb_creature_template_action(template_slug);

CREATE TABLE rpg.phb_creature_template_spell (
  id BIGSERIAL PRIMARY KEY,
  template_slug TEXT NOT NULL REFERENCES rpg.phb_creature_template(slug) ON DELETE CASCADE,
  spell_slug TEXT NOT NULL REFERENCES rpg.phb_spell(slug),
  usage_kind rpg.innate_spell_usage NOT NULL,
  uses_per_day INT CHECK (uses_per_day IS NULL OR uses_per_day >= 1),
  slot_level INT CHECK (slot_level IS NULL OR slot_level BETWEEN 0 AND 9),
  recharge_dice TEXT,
  sort_order INT NOT NULL DEFAULT 0,
  UNIQUE (template_slug, spell_slug, usage_kind, slot_level)
);

CREATE TABLE rpg.phb_creature_template_trait (
  id BIGSERIAL PRIMARY KEY,
  template_slug TEXT NOT NULL REFERENCES rpg.phb_creature_template(slug) ON DELETE CASCADE,
  name TEXT NOT NULL CHECK (char_length(name) BETWEEN 1 AND 120),
  description TEXT NOT NULL,
  sort_order INT NOT NULL DEFAULT 0
);

CREATE INDEX idx_phb_creature_template_trait_slug
  ON rpg.phb_creature_template_trait(template_slug);

CREATE TABLE rpg.phb_vehicle_template (
  slug TEXT PRIMARY KEY,
  edition_slug TEXT NOT NULL REFERENCES rpg.phb_edition(slug),
  name TEXT NOT NULL CHECK (char_length(name) BETWEEN 1 AND 120),
  armor_class INT,
  hit_points INT CHECK (hit_points IS NULL OR hit_points >= 0),
  damage_threshold INT CHECK (damage_threshold IS NULL OR damage_threshold >= 0),
  crew_capacity INT CHECK (crew_capacity IS NULL OR crew_capacity >= 0),
  cargo_capacity_lb INT CHECK (cargo_capacity_lb IS NULL OR cargo_capacity_lb >= 0),
  source_citation_id BIGINT REFERENCES rpg.phb_source_citation(id)
);

CREATE TABLE rpg.phb_vehicle_template_speed (
  template_slug TEXT NOT NULL REFERENCES rpg.phb_vehicle_template(slug) ON DELETE CASCADE,
  movement_kind TEXT NOT NULL CHECK (char_length(movement_kind) BETWEEN 1 AND 32),
  speed_ft INT NOT NULL CHECK (speed_ft >= 0),
  PRIMARY KEY (template_slug, movement_kind)
);

CREATE TABLE rpg.phb_vehicle_template_action (
  id BIGSERIAL PRIMARY KEY,
  template_slug TEXT NOT NULL REFERENCES rpg.phb_vehicle_template(slug) ON DELETE CASCADE,
  name TEXT NOT NULL CHECK (char_length(name) BETWEEN 1 AND 120),
  action_bucket rpg.actor_action_bucket NOT NULL DEFAULT 'action',
  attack_bonus INT,
  damage_expression TEXT,
  reach_ft INT CHECK (reach_ft IS NULL OR reach_ft >= 0),
  sort_order INT NOT NULL DEFAULT 0
);

CREATE INDEX idx_phb_vehicle_template_action_slug
  ON rpg.phb_vehicle_template_action(template_slug);
